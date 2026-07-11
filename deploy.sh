#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== [1/4] git pull ==="
git pull

echo "=== [2/4] pnpm install ==="
pnpm install --frozen-lockfile

echo "=== [3/4] Prisma migrate & Build ==="
pnpm --filter frontend prisma:migrate:prod
pnpm build

echo "=== [4/4] PM2 restart ==="
pm2 restart study-frontend

echo ""
echo "=== Deploy complete ==="
pm2 list
