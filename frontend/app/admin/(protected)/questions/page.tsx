import Link from "next/link";
import DeleteButton from "@/components/admin/DeleteButton";
import SubjectFilter from "@/components/admin/SubjectFilter";
import TopicFilter from "@/components/admin/TopicFilter";
import KeywordSearch from "@/components/admin/KeywordSearch";
import Pagination from "@/components/admin/Pagination";
import { findAllSubjects } from "@/lib/admin/subjects";
import { findAllTopics } from "@/lib/admin/topics";
import { findAllQuestions } from "@/lib/admin/questions";
import type { QuestionType } from "@/lib/types";

export const dynamic = "force-dynamic";

const TYPE_LABELS: Record<QuestionType, string> = {
  multiple_choice: "4択",
  text_input: "記述式",
  fill_blank: "穴埋め",
  ordering: "並べ替え",
};

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

  const [subjects, topics] = await Promise.all([findAllSubjects(), findAllTopics()]);

  const { items: questions, total, page: currentPage, pageSize } = await findAllQuestions({
    subjectId: subjectId ? Number(subjectId) : undefined,
    topicId: topicId ? Number(topicId) : undefined,
    keyword: keyword?.trim() || undefined,
    page: page ? Number(page) : undefined,
  });

  const topicName = (id: number) => topics.find((t) => t.id === id)?.name ?? "";
  const topicsForSubject = subjectId
    ? topics.filter((t) => t.subjectId === Number(subjectId))
    : topics;
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
        {subjectId && (
          <TopicFilter topics={topicsForSubject} basePath="/admin/questions" value={topicId} />
        )}
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
