import Link from "next/link";

export default function Header() {
  return (
    <header className="sticky top-0 z-40 bg-white border-b border-gray-200 shadow-sm">
      <div className="max-w-2xl mx-auto px-4 h-14 flex items-center justify-between">
        <Link href="/" className="text-lg font-bold text-blue-600">
          受験スタディ
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
