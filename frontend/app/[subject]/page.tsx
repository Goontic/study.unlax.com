import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { getSubjectBySlug, getSubjects, getTopics } from "@/lib/data";
import type { Subject, Topic } from "@/lib/types";

interface Props {
  params: Promise<{ subject: string }>;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { subject: slug } = await params;
  try {
    const data = await getSubjectBySlug(slug);
    if (!data) return { title: "科目" };
    const description =
      data.genre === "certification"
        ? `${data.name}の検定対策問題を単元別に学習できます。`
        : `高校受験対策の${data.name}問題を単元別に学習できます。`;
    return {
      title: `${data.name}の問題一覧`,
      description,
    };
  } catch {
    return { title: "科目" };
  }
}

export async function generateStaticParams() {
  try {
    const subjects = await getSubjects();
    return subjects.map((s) => ({ subject: s.slug }));
  } catch {
    return [];
  }
}

export default async function SubjectPage({ params }: Props) {
  const { subject: slug } = await params;

  const [subjectResult, topics]: [Subject | null, Topic[]] = await Promise.all([
    getSubjectBySlug(slug),
    getTopics(slug),
  ]);
  if (!subjectResult) notFound();
  const subjectData = subjectResult;

  const sorted = [...topics].sort((a, b) => a.displayOrder - b.displayOrder);

  const isCertification = subjectData.genre === "certification";
  const isExamPrep = !isCertification && subjectData.schoolLevel === "exam_prep";
  const isElementary = !isCertification && subjectData.schoolLevel === "elementary";

  const gradeGroups = sorted.reduce<Map<number, Topic[]>>((map, t) => {
    const list = map.get(t.gradeLevel) ?? [];
    list.push(t);
    map.set(t.gradeLevel, list);
    return map;
  }, new Map());
  const grades = [...gradeGroups.keys()].sort((a, b) => a - b);

  const gradeLabel = (g: number) => {
    if (isExamPrep) return "入試対策";
    if (isCertification) return `${g}級`;
    if (isElementary) return `小学${g}年`;
    return `中学${g}年`;
  };

  const backHref = isExamPrep ? "/exam-prep" : isCertification ? "/certification" : "/";
  const breadcrumbLabel = isExamPrep
    ? "高校入試対策"
    : isCertification
      ? "検定"
      : isElementary
        ? "小学校"
        : "トップ";

  return (
    <div className="max-w-3xl mx-auto px-4 py-6">
      <div className="mb-6">
        <Link
          href={backHref}
          className="mb-3 inline-flex items-center gap-1 rounded-full bg-white border border-gray-200 px-3 py-1.5 text-xs font-bold text-gray-500 shadow-sm transition-colors hover:bg-gray-50 hover:text-gray-700"
        >
          ‹ {breadcrumbLabel}
        </Link>
        <div className="flex items-center gap-3">
          <span
            className="flex h-12 w-12 items-center justify-center rounded-2xl bg-white border border-gray-200 text-2xl shadow-sm"
            aria-hidden
          >
            {subjectData.icon}
          </span>
          <div>
            <h1 className="text-2xl font-black text-gray-800">{subjectData.name}</h1>
            <p className="text-gray-500 text-sm mt-0.5">
              {isExamPrep ? "入試傾向別に対策しよう" : "単元を選んで問題を解こう"}
            </p>
          </div>
        </div>
      </div>

      <div className="space-y-8">
        {grades.map((grade) => (
          <section key={grade}>
            {!isExamPrep && (
              <h2 className="mb-3 inline-block rounded-full bg-emerald-100 px-3 py-1 text-xs font-black text-emerald-700">
                {gradeLabel(grade)}
              </h2>
            )}
            <ul className="space-y-3">
              {gradeGroups.get(grade)!.map((topic) => (
                <li key={topic.id}>
                  <Link
                    href={`/${slug}/${topic.slug}`}
                    className="flex items-center justify-between rounded-2xl bg-white border border-gray-200 px-5 py-4 shadow-sm transition-colors hover:border-emerald-300 hover:bg-emerald-50/40 active:bg-gray-50"
                  >
                    <span className="font-bold text-gray-800">{topic.name}</span>
                    <span className="text-gray-300">›</span>
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
