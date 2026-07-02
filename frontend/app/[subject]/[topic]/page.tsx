import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { apiFetch } from "@/lib/api";
import type { Subject, Topic, Question } from "@/lib/types";
import TopicProgress from "@/components/quiz/TopicProgress";

interface Props {
  params: Promise<{ subject: string; topic: string }>;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { subject: subjectSlug, topic: topicSlug } = await params;
  try {
    const topic = await apiFetch<Topic>(`/subjects/${subjectSlug}/topics/${topicSlug}`);
    // 要点まとめがあれば冒頭を meta description に使う（単元ごとに固有の説明文にする）
    const summary = topic.description?.replace(/\s+/g, " ").trim();
    return {
      title: `${topic.name}の問題`,
      description: summary
        ? `${topic.name}を無料ドリルで学習。${summary.slice(0, 90)}${summary.length > 90 ? "…" : ""}`
        : `${topic.name}の対策問題を解いて理解を深めよう。解説付きの無料ドリルです。`,
    };
  } catch {
    return { title: "単元" };
  }
}

export async function generateStaticParams() {
  try {
    const subjects = await apiFetch<Subject[]>("/subjects");
    const pairs: { subject: string; topic: string }[] = [];
    for (const s of subjects) {
      const topics = await apiFetch<Topic[]>(`/subjects/${s.slug}/topics`);
      for (const t of topics) {
        pairs.push({ subject: s.slug, topic: t.slug });
      }
    }
    return pairs;
  } catch {
    return [];
  }
}

export default async function TopicPage({ params }: Props) {
  const { subject: subjectSlug, topic: topicSlug } = await params;
  let topicData: Topic;
  let questions: Question[];

  try {
    [topicData, questions] = await Promise.all([
      apiFetch<Topic>(`/subjects/${subjectSlug}/topics/${topicSlug}`),
      apiFetch<Question[]>(`/subjects/${subjectSlug}/topics/${topicSlug}/questions`),
    ]);
  } catch {
    notFound();
  }

  return (
    <div className="max-w-3xl mx-auto px-4 py-6">
      <div className="mb-6">
        <Link
          href={`/${subjectSlug}`}
          className="mb-3 inline-flex items-center gap-1 rounded-full bg-white border border-gray-200 px-3 py-1.5 text-xs font-bold text-gray-500 shadow-sm transition-colors hover:bg-gray-50 hover:text-gray-700"
        >
          ‹ 単元一覧へ
        </Link>
        <h1 className="text-2xl font-black text-gray-800">{topicData.name}</h1>
        <p className="text-gray-500 text-sm mt-1">全{questions.length}問</p>
      </div>

      {topicData.description && (
        <section className="mb-6 rounded-2xl border border-amber-200 bg-amber-50/70 p-5">
          <h2 className="mb-2 flex items-center gap-1.5 text-sm font-black text-amber-800">
            <span aria-hidden>📝</span> この単元の要点
          </h2>
          <p className="whitespace-pre-line text-sm leading-relaxed text-gray-700">
            {topicData.description}
          </p>
        </section>
      )}

      <TopicProgress
        subjectSlug={subjectSlug}
        topicSlug={topicSlug}
        questions={[...questions].sort((a, b) => a.displayOrder - b.displayOrder)}
      />
    </div>
  );
}
