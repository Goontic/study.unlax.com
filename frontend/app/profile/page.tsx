import { auth } from "@/lib/auth";
import { redirect } from "next/navigation";
import type { Metadata } from "next";
import SignOutButton from "./SignOutButton";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

export const metadata: Metadata = {
  title: "マイページ",
};

interface Stats {
  total: number;
  correct: number;
  accuracy: number;
}

async function fetchStats(accessToken: string): Promise<Stats | null> {
  try {
    const res = await fetch(`${API_BASE}/progress/stats`, {
      headers: { Authorization: `Bearer ${accessToken}` },
      cache: "no-store",
    });
    if (!res.ok) return null;
    return res.json() as Promise<Stats>;
  } catch {
    return null;
  }
}

export default async function ProfilePage() {
  const session = await auth();
  if (!session?.user) redirect("/login");

  const accessToken = (session as { accessToken?: string }).accessToken;
  const stats = accessToken ? await fetchStats(accessToken) : null;

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <h1 className="text-2xl font-bold text-gray-800 mb-6">マイページ</h1>

      <div className="bg-white rounded-xl border border-gray-200 p-5 shadow-sm mb-6">
        <p className="font-bold text-lg text-gray-800">{session.user.name}</p>
        <p className="text-gray-500 text-sm">{session.user.email}</p>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-5 shadow-sm mb-6">
        <h2 className="font-bold text-gray-700 mb-4">学習統計</h2>
        {stats && stats.total > 0 ? (
          <div className="grid grid-cols-3 gap-4 text-center">
            <div className="bg-blue-50 rounded-xl py-4">
              <p className="text-3xl font-bold text-blue-600">{stats.total}</p>
              <p className="text-xs text-gray-500 mt-1">回答数</p>
            </div>
            <div className="bg-green-50 rounded-xl py-4">
              <p className="text-3xl font-bold text-green-600">{stats.correct}</p>
              <p className="text-xs text-gray-500 mt-1">正解数</p>
            </div>
            <div className="bg-purple-50 rounded-xl py-4">
              <p className="text-3xl font-bold text-purple-600">{stats.accuracy}%</p>
              <p className="text-xs text-gray-500 mt-1">正答率</p>
            </div>
          </div>
        ) : (
          <p className="text-gray-500 text-sm">
            統計データは学習を進めると表示されます。
          </p>
        )}
      </div>

      <SignOutButton />
    </div>
  );
}
