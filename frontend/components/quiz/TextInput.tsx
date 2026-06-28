"use client";

import { useState } from "react";
import type { QuestionStep } from "@/lib/types";

interface Props {
  body: string;
  correctAnswer: string;
  steps: QuestionStep[];
}

function normalize(s: string) {
  return s.trim().replace(/\s+/g, "").toLowerCase();
}

export default function TextInput({ body, correctAnswer, steps }: Props) {
  const [value, setValue] = useState("");
  const [submitted, setSubmitted] = useState(false);
  const correct = submitted && normalize(value) === normalize(correctAnswer);

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-xl border border-gray-200 p-5 shadow-sm">
        <p className="text-gray-800 leading-relaxed text-base font-medium">{body}</p>
      </div>

      <div>
        <input
          type="text"
          value={value}
          onChange={(e) => setValue(e.target.value)}
          disabled={submitted}
          placeholder="答えを入力してください"
          className="w-full rounded-xl border-2 border-gray-200 px-5 py-4 text-base focus:border-blue-400 focus:outline-none disabled:bg-gray-50 disabled:text-gray-500"
        />
      </div>

      {!submitted && (
        <button
          onClick={() => value.trim() && setSubmitted(true)}
          disabled={!value.trim()}
          className="w-full rounded-xl bg-blue-600 text-white font-bold py-4 text-base disabled:opacity-40 active:bg-blue-700 transition-colors min-h-[56px]"
        >
          答え合わせ
        </button>
      )}

      {submitted && (
        <div
          className={`rounded-xl border-2 p-5 ${
            correct ? "bg-green-50 border-green-300" : "bg-red-50 border-red-300"
          }`}
        >
          <p className={`font-bold mb-1 text-lg ${correct ? "text-green-700" : "text-red-700"}`}>
            {correct ? "正解！" : "不正解…"}
          </p>
          {!correct && (
            <p className="text-sm text-gray-700 mb-3">
              正解：<span className="font-bold">{correctAnswer}</span>
            </p>
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
    </div>
  );
}
