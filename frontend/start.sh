#!/bin/bash
# 本番サーバー上の秘匿環境変数を読み込む（.env.production.local は git 管理外）
ENV_FILE="$(dirname "$0")/.env.production.local"
if [ -f "$ENV_FILE" ]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

exec node "$(dirname "$0")/.next/standalone/frontend/server.js"
