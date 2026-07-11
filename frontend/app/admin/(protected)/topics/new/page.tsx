import TopicForm from "@/components/admin/TopicForm";
import { findAllSubjects } from "@/lib/admin/subjects";

export const dynamic = "force-dynamic";

interface Props {
  searchParams: Promise<{ subjectId?: string }>;
}

export default async function NewTopicPage({ searchParams }: Props) {
  const { subjectId } = await searchParams;
  const subjects = await findAllSubjects();

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">単元の新規作成</h1>
      <TopicForm subjects={subjects} defaultSubjectId={subjectId ? Number(subjectId) : undefined} />
    </div>
  );
}
