import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { apiFetch } from "@/lib/api";
import type { Subject, Topic } from "@/lib/types";

interface Props {
  params: Promise<{ level: string; subject: string }>;
}

export async function generateStaticParams() {
  try {
    const subjects = await apiFetch<Subject[]>("/subjects");
    return subjects.flatMap((s) =>
      ["1", "2", "3"].map((level) => ({ level, subject: s.slug })),
    );
  } catch {
    return [];
  }
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { level, subject: subjectSlug } = await params;
  try {
    const s = await apiFetch<Subject>(`/subjects/${subjectSlug}`);
    return {
      title: `中学${level}年・${s.name}の問題一覧`,
      description: `中学${level}年の${s.name}の問題と解説が無料で使えます。`,
    };
  } catch {
    return { title: "問題一覧" };
  }
}

export default async function GradeSubjectPage({ params }: Props) {
  const { level, subject: subjectSlug } = await params;
  const gradeLevel = Number(level);
  if (!Number.isInteger(gradeLevel) || gradeLevel < 1 || gradeLevel > 3) notFound();

  let subjectData: Subject;
  let topics: Topic[];
  try {
    [subjectData, topics] = await Promise.all([
      apiFetch<Subject>(`/subjects/${subjectSlug}`),
      apiFetch<Topic[]>(`/subjects/${subjectSlug}/topics`),
    ]);
  } catch {
    notFound();
  }

  const gradeTopics = topics
    .filter((t) => t.gradeLevel === gradeLevel)
    .sort((a, b) => a.displayOrder - b.displayOrder);

  if (gradeTopics.length === 0) notFound();

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <div className="mb-6">
        <p className="text-sm text-gray-400 mb-1">
          <Link href="/" className="hover:underline">中学</Link>
          {" › "}
          <Link href={`/grade/${level}`} className="hover:underline">中学{level}年</Link>
          {" › "}
        </p>
        <h1 className="text-2xl font-bold text-gray-800">
          {subjectData.icon} {subjectData.name}
        </h1>
        <p className="text-gray-500 text-sm mt-1">中学{level}年 · 全{gradeTopics.length}単元</p>
      </div>

      <ul className="space-y-3">
        {gradeTopics.map((topic) => (
          <li key={topic.id}>
            <Link
              href={`/${subjectSlug}/${topic.slug}`}
              className="flex items-center justify-between rounded-xl bg-white border border-gray-200 px-5 py-4 shadow-sm active:bg-gray-50 transition-colors"
            >
              <span className="font-medium text-gray-800">{topic.name}</span>
              <span className="text-gray-400">›</span>
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
}
