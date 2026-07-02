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

      <div className="max-w-3xl mx-auto px-4 py-5 space-y-6">
        <div>
          <div className="flex items-center gap-3">
            <Link
              href={`/${subjectSlug}/${topicSlug}`}
              aria-label={`${topic.name}の問題一覧に戻る`}
              className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full text-lg text-gray-400 transition-colors hover:bg-gray-100 hover:text-gray-600"
            >
              ✕
            </Link>
            <div
              className="h-3.5 flex-1 rounded-full bg-gray-200 overflow-hidden"
              role="progressbar"
              aria-valuenow={currentIndex + 1}
              aria-valuemax={sorted.length}
            >
              <div
                className="h-full rounded-full bg-emerald-500 transition-all duration-500"
                style={{ width: `${((currentIndex + 1) / sorted.length) * 100}%` }}
              />
            </div>
            <span className="shrink-0 rounded-full bg-emerald-100 px-2.5 py-1 text-xs font-black text-emerald-700">
              {currentIndex + 1} / {sorted.length}
            </span>
          </div>
          <h1 className="mt-3 text-sm font-bold text-gray-500">
            {subject.icon} {subject.name}｜{topic.name}
          </h1>
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
