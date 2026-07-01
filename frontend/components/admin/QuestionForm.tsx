"use client";

import { useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import type { Question, QuestionType, Subject, Topic } from "@/lib/types";
import MultipleChoiceEditor, { type ChoiceInput } from "./question-editors/MultipleChoiceEditor";
import FillBlankEditor, { type BlankAnswerInput } from "./question-editors/FillBlankEditor";
import OrderingEditor, { type OrderItemInput } from "./question-editors/OrderingEditor";
import StepsEditor, { type StepInput } from "./question-editors/StepsEditor";

const TYPE_LABELS: { value: QuestionType; label: string }[] = [
  { value: "multiple_choice", label: "4択" },
  { value: "text_input", label: "記述式" },
  { value: "fill_blank", label: "穴埋め" },
  { value: "ordering", label: "並べ替え" },
];

export default function QuestionForm({
  subjects,
  topics,
  question,
  defaultTopicId,
}: {
  subjects: Subject[];
  topics: Topic[];
  question?: Question;
  defaultTopicId?: number;
}) {
  const router = useRouter();

  const initialTopicId = question?.topicId ?? defaultTopicId ?? topics[0]?.id;
  const initialSubjectId = topics.find((t) => t.id === initialTopicId)?.subjectId ?? subjects[0]?.id;

  const [subjectId, setSubjectId] = useState<number | undefined>(initialSubjectId);
  const [topicId, setTopicId] = useState<number | undefined>(initialTopicId);
  const [type, setType] = useState<QuestionType>(question?.type ?? "multiple_choice");
  const [body, setBody] = useState(question?.body ?? "");
  const [difficulty, setDifficulty] = useState(question?.difficulty ?? 3);
  const [displayOrder, setDisplayOrder] = useState(question?.displayOrder ?? 0);

  const [choices, setChoices] = useState<ChoiceInput[]>(
    question?.choices?.map((c) => ({ body: c.body, isCorrect: c.isCorrect })) ?? [],
  );
  const [blankAnswers, setBlankAnswers] = useState<BlankAnswerInput[]>(
    question?.blankAnswers?.map((b) => ({ correctAnswer: b.correctAnswer })) ?? [],
  );
  const [orderItems, setOrderItems] = useState<OrderItemInput[]>(
    question?.orderItems?.map((o) => ({ body: o.body })) ?? [],
  );
  const [steps, setSteps] = useState<StepInput[]>(
    question?.steps?.map((s) => ({ body: s.body })) ?? [],
  );

  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const filteredTopics = useMemo(
    () => topics.filter((t) => t.subjectId === subjectId),
    [topics, subjectId],
  );

  const handleSubjectChange = (id: number) => {
    setSubjectId(id);
    const first = topics.find((t) => t.subjectId === id);
    setTopicId(first?.id);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!topicId) {
      setError("単元を選択してください");
      return;
    }
    setLoading(true);
    setError("");

    const payload = {
      topicId,
      type,
      body,
      difficulty: Number(difficulty),
      displayOrder: Number(displayOrder),
      choices:
        type === "multiple_choice"
          ? choices.map((c, i) => ({ body: c.body, isCorrect: c.isCorrect, displayOrder: i }))
          : undefined,
      blankAnswers:
        type === "fill_blank"
          ? blankAnswers.map((b, i) => ({ blankIndex: i + 1, correctAnswer: b.correctAnswer }))
          : undefined,
      orderItems:
        type === "ordering"
          ? orderItems.map((o, i) => ({ body: o.body, correctPosition: i + 1 }))
          : undefined,
      steps: steps.length ? steps.map((s, i) => ({ stepNumber: i + 1, body: s.body })) : undefined,
    };

    const path = question ? `questions/${question.id}` : "questions";
    const res = await fetch(`/api/admin/${path}`, {
      method: question ? "PATCH" : "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });

    setLoading(false);
    if (!res.ok) {
      const data = await res.json().catch(() => null);
      setError(data?.message ?? "保存に失敗しました");
      return;
    }
    router.push("/admin/questions");
    router.refresh();
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4 bg-white rounded-xl border border-gray-200 p-5 shadow-sm">
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">科目</label>
          <select
            value={subjectId}
            onChange={(e) => handleSubjectChange(Number(e.target.value))}
            className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
          >
            {subjects.map((s) => (
              <option key={s.id} value={s.id}>
                {s.name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">単元</label>
          <select
            value={topicId}
            onChange={(e) => setTopicId(Number(e.target.value))}
            className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
          >
            {filteredTopics.map((t) => (
              <option key={t.id} value={t.id}>
                {t.name}
              </option>
            ))}
          </select>
        </div>
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">形式</label>
        <select
          value={type}
          onChange={(e) => setType(e.target.value as QuestionType)}
          className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
        >
          {TYPE_LABELS.map((t) => (
            <option key={t.value} value={t.value}>
              {t.label}
            </option>
          ))}
        </select>
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">問題文</label>
        <textarea
          value={body}
          onChange={(e) => setBody(e.target.value)}
          required
          rows={4}
          className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
        />
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">難易度（1〜5）</label>
          <input
            type="number"
            min={1}
            max={5}
            value={difficulty}
            onChange={(e) => setDifficulty(Number(e.target.value))}
            required
            className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
          />
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">表示順</label>
          <input
            type="number"
            value={displayOrder}
            onChange={(e) => setDisplayOrder(Number(e.target.value))}
            required
            className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
          />
        </div>
      </div>

      {type === "multiple_choice" && (
        <MultipleChoiceEditor choices={choices} onChange={setChoices} />
      )}
      {type === "fill_blank" && (
        <FillBlankEditor body={body} blankAnswers={blankAnswers} onChange={setBlankAnswers} />
      )}
      {type === "ordering" && (
        <OrderingEditor orderItems={orderItems} onChange={setOrderItems} />
      )}

      <StepsEditor steps={steps} onChange={setSteps} />

      {error && <p className="text-red-600 text-sm">{error}</p>}
      <button
        type="submit"
        disabled={loading}
        className="w-full rounded-xl bg-blue-600 text-white font-bold py-4 text-base disabled:opacity-40 active:bg-blue-700 transition-colors min-h-[56px]"
      >
        {loading ? "保存中…" : "保存"}
      </button>
    </form>
  );
}
