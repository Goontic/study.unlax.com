"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import type { Subject, Topic } from "@/lib/types";

export default function TopicForm({
  subjects,
  topic,
  defaultSubjectId,
}: {
  subjects: Subject[];
  topic?: Topic;
  defaultSubjectId?: number;
}) {
  const router = useRouter();
  const [subjectId, setSubjectId] = useState(
    topic?.subjectId ?? defaultSubjectId ?? subjects[0]?.id ?? 0,
  );
  const [slug, setSlug] = useState(topic?.slug ?? "");
  const [name, setName] = useState(topic?.name ?? "");
  const [gradeLevel, setGradeLevel] = useState(topic?.gradeLevel ?? 1);
  const [displayOrder, setDisplayOrder] = useState(topic?.displayOrder ?? 0);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    const path = topic ? `topics/${topic.id}` : "topics";
    const res = await fetch(`/api/admin/${path}`, {
      method: topic ? "PATCH" : "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        subjectId: Number(subjectId),
        slug,
        name,
        gradeLevel: Number(gradeLevel),
        displayOrder: Number(displayOrder),
      }),
    });

    setLoading(false);
    if (!res.ok) {
      const data = await res.json().catch(() => null);
      setError(data?.message ?? "保存に失敗しました");
      return;
    }
    router.push("/admin/topics");
    router.refresh();
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4 bg-white rounded-xl border border-gray-200 p-5 shadow-sm">
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">科目</label>
        <select
          value={subjectId}
          onChange={(e) => setSubjectId(Number(e.target.value))}
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
        <label className="block text-sm font-medium text-gray-700 mb-1">単元名</label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
          className="w-full rounded-xl border-2 border-gray-200 px-4 py-3 text-base focus:border-blue-400 focus:outline-none"
        />
      </div>
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">学年</label>
        <input
          type="number"
          value={gradeLevel}
          onChange={(e) => setGradeLevel(Number(e.target.value))}
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
