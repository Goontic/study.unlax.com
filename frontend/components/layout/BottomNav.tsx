"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const NAV_ITEMS = [
  { href: "/", label: "ホーム", icon: "🏠" },
  { href: "/exam-prep", label: "入試対策", icon: "🎯" },
  { href: "/profile", label: "マイページ", icon: "👤" },
];

export default function BottomNav() {
  const pathname = usePathname();

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-40 bg-white border-t border-gray-200 pb-[env(safe-area-inset-bottom)]">
      <div className="max-w-3xl mx-auto flex">
        {NAV_ITEMS.map((item) => {
          const active =
            item.href === "/" ? pathname === "/" : pathname.startsWith(item.href);
          return (
            <Link
              key={item.href}
              href={item.href}
              className={`flex-1 flex flex-col items-center justify-center py-2 min-h-[56px] text-xs transition-colors ${
                active ? "font-black text-emerald-600" : "text-gray-500 hover:text-gray-700"
              }`}
            >
              <span
                className={`text-xl leading-none mb-0.5 transition-transform ${active ? "scale-110" : ""}`}
                aria-hidden
              >
                {item.icon}
              </span>
              <span>{item.label}</span>
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
