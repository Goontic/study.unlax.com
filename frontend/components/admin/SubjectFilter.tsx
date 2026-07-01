"use client";

import { useRouter, useSearchParams } from "next/navigation";
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
  const searchParams = useSearchParams();

  return (
    <select
      defaultValue={value ?? ""}
      onChange={(e) => {
        const params = new URLSearchParams(searchParams.toString());
        const v = e.target.value;
        if (v) {
          params.set("subjectId", v);
        } else {
          params.delete("subjectId");
        }
        params.delete("page");
        router.push(`${basePath}?${params.toString()}`);
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
