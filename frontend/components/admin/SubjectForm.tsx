"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import type { Subject, SchoolLevel } from "@/lib/types";

const SCHOOL_LEVELS: { value: SchoolLevel; label: string }[] = [
  { value: "elementary", label: "小学生" },
  { value: "middle", label: "中学生" },
  { value: "exam_prep", label: "受験対策" },
];

export default function SubjectForm({ subject }: { subject?: Subject }) {
  const router = useRouter();
  const [slug, setSlug] = useState(subject?.slug ?? "");
  const [name, setName] = useState(subject?.name ?? "");
  const [icon, setIcon] = useState(subject?.icon ?? "");
  const [displayOrder, setDisplayOrder] = useState(subject?.displayOrder ?? 0);
  const [schoolLevel, setSchoolLevel] = useState<SchoolLevel>(subject?.schoolLevel ?? "middle");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    const path = subject ? `subjects/${subject.id}` : "subjects";
    const res = await fetch(`/api/admin/${path}`, {
      method: subject ? "PATCH" : "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ slug, name, icon, displayOrder: Number(displayOrder), schoolLevel }),
    });

    setLoading(false);
    if (!res.ok) {
      const data = await res.json().catch(() => null);
      setError(data?.message ?? "保存に失敗しました");
      return;
    }
    router.push("/admin/subjects");
    router.refresh();
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4 bg-white rounded-xl border border-gray-200 p-5 shadow-sm">
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">slug</label>
        <input
          type="text"
          value={slug}
          onChange={(e) => setSlug(e.target.value)}
          required
          className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
        />
      </div>
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">名前</label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
          className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
        />
      </div>
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">アイコン</label>
        <input
          type="text"
          value={icon}
          onChange={(e) => setIcon(e.target.value)}
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
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">対象</label>
        <select
          value={schoolLevel}
          onChange={(e) => setSchoolLevel(e.target.value as SchoolLevel)}
          className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
        >
          {SCHOOL_LEVELS.map((s) => (
            <option key={s.value} value={s.value}>
              {s.label}
            </option>
          ))}
        </select>
      </div>
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
