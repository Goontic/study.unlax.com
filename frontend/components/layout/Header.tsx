import Link from "next/link";
import Image from "next/image";

export default function Header() {
  return (
    <header className="sticky top-0 z-40 bg-white border-b border-gray-200 shadow-sm">
      <div className="max-w-3xl mx-auto px-4 h-16 flex items-center justify-between gap-3">
        {/* ロゴ画像 */}
        <Link href="/" className="flex-shrink-0">
          <Image
            src="/images/logo.png"
            alt="ポケスタ - スキマ時間で合格を掴む無料ドリル"
            width={160}
            height={46}
            priority
            unoptimized
          />
        </Link>

        {/* ナビボタン */}
        <div className="flex items-center gap-2">
          <Link
            href="/login"
            className="text-xs text-gray-600 font-bold px-3 py-1.5 rounded-full border border-gray-300 hover:bg-gray-50 active:bg-gray-100 transition-colors"
          >
            ログイン
          </Link>
          <Link
            href="/register"
            className="text-xs text-white font-bold px-3 py-1.5 rounded-full bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 transition-colors shadow-sm"
          >
            無料登録
          </Link>
        </div>
      </div>
    </header>
  );
}
