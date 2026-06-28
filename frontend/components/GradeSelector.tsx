"use client";

import { useState } from "react";
import Link from "next/link";

const MIDDLE_SUBJECTS = [
  { slug: "math",     name: "数学", icon: "🔢", color: "bg-blue-50 border-blue-200 text-blue-700" },
  { slug: "english",  name: "英語", icon: "🔤", color: "bg-green-50 border-green-200 text-green-700" },
  { slug: "japanese", name: "国語", icon: "📖", color: "bg-red-50 border-red-200 text-red-700" },
  { slug: "science",  name: "理科", icon: "🔬", color: "bg-purple-50 border-purple-200 text-purple-700" },
  { slug: "social",   name: "社会", icon: "🌏", color: "bg-yellow-50 border-yellow-200 text-yellow-700" },
];

type Grade = "elementary" | "middle";

export default function GradeSelector() {
  const [grade, setGrade] = useState<Grade>("middle");

  return (
    <>
      <section className="mb-6">
        <div className="flex rounded-xl overflow-hidden border-2 border-gray-200">
          <button
            onClick={() => setGrade("elementary")}
            className={`flex-1 py-3 font-bold text-base transition-colors ${
              grade === "elementary"
                ? "bg-orange-500 text-white"
                : "bg-white text-gray-500 active:bg-gray-50"
            }`}
          >
            小学生
          </button>
          <button
            onClick={() => setGrade("middle")}
            className={`flex-1 py-3 font-bold text-base transition-colors ${
              grade === "middle"
                ? "bg-blue-600 text-white"
                : "bg-white text-gray-500 active:bg-gray-50"
            }`}
          >
            中学生
          </button>
        </div>
      </section>

      <section>
        <h2 className="text-base font-bold text-gray-700 mb-3">科目を選ぼう</h2>
        {grade === "middle" ? (
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-3">
            {MIDDLE_SUBJECTS.map((subject) => (
              <Link
                key={subject.slug}
                href={`/${subject.slug}`}
                className={`flex flex-col items-center justify-center rounded-xl border-2 p-5 min-h-[96px] font-bold text-lg transition-opacity active:opacity-70 ${subject.color}`}
              >
                <span className="text-3xl mb-1">{subject.icon}</span>
                {subject.name}
              </Link>
            ))}
          </div>
        ) : (
          <div className="rounded-xl bg-orange-50 border-2 border-orange-200 p-8 text-center">
            <p className="text-3xl mb-2">🚧</p>
            <p className="font-bold text-orange-700 mb-1">準備中です</p>
            <p className="text-orange-600 text-sm">小学生向けコンテンツは近日公開予定です。</p>
          </div>
        )}
      </section>
    </>
  );
}
