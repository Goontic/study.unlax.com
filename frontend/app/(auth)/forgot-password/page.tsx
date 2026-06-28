"use client";

import { useState } from "react";
import Link from "next/link";

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);
  const [sent, setSent] = useState(false);
  const [error, setError] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError("");
    try {
      await fetch("/api/auth/forgot-password", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email }),
      });
      setSent(true);
    } catch {
      setError("エラーが発生しました。もう一度お試しください。");
    } finally {
      setLoading(false);
    }
  };

  if (sent) {
    return (
      <div className="max-w-sm mx-auto px-4 py-10 text-center">
        <div className="text-5xl mb-4">📧</div>
        <h1 className="text-2xl font-bold text-gray-800 mb-3">メールを送信しました</h1>
        <p className="text-sm text-gray-600 mb-6">
          入力したメールアドレスに、パスワード再設定用のURLを送りました。
          メールが届くまで少々お待ちください。
        </p>
        <p className="text-xs text-gray-400 mb-8">
          メールが届かない場合は、迷惑メールフォルダもご確認ください。
        </p>
        <Link href="/login" className="text-blue-600 underline text-sm">
          ログイン画面に戻る
        </Link>
      </div>
    );
  }

  return (
    <div className="max-w-sm mx-auto px-4 py-10">
      <h1 className="text-2xl font-bold text-gray-800 mb-2">パスワードをお忘れの方へ</h1>
      <p className="text-sm text-gray-500 mb-6">
        登録したメールアドレスを入力してください。パスワード再設定用のURLをお送りします。
      </p>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            メールアドレス
          </label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
          />
        </div>
        {error && <p className="text-red-600 text-sm">{error}</p>}
        <button
          type="submit"
          disabled={loading}
          className="w-full rounded-xl bg-blue-600 text-white font-bold py-4 text-base disabled:opacity-40 active:bg-blue-700 transition-colors min-h-[56px]"
        >
          {loading ? "送信中…" : "再設定メールを送る"}
        </button>
      </form>
      <p className="mt-4 text-center text-sm text-gray-500">
        <Link href="/login" className="text-blue-600 underline">
          ログイン画面に戻る
        </Link>
      </p>
    </div>
  );
}
