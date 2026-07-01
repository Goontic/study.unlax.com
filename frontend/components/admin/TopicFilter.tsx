"use client";

import { useRouter, useSearchParams } from "next/navigation";
import type { Topic } from "@/lib/types";

export default function TopicFilter({
  topics,
  basePath,
  value,
}: {
  topics: Topic[];
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
          params.set("topicId", v);
        } else {
          params.delete("topicId");
        }
        params.delete("page");
        router.push(`${basePath}?${params.toString()}`);
      }}
      className="rounded-xl border-2 border-gray-200 px-4 py-2 text-sm"
    >
      <option value="">すべての単元</option>
      {topics.map((t) => (
        <option key={t.id} value={t.id}>
          {t.name}
        </option>
      ))}
    </select>
  );
}
