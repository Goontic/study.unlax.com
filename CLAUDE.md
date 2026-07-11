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
| Frontend / Backend | Next.js 16 (App Router + API Route Handlers) + Tailwind CSS v4 |
| Database | PostgreSQL + Prisma v7 |
| Auth | NextAuth.js v5 (Credentials Provider) |
| Package manager | pnpm workspaces |

バックエンドは NestJS を廃止し、Next.js の Route Handlers / Server Components に統合済み（旧 `backend/` は削除）。
Server Component からは `lib/data.ts`（公開データ）・`lib/admin/*.ts`（管理データ）経由で Prisma を直接呼び出す。
クライアントコンポーネントからの書き込み系のみ `app/api/` の Route Handler を経由する。

## Development Commands

```bash
# ルートから全パッケージインストール（pnpm v11 の allowBuilds が pnpm-workspace.yaml で管理）
pnpm install

# フロントエンド
pnpm dev:frontend        # Next.js dev server (port 3000)
pnpm build:frontend      # production build

# Prisma (frontend/ ディレクトリで実行)
pnpm --filter frontend prisma:generate     # prisma generate（スキーマ変更後に実行）
pnpm --filter frontend prisma:migrate      # prisma migrate dev（開発時）
pnpm --filter frontend prisma:migrate:prod # prisma migrate deploy（本番）

# 管理者アカウント作成
pnpm --filter frontend admin:create <email> <password> <displayName>
```

## Architecture Overview

```
study.unlax.com/
└── frontend/              # Next.js App Router（フロント + API + DBアクセス）
    ├── app/
    │   ├── (auth)/        # login / register（Route Group）
    │   ├── [subject]/     # 科目ページ
    │   │   └── [topic]/[questionId]/ # 問題ページ
    │   ├── profile/       # マイページ（要認証）
    │   ├── admin/          # 管理画面（Server Components、Cookie の admin_token で保護）
    │   └── api/
    │       ├── auth/      # NextAuth ハンドラー、register/forgot-password/reset-password
    │       ├── admin/     # 管理API（subjects/topics/questions/admins の CRUD）
    │       └── progress/  # 回答記録・進捗取得（要ログイン）
    ├── components/
    │   ├── quiz/          # MultipleChoice / TextInput / FillBlank / Ordering
    │   ├── admin/          # 管理画面フォーム類
    │   └── layout/        # Header / BottomNav（スマホ向け下部ナビ）
    ├── lib/
    │   ├── prisma.ts      # PrismaClient シングルトン（globalThis キャッシュ）
    │   ├── data.ts        # 公開ページ用の読み取りクエリ（Server Component から直接呼ぶ）
    │   ├── admin/          # 管理API用サービス層（subjects/topics/questions/admins.ts, http.ts）
    │   ├── auth.ts         # NextAuth.js 設定 + getSessionUserId()
    │   ├── admin-auth.ts   # 管理者JWT発行・検証（jose）、Cookie 読み取り
    │   ├── mail.ts         # パスワード再設定メール送信
    │   └── types.ts        # 共有型定義
    ├── prisma/
    │   ├── schema.prisma
    │   └── migrations/
    └── prisma.config.ts
```

## Key Patterns

### Prisma v7 の注意点
- `schema.prisma` には `url` を書かない。接続は `prisma.config.ts` で管理。
- スキーマ変更後は必ず `pnpm --filter frontend prisma:generate` を実行してクライアントを再生成する（`postinstall` でも自動実行される）。
- `prisma.config.ts` は `DATABASE_URL` 環境変数を参照する。
- DBのテーブル名・カラム名は snake_case とする。Prismaのモデル名・フィールド名はcamelCaseのまま、`@@map` / `@map` でDB側の実名（snake_case）にマッピングする。新しいモデル・フィールドを追加する際も同様に `@map` を付けること。
- サーバーレス環境（Vercel等）にデプロイする場合、Neon 等の pooled 接続（pgBouncer）を `DATABASE_URL` に使うこと。`lib/prisma.ts` は接続数を絞る設定済み。

### pnpm build スクリプトのビルド許可
- `sharp`, `unrs-resolver`, `@prisma/engines`, `prisma` のビルドは `pnpm-workspace.yaml` の `allowBuilds` で許可済み。
- 新しいネイティブモジュールを追加したとき同様に対応すること。

### Server Component から DB を直接読む方針
- 公開ページの読み取りは NestJS API 時代の名残で fetch を経由せず、`lib/data.ts` の関数を Server Component から直接呼ぶ（例: `getSubjects()`, `getQuestion(id)`）。
- 管理画面も同様に `lib/admin/*.ts` のサービス関数を Server Component から直接呼ぶ。管理APIルート（`app/api/admin/**`）はクライアントコンポーネントからの書き込み専用。
- 管理APIルートは `lib/admin/http.ts` の `withAdmin()` でラップし、Cookie の `admin_token` を検証してから処理する。

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
- 一般ユーザー: NextAuth.js Credentials Provider が `lib/prisma.ts` 経由で直接 `users` テーブルを検証（bcryptjs）。セッションは JWT strategy、有効期限 7日。`getSessionUserId()` (`lib/auth.ts`) で Server Component / Route Handler からログインユーザーIDを取得する。
- 管理者: 独自の Cookie ベース認証。ログイン時に `lib/admin-auth.ts` の `signAdminToken()`（jose, HS256, 12時間）で JWT を発行し `admin_token` という httpOnly Cookie に保存。`requireAdmin()` は Server Component 用（未認証なら `/admin/login` へリダイレクト）、`withAdmin()` (`lib/admin/http.ts`) は Route Handler 用。

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

環境変数は `frontend/.env.example` を参照して `frontend/.env` を作成する。

## Vercel + Neon への移行

Vercel(Next.js)+ Neon(サーバーレス PostgreSQL、無料枠)への移行を計画中。
移行時は Neon の pooled 接続文字列（`-pooler` 付き）を `DATABASE_URL` に設定し、マイグレーション実行時のみ non-pooled の直結続 URL を使う。
Vercel のビルド時に `generateStaticParams` が DB へ接続するため、ビルド環境にも `DATABASE_URL` が必要。

## Content Structure

高校受験5科目: 数学 (math) / 英語 (english) / 国語 (japanese) / 理科 (science) / 社会 (social)

解説文は小中学生向けに平易な日本語で記述。難しい用語は避け、手順ごとに分けて説明する。
