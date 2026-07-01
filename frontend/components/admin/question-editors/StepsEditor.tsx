"use client";

export interface StepInput {
  body: string;
}

export default function StepsEditor({
  steps,
  onChange,
}: {
  steps: StepInput[];
  onChange: (steps: StepInput[]) => void;
}) {
  const update = (index: number, body: string) => {
    onChange(steps.map((s, i) => (i === index ? { body } : s)));
  };

  const remove = (index: number) => {
    onChange(steps.filter((_, i) => i !== index));
  };

  const add = () => {
    onChange([...steps, { body: "" }]);
  };

  return (
    <div className="space-y-2">
      <label className="block text-sm font-medium text-gray-700">解説ステップ（任意）</label>
      {steps.map((s, i) => (
        <div key={i} className="flex items-start gap-2">
          <span className="text-sm text-gray-500 w-6 shrink-0 mt-2">{i + 1}</span>
          <textarea
            value={s.body}
            onChange={(e) => update(i, e.target.value)}
            placeholder={`ステップ${i + 1}の説明`}
            rows={2}
            className="flex-1 rounded-xl border-2 border-gray-200 px-3 py-2 text-sm focus:border-blue-400 focus:outline-none"
          />
          <button
            type="button"
            onClick={() => remove(i)}
            className="text-red-600 text-sm underline mt-2"
          >
            削除
          </button>
        </div>
      ))}
      <button type="button" onClick={add} className="text-blue-600 text-sm underline">
        + ステップを追加
      </button>
    </div>
  );
}
