import Link from "next/link";

export default function Header() {
  return (
    <header className="sticky top-0 z-40 bg-white border-b border-gray-200 shadow-sm">
      <div className="max-w-2xl mx-auto px-4 h-14 flex items-center justify-between gap-3">
        {/* ロゴ */}
        <Link href="/" className="flex items-center gap-1.5 flex-shrink-0">
          <span className="text-xl" aria-hidden>🚀</span>
          <div className="flex flex-col leading-tight">
            <span className="text-base font-black text-emerald-600">ポケスタ</span>
            <span className="text-[10px] text-gray-400 font-normal -mt-0.5 hidden sm:block">
              スキマ時間で合格を掴む無料ドリル
            </span>
          </div>
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
