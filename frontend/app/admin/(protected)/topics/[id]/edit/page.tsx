import { notFound } from "next/navigation";
import { getAdminToken } from "@/lib/admin-auth";
import TopicForm from "@/components/admin/TopicForm";
import type { Subject, Topic } from "@/lib/types";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

interface Props {
  params: Promise<{ id: string }>;
}

export default async function EditTopicPage({ params }: Props) {
  const { id } = await params;
  const token = (await getAdminToken())!;

  const [topicRes, subjectsRes] = await Promise.all([
    fetch(`${API_BASE}/admin/topics/${id}`, {
      headers: { Authorization: `Bearer ${token}` },
      cache: "no-store",
    }),
    fetch(`${API_BASE}/admin/subjects`, {
      headers: { Authorization: `Bearer ${token}` },
      cache: "no-store",
    }),
  ]);
  if (!topicRes.ok) notFound();

  const topic = (await topicRes.json()) as Topic;
  const subjects = (subjectsRes.ok ? await subjectsRes.json() : []) as Subject[];

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">単元の編集</h1>
      <TopicForm subjects={subjects} topic={topic} />
    </div>
  );
}
