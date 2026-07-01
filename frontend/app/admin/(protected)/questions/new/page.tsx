import Link from "next/link";
import { notFound } from "next/navigation";
import { getAdminToken } from "@/lib/admin-auth";
import QuestionForm from "@/components/admin/QuestionForm";
import type { SchoolLevel, Subject, Topic } from "@/lib/types";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

const SCHOOL_LEVELS: { value: SchoolLevel; label: string }[] = [
  { value: "elementary", label: "小学生" },
  { value: "middle", label: "中学生" },
  { value: "exam_prep", label: "受験対策" },
];

async function fetchJson<T>(path: string, token: string): Promise<T> {
  const res = await fetch(`${API_BASE}${path}`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!res.ok) return [] as unknown as T;
  return res.json() as Promise<T>;
}

interface Props {
  searchParams: Promise<{ schoolLevel?: string; subjectId?: string; topicId?: string }>;
}

export default async function NewQuestionPage({ searchParams }: Props) {
  const { schoolLevel, subjectId, topicId } = await searchParams;
  const token = (await getAdminToken())!;
  const [subjects, topics] = await Promise.all([
    fetchJson<Subject[]>("/admin/subjects", token),
    fetchJson<Topic[]>("/admin/topics", token),
  ]);

  // ステップ1: 学校区分を選ぶ
  if (!schoolLevel) {
    return (
      <div>
        <h1 className="text-2xl font-bold text-gray-800 mb-6">問題の新規作成</h1>
        <p className="text-sm text-gray-600 mb-4">まず学校区分を選んでください。</p>
        <div className="grid grid-cols-1 gap-3">
          {SCHOOL_LEVELS.map((level) => (
            <Link
              key={level.value}
              href={`/admin/questions/new?schoolLevel=${level.value}`}
              className="bg-white rounded-xl border border-gray-200 p-4 font-bold text-gray-800 hover:border-blue-400"
            >
              {level.label}
            </Link>
          ))}
        </div>
      </div>
    );
  }

  const levelSubjects = subjects.filter((s) => s.schoolLevel === schoolLevel);
  const levelLabel = SCHOOL_LEVELS.find((l) => l.value === schoolLevel)?.label ?? schoolLevel;

  // ステップ2: 科目を選ぶ
  if (!subjectId) {
    return (
      <div>
        <h1 className="text-2xl font-bold text-gray-800 mb-2">問題の新規作成</h1>
        <p className="text-sm text-gray-500 mb-6">
          <Link href="/admin/questions/new" className="underline">
            学校区分
          </Link>
          {" > "}
          {levelLabel} {"> 科目を選ぶ"}
        </p>
        <div className="grid grid-cols-1 gap-3">
          {levelSubjects.map((s) => (
            <Link
              key={s.id}
              href={`/admin/questions/new?schoolLevel=${schoolLevel}&subjectId=${s.id}`}
              className="bg-white rounded-xl border border-gray-200 p-4 font-bold text-gray-800 hover:border-blue-400"
            >
              {s.icon} {s.name}
            </Link>
          ))}
          {levelSubjects.length === 0 && (
            <p className="text-gray-500 text-sm">この学校区分の科目がまだ登録されていません。</p>
          )}
        </div>
      </div>
    );
  }

  const subject = subjects.find((s) => s.id === Number(subjectId));
  if (!subject) notFound();

  const subjectTopics = topics.filter((t) => t.subjectId === subject.id);
  const initialTopicId = topicId ? Number(topicId) : subjectTopics[0]?.id;

  // ステップ3: 問題登録フォーム
  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-2">問題の新規作成</h1>
      <p className="text-sm text-gray-500 mb-6">
        <Link href="/admin/questions/new" className="underline">
          学校区分
        </Link>
        {" > "}
        <Link href={`/admin/questions/new?schoolLevel=${schoolLevel}`} className="underline">
          {levelLabel}
        </Link>
        {" > "}
        {subject.icon} {subject.name}
      </p>
      <QuestionForm subjects={subjects} topics={topics} defaultTopicId={initialTopicId} />
    </div>
  );
}
