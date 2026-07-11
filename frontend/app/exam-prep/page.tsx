import type { Metadata } from "next";
import Link from "next/link";
import { getExamPrepSubjects } from "@/lib/data";
import type { SubjectWithTopics } from "@/lib/types";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "高校入試対策 | ポケスタ",
  description:
    "高校入試の傾向に合わせたオリジナル問題で無料受験対策。数学・英語・国語・理科・社会の5科目を中学生がスキマ時間に効率よく学習できます。",
};

const SUBJECT_COLORS: Record<string, string> = {
  "exam-math":    "bg-blue-50 border-blue-200 text-blue-700",
  "exam-english": "bg-green-50 border-green-200 text-green-700",
  "exam-japanese":"bg-purple-50 border-purple-200 text-purple-700",
  "exam-science": "bg-teal-50 border-teal-200 text-teal-700",
  "exam-social":  "bg-orange-50 border-orange-200 text-orange-700",
};

export default async function ExamPrepPage() {
  let subjects: SubjectWithTopics[] = [];
  try {
    subjects = await getExamPrepSubjects();
  } catch {
    subjects = [];
  }

  return (
    <div className="max-w-3xl mx-auto px-4 py-6">
      <div className="mb-6">
        <Link
          href="/"
          className="mb-3 inline-flex items-center gap-1 rounded-full bg-white border border-gray-200 px-3 py-1.5 text-xs font-bold text-gray-500 shadow-sm transition-colors hover:bg-gray-50 hover:text-gray-700"
        >
          ‹ ホーム
        </Link>
        <h1 className="text-2xl font-black text-gray-800">🎯 高校入試対策</h1>
        <p className="text-gray-500 text-sm mt-1">入試傾向に合わせたオリジナル問題で効率よく対策しよう</p>
      </div>

      <div className="grid grid-cols-2 gap-3 mb-8 sm:grid-cols-3">
        {subjects.map((subject) => {
          const colorClass = SUBJECT_COLORS[subject.slug] ?? "bg-red-50 border-red-200 text-red-700";
          return (
            <Link
              key={subject.slug}
              href={`/${subject.slug}`}
              className={`flex flex-col items-center justify-center rounded-2xl border-2 py-5 px-3 text-center shadow-sm transition-all hover:-translate-y-0.5 hover:shadow-md active:scale-95 ${colorClass}`}
            >
              <span className="text-3xl mb-2">{subject.icon}</span>
              <span className="text-sm font-bold leading-tight">{subject.name}</span>
              <span className="text-xs mt-1 opacity-70">{subject.topics.length}単元</span>
            </Link>
          );
        })}
      </div>

      <section className="rounded-2xl bg-red-50 border border-red-200 p-5">
        <h2 className="text-sm font-bold text-red-700 mb-3">📌 入試対策のポイント</h2>
        <ul className="space-y-2 text-sm text-red-800">
          <li>✅ 各都道府県の公立高校入試の傾向に合わせた問題</li>
          <li>✅ 基礎から応用まで段階的に学習できる</li>
          <li>✅ 解説付きで解き方の流れを確認できる</li>
          <li>✅ 苦手な単元を繰り返し練習できる</li>
        </ul>
      </section>
    </div>
  );
}
