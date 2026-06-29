#!/bin/bash
# 初回セットアップ用: subjects → topics → questions を全投入する
#
# 2回目以降の問題更新は reseed-questions.sh を使うこと。
# subjects/topics は ON CONFLICT DO NOTHING なので重複しない。
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

echo "=== 初回シードデータ投入開始 ==="
echo "DB: $DB_HOST:$DB_PORT/$DB_NAME"

for sql_file in "$SEEDS_DIR"/*.sql; do
  filename=$(basename "$sql_file")
  echo ""
  echo "--- $filename ---"
  $PSQL -f "$sql_file"
  echo "OK"
done

echo ""
echo "=== 全シード完了 ==="
echo ""
echo "次回以降の問題更新は db/reseed-questions.sh を使ってください。"
