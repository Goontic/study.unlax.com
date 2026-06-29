#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== [1/5] git pull ==="
git pull

echo "=== [2/5] pnpm install ==="
pnpm install --frozen-lockfile

echo "=== [3/5] Prisma: generate & migrate ==="
pnpm --filter backend prisma:generate
pnpm --filter backend prisma:migrate:prod

echo "=== [4/5] Build ==="
pnpm build

echo "=== [5/5] PM2 restart ==="
pm2 restart study-backend study-frontend

echo ""
echo "=== Deploy complete ==="
pm2 list
