"use client";

import { useState } from "react";
import type { QuestionChoice, QuestionStep } from "@/lib/types";
import Feedback from "./Feedback";

interface Props {
  questionId: number;
  body: string;
  choices: QuestionChoice[];
  steps: QuestionStep[];
  nextHref: string;
  isLast: boolean;
}

const CHOICE_LABELS = ["A", "B", "C", "D", "E", "F"];

export default function MultipleChoice({ questionId, body, choices, steps, nextHref, isLast }: Props) {
  const [selected, setSelected] = useState<number | null>(null);
  const answered = selected !== null;
  const correct = answered && choices.find((c) => c.id === selected)?.isCorrect;

  const handleSelect = (choiceId: number, isCorrect: boolean) => {
    if (answered) return;
    setSelected(choiceId);
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

      <div className="space-y-3">
        {[...choices]
          .sort((a, b) => a.displayOrder - b.displayOrder)
          .map((choice, idx) => {
            let card =
              "w-full flex items-center gap-3 text-left rounded-2xl border-2 px-4 py-4 text-base font-medium transition-all min-h-[56px]";
            let badge =
              "flex h-8 w-8 shrink-0 items-center justify-center rounded-lg text-sm font-black";
            if (!answered) {
              card +=
                " bg-white border-gray-200 hover:border-emerald-300 hover:bg-emerald-50/50 active:scale-[0.98] cursor-pointer";
              badge += " bg-gray-100 text-gray-500";
            } else if (choice.isCorrect) {
              card += " bg-emerald-50 border-emerald-400 text-emerald-800 animate-pop";
              badge += " bg-emerald-500 text-white";
            } else if (choice.id === selected) {
              card += " bg-rose-50 border-rose-400 text-rose-800 animate-shake";
              badge += " bg-rose-500 text-white";
            } else {
              card += " bg-gray-50 border-gray-200 text-gray-400";
              badge += " bg-gray-100 text-gray-400";
            }

            return (
              <button
                key={choice.id}
                className={card}
                onClick={() => handleSelect(choice.id, choice.isCorrect)}
                disabled={answered}
              >
                <span className={badge} aria-hidden>
                  {answered && choice.isCorrect
                    ? "✓"
                    : answered && choice.id === selected
                      ? "✗"
                      : CHOICE_LABELS[idx]}
                </span>
                <span className="flex-1">{choice.body}</span>
              </button>
            );
          })}
      </div>

      {answered && (
        <Feedback correct={!!correct} steps={steps} nextHref={nextHref} isLast={isLast} />
      )}
    </div>
  );
}
