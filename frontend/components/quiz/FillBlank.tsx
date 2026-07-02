"use client";

import { useState } from "react";
import type { QuestionBlankAnswer, QuestionStep } from "@/lib/types";
import Feedback from "./Feedback";

interface Props {
  questionId: number;
  body: string;
  blankAnswers: QuestionBlankAnswer[];
  steps: QuestionStep[];
  nextHref: string;
  isLast: boolean;
}

function normalize(s: string) {
  return s.trim().replace(/\s+/g, "").toLowerCase();
}

export default function FillBlank({ questionId, body, blankAnswers, steps, nextHref, isLast }: Props) {
  const [inputs, setInputs] = useState<Record<number, string>>({});
  const [submitted, setSubmitted] = useState(false);

  const sorted = [...blankAnswers].sort((a, b) => a.blankIndex - b.blankIndex);
  const allFilled = sorted.every((ba) => (inputs[ba.blankIndex] ?? "").trim() !== "");

  const isCorrect = (ba: QuestionBlankAnswer) =>
    normalize(inputs[ba.blankIndex] ?? "") === normalize(ba.correctAnswer);

  const allCorrect = submitted && sorted.every(isCorrect);

  const handleSubmit = () => {
    if (!allFilled || submitted) return;
    const correct = sorted.every(isCorrect);
    setSubmitted(true);
    fetch("/api/progress", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ questionId, isCorrect: correct }),
    }).catch(() => {});
  };

  const parts = body.split(/(\{\{\d+\}\})/g);

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm">
        <p className="text-gray-800 leading-loose text-base font-medium">
          {parts.map((part, i) => {
            const match = part.match(/\{\{(\d+)\}\}/);
            if (!match) return <span key={i}>{part}</span>;
            const idx = Number(match[1]);
            const ba = blankAnswers.find((b) => b.blankIndex === idx);

            let style = "border-emerald-300 focus:border-emerald-500 bg-emerald-50/50";
            if (submitted && ba) {
              style = isCorrect(ba)
                ? "border-emerald-400 bg-emerald-50 text-emerald-800"
                : "border-rose-400 bg-rose-50 text-rose-800";
            }

            return (
              <input
                key={i}
                type="text"
                value={inputs[idx] ?? ""}
                onChange={(e) =>
                  setInputs((prev) => ({ ...prev, [idx]: e.target.value }))
                }
                disabled={submitted}
                className={`inline-block w-24 rounded-lg border-2 ${style} text-center text-base focus:outline-none mx-1 py-0.5 transition-colors`}
                placeholder={`${idx}`}
              />
            );
          })}
        </p>
      </div>

      {!submitted && (
        <button
          onClick={handleSubmit}
          disabled={!allFilled}
          className="w-full min-h-[56px] rounded-2xl bg-emerald-500 py-4 text-base font-black text-white shadow-md shadow-emerald-200 transition-all hover:bg-emerald-600 active:scale-[0.98] disabled:opacity-40 disabled:shadow-none"
        >
          答え合わせ
        </button>
      )}

      {submitted && (
        <Feedback correct={allCorrect} steps={steps} nextHref={nextHref} isLast={isLast}>
          {!allCorrect && (
            <div className="space-y-1">
              {sorted
                .filter((ba) => !isCorrect(ba))
                .map((ba) => (
                  <p key={ba.id} className="text-sm text-gray-700">
                    <span className="mr-1.5 inline-flex h-5 w-5 items-center justify-center rounded-full bg-white text-[11px] font-black text-gray-500">
                      {ba.blankIndex}
                    </span>
                    正解：<span className="font-black text-gray-900">{ba.correctAnswer}</span>
                  </p>
                ))}
            </div>
          )}
        </Feedback>
      )}
    </div>
  );
}
