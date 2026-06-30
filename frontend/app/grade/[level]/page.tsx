import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { apiFetch } from "@/lib/api";
import type { SubjectWithTopics } from "@/lib/types";

interface Props {
  params: Promise<{ level: string }>;
}

export async function generateStaticParams() {
  return [{ level: "1" }, { level: "2" }, { level: "3" }];
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { level } = await params;
  const n = Number(level);
  if (n < 1 || n > 3) return { title: "学年" };
  return {
    title: `中学${n}年の問題一覧`,
    description: `中学${n}年の5科目（数学・英語・国語・理科・社会）の問題と解説が無料で使えます。`,
  };
}

export default async function GradePage({ params }: Props) {
  const { level } = await params;
  const gradeLevel = Number(level);
  if (!Number.isInteger(gradeLevel) || gradeLevel < 1 || gradeLevel > 3) notFound();

  let subjects: SubjectWithTopics[];
  try {
    subjects = await apiFetch<SubjectWithTopics[]>(`/subjects/by-grade/${gradeLevel}`);
  } catch {
    notFound();
  }

  return (
    <div className="max-w-3xl mx-auto px-4 py-6">
      <div className="mb-6">
        <p className="text-sm text-gray-400 mb-1">
          <Link href="/" className="hover:underline">中学</Link> ›
        </p>
        <h1 className="text-2xl font-bold text-gray-800">中学{gradeLevel}年</h1>
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
