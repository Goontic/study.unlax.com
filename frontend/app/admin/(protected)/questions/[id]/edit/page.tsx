import { notFound } from "next/navigation";
import QuestionForm from "@/components/admin/QuestionForm";
import { prisma } from "@/lib/prisma";
import { findAllSubjects } from "@/lib/admin/subjects";
import { findAllTopics } from "@/lib/admin/topics";

export const dynamic = "force-dynamic";

interface Props {
  params: Promise<{ id: string }>;
}

export default async function EditQuestionPage({ params }: Props) {
  const { id } = await params;

  const question = await prisma.question.findUnique({
    where: { id: Number(id) },
    include: {
      choices: { orderBy: { displayOrder: "asc" } },
      blankAnswers: { orderBy: { blankIndex: "asc" } },
      orderItems: { orderBy: { correctPosition: "asc" } },
      steps: { orderBy: { stepNumber: "asc" } },
    },
  });
  if (!question) notFound();

  const [subjects, topics] = await Promise.all([findAllSubjects(), findAllTopics()]);

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">問題の編集</h1>
      <QuestionForm subjects={subjects} topics={topics} question={question} />
    </div>
  );
}
