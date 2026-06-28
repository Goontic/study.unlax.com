FROM node:24-alpine

# Native module build deps (sharp)
RUN apk add --no-cache python3 make g++

RUN corepack enable && corepack prepare pnpm@11.9.0 --activate

WORKDIR /app

# Install deps (cached layer — only reinstalls when lockfile or manifests change)
COPY pnpm-workspace.yaml pnpm-lock.yaml package.json pnpm.yaml ./
COPY backend/package.json ./backend/
COPY frontend/package.json ./frontend/
RUN pnpm install --frozen-lockfile
# Docker コンテナ内では非TTY 環境のため、起動前の deps 整合性チェックを無効化
RUN echo "verify-deps-before-run=false" >> /root/.npmrc

COPY . .

WORKDIR /app/frontend

EXPOSE 3000

ENV NEXT_TELEMETRY_DISABLED=1

CMD ["node_modules/.bin/next", "dev"]
