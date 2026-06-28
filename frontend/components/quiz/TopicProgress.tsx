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

  return (
    <>
      {hasProgress && (
        <div className="mb-4 bg-white rounded-xl border border-gray-200 p-4 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm font-medium text-gray-600">正解率</span>
            <span className="text-sm font-bold text-blue-600">
              {correctCount}/{total}問正解（{pct}%）
            </span>
          </div>
          <div className="h-2 rounded-full bg-gray-100 overflow-hidden">
            <div
              className="h-full rounded-full bg-blue-500 transition-all duration-500"
              style={{ width: `${pct}%` }}
            />
          </div>
        </div>
      )}

      <ul className="space-y-3">
        {questions.map((q, idx) => {
          const isCorrect = correctSet.has(q.id);
          const isAnswered = answeredSet.has(q.id);

          return (
            <li key={q.id}>
              <Link
                href={`/${subjectSlug}/${topicSlug}/${q.id}`}
                className="flex items-center gap-4 rounded-xl bg-white border border-gray-200 px-5 py-4 shadow-sm active:bg-gray-50 transition-colors"
              >
                <span className="text-gray-400 font-medium w-8 shrink-0 text-center">
                  {idx + 1}
                </span>
                <div className="flex-1 min-w-0">
                  <p className="text-gray-800 text-sm leading-snug line-clamp-2">{q.body}</p>
                  <p className="text-yellow-500 text-xs mt-1">{DIFFICULTY_LABEL[q.difficulty]}</p>
                </div>
                {isCorrect ? (
                  <span className="text-green-500 font-bold text-lg shrink-0">✓</span>
                ) : isAnswered ? (
                  <span className="text-red-400 font-bold text-lg shrink-0">✗</span>
                ) : (
                  <span className="text-gray-400 shrink-0">›</span>
                )}
              </Link>
            </li>
          );
        })}
      </ul>
    </>
  );
}
