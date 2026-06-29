#!/bin/bash
# 全シードデータを順番に投入する（初回セットアップ用）
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SEEDS_DIR="$SCRIPT_DIR/seeds"

# DATABASE_URL から psql 接続パラメータを読み取る
# 例: postgresql://study_user:password@localhost:5432/study_unlax
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

# DATABASE_URL をパース
DB_URL="${DATABASE_URL}"
DB_USER=$(echo "$DB_URL" | sed -E 's|postgresql://([^:]+):.*|\1|')
DB_PASS=$(echo "$DB_URL" | sed -E 's|postgresql://[^:]+:([^@]+)@.*|\1|')
DB_HOST=$(echo "$DB_URL" | sed -E 's|postgresql://[^@]+@([^:/]+).*|\1|')
DB_PORT=$(echo "$DB_URL" | sed -E 's|postgresql://[^@]+@[^:]+:([^/]+)/.*|\1|')
DB_NAME=$(echo "$DB_URL" | sed -E 's|postgresql://[^/]+/([^?]+).*|\1|')

export PGPASSWORD="$DB_PASS"
PSQL="psql -U $DB_USER -h $DB_HOST -p $DB_PORT -d $DB_NAME"

echo "=== シードデータ投入開始 ==="
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
