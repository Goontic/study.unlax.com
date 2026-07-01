"use client";

import { useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";

export default function KeywordSearch({
  basePath,
  value,
}: {
  basePath: string;
  value?: string;
}) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [keyword, setKeyword] = useState(value ?? "");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const params = new URLSearchParams(searchParams.toString());
    if (keyword) {
      params.set("keyword", keyword);
    } else {
      params.delete("keyword");
    }
    params.delete("page");
    router.push(`${basePath}?${params.toString()}`);
  };

  return (
    <form onSubmit={handleSubmit} className="flex gap-2">
      <input
        type="text"
        value={keyword}
        onChange={(e) => setKeyword(e.target.value)}
        placeholder="キーワードで検索"
        className="rounded-xl border-2 border-gray-200 px-4 py-2 text-sm focus:border-blue-400 focus:outline-none"
      />
      <button
        type="submit"
        className="rounded-xl bg-gray-200 text-gray-700 text-sm font-medium px-4 py-2"
      >
        検索
      </button>
    </form>
  );
}
