import { notFound } from "next/navigation";
import TopicForm from "@/components/admin/TopicForm";
import { prisma } from "@/lib/prisma";
import { findAllSubjects } from "@/lib/admin/subjects";

export const dynamic = "force-dynamic";

interface Props {
  params: Promise<{ id: string }>;
}

export default async function EditTopicPage({ params }: Props) {
  const { id } = await params;

  const [topic, subjects] = await Promise.all([
    prisma.topic.findUnique({ where: { id: Number(id) } }),
    findAllSubjects(),
  ]);
  if (!topic) notFound();

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">単元の編集</h1>
      <TopicForm subjects={subjects} topic={topic} />
    </div>
  );
}
