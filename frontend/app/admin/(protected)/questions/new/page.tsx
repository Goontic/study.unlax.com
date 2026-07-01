import { getAdminToken } from "@/lib/admin-auth";
import QuestionForm from "@/components/admin/QuestionForm";
import type { Subject, Topic } from "@/lib/types";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

async function fetchJson<T>(path: string, token: string): Promise<T> {
  const res = await fetch(`${API_BASE}${path}`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!res.ok) return [] as unknown as T;
  return res.json() as Promise<T>;
}

interface Props {
  searchParams: Promise<{ topicId?: string }>;
}

export default async function NewQuestionPage({ searchParams }: Props) {
  const { topicId } = await searchParams;
  const token = (await getAdminToken())!;
  const [subjects, topics] = await Promise.all([
    fetchJson<Subject[]>("/admin/subjects", token),
    fetchJson<Topic[]>("/admin/topics", token),
  ]);

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">問題の新規作成</h1>
      <QuestionForm
        subjects={subjects}
        topics={topics}
        defaultTopicId={topicId ? Number(topicId) : undefined}
      />
    </div>
  );
}
