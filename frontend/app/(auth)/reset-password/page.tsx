"use client";

import { useState, Suspense } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import Link from "next/link";

function ResetPasswordForm() {
  const searchParams = useSearchParams();
  const router = useRouter();
  const token = searchParams.get("token") ?? "";

  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [done, setDone] = useState(false);

  if (!token) {
    return (
      <div className="max-w-sm mx-auto px-4 py-10 text-center">
        <p className="text-red-600 mb-4">無効なURLです。</p>
        <Link href="/forgot-password" className="text-blue-600 underline text-sm">
          パスワード再設定をやり直す
        </Link>
      </div>
    );
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (password !== confirm) {
      setError("パスワードが一致しません");
      return;
    }
    setLoading(true);
    setError("");
    try {
      const res = await fetch("/api/auth/reset-password", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ token, password }),
      });
      if (!res.ok) {
        const data = (await res.json()) as { message?: string };
        setError(data.message ?? "パスワードの再設定に失敗しました。URLが無効または期限切れです。");
        return;
      }
      setDone(true);
      setTimeout(() => router.push("/login"), 3000);
    } catch {
      setError("エラーが発生しました。もう一度お試しください。");
    } finally {
      setLoading(false);
    }
  };

  if (done) {
    return (
      <div className="max-w-sm mx-auto px-4 py-10 text-center">
        <div className="text-5xl mb-4">✅</div>
        <h1 className="text-2xl font-bold text-gray-800 mb-3">パスワードを変更しました</h1>
        <p className="text-sm text-gray-600 mb-6">
          新しいパスワードでログインできます。まもなくログイン画面に移動します。
        </p>
        <Link href="/login" className="text-blue-600 underline text-sm">
          今すぐログイン画面へ
        </Link>
      </div>
    );
  }

  return (
    <div className="max-w-sm mx-auto px-4 py-10">
      <h1 className="text-2xl font-bold text-gray-800 mb-2">新しいパスワードを設定</h1>
      <p className="text-sm text-gray-500 mb-6">6文字以上のパスワードを入力してください。</p>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            新しいパスワード（6文字以上）
          </label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            minLength={6}
            required
            className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
          />
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            パスワード（確認）
          </label>
          <input
            type="password"
            value={confirm}
            onChange={(e) => setConfirm(e.target.value)}
            minLength={6}
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
          {loading ? "変更中…" : "パスワードを変更する"}
        </button>
      </form>
    </div>
  );
}

export default function ResetPasswordPage() {
  return (
    <Suspense>
      <ResetPasswordForm />
    </Suspense>
  );
}
