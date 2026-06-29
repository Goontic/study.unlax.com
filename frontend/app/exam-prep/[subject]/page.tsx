import type { Metadata } from "next";
import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { apiFetch } from "@/lib/api";
import type { Subject } from "@/lib/types";

interface Props {
  params: Promise<{ subject: string }>;
}

const EXAM_SUBJECT_SLUGS = ["exam-math", "exam-english", "exam-japanese", "exam-science", "exam-social"];

export async function generateStaticParams() {
  return EXAM_SUBJECT_SLUGS.map((subject) => ({ subject }));
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { subject: slug } = await params;
  try {
    const data = await apiFetch<Subject>(`/subjects/${slug}`);
    return {
      title: `高校入試対策 ${data.name} | 受験スタディ`,
      description: `高校入試の${data.name}対策。入試頻出の単元を効率よく学習できます。`,
    };
  } catch {
    return { title: "高校入試対策" };
  }
}

export default async function ExamPrepSubjectPage({ params }: Props) {
  const { subject: slug } = await params;
  if (!EXAM_SUBJECT_SLUGS.includes(slug)) notFound();

  // Redirect to the standard subject page which handles exam_prep subjects
  redirect(`/${slug}`);
}
