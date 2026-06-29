#!/bin/bash
# 問題データを全入れ替えする（定期更新用）
#
# 実行すると以下の順で処理される:
#   1. questions を全削除（CASCADE で子テーブル・ユーザー履歴も削除）
#   2. seeds/ の questions ファイルを順に INSERT
#   3. 全体を1トランザクションで包む（失敗時はロールバック）
#
# subjects / topics は変更しない。
# 新しい topics を追加したい場合は先に seed-all.sh を実行すること。
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SEEDS_DIR="$SCRIPT_DIR/seeds"

if [ -z "${DATABASE_URL:-}" ]; then
  ENV_FILE="$SCRIPT_DIR/../backend/.env"
  if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | grep DATABASE_URL | xargs)
  fi
fi

if [ -z "${DATABASE_URL:-}" ]; then
  echo "ERROR: DATABASE_URL が設定されていません。backend/.env を確認してください。"
  exit 1
fi

DB_USER=$(echo "$DATABASE_URL" | sed -E 's|postgresql://([^:]+):.*|\1|')
DB_PASS=$(echo "$DATABASE_URL" | sed -E 's|postgresql://[^:]+:([^@]+)@.*|\1|')
DB_HOST=$(echo "$DATABASE_URL" | sed -E 's|postgresql://[^@]+@([^:/]+).*|\1|')
DB_PORT=$(echo "$DATABASE_URL" | sed -E 's|postgresql://[^@]+@[^:]+:([^/]+)/.*|\1|')
DB_NAME=$(echo "$DATABASE_URL" | sed -E 's|postgresql://[^/]+/([^?]+).*|\1|')

export PGPASSWORD="$DB_PASS"
PSQL="psql -U $DB_USER -h $DB_HOST -p $DB_PORT -d $DB_NAME"

# 問題 seed ファイルのみ対象（subjects/topics は除外）
QUESTION_FILES=$(ls "$SEEDS_DIR"/*.sql | grep -v '_subjects\|_topics')

echo "=== 問題データ全入れ替え開始 ==="
echo "DB: $DB_HOST:$DB_PORT/$DB_NAME"
echo ""
echo "対象ファイル:"
for f in $QUESTION_FILES; do echo "  $(basename $f)"; done
echo ""
echo "WARNING: 既存の問題データとユーザー回答履歴・お気に入りは全て削除されます。"
echo "続行しますか？ [y/N]"
read -r answer
if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
  echo "中止しました。"
  exit 0
fi

# 全体を1つのSQLにまとめてトランザクションで実行
TMPFILE=$(mktemp /tmp/reseed_questions_XXXXXX.sql)
trap "rm -f $TMPFILE" EXIT

{
  echo "BEGIN;"
  echo ""
  echo "-- 問題を全削除（CASCADE で question_choices / question_steps 等も削除）"
  echo "-- UserAnswer / UserFavorite も CASCADE で削除される"
  echo "DELETE FROM questions;"
  echo ""
  for f in $QUESTION_FILES; do
    echo "-- $(basename $f)"
    cat "$f"
    echo ""
  done
  echo "COMMIT;"
} > "$TMPFILE"

echo ""
echo "--- 実行中 ---"
$PSQL -f "$TMPFILE"

echo ""
echo "=== 問題データ全入れ替え完了 ==="
echo ""

# 投入件数を確認
$PSQL -c "SELECT t.name AS topic, COUNT(q.id) AS questions FROM topics t LEFT JOIN questions q ON q.\"topicId\" = t.id GROUP BY t.id, t.name ORDER BY t.id;"
