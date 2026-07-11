import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "standalone",
  // モノレポ直下にも pnpm-workspace.yaml があり、Next.js のワークスペースルート推定が
  // リポジトリ直下に誤検出されてビルド出力の配置がずれる（Vercelで全ルート404になる）
  // ため、明示的に frontend ディレクトリをルートとして固定する。
  turbopack: {
    root: __dirname,
  },
};

export default nextConfig;
