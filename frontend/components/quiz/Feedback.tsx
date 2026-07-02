"use client";

import type { ReactNode } from "react";
import Link from "next/link";
import type { QuestionStep } from "@/lib/types";

interface Props {
  correct: boolean;
  steps: QuestionStep[];
  nextHref: string;
  isLast: boolean;
  children?: ReactNode;
}

export default function Feedback({ correct, steps, nextHref, isLast, children }: Props) {
  return (
    <div className="space-y-4 animate-slide-up">
      <div
        className={`rounded-2xl border-2 overflow-hidden ${
          correct ? "border-emerald-300 bg-emerald-50" : "border-rose-300 bg-rose-50"
        }`}
      >
        <div className="flex items-center gap-3 px-5 py-4">
          <span
            className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-full text-xl font-black text-white ${
              correct ? "bg-emerald-500" : "bg-rose-500"
            }`}
            aria-hidden
          >
            {correct ? "✓" : "✗"}
          </span>
          <div>
            <p className={`text-lg font-black ${correct ? "text-emerald-700" : "text-rose-700"}`}>
              {correct ? "正解！" : "不正解…"}
            </p>
            <p className={`text-xs font-medium ${correct ? "text-emerald-600" : "text-rose-500"}`}>
              {correct ? "その調子！" : "解説を読んで理解を深めよう"}
            </p>
          </div>
        </div>

        {children && <div className="px-5 pb-4">{children}</div>}

        {steps.length > 0 && (
          <div className="mx-3 mb-3 rounded-xl bg-white/80 p-4">
            <p className="mb-2 flex items-center gap-1.5 text-sm font-black text-gray-700">
              <span aria-hidden>💡</span>解説
            </p>
            <div className="space-y-2">
              {[...steps]
                .sort((a, b) => a.stepNumber - b.stepNumber)
                .map((step) => (
                  <p key={step.id} className="text-sm leading-relaxed text-gray-700">
                    {steps.length > 1 && (
                      <span className="mr-1.5 inline-flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100 text-[11px] font-black text-emerald-700">
                        {step.stepNumber}
                      </span>
                    )}
                    {step.body}
                  </p>
                ))}
            </div>
          </div>
        )}
      </div>

      <Link
        href={nextHref}
        className="block min-h-[56px] w-full rounded-2xl bg-emerald-500 py-4 text-center text-base font-black text-white shadow-md shadow-emerald-200 transition-all hover:bg-emerald-600 active:scale-[0.98]"
      >
        {isLast ? "単元一覧に戻る" : "次の問題へ →"}
      </Link>
    </div>
  );
}
