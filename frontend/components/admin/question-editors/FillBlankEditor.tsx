"use client";

export interface BlankAnswerInput {
  correctAnswer: string;
}

export default function FillBlankEditor({
  body,
  blankAnswers,
  onChange,
}: {
  body: string;
  blankAnswers: BlankAnswerInput[];
  onChange: (blankAnswers: BlankAnswerInput[]) => void;
}) {
  const update = (index: number, correctAnswer: string) => {
    onChange(blankAnswers.map((b, i) => (i === index ? { correctAnswer } : b)));
  };

  const remove = (index: number) => {
    onChange(blankAnswers.filter((_, i) => i !== index));
  };

  const add = () => {
    onChange([...blankAnswers, { correctAnswer: "" }]);
  };

  return (
    <div className="space-y-2">
      <label className="block text-sm font-medium text-gray-700">
        空欄の正解（本文中の {"{{1}}"}, {"{{2}}"} … に対応させてください）
      </label>
      <p className="text-xs text-gray-500 whitespace-pre-wrap bg-gray-50 rounded-lg p-2">
        {body || "（本文を入力すると、ここにプレビューが表示されます）"}
      </p>
      {blankAnswers.map((b, i) => (
        <div key={i} className="flex items-center gap-2">
          <span className="text-sm text-gray-500 w-16 shrink-0">{`{{${i + 1}}}`}</span>
          <input
            type="text"
            value={b.correctAnswer}
            onChange={(e) => update(i, e.target.value)}
            placeholder="正解"
            className="flex-1 rounded-xl border-2 border-gray-200 px-3 py-2 text-sm focus:border-blue-400 focus:outline-none"
          />
          <button
            type="button"
            onClick={() => remove(i)}
            className="text-red-600 text-sm underline"
          >
            削除
          </button>
        </div>
      ))}
      <button type="button" onClick={add} className="text-blue-600 text-sm underline">
        + 空欄を追加
      </button>
    </div>
  );
}
