"use client";

import { useState } from "react";
import type { QuestionChoice, QuestionStep } from "@/lib/types";

interface Props {
  body: string;
  choices: QuestionChoice[];
  steps: QuestionStep[];
}

export default function MultipleChoice({ body, choices, steps }: Props) {
  const [selected, setSelected] = useState<number | null>(null);
  const answered = selected !== null;
  const correct = answered && choices.find((c) => c.id === selected)?.isCorrect;

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-xl border border-gray-200 p-5 shadow-sm">
        <p className="text-gray-800 leading-relaxed text-base font-medium">{body}</p>
      </div>

      <div className="space-y-3">
        {[...choices]
          .sort((a, b) => a.displayOrder - b.displayOrder)
          .map((choice) => {
            let style =
              "w-full text-left rounded-xl border-2 px-5 py-4 text-base font-medium transition-colors min-h-[56px]";
            if (!answered) {
              style += " bg-white border-gray-200 active:bg-gray-50";
            } else if (choice.isCorrect) {
              style += " bg-green-50 border-green-400 text-green-800";
            } else if (choice.id === selected) {
              style += " bg-red-50 border-red-400 text-red-800";
            } else {
              style += " bg-gray-50 border-gray-200 text-gray-400";
            }

            return (
              <button
                key={choice.id}
                className={style}
                onClick={() => !answered && setSelected(choice.id)}
                disabled={answered}
              >
                {choice.body}
              </button>
            );
          })}
      </div>

      {answered && (
        <div
          className={`rounded-xl border-2 p-5 ${
            correct
              ? "bg-green-50 border-green-300"
              : "bg-red-50 border-red-300"
          }`}
        >
          <p className={`font-bold mb-3 text-lg ${correct ? "text-green-700" : "text-red-700"}`}>
            {correct ? "正解！" : "不正解…"}
          </p>
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
