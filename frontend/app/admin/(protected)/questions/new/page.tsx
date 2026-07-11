import Link from "next/link";
import { notFound } from "next/navigation";
import QuestionForm from "@/components/admin/QuestionForm";
import { findAllSubjects } from "@/lib/admin/subjects";
import { findAllTopics } from "@/lib/admin/topics";
import type { Genre, SchoolLevel } from "@/lib/types";

export const dynamic = "force-dynamic";

const GENRES: { value: Genre; label: string }[] = [
  { value: "school_education", label: "学校教育" },
  { value: "certification", label: "検定" },
];

const SCHOOL_LEVELS: { value: SchoolLevel; label: string }[] = [
  { value: "elementary", label: "小学生" },
  { value: "middle", label: "中学生" },
  { value: "exam_prep", label: "受験対策" },
];

interface Props {
  searchParams: Promise<{
    genre?: string;
    schoolLevel?: string;
    subjectId?: string;
    topicId?: string;
  }>;
}

export default async function NewQuestionPage({ searchParams }: Props) {
  const { genre, schoolLevel, subjectId, topicId } = await searchParams;
  const [subjects, topics] = await Promise.all([findAllSubjects(), findAllTopics()]);

  // ステップ1: ジャンルを選ぶ
  if (!genre) {
    return (
      <div>
        <h1 className="text-2xl font-bold text-gray-800 mb-6">問題の新規作成</h1>
        <p className="text-sm text-gray-600 mb-4">まずジャンルを選んでください。</p>
        <div className="grid grid-cols-1 gap-3">
          {GENRES.map((g) => (
            <Link
              key={g.value}
              href={`/admin/questions/new?genre=${g.value}`}
              className="bg-white rounded-xl border border-gray-200 p-4 font-bold text-gray-800 hover:border-blue-400"
            >
              {g.label}
            </Link>
          ))}
        </div>
      </div>
    );
  }

  const isCertification = genre === "certification";

  // 検定: ジャンル > 科目 > フォーム（学校区分ステップなし）
  if (isCertification) {
    const certSubjects = subjects.filter((s) => s.genre === "certification");

    if (!subjectId) {
      return (
        <div>
          <h1 className="text-2xl font-bold text-gray-800 mb-2">問題の新規作成</h1>
          <p className="text-sm text-gray-500 mb-6">
            <Link href="/admin/questions/new" className="underline">
              ジャンル
            </Link>
            {" > "}
            検定 {"> 科目を選ぶ"}
          </p>
          <div className="grid grid-cols-1 gap-3">
            {certSubjects.map((s) => (
              <Link
                key={s.id}
                href={`/admin/questions/new?genre=certification&subjectId=${s.id}`}
                className="bg-white rounded-xl border border-gray-200 p-4 font-bold text-gray-800 hover:border-blue-400"
              >
                {s.icon} {s.name}
              </Link>
            ))}
            {certSubjects.length === 0 && (
              <p className="text-gray-500 text-sm">
                検定科目がまだ登録されていません。先に
                <Link href="/admin/subjects/new" className="underline">
                  科目管理
                </Link>
                から作成してください。
              </p>
            )}
          </div>
        </div>
      );
    }

    const subject = certSubjects.find((s) => s.id === Number(subjectId));
    if (!subject) notFound();

    const subjectTopics = topics.filter((t) => t.subjectId === subject.id);
    const initialTopicId = topicId ? Number(topicId) : subjectTopics[0]?.id;

    return (
      <div>
        <h1 className="text-2xl font-bold text-gray-800 mb-2">問題の新規作成</h1>
        <p className="text-sm text-gray-500 mb-6">
          <Link href="/admin/questions/new" className="underline">
            ジャンル
          </Link>
          {" > "}
          <Link href="/admin/questions/new?genre=certification" className="underline">
            検定
          </Link>
          {" > "}
          {subject.icon} {subject.name}
        </p>
        <QuestionForm subjects={subjects} topics={topics} defaultTopicId={initialTopicId} />
      </div>
    );
  }

  // 学校教育: ジャンル > 学校区分 > 科目 > フォーム
  const schoolEducationSubjects = subjects.filter((s) => s.genre !== "certification");

  if (!schoolLevel) {
    return (
      <div>
        <h1 className="text-2xl font-bold text-gray-800 mb-2">問題の新規作成</h1>
        <p className="text-sm text-gray-500 mb-6">
          <Link href="/admin/questions/new" className="underline">
            ジャンル
          </Link>
          {" > "}
          学校教育 {"> 学校区分を選ぶ"}
        </p>
        <div className="grid grid-cols-1 gap-3">
          {SCHOOL_LEVELS.map((level) => (
            <Link
              key={level.value}
              href={`/admin/questions/new?genre=school_education&schoolLevel=${level.value}`}
              className="bg-white rounded-xl border border-gray-200 p-4 font-bold text-gray-800 hover:border-blue-400"
            >
              {level.label}
            </Link>
          ))}
        </div>
      </div>
    );
  }

  const levelSubjects = schoolEducationSubjects.filter((s) => s.schoolLevel === schoolLevel);
  const levelLabel = SCHOOL_LEVELS.find((l) => l.value === schoolLevel)?.label ?? schoolLevel;

  if (!subjectId) {
    return (
      <div>
        <h1 className="text-2xl font-bold text-gray-800 mb-2">問題の新規作成</h1>
        <p className="text-sm text-gray-500 mb-6">
          <Link href="/admin/questions/new" className="underline">
            ジャンル
          </Link>
          {" > "}
          <Link href="/admin/questions/new?genre=school_education" className="underline">
            学校教育
          </Link>
          {" > "}
          {levelLabel} {"> 科目を選ぶ"}
        </p>
        <div className="grid grid-cols-1 gap-3">
          {levelSubjects.map((s) => (
            <Link
              key={s.id}
              href={`/admin/questions/new?genre=school_education&schoolLevel=${schoolLevel}&subjectId=${s.id}`}
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

  const subject = levelSubjects.find((s) => s.id === Number(subjectId));
  if (!subject) notFound();

  const subjectTopics = topics.filter((t) => t.subjectId === subject.id);
  const initialTopicId = topicId ? Number(topicId) : subjectTopics[0]?.id;

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-2">問題の新規作成</h1>
      <p className="text-sm text-gray-500 mb-6">
        <Link href="/admin/questions/new" className="underline">
          ジャンル
        </Link>
        {" > "}
        <Link href="/admin/questions/new?genre=school_education" className="underline">
          学校教育
        </Link>
        {" > "}
        <Link
          href={`/admin/questions/new?genre=school_education&schoolLevel=${schoolLevel}`}
          className="underline"
        >
          {levelLabel}
        </Link>
        {" > "}
        {subject.icon} {subject.name}
      </p>
      <QuestionForm subjects={subjects} topics={topics} defaultTopicId={initialTopicId} />
    </div>
  );
}
