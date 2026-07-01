import type { Metadata } from "next";
import Link from "next/link";
import { apiFetch } from "@/lib/api";
import type { SubjectWithTopics } from "@/lib/types";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "検定対策 | ポケスタ",
  description: "英検・漢検・数検など各種検定試験の対策問題を無料で学習できます。",
};

export default async function CertificationPage() {
  let subjects: SubjectWithTopics[] = [];
  try {
    subjects = await apiFetch<SubjectWithTopics[]>("/subjects/certification");
  } catch {
    subjects = [];
  }

  return (
    <div className="max-w-3xl mx-auto px-4 py-6">
      <div className="mb-6">
        <p className="text-sm text-gray-400 mb-1">
          <Link href="/" className="hover:underline">トップ</Link>
          {" ›"}
        </p>
        <h1 className="text-2xl font-bold text-gray-800">📖 検定対策</h1>
        <p className="text-gray-500 text-sm mt-1">各種検定試験の対策問題で効率よく学習しよう</p>
      </div>

      {subjects.length > 0 ? (
        <div className="grid grid-cols-2 gap-3 mb-8 sm:grid-cols-3">
          {subjects.map((subject) => (
            <Link
              key={subject.slug}
              href={`/${subject.slug}`}
              className="flex flex-col items-center justify-center rounded-2xl border-2 py-5 px-3 text-center transition-all active:scale-95 active:opacity-70 bg-indigo-50 border-indigo-200 text-indigo-700"
            >
              <span className="text-3xl mb-2">{subject.icon}</span>
              <span className="text-sm font-bold leading-tight">{subject.name}</span>
              <span className="text-xs mt-1 opacity-70">{subject.topics.length}単元</span>
            </Link>
          ))}
        </div>
      ) : (
        <div className="rounded-3xl bg-gradient-to-br from-indigo-50 to-blue-100 border-2 border-indigo-200 p-5 text-center">
          <p className="text-3xl mb-2" aria-hidden>🚧</p>
          <p className="font-black text-indigo-700 text-sm mb-1">検定コンテンツ</p>
          <p className="text-indigo-500 text-xs font-bold">まもなく公開！お楽しみに ✨</p>
        </div>
      )}
    </div>
  );
}
