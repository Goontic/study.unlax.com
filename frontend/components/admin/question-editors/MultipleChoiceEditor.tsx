"use client";

export interface ChoiceInput {
  body: string;
  isCorrect: boolean;
}

export default function MultipleChoiceEditor({
  choices,
  onChange,
}: {
  choices: ChoiceInput[];
  onChange: (choices: ChoiceInput[]) => void;
}) {
  const update = (index: number, patch: Partial<ChoiceInput>) => {
    onChange(choices.map((c, i) => (i === index ? { ...c, ...patch } : c)));
  };

  const setCorrect = (index: number) => {
    onChange(choices.map((c, i) => ({ ...c, isCorrect: i === index })));
  };

  const remove = (index: number) => {
    onChange(choices.filter((_, i) => i !== index));
  };

  const add = () => {
    onChange([...choices, { body: "", isCorrect: choices.length === 0 }]);
  };

  return (
    <div className="space-y-2">
      <label className="block text-sm font-medium text-gray-700">選択肢（正解を1つ選択）</label>
      {choices.map((c, i) => (
        <div key={i} className="flex items-center gap-2">
          <input
            type="radio"
            name="correct-choice"
            checked={c.isCorrect}
            onChange={() => setCorrect(i)}
          />
          <input
            type="text"
            value={c.body}
            onChange={(e) => update(i, { body: e.target.value })}
            placeholder={`選択肢${i + 1}`}
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
        + 選択肢を追加
      </button>
    </div>
  );
}
