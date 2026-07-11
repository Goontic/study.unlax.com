#!/bin/sh
set -e

echo "[frontend] Applying Prisma migrations..."
node_modules/.bin/prisma migrate deploy

echo "[frontend] Starting Next.js in dev mode..."
exec node_modules/.bin/next dev
