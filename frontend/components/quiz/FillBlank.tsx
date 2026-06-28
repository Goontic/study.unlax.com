"use client";

import { useState } from "react";
import Link from "next/link";
import type { QuestionBlankAnswer, QuestionStep } from "@/lib/types";

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
      <div className="bg-white rounded-xl border border-gray-200 p-5 shadow-sm">
        <p className="text-gray-800 leading-relaxed text-base font-medium">
          {parts.map((part, i) => {
            const match = part.match(/\{\{(\d+)\}\}/);
            if (!match) return <span key={i}>{part}</span>;
            const idx = Number(match[1]);
            const ba = blankAnswers.find((b) => b.blankIndex === idx);

            let borderColor = "border-blue-300";
            if (submitted && ba) {
              borderColor = isCorrect(ba) ? "border-green-400" : "border-red-400";
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
                className={`inline-block w-24 border-b-2 ${borderColor} text-center text-base focus:outline-none bg-transparent mx-1 disabled:text-gray-600`}
                placeholder={`　${idx}　`}
              />
            );
          })}
        </p>
      </div>

      {!submitted && (
        <button
          onClick={handleSubmit}
          disabled={!allFilled}
          className="w-full rounded-xl bg-blue-600 text-white font-bold py-4 text-base disabled:opacity-40 active:bg-blue-700 transition-colors min-h-[56px]"
        >
          答え合わせ
        </button>
      )}

      {submitted && (
        <div
          className={`rounded-xl border-2 p-5 ${
            allCorrect ? "bg-green-50 border-green-300" : "bg-red-50 border-red-300"
          }`}
        >
          <p className={`font-bold mb-3 text-lg ${allCorrect ? "text-green-700" : "text-red-700"}`}>
            {allCorrect ? "正解！" : "不正解…"}
          </p>
          {!allCorrect && (
            <div className="mb-3 space-y-1">
              {sorted.map((ba) => (
                <p key={ba.id} className="text-sm text-gray-700">
                  {`[${ba.blankIndex}]`}の正解：
                  <span className="font-bold">{ba.correctAnswer}</span>
                </p>
              ))}
            </div>
          )}
          {steps.length > 0 && (
            <div className="space-y-2">
              <p className="font-bold text-gray-700 text-sm">解説</p>
              {steps
                .sort((a, b) => a.stepNumber - b.stepNumber)
                .map((step) => (
                  <p key={step.id} className="text-gray-700 text-sm leading-relaxed">
                    {step.stepNumber > 1 && (
                      <span className="font-bold text-gray-500 mr-1">
                        手順{step.stepNumber}:
                      </span>
                    )}
                    {step.body}
                  </p>
                ))}
            </div>
          )}
        </div>
      )}

      {submitted && (
        <Link
          href={nextHref}
          className="block w-full rounded-xl bg-blue-600 text-white font-bold py-4 text-base text-center active:bg-blue-700 transition-colors min-h-[56px] leading-[56px]"
        >
          {isLast ? "単元一覧に戻る" : "次の問題へ →"}
        </Link>
      )}
    </div>
  );
}
