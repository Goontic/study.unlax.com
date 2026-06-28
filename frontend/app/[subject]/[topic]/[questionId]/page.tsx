import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { apiFetch } from "@/lib/api";
import type { Question, Subject, Topic } from "@/lib/types";
import MultipleChoice from "@/components/quiz/MultipleChoice";
import TextInput from "@/components/quiz/TextInput";
import FillBlank from "@/components/quiz/FillBlank";
import Ordering from "@/components/quiz/Ordering";

interface Props {
  params: Promise<{ subject: string; topic: string; questionId: string }>;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { questionId } = await params;
  try {
    const q = await apiFetch<Question>(`/questions/${questionId}`);
    return {
      title: q.body.slice(0, 40),
      description: `${q.body.slice(0, 80)} — 解説付きの高校受験対策問題`,
    };
  } catch {
    return { title: "問題" };
  }
}

function buildJsonLd(q: Question, subject: Subject, topic: Topic) {
  const correctAnswer =
    q.type === "multiple_choice"
      ? q.choices?.find((c) => c.isCorrect)?.body
      : q.type === "text_input"
      ? q.blankAnswers?.[0]?.correctAnswer
      : undefined;

  return {
    "@context": "https://schema.org",
    "@type": "Question",
    name: q.body,
    text: q.body,
    answerCount: q.choices?.length ?? 1,
    acceptedAnswer: correctAnswer
      ? {
          "@type": "Answer",
          text: correctAnswer,
          ...(q.steps?.length
            ? { description: q.steps.map((s) => s.body).join(" ") }
            : {}),
        }
      : undefined,
    about: {
      "@type": "Thing",
      name: `${subject.name} - ${topic.name}`,
    },
  };
}

export default async function QuestionPage({ params }: Props) {
  const { subject: subjectSlug, topic: topicSlug, questionId } = await params;
  let question: Question;
  let subject: Subject;
  let topic: Topic;

  let questions: Question[] = [];
  try {
    [question, subject, topic, questions] = await Promise.all([
      apiFetch<Question>(`/questions/${questionId}`),
      apiFetch<Subject>(`/subjects/${subjectSlug}`),
      apiFetch<Topic>(`/subjects/${subjectSlug}/topics/${topicSlug}`),
      apiFetch<Question[]>(`/subjects/${subjectSlug}/topics/${topicSlug}/questions`),
    ]);
  } catch {
    notFound();
  }

  const sorted = [...questions].sort((a, b) => a.displayOrder - b.displayOrder);
  const currentIndex = sorted.findIndex((q) => q.id === question.id);
  const nextQuestion = sorted[currentIndex + 1] ?? null;
  const nextHref = nextQuestion
    ? `/${subjectSlug}/${topicSlug}/${nextQuestion.id}`
    : `/${subjectSlug}/${topicSlug}`;
  const isLast = currentIndex === sorted.length - 1;

  const jsonLd = buildJsonLd(question, subject, topic);

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      <div className="max-w-2xl mx-auto px-4 py-6 space-y-6">
        <div>
          <p className="text-sm text-gray-400 mb-1">
            <Link href={`/${subjectSlug}`} className="hover:underline">
              {subject.name}
            </Link>{" "}
            ›{" "}
            <Link href={`/${subjectSlug}/${topicSlug}`} className="hover:underline">
              {topic.name}
            </Link>{" "}
            ›
          </p>
          <div className="flex items-center justify-between">
            <h1 className="text-base font-bold text-gray-700">問題</h1>
            <span className="text-sm text-gray-400">
              {currentIndex + 1} / {sorted.length}
            </span>
          </div>
          <div className="mt-2 h-1.5 rounded-full bg-gray-100 overflow-hidden">
            <div
              className="h-full rounded-full bg-blue-400 transition-all"
              style={{ width: `${((currentIndex + 1) / sorted.length) * 100}%` }}
            />
          </div>
        </div>

        {question.type === "multiple_choice" && (
          <MultipleChoice
            questionId={question.id}
            body={question.body}
            choices={question.choices ?? []}
            steps={question.steps ?? []}
            nextHref={nextHref}
            isLast={isLast}
          />
        )}

        {question.type === "text_input" && (
          <TextInput
            questionId={question.id}
            body={question.body}
            correctAnswer={question.blankAnswers?.[0]?.correctAnswer ?? ""}
            steps={question.steps ?? []}
            nextHref={nextHref}
            isLast={isLast}
          />
        )}

        {question.type === "fill_blank" && (
          <FillBlank
            questionId={question.id}
            body={question.body}
            blankAnswers={question.blankAnswers ?? []}
            steps={question.steps ?? []}
            nextHref={nextHref}
            isLast={isLast}
          />
        )}

        {question.type === "ordering" && (
          <Ordering
            questionId={question.id}
            body={question.body}
            orderItems={question.orderItems ?? []}
            steps={question.steps ?? []}
            nextHref={nextHref}
            isLast={isLast}
          />
        )}
      </div>
    </>
  );
}
