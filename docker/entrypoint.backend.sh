#!/bin/sh
set -e

echo "[backend] Applying Prisma migrations..."
node_modules/.bin/prisma migrate deploy

echo "[backend] Starting NestJS in watch mode..."
exec node_modules/.bin/nest start --watch
