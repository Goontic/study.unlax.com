import Link from "next/link";
import { apiFetch } from "@/lib/api";
import type { SubjectWithTopics } from "@/lib/types";

const GRADES = [
  { level: 1, label: "中学1年", headerColor: "text-blue-700", chipColor: "bg-blue-50 border-blue-200 text-blue-700" },
  { level: 2, label: "中学2年", headerColor: "text-indigo-700", chipColor: "bg-indigo-50 border-indigo-200 text-indigo-700" },
  { level: 3, label: "中学3年", headerColor: "text-violet-700", chipColor: "bg-violet-50 border-violet-200 text-violet-700" },
];

export default async function GradeSelector() {
  const gradeData = await Promise.all(
    GRADES.map(async (g) => {
      const subjects = await apiFetch<SubjectWithTopics[]>(`/subjects/by-grade/${g.level}`);
      return { ...g, subjects };
    }),
  );

  return (
    <>
      <div className="space-y-6">
        {gradeData.map(({ level, label, headerColor, chipColor, subjects }) => (
          <section key={level}>
            <Link
              href={`/grade/${level}`}
              className={`flex items-center justify-between mb-3 group`}
            >
              <h2 className={`text-base font-bold ${headerColor}`}>{label}</h2>
              <span className="text-gray-300 group-active:text-gray-500 text-sm">すべて見る ›</span>
            </Link>
            <div className="grid grid-cols-3 gap-2 sm:grid-cols-5">
              {subjects.map((subject) => (
                <Link
                  key={subject.slug}
                  href={`/grade/${level}/${subject.slug}`}
                  className={`flex flex-col items-center justify-center rounded-xl border py-3 px-2 text-center transition-opacity active:opacity-60 ${chipColor}`}
                >
                  <span className="text-2xl mb-1">{subject.icon}</span>
                  <span className="text-xs font-bold leading-tight">{subject.name}</span>
                </Link>
              ))}
            </div>
          </section>
        ))}
      </div>

      <div className="mt-6 rounded-xl bg-orange-50 border border-orange-200 p-5 text-center">
        <p className="text-xl mb-1">🚧</p>
        <p className="font-bold text-orange-700 text-sm mb-0.5">小学生向けコンテンツ</p>
        <p className="text-orange-600 text-xs">近日公開予定です</p>
      </div>
    </>
  );
}
