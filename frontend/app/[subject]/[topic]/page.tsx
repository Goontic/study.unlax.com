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
    return {
      title: `${topic.name}の問題`,
      description: `${topic.name}の高校受験対策問題を解いて理解を深めよう。`,
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

      <TopicProgress
        subjectSlug={subjectSlug}
        topicSlug={topicSlug}
        questions={[...questions].sort((a, b) => a.displayOrder - b.displayOrder)}
      />
    </div>
  );
}
