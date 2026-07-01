"use client";

export interface OrderItemInput {
  body: string;
}

export default function OrderingEditor({
  orderItems,
  onChange,
}: {
  orderItems: OrderItemInput[];
  onChange: (orderItems: OrderItemInput[]) => void;
}) {
  const update = (index: number, body: string) => {
    onChange(orderItems.map((o, i) => (i === index ? { body } : o)));
  };

  const move = (index: number, dir: -1 | 1) => {
    const target = index + dir;
    if (target < 0 || target >= orderItems.length) return;
    const next = [...orderItems];
    [next[index], next[target]] = [next[target], next[index]];
    onChange(next);
  };

  const remove = (index: number) => {
    onChange(orderItems.filter((_, i) => i !== index));
  };

  const add = () => {
    onChange([...orderItems, { body: "" }]);
  };

  return (
    <div className="space-y-2">
      <label className="block text-sm font-medium text-gray-700">
        並べ替え項目（上から正解の順番で入力してください）
      </label>
      {orderItems.map((o, i) => (
        <div key={i} className="flex items-center gap-2">
          <span className="text-sm text-gray-500 w-6 shrink-0">{i + 1}</span>
          <input
            type="text"
            value={o.body}
            onChange={(e) => update(i, e.target.value)}
            placeholder={`項目${i + 1}`}
            className="flex-1 rounded-xl border-2 border-gray-200 px-3 py-2 text-sm focus:border-blue-400 focus:outline-none"
          />
          <button type="button" onClick={() => move(i, -1)} className="text-gray-500 text-sm">
            ↑
          </button>
          <button type="button" onClick={() => move(i, 1)} className="text-gray-500 text-sm">
            ↓
          </button>
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
        + 項目を追加
      </button>
    </div>
  );
}
