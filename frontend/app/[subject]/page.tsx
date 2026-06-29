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

  const sorted = [...topics].sort((a, b) => a.displayOrder - b.displayOrder);

  const isExamPrep = subjectData.schoolLevel === "exam_prep";
  const isElementary = subjectData.schoolLevel === "elementary";

  const gradeGroups = sorted.reduce<Map<number, Topic[]>>((map, t) => {
    const list = map.get(t.gradeLevel) ?? [];
    list.push(t);
    map.set(t.gradeLevel, list);
    return map;
  }, new Map());
  const grades = [...gradeGroups.keys()].sort((a, b) => a - b);

  const gradeLabel = (g: number) => {
    if (isExamPrep) return "入試対策";
    if (isElementary) return `小学${g}年`;
    return `中学${g}年`;
  };

  const backHref = isExamPrep ? "/exam-prep" : "/";

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <div className="mb-6">
        <p className="text-sm text-gray-400 mb-1">
          <Link href={backHref} className="hover:underline">
            {isExamPrep ? "高校入試対策" : isElementary ? "小学校" : "トップ"}
          </Link>
          {" ›"}
        </p>
        <h1 className="text-2xl font-bold text-gray-800">
          {subjectData.icon} {subjectData.name}
        </h1>
        <p className="text-gray-500 text-sm mt-1">
          {isExamPrep ? "入試傾向別に対策しよう" : "単元を選んで問題を解こう"}
        </p>
      </div>

      <div className="space-y-8">
        {grades.map((grade) => (
          <section key={grade}>
            {!isExamPrep && (
              <h2 className="text-sm font-bold text-gray-400 uppercase tracking-wide mb-3">
                {gradeLabel(grade)}
              </h2>
            )}
            <ul className="space-y-3">
              {gradeGroups.get(grade)!.map((topic) => (
                <li key={topic.id}>
                  <Link
                    href={`/${slug}/${topic.slug}`}
                    className="flex items-center justify-between rounded-xl bg-white border border-gray-200 px-5 py-4 shadow-sm active:bg-gray-50 transition-colors"
                  >
                    <span className="font-medium text-gray-800">{topic.name}</span>
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
