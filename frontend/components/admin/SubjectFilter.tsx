"use client";

import { useRouter } from "next/navigation";
import type { Subject } from "@/lib/types";

export default function SubjectFilter({
  subjects,
  basePath,
  value,
}: {
  subjects: Subject[];
  basePath: string;
  value?: string;
}) {
  const router = useRouter();

  return (
    <select
      defaultValue={value ?? ""}
      onChange={(e) => {
        const v = e.target.value;
        router.push(v ? `${basePath}?subjectId=${v}` : basePath);
      }}
      className="rounded-xl border-2 border-gray-200 px-4 py-2 text-sm"
    >
      <option value="">すべての科目</option>
      {subjects.map((s) => (
        <option key={s.id} value={s.id}>
          {s.name}
        </option>
      ))}
    </select>
  );
}
