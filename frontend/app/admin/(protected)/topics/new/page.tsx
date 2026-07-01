import { getAdminToken } from "@/lib/admin-auth";
import TopicForm from "@/components/admin/TopicForm";
import type { Subject } from "@/lib/types";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

interface Props {
  searchParams: Promise<{ subjectId?: string }>;
}

export default async function NewTopicPage({ searchParams }: Props) {
  const { subjectId } = await searchParams;
  const token = (await getAdminToken())!;
  const res = await fetch(`${API_BASE}/admin/subjects`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  const subjects = (res.ok ? await res.json() : []) as Subject[];

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">単元の新規作成</h1>
      <TopicForm subjects={subjects} defaultSubjectId={subjectId ? Number(subjectId) : undefined} />
    </div>
  );
}
