"use client";

import { signOut } from "next-auth/react";

export default function SignOutButton() {
  return (
    <button
      onClick={() => signOut({ callbackUrl: "/" })}
      className="w-full rounded-xl border-2 border-gray-200 text-gray-600 font-medium py-4 text-base active:bg-gray-50 transition-colors min-h-[56px]"
    >
      ログアウト
    </button>
  );
}
