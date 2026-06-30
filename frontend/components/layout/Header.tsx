import Link from "next/link";

export default function Header() {
  return (
    <header className="sticky top-0 z-40 bg-white border-b border-gray-200 shadow-sm">
      <div className="max-w-2xl mx-auto px-4 h-14 flex items-center justify-between">
        <Link href="/" className="flex flex-col leading-tight">
          <span className="text-lg font-bold text-blue-600">ポケスタ</span>
          <span className="text-[10px] text-gray-400 font-normal -mt-0.5">スキマ時間で合格を掴む無料ドリル</span>
        </Link>
        <Link
          href="/profile"
          className="text-sm text-gray-600 hover:text-blue-600 transition-colors"
        >
          マイページ
        </Link>
      </div>
    </header>
  );
}
