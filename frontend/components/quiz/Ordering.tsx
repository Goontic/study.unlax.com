"use client";

import { useState } from "react";
import type { QuestionOrderItem, QuestionStep } from "@/lib/types";

interface Props {
  body: string;
  orderItems: QuestionOrderItem[];
  steps: QuestionStep[];
}

export default function Ordering({ body, orderItems, steps }: Props) {
  const shuffled = [...orderItems].sort(() => Math.random() - 0.5);
  const [remaining, setRemaining] = useState<QuestionOrderItem[]>(shuffled);
  const [selected, setSelected] = useState<QuestionOrderItem[]>([]);
  const [submitted, setSubmitted] = useState(false);

  const done = selected.length === orderItems.length;

  const correct =
    submitted &&
    selected.every((item, idx) => item.correctPosition === idx + 1);

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
      <div className="bg-white rounded-xl border border-gray-200 p-5 shadow-sm">
        <p className="text-gray-800 leading-relaxed text-base font-medium">{body}</p>
      </div>

      <div>
        <p className="text-xs text-gray-500 mb-2 font-medium">タップして正しい順番に並べよう</p>
        <div className="min-h-[60px] rounded-xl border-2 border-dashed border-blue-200 bg-blue-50 p-3 flex flex-wrap gap-2">
          {selected.map((item, idx) => (
            <button
              key={item.id}
              onClick={() => handleUnselect(item)}
              disabled={submitted}
              className="flex items-center gap-2 rounded-lg bg-white border border-blue-300 px-3 py-2 text-sm font-medium text-gray-800 shadow-sm active:opacity-70 disabled:opacity-100"
            >
              <span className="text-blue-600 font-bold">{idx + 1}.</span>
              {item.body}
            </button>
          ))}
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
            className="rounded-lg bg-white border-2 border-gray-200 px-4 py-2 text-sm font-medium text-gray-800 active:bg-gray-50 transition-colors"
          >
            {item.body}
          </button>
        ))}
      </div>

      {!submitted && done && (
        <button
          onClick={() => setSubmitted(true)}
          className="w-full rounded-xl bg-blue-600 text-white font-bold py-4 text-base active:bg-blue-700 transition-colors min-h-[56px]"
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
          <p className={`font-bold mb-3 text-lg ${correct ? "text-green-700" : "text-red-700"}`}>
            {correct ? "正解！" : "不正解…"}
          </p>
          {!correct && (
            <div className="mb-3">
              <p className="text-sm font-bold text-gray-700 mb-1">正しい順番：</p>
              <div className="flex flex-wrap gap-2">
                {[...orderItems]
                  .sort((a, b) => a.correctPosition - b.correctPosition)
                  .map((item, idx) => (
                    <span
                      key={item.id}
                      className="rounded-lg bg-white border border-gray-300 px-3 py-1 text-sm text-gray-800"
                    >
                      {idx + 1}. {item.body}
                    </span>
                  ))}
              </div>
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
    </div>
  );
}
