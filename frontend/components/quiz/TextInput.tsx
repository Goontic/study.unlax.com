"use client";

import { useState } from "react";
import type { QuestionStep } from "@/lib/types";
import Feedback from "./Feedback";

interface Props {
  questionId: number;
  body: string;
  correctAnswer: string;
  steps: QuestionStep[];
  nextHref: string;
  isLast: boolean;
}

function normalize(s: string) {
  return s.trim().replace(/\s+/g, "").toLowerCase();
}

export default function TextInput({ questionId, body, correctAnswer, steps, nextHref, isLast }: Props) {
  const [value, setValue] = useState("");
  const [submitted, setSubmitted] = useState(false);
  const correct = submitted && normalize(value) === normalize(correctAnswer);

  const handleSubmit = () => {
    if (!value.trim() || submitted) return;
    const isCorrect = normalize(value) === normalize(correctAnswer);
    setSubmitted(true);
    fetch("/api/progress", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ questionId, isCorrect }),
    }).catch(() => {});
  };

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm">
        <p className="text-gray-800 leading-relaxed text-base font-medium">{body}</p>
      </div>

      <div>
        <input
          type="text"
          value={value}
          onChange={(e) => setValue(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter") handleSubmit();
          }}
          disabled={submitted}
          placeholder="答えを入力してください"
          className={`w-full rounded-2xl border-2 px-5 py-4 text-base transition-colors focus:outline-none disabled:bg-gray-50 ${
            !submitted
              ? "border-gray-200 focus:border-emerald-400 bg-white"
              : correct
                ? "border-emerald-400 bg-emerald-50 text-emerald-800"
                : "border-rose-400 bg-rose-50 text-rose-800"
          }`}
        />
      </div>

      {!submitted && (
        <button
          onClick={handleSubmit}
          disabled={!value.trim()}
          className="w-full min-h-[56px] rounded-2xl bg-emerald-500 py-4 text-base font-black text-white shadow-md shadow-emerald-200 transition-all hover:bg-emerald-600 active:scale-[0.98] disabled:opacity-40 disabled:shadow-none"
        >
          答え合わせ
        </button>
      )}

      {submitted && (
        <Feedback correct={correct} steps={steps} nextHref={nextHref} isLast={isLast}>
          {!correct && (
            <p className="text-sm text-gray-700">
              正解：<span className="font-black text-gray-900">{correctAnswer}</span>
            </p>
          )}
        </Feedback>
      )}
    </div>
  );
}
