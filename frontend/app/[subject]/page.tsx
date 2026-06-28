import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { apiFetch } from "@/lib/api";
import type { Subject, Topic } from "@/lib/types";

interface Props {
  params: Promise<{ subject: string }>;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { subject: slug } = await params;
  try {
    const data = await apiFetch<Subject>(`/subjects/${slug}`);
    return {
      title: `${data.name}の問題一覧`,
      description: `高校受験対策の${data.name}問題を単元別に学習できます。`,
    };
  } catch {
    return { title: "科目" };
  }
}

export async function generateStaticParams() {
  try {
    const subjects = await apiFetch<Subject[]>("/subjects");
    return subjects.map((s) => ({ subject: s.slug }));
  } catch {
    return [];
  }
}

export default async function SubjectPage({ params }: Props) {
  const { subject: slug } = await params;
  let subjectData: Subject;
  let topics: Topic[];

  try {
    [subjectData, topics] = await Promise.all([
      apiFetch<Subject>(`/subjects/${slug}`),
      apiFetch<Topic[]>(`/subjects/${slug}/topics`),
    ]);
  } catch {
    notFound();
  }

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">
          {subjectData.icon} {subjectData.name}
        </h1>
        <p className="text-gray-500 text-sm mt-1">単元を選んで問題を解こう</p>
      </div>

      <ul className="space-y-3">
        {topics.map((topic) => (
          <li key={topic.id}>
            <Link
              href={`/${slug}/${topic.slug}`}
              className="flex items-center justify-between rounded-xl bg-white border border-gray-200 px-5 py-4 shadow-sm active:bg-gray-50 transition-colors"
            >
              <div>
                <span className="font-medium text-gray-800">{topic.name}</span>
                <span className="ml-2 text-xs text-gray-400">{topic.gradeLevel}年生</span>
              </div>
              <span className="text-gray-400">›</span>
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
}
