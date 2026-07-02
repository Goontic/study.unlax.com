"use client";

import { useState } from "react";
import type { QuestionOrderItem, QuestionStep } from "@/lib/types";
import Feedback from "./Feedback";

interface Props {
  questionId: number;
  body: string;
  orderItems: QuestionOrderItem[];
  steps: QuestionStep[];
  nextHref: string;
  isLast: boolean;
}

export default function Ordering({ questionId, body, orderItems, steps, nextHref, isLast }: Props) {
  const [remaining, setRemaining] = useState<QuestionOrderItem[]>(() =>
    [...orderItems].sort(() => Math.random() - 0.5),
  );
  const [selected, setSelected] = useState<QuestionOrderItem[]>([]);
  const [submitted, setSubmitted] = useState(false);

  const done = selected.length === orderItems.length;

  const correct =
    submitted &&
    selected.every((item, idx) => item.correctPosition === idx + 1);

  const handleSubmit = () => {
    if (submitted) return;
    const isCorrect = selected.every((item, idx) => item.correctPosition === idx + 1);
    setSubmitted(true);
    fetch("/api/progress", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ questionId, isCorrect }),
    }).catch(() => {});
  };

  const handleSelect = (item: QuestionOrderItem) => {
    if (submitted) return;
    setSelected((prev) => [...prev, item]);
    setRemaining((prev) => prev.filter((r) => r.id !== item.id));
  };

  const handleUnselect = (item: QuestionOrderItem) => {
    if (submitted) return;
    setRemaining((prev) => [...prev, item]);
    setSelected((prev) => prev.filter((s) => s.id !== item.id));
  };

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm">
        <p className="text-gray-800 leading-relaxed text-base font-medium">{body}</p>
      </div>

      <div>
        <p className="text-xs text-gray-500 mb-2 font-bold">
          👆 タップして正しい順番に並べよう（もう一度タップで戻せます）
        </p>
        <div className="min-h-[64px] rounded-2xl border-2 border-dashed border-emerald-300 bg-emerald-50/60 p-3 flex flex-wrap gap-2">
          {selected.map((item, idx) => {
            let style = "bg-white border-emerald-300";
            if (submitted) {
              style =
                item.correctPosition === idx + 1
                  ? "bg-emerald-50 border-emerald-400 text-emerald-800"
                  : "bg-rose-50 border-rose-400 text-rose-800";
            }
            return (
              <button
                key={item.id}
                onClick={() => handleUnselect(item)}
                disabled={submitted}
                className={`flex items-center gap-2 rounded-xl border-2 px-3 py-2 text-sm font-medium text-gray-800 shadow-sm transition-all active:scale-95 disabled:active:scale-100 ${style}`}
              >
                <span className="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-500 text-[11px] font-black text-white">
                  {idx + 1}
                </span>
                {item.body}
              </button>
            );
          })}
          {selected.length === 0 && (
            <span className="text-gray-400 text-sm self-center">ここに並べます</span>
          )}
        </div>
      </div>

      <div className="flex flex-wrap gap-2">
        {remaining.map((item) => (
          <button
            key={item.id}
            onClick={() => handleSelect(item)}
            className="rounded-xl bg-white border-2 border-gray-200 px-4 py-2.5 text-sm font-medium text-gray-800 shadow-sm transition-all hover:border-emerald-300 hover:bg-emerald-50/50 active:scale-95"
          >
            {item.body}
          </button>
        ))}
      </div>

      {!submitted && done && (
        <button
          onClick={handleSubmit}
          className="w-full min-h-[56px] rounded-2xl bg-emerald-500 py-4 text-base font-black text-white shadow-md shadow-emerald-200 transition-all hover:bg-emerald-600 active:scale-[0.98] animate-slide-up"
        >
          答え合わせ
        </button>
      )}

      {submitted && (
        <Feedback correct={correct} steps={steps} nextHref={nextHref} isLast={isLast}>
          {!correct && (
            <div>
              <p className="text-sm font-black text-gray-700 mb-1.5">正しい順番：</p>
              <div className="flex flex-wrap gap-2">
                {[...orderItems]
                  .sort((a, b) => a.correctPosition - b.correctPosition)
                  .map((item, idx) => (
                    <span
                      key={item.id}
                      className="flex items-center gap-1.5 rounded-xl bg-white border border-gray-300 px-3 py-1.5 text-sm text-gray-800"
                    >
                      <span className="flex h-5 w-5 items-center justify-center rounded-full bg-gray-200 text-[11px] font-black text-gray-600">
                        {idx + 1}
                      </span>
                      {item.body}
                    </span>
                  ))}
              </div>
            </div>
          )}
        </Feedback>
      )}
    </div>
  );
}
