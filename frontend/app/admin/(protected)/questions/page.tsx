import Link from "next/link";
import { getAdminToken } from "@/lib/admin-auth";
import DeleteButton from "@/components/admin/DeleteButton";
import SubjectFilter from "@/components/admin/SubjectFilter";
import KeywordSearch from "@/components/admin/KeywordSearch";
import Pagination from "@/components/admin/Pagination";
import type { Question, QuestionType, Subject, Topic } from "@/lib/types";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

const TYPE_LABELS: Record<QuestionType, string> = {
  multiple_choice: "4択",
  text_input: "記述式",
  fill_blank: "穴埋め",
  ordering: "並べ替え",
};

async function fetchJson<T>(path: string, token: string): Promise<T> {
  const res = await fetch(`${API_BASE}${path}`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!res.ok) return [] as unknown as T;
  return res.json() as Promise<T>;
}

interface QuestionListResponse {
  items: Question[];
  total: number;
  page: number;
  pageSize: number;
}

async function fetchQuestions(qs: URLSearchParams, token: string): Promise<QuestionListResponse> {
  const res = await fetch(`${API_BASE}/admin/questions?${qs.toString()}`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!res.ok) return { items: [], total: 0, page: 1, pageSize: 20 };
  return res.json() as Promise<QuestionListResponse>;
}

interface Props {
  searchParams: Promise<{
    subjectId?: string;
    topicId?: string;
    keyword?: string;
    page?: string;
  }>;
}

export default async function AdminQuestionsPage({ searchParams }: Props) {
  const { subjectId, topicId, keyword, page } = await searchParams;
  const token = (await getAdminToken())!;

  const [subjects, topics] = await Promise.all([
    fetchJson<Subject[]>("/admin/subjects", token),
    fetchJson<Topic[]>("/admin/topics", token),
  ]);

  const qs = new URLSearchParams();
  if (subjectId) qs.set("subjectId", subjectId);
  if (topicId) qs.set("topicId", topicId);
  if (keyword) qs.set("keyword", keyword);
  if (page) qs.set("page", page);
  const { items: questions, total, page: currentPage, pageSize } = await fetchQuestions(qs, token);

  const topicName = (id: number) => topics.find((t) => t.id === id)?.name ?? "";
  const totalPages = Math.max(1, Math.ceil(total / pageSize));

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-800">問題管理</h1>
        <Link
          href="/admin/questions/new"
          className="rounded-xl bg-blue-600 text-white font-bold px-4 py-2"
        >
          新規作成
        </Link>
      </div>

      <div className="mb-4 flex flex-wrap gap-3 items-center">
        <SubjectFilter subjects={subjects} basePath="/admin/questions" value={subjectId} />
        <KeywordSearch basePath="/admin/questions" value={keyword} />
      </div>

      <div className="space-y-2">
        {questions.map((q) => (
          <div
            key={q.id}
            className="bg-white rounded-xl border border-gray-200 p-4 flex justify-between items-center"
          >
            <div className="min-w-0">
              <p className="font-bold text-gray-800 truncate">{q.body}</p>
              <p className="text-xs text-gray-500">
                {topicName(q.topicId)} / {TYPE_LABELS[q.type]} / 難易度{q.difficulty}
              </p>
            </div>
            <div className="flex gap-3 items-center shrink-0">
              <Link href={`/admin/questions/${q.id}/edit`} className="text-blue-600 text-sm underline">
                編集
              </Link>
              <DeleteButton path={`questions/${q.id}`} />
            </div>
          </div>
        ))}
        {questions.length === 0 && (
          <p className="text-gray-500 text-sm">問題がまだ登録されていません。</p>
        )}
      </div>

      <Pagination basePath="/admin/questions" page={currentPage} totalPages={totalPages} />
    </div>
  );
}
