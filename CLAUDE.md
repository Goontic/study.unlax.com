# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**study.unlax.com** — 中学生向け高校受験対策サイト（完全無料）  
スマートフォン・タブレットでの移動中学習を主眼に置いたモバイルファーストのWebアプリ。  
ユーザーアカウントあり（進捗・お気に入り保存）。問題はSQL/スクリプトで直接DB投入。
修正後は git commit まで行う。

## Tech Stack

| Layer | Technology |
|-------|------------|
| Server OS | AlmaLinux 9 + Cloudflare Tunnel |
| Frontend | Next.js 16 (App Router) + Tailwind CSS v4 |
| Backend | NestJS 11 |
| Database | PostgreSQL + Prisma v7 |
| Auth | NextAuth.js v5 (Credentials Provider) + JWT |
| Package manager | pnpm workspaces (monorepo) |

## Development Commands

```bash
# ルートから全パッケージインストール（pnpm v11 の allowBuilds が pnpm-workspace.yaml で管理）
pnpm install

# フロントエンド
pnpm dev:frontend        # Next.js dev server (port 3000)
pnpm build:frontend      # production build

# バックエンド
pnpm dev:backend         # NestJS watch mode (port 4000)
pnpm build:backend       # production build

# Prisma (backend/ ディレクトリで実行)
pnpm prisma:generate     # prisma generate（スキーマ変更後に実行）
pnpm prisma:migrate      # prisma migrate dev（開発時）
pnpm prisma:migrate:prod # prisma migrate deploy（本番）

# テスト
cd backend && pnpm test        # NestJS unit tests
cd backend && pnpm test:e2e    # e2e tests
```

## Architecture Overview

```
study.unlax.com/
├── frontend/          # Next.js App Router
│   ├── app/           # ページ（Server Components + Client Components）
│   │   ├── (auth)/    # login / register（Route Group）
│   │   ├── [subject]/ # 科目ページ
│   │   │   └── [topic]/[questionId]/ # 問題ページ
│   │   ├── profile/   # マイページ（要認証）
│   │   └── api/       # Next.js API Routes（auth プロキシ）
│   ├── components/
│   │   ├── quiz/      # MultipleChoice / TextInput / FillBlank / Ordering
│   │   └── layout/    # Header / BottomNav（スマホ向け下部ナビ）
│   └── lib/
│       ├── api.ts     # バックエンドへの fetch ラッパー
│       ├── auth.ts    # NextAuth.js 設定
│       └── types.ts   # 共有型定義
└── backend/           # NestJS
    ├── src/
    │   ├── prisma/    # PrismaService（グローバルモジュール）
    │   ├── auth/      # JWT 発行・検証（/auth/register, /auth/login, /auth/refresh）
    │   ├── subjects/  # 科目・単元・問題 API + /questions/:id
    │   ├── progress/  # 回答履歴・進捗（要 JWT）
    │   └── favorites/ # お気に入り（要 JWT）
    └── prisma/
        └── schema.prisma
```

## Key Patterns

### Prisma v7 の注意点
- `schema.prisma` には `url` を書かない。接続は `prisma.config.ts` で管理。
- スキーマ変更後は必ず `pnpm prisma:generate` を実行してクライアントを再生成する。
- `prisma.config.ts` は `DATABASE_URL` 環境変数を参照する。
- DBのテーブル名・カラム名は snake_case とする。Prismaのモデル名・フィールド名はcamelCaseのまま、`@@map` / `@map` でDB側の実名（snake_case）にマッピングする。新しいモデル・フィールドを追加する際も同様に `@map` を付けること。

### pnpm build スクリプトのビルド許可
- `sharp`, `unrs-resolver`, `bcrypt`, `@prisma/engines`, `prisma` のビルドは各 `pnpm-workspace.yaml` の `allowBuilds` で許可済み。
- 新しいネイティブモジュールを追加したとき同様に対応すること。

### 問題形式と実装
| 形式 | type 値 | コンポーネント |
|------|---------|---------------|
| 4択 | `multiple_choice` | `components/quiz/MultipleChoice.tsx` |
| 記述式 | `text_input` | `components/quiz/TextInput.tsx` |
| 穴埋め | `fill_blank` | `components/quiz/FillBlank.tsx` |
| 並べ替え | `ordering` | `components/quiz/Ordering.tsx` |

穴埋め問題の本文は `{{1}}`, `{{2}}` プレースホルダーで空欄を表す。

### SEO
- 全ページに `generateMetadata` で title/description を設定。
- 科目・単元ページは `generateStaticParams` でビルド時に静的生成。
- 問題ページに JSON-LD (Q&A structured data) を埋め込み。

### 認証フロー
- NextAuth.js Credentials Provider → NestJS `/auth/login` を呼び出し。
- アクセストークン: 15分 (Bearer)、リフレッシュトークン: 7日 (httpOnly Cookie)。
- `frontend/lib/auth.ts` で NextAuth.js 設定、`backend/src/auth/` で JWT 発行。

## Database

問題データは `db/seeds/` の SQL スクリプトで投入する。

```bash
psql -U study_user -d study_unlax -f db/seeds/01_subjects.sql
psql -U study_user -d study_unlax -f db/seeds/02_topics_math.sql
psql -U study_user -d study_unlax -f db/seeds/03_questions_linear_equations.sql
```

## Deployment (AlmaLinux 9)

```bash
# ビルド
pnpm build

# 起動
pm2 start ecosystem.config.js

# Nginx 設定（Cloudflare Tunnel 経由なので SSL 不要）
cp nginx.conf.example /etc/nginx/conf.d/study.unlax.com.conf
systemctl reload nginx
```

環境変数はそれぞれの `.env.example` を参照して `.env` を作成する。

## Content Structure

高校受験5科目: 数学 (math) / 英語 (english) / 国語 (japanese) / 理科 (science) / 社会 (social)

解説文は小中学生向けに平易な日本語で記述。難しい用語は避け、手順ごとに分けて説明する。
