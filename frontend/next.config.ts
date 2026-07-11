import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // standalone出力はAlmaLinux上でPM2から node .next/standalone/.../server.js を
  // 直接実行するために必要（start.sh参照）。Vercelではこの出力形式が
  // サーバーレス関数のルーティング生成と競合し全ルート404になるため、
  // Vercelのビルド環境（VERCEL=1が自動設定される）でのみ無効化する。
  output: process.env.VERCEL ? undefined : "standalone",
  // モノレポ直下にも pnpm-workspace.yaml があり、Next.js のワークスペースルート推定が
  // リポジトリ直下に誤検出されてビルド出力の配置がずれる（Vercelで全ルート404になる）
  // ため、明示的に frontend ディレクトリをルートとして固定する。
  turbopack: {
    root: __dirname,
  },
};

export default nextConfig;
