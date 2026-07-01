"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

export default function DeleteButton({ path }: { path: string }) {
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  const handleDelete = async () => {
    if (!confirm("本当に削除しますか？")) return;
    setLoading(true);
    await fetch(`/api/admin/${path}`, { method: "DELETE" });
    setLoading(false);
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
