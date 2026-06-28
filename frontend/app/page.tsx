import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "受験スタディ | 中学生の高校受験対策",
  description:
    "高校受験の5科目（数学・英語・国語・理科・社会）を無料で勉強できるサイトです。スマホ・タブレットで移動中も学習できます。",
};

const SUBJECTS = [
  { slug: "math", name: "数学", icon: "🔢", color: "bg-blue-50 border-blue-200 text-blue-700" },
  { slug: "english", name: "英語", icon: "🔤", color: "bg-green-50 border-green-200 text-green-700" },
  { slug: "japanese", name: "国語", icon: "📖", color: "bg-red-50 border-red-200 text-red-700" },
  { slug: "science", name: "理科", icon: "🔬", color: "bg-purple-50 border-purple-200 text-purple-700" },
  { slug: "social", name: "社会", icon: "🌏", color: "bg-yellow-50 border-yellow-200 text-yellow-700" },
];

export default function HomePage() {
  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <section className="mb-8">
        <h1 className="text-2xl font-bold text-gray-800 mb-1">受験スタディ</h1>
        <p className="text-gray-500 text-sm">
          高校受験の勉強を、スマホで手軽に。全問題・解説が無料です。
        </p>
      </section>

      <section>
        <h2 className="text-base font-bold text-gray-700 mb-3">科目を選ぼう</h2>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-3">
          {SUBJECTS.map((subject) => (
            <Link
              key={subject.slug}
              href={`/${subject.slug}`}
              className={`flex flex-col items-center justify-center rounded-xl border-2 p-5 min-h-[96px] font-bold text-lg transition-opacity active:opacity-70 ${subject.color}`}
            >
              <span className="text-3xl mb-1">{subject.icon}</span>
              {subject.name}
            </Link>
          ))}
        </div>
      </section>
    </div>
  );
}
