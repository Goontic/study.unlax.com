import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { apiFetch } from "@/lib/api";
import type { SubjectWithTopics } from "@/lib/types";

interface Props {
  params: Promise<{ grade: string }>;
}

export async function generateStaticParams() {
  return ["1", "2", "3", "4", "5", "6"].map((grade) => ({ grade }));
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { grade } = await params;
  const n = Number(grade);
  if (n < 1 || n > 6) return { title: "学年" };
  return {
    title: `小学${n}年の問題一覧`,
    description: `小学${n}年の問題と解説が無料で使えます。算数・国語・理科・社会・英語をスマホで手軽に学習できます。`,
  };
}

export default async function ElementaryGradePage({ params }: Props) {
  const { grade } = await params;
  const gradeLevel = Number(grade);
  if (!Number.isInteger(gradeLevel) || gradeLevel < 1 || gradeLevel > 6) notFound();

  let subjects: SubjectWithTopics[];
  try {
    subjects = await apiFetch<SubjectWithTopics[]>(`/subjects/elementary/by-grade/${gradeLevel}`);
  } catch {
    notFound();
  }

  if (subjects.length === 0) notFound();

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <div className="mb-6">
        <p className="text-sm text-gray-400 mb-1">
          <Link href="/" className="hover:underline">小学校</Link>
          {" ›"}
        </p>
        <h1 className="text-2xl font-bold text-gray-800">小学{gradeLevel}年</h1>
        <p className="text-gray-500 text-sm mt-1">科目を選んで問題を解こう</p>
      </div>

      <div className="space-y-6">
        {subjects.map((subject) => (
          <section key={subject.slug} id={subject.slug}>
            <div className="flex items-center gap-2 mb-3">
              <span className="text-xl">{subject.icon}</span>
              <h2 className="text-base font-bold text-gray-700">{subject.name}</h2>
            </div>
            <ul className="space-y-2">
              {subject.topics.map((topic) => (
                <li key={topic.id}>
                  <Link
                    href={`/${subject.slug}/${topic.slug}`}
                    className="flex items-center justify-between rounded-xl bg-white border border-gray-200 px-5 py-3.5 shadow-sm active:bg-gray-50 transition-colors"
                  >
                    <span className="font-medium text-gray-800 text-sm">{topic.name}</span>
                    <span className="text-gray-400">›</span>
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        ))}
      </div>
    </div>
  );
}
