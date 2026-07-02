"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import type { Question } from "@/lib/types";

interface Props {
  subjectSlug: string;
  topicSlug: string;
  questions: Question[];
}

interface ProgressData {
  answeredIds: number[];
  correctIds: number[];
}

const DIFFICULTY_LABEL = ["", "★☆☆☆☆", "★★☆☆☆", "★★★☆☆", "★★★★☆", "★★★★★"];

export default function TopicProgress({ subjectSlug, topicSlug, questions }: Props) {
  const [correctSet, setCorrectSet] = useState<Set<number>>(new Set());
  const [answeredSet, setAnsweredSet] = useState<Set<number>>(new Set());

  useEffect(() => {
    fetch(`/api/progress/topic/${subjectSlug}/${topicSlug}`)
      .then((r) => r.json())
      .then((d: ProgressData) => {
        setCorrectSet(new Set(d.correctIds));
        setAnsweredSet(new Set(d.answeredIds));
      })
      .catch(() => {});
  }, [subjectSlug, topicSlug]);

  const hasProgress = answeredSet.size > 0;
  const correctCount = questions.filter((q) => correctSet.has(q.id)).length;
  const total = questions.length;
  const pct = total > 0 ? Math.round((correctCount / total) * 100) : 0;
  const complete = total > 0 && correctCount === total;

  // 未正解の最初の問題から再開（すべて正解なら先頭から）
  const resumeQuestion = questions.find((q) => !correctSet.has(q.id)) ?? questions[0];

  return (
    <>
      {hasProgress && (
        <div className="mb-4 bg-white rounded-2xl border border-gray-200 p-4 shadow-sm">
          <div className="flex items-center gap-4">
            {/* 進捗リング */}
            <div
              className="relative h-16 w-16 shrink-0 rounded-full"
              style={{
                background: `conic-gradient(#10b981 ${pct * 3.6}deg, #e5e7eb 0deg)`,
              }}
              aria-hidden
            >
              <div className="absolute inset-1.5 flex items-center justify-center rounded-full bg-white">
                <span className="text-sm font-black text-emerald-600">
                  {complete ? "🏆" : `${pct}%`}
                </span>
              </div>
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-black text-gray-800">
                {complete ? "全問クリア！おめでとう🎉" : "クリア状況"}
              </p>
              <p className="text-xs text-gray-500 mt-0.5">
                {correctCount}/{total}問 正解
              </p>
              <div className="mt-2 h-2 rounded-full bg-gray-100 overflow-hidden">
                <div
                  className="h-full rounded-full bg-emerald-500 transition-all duration-500"
                  style={{ width: `${pct}%` }}
                />
              </div>
            </div>
          </div>
        </div>
      )}

      {questions.length > 0 && (
        <Link
          href={`/${subjectSlug}/${topicSlug}/${resumeQuestion.id}`}
          className="mb-6 block w-full rounded-2xl bg-emerald-500 py-4 text-center text-base font-black text-white shadow-md shadow-emerald-200 transition-all hover:bg-emerald-600 active:scale-[0.98]"
        >
          {!hasProgress ? "🚀 最初から始める" : complete ? "🔁 もう一度挑戦する" : "▶ つづきから始める"}
        </Link>
      )}

      <ul className="space-y-3">
        {questions.map((q, idx) => {
          const isCorrect = correctSet.has(q.id);
          const isAnswered = answeredSet.has(q.id);

          return (
            <li key={q.id}>
              <Link
                href={`/${subjectSlug}/${topicSlug}/${q.id}`}
                className="flex items-center gap-3.5 rounded-2xl bg-white border border-gray-200 px-4 py-4 shadow-sm transition-colors hover:border-emerald-300 hover:bg-emerald-50/40 active:bg-gray-50"
              >
                <span
                  className={`flex h-9 w-9 shrink-0 items-center justify-center rounded-full text-sm font-black ${
                    isCorrect
                      ? "bg-emerald-500 text-white"
                      : isAnswered
                        ? "bg-rose-100 text-rose-500"
                        : "bg-gray-100 text-gray-500"
                  }`}
                  aria-label={isCorrect ? "正解済み" : isAnswered ? "要復習" : "未回答"}
                >
                  {isCorrect ? "✓" : idx + 1}
                </span>
                <div className="flex-1 min-w-0">
                  <p className="text-gray-800 text-sm leading-snug line-clamp-2">{q.body}</p>
                  <p className="text-yellow-500 text-xs mt-1">
                    {DIFFICULTY_LABEL[q.difficulty]}
                    {!isCorrect && isAnswered && (
                      <span className="ml-2 rounded-full bg-rose-50 px-2 py-0.5 text-[10px] font-black text-rose-500">
                        要復習
                      </span>
                    )}
                  </p>
                </div>
                <span className="text-gray-300 shrink-0">›</span>
              </Link>
            </li>
          );
        })}
      </ul>
    </>
  );
}
