import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { apiFetch } from "@/lib/api";
import type { Subject, Topic, Question } from "@/lib/types";

const DIFFICULTY_LABEL = ["", "★☆☆☆☆", "★★☆☆☆", "★★★☆☆", "★★★★☆", "★★★★★"];

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
    <div className="max-w-2xl mx-auto px-4 py-6">
      <div className="mb-6">
        <p className="text-sm text-gray-400 mb-1">
          <Link href={`/${subjectSlug}`} className="hover:underline">
            科目
          </Link>{" "}
          ›
        </p>
        <h1 className="text-2xl font-bold text-gray-800">{topicData.name}</h1>
        <p className="text-gray-500 text-sm mt-1">全{questions.length}問</p>
      </div>

      <ul className="space-y-3">
        {questions.map((q, idx) => (
          <li key={q.id}>
            <Link
              href={`/${subjectSlug}/${topicSlug}/${q.id}`}
              className="flex items-center gap-4 rounded-xl bg-white border border-gray-200 px-5 py-4 shadow-sm active:bg-gray-50 transition-colors"
            >
              <span className="text-gray-400 font-medium w-8 shrink-0 text-center">
                {idx + 1}
              </span>
              <div className="flex-1 min-w-0">
                <p className="text-gray-800 text-sm leading-snug line-clamp-2">{q.body}</p>
                <p className="text-yellow-500 text-xs mt-1">{DIFFICULTY_LABEL[q.difficulty]}</p>
              </div>
              <span className="text-gray-400 shrink-0">›</span>
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
}
