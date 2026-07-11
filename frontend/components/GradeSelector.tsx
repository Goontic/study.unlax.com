import Link from "next/link";
import {
  getCertificationSubjects,
  getExamPrepSubjects,
  getSubjectsByGrade,
  getSubjectsByGradeElementary,
} from "@/lib/data";
import type { SubjectWithTopics } from "@/lib/types";

const MIDDLE_GRADES = [
  {
    level: 1,
    label: "中学1年生",
    emoji: "🌱",
    headerGradient: "bg-gradient-to-r from-sky-400 to-cyan-400",
    chipBg: "bg-sky-50 border-sky-300 text-sky-700 active:bg-sky-100",
  },
  {
    level: 2,
    label: "中学2年生",
    emoji: "🌿",
    headerGradient: "bg-gradient-to-r from-violet-400 to-purple-500",
    chipBg: "bg-violet-50 border-violet-300 text-violet-700 active:bg-violet-100",
  },
  {
    level: 3,
    label: "中学3年生",
    emoji: "🔥",
    headerGradient: "bg-gradient-to-r from-rose-400 to-pink-500",
    chipBg: "bg-rose-50 border-rose-300 text-rose-700 active:bg-rose-100",
  },
];

const ELEMENTARY_GRADES = [
  { level: 1, label: "小学1年生", emoji: "🐣", headerGradient: "bg-gradient-to-r from-yellow-400 to-amber-400", chipBg: "bg-yellow-50 border-yellow-300 text-yellow-700 active:bg-yellow-100" },
  { level: 2, label: "小学2年生", emoji: "🌸", headerGradient: "bg-gradient-to-r from-pink-400 to-rose-400", chipBg: "bg-pink-50 border-pink-300 text-pink-700 active:bg-pink-100" },
  { level: 3, label: "小学3年生", emoji: "🐸", headerGradient: "bg-gradient-to-r from-green-400 to-emerald-400", chipBg: "bg-green-50 border-green-300 text-green-700 active:bg-green-100" },
  { level: 4, label: "小学4年生", emoji: "🌻", headerGradient: "bg-gradient-to-r from-orange-400 to-amber-500", chipBg: "bg-orange-50 border-orange-300 text-orange-700 active:bg-orange-100" },
  { level: 5, label: "小学5年生", emoji: "⭐", headerGradient: "bg-gradient-to-r from-teal-400 to-cyan-500", chipBg: "bg-teal-50 border-teal-300 text-teal-700 active:bg-teal-100" },
  { level: 6, label: "小学6年生", emoji: "🚀", headerGradient: "bg-gradient-to-r from-indigo-400 to-blue-500", chipBg: "bg-indigo-50 border-indigo-300 text-indigo-700 active:bg-indigo-100" },
];

export default async function GradeSelector() {
  const [middleData, elementaryData, examPrepSubjects, certificationSubjects] = await Promise.all([
    Promise.all(
      MIDDLE_GRADES.map(async (g) => {
        const subjects: SubjectWithTopics[] = await getSubjectsByGrade(g.level);
        return { ...g, subjects };
      }),
    ),
    Promise.all(
      ELEMENTARY_GRADES.map(async (g) => {
        try {
          const subjects: SubjectWithTopics[] = await getSubjectsByGradeElementary(g.level);
          return { ...g, subjects };
        } catch {
          return { ...g, subjects: [] as SubjectWithTopics[] };
        }
      }),
    ),
    getExamPrepSubjects().catch(() => [] as SubjectWithTopics[]),
    getCertificationSubjects().catch(() => [] as SubjectWithTopics[]),
  ]);

  const elementaryWithContent = elementaryData.filter((g) => g.subjects.length > 0);

  return (
    <>
      {/* 学校教育ジャンル */}
      <div className="flex items-center gap-2 mb-4">
        <span className="text-xl" aria-hidden>🎓</span>
        <h2 className="text-lg font-black text-gray-800">学校教育</h2>
      </div>

      {/* 中学校セクション */}
      <div className="mb-3">
        <div className="flex items-center gap-2 mb-3">
          <span className="text-xl" aria-hidden>🏫</span>
          <h2 className="text-base font-black text-gray-700">中学校</h2>
        </div>
        <div className="space-y-4">
          {middleData.map(({ level, label, emoji, headerGradient, chipBg, subjects }) => (
            <section key={level} className="bg-white rounded-3xl shadow-md overflow-hidden border border-gray-100">
              <Link
                href={`/grade/${level}`}
                className={`flex items-center justify-between px-5 py-4 ${headerGradient} group`}
              >
                <div className="flex items-center gap-2">
                  <span className="text-2xl" aria-hidden>{emoji}</span>
                  <h3 className="text-base font-black text-white">{label}</h3>
                </div>
                <span className="text-white/80 text-sm font-bold transition-colors group-hover:text-white group-active:text-white">すべて見る ›</span>
              </Link>
              <div className="grid grid-cols-3 gap-3 p-4 sm:grid-cols-5">
                {subjects.map((subject) => (
                  <Link
                    key={subject.slug}
                    href={`/grade/${level}/${subject.slug}`}
                    className={`flex flex-col items-center justify-center rounded-2xl border-2 py-3 px-2 text-center shadow-sm transition-all hover:-translate-y-0.5 hover:shadow-md active:scale-95 ${chipBg}`}
                  >
                    <span className="text-2xl mb-1">{subject.icon}</span>
                    <span className="text-xs font-bold leading-tight">{subject.name}</span>
                  </Link>
                ))}
              </div>
            </section>
          ))}
        </div>
      </div>

      {/* 高校入試対策セクション */}
      {examPrepSubjects.length > 0 && (
        <div className="mb-3 mt-6">
          <div className="flex items-center gap-2 mb-3">
            <span className="text-xl" aria-hidden>🎯</span>
            <h2 className="text-base font-black text-gray-700">高校入試対策</h2>
          </div>
          <section className="bg-white rounded-3xl shadow-md overflow-hidden border border-gray-100">
            <Link
              href="/exam-prep"
              className="flex items-center justify-between px-5 py-4 bg-gradient-to-r from-red-500 to-rose-600 group"
            >
              <div className="flex items-center gap-2">
                <span className="text-2xl" aria-hidden>🏆</span>
                <h3 className="text-base font-black text-white">入試対策 全5科目</h3>
              </div>
              <span className="text-white/80 text-sm font-bold transition-colors group-hover:text-white group-active:text-white">すべて見る ›</span>
            </Link>
            <div className="grid grid-cols-3 gap-3 p-4 sm:grid-cols-5">
              {examPrepSubjects.map((subject) => (
                <Link
                  key={subject.slug}
                  href={`/${subject.slug}`}
                  className="flex flex-col items-center justify-center rounded-2xl border-2 py-3 px-2 text-center shadow-sm transition-all hover:-translate-y-0.5 hover:shadow-md active:scale-95 bg-red-50 border-red-300 text-red-700 active:bg-red-100"
                >
                  <span className="text-2xl mb-1">{subject.icon}</span>
                  <span className="text-xs font-bold leading-tight">{subject.name}</span>
                </Link>
              ))}
            </div>
          </section>
        </div>
      )}

      {/* 小学校セクション */}
      <div className="mt-6">
        <div className="flex items-center gap-2 mb-3">
          <span className="text-xl" aria-hidden>🎒</span>
          <h2 className="text-base font-black text-gray-700">小学校</h2>
        </div>
        {elementaryWithContent.length > 0 ? (
          <div className="space-y-4">
            {elementaryWithContent.map(({ level, label, emoji, headerGradient, chipBg, subjects }) => (
              <section key={level} className="bg-white rounded-3xl shadow-md overflow-hidden border border-gray-100">
                <Link
                  href={`/elementary/${level}`}
                  className={`flex items-center justify-between px-5 py-4 ${headerGradient} group`}
                >
                  <div className="flex items-center gap-2">
                    <span className="text-2xl" aria-hidden>{emoji}</span>
                    <h3 className="text-base font-black text-white">{label}</h3>
                  </div>
                  <span className="text-white/80 text-sm font-bold transition-colors group-hover:text-white group-active:text-white">すべて見る ›</span>
                </Link>
                <div className="grid grid-cols-3 gap-3 p-4 sm:grid-cols-5">
                  {subjects.map((subject) => (
                    <Link
                      key={subject.slug}
                      href={`/${subject.slug}`}
                      className={`flex flex-col items-center justify-center rounded-2xl border-2 py-3 px-2 text-center shadow-sm transition-all hover:-translate-y-0.5 hover:shadow-md active:scale-95 ${chipBg}`}
                    >
                      <span className="text-2xl mb-1">{subject.icon}</span>
                      <span className="text-xs font-bold leading-tight">{subject.name}</span>
                    </Link>
                  ))}
                </div>
              </section>
            ))}
          </div>
        ) : (
          <div className="rounded-3xl bg-gradient-to-br from-amber-50 to-orange-100 border-2 border-orange-200 p-5 text-center">
            <p className="text-3xl mb-2" aria-hidden>🚧</p>
            <p className="font-black text-orange-700 text-sm mb-1">小学校コンテンツ</p>
            <p className="text-orange-500 text-xs font-bold">まもなく公開！お楽しみに ✨</p>
          </div>
        )}
      </div>

      {/* 検定ジャンル */}
      <div className="flex items-center gap-2 mb-4 mt-10">
        <span className="text-xl" aria-hidden>📖</span>
        <h2 className="text-lg font-black text-gray-800">検定</h2>
      </div>
      {certificationSubjects.length > 0 ? (
        <section className="bg-white rounded-3xl shadow-md overflow-hidden border border-gray-100">
          <Link
            href="/certification"
            className="flex items-center justify-between px-5 py-4 bg-gradient-to-r from-indigo-500 to-blue-600 group"
          >
            <div className="flex items-center gap-2">
              <span className="text-2xl" aria-hidden>📖</span>
              <h3 className="text-base font-black text-white">検定対策</h3>
            </div>
            <span className="text-white/80 text-sm font-bold transition-colors group-hover:text-white group-active:text-white">すべて見る ›</span>
          </Link>
          <div className="grid grid-cols-3 gap-3 p-4 sm:grid-cols-5">
            {certificationSubjects.map((subject) => (
              <Link
                key={subject.slug}
                href={`/${subject.slug}`}
                className="flex flex-col items-center justify-center rounded-2xl border-2 py-3 px-2 text-center shadow-sm transition-all hover:-translate-y-0.5 hover:shadow-md active:scale-95 bg-indigo-50 border-indigo-300 text-indigo-700 active:bg-indigo-100"
              >
                <span className="text-2xl mb-1">{subject.icon}</span>
                <span className="text-xs font-bold leading-tight">{subject.name}</span>
              </Link>
            ))}
          </div>
        </section>
      ) : (
        <div className="rounded-3xl bg-gradient-to-br from-indigo-50 to-blue-100 border-2 border-indigo-200 p-5 text-center">
          <p className="text-3xl mb-2" aria-hidden>🚧</p>
          <p className="font-black text-indigo-700 text-sm mb-1">検定コンテンツ</p>
          <p className="text-indigo-500 text-xs font-bold">まもなく公開！お楽しみに ✨</p>
        </div>
      )}
    </>
  );
}
