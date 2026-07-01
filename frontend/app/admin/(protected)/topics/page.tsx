import Link from "next/link";
import { getAdminToken } from "@/lib/admin-auth";
import DeleteButton from "@/components/admin/DeleteButton";
import SubjectFilter from "@/components/admin/SubjectFilter";
import type { Subject, Topic } from "@/lib/types";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

async function fetchSubjects(token: string): Promise<Subject[]> {
  const res = await fetch(`${API_BASE}/admin/subjects`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!res.ok) return [];
  return res.json() as Promise<Subject[]>;
}

async function fetchTopics(token: string, subjectId?: string): Promise<Topic[]> {
  const qs = subjectId ? `?subjectId=${subjectId}` : "";
  const res = await fetch(`${API_BASE}/admin/topics${qs}`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!res.ok) return [];
  return res.json() as Promise<Topic[]>;
}

interface Props {
  searchParams: Promise<{ subjectId?: string }>;
}

export default async function AdminTopicsPage({ searchParams }: Props) {
  const { subjectId } = await searchParams;
  const token = (await getAdminToken())!;
  const [subjects, topics] = await Promise.all([
    fetchSubjects(token),
    fetchTopics(token, subjectId),
  ]);
  const subjectName = (id: number) => subjects.find((s) => s.id === id)?.name ?? "";

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-800">単元管理</h1>
        <Link
          href="/admin/topics/new"
          className="rounded-xl bg-blue-600 text-white font-bold px-4 py-2"
        >
          新規作成
        </Link>
      </div>

      <div className="mb-4">
        <SubjectFilter subjects={subjects} basePath="/admin/topics" value={subjectId} />
      </div>

      <div className="space-y-2">
        {topics.map((t) => (
          <div
            key={t.id}
            className="bg-white rounded-xl border border-gray-200 p-4 flex justify-between items-center"
          >
            <div>
              <p className="font-bold text-gray-800">{t.name}</p>
              <p className="text-xs text-gray-500">
                {subjectName(t.subjectId)} / {t.slug} / {t.gradeLevel}年 / 表示順 {t.displayOrder}
              </p>
            </div>
            <div className="flex gap-3 items-center">
              <Link href={`/admin/topics/${t.id}/edit`} className="text-blue-600 text-sm underline">
                編集
              </Link>
              <DeleteButton path={`topics/${t.id}`} />
            </div>
          </div>
        ))}
        {topics.length === 0 && (
          <p className="text-gray-500 text-sm">単元がまだ登録されていません。</p>
        )}
      </div>
    </div>
  );
}
