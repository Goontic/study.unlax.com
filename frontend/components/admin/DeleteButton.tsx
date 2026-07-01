"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

export default function DeleteButton({ path }: { path: string }) {
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  const handleDelete = async () => {
    if (!confirm("本当に削除しますか？")) return;
    setLoading(true);
    const res = await fetch(`/api/admin/${path}`, { method: "DELETE" });
    setLoading(false);
    if (!res.ok) {
      const data = await res.json().catch(() => null);
      alert(data?.message ?? "削除に失敗しました");
      return;
    }
    router.refresh();
  };

  return (
    <button
      onClick={handleDelete}
      disabled={loading}
      className="text-red-600 text-sm underline disabled:opacity-40"
    >
      削除
    </button>
  );
}
