import Link from "next/link";
import { getAdminToken } from "@/lib/admin-auth";
import DeleteButton from "@/components/admin/DeleteButton";
import type { AdminUser } from "@/lib/types";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

async function fetchAdmins(token: string): Promise<AdminUser[]> {
  const res = await fetch(`${API_BASE}/admin/admins`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!res.ok) return [];
  return res.json() as Promise<AdminUser[]>;
}

export default async function AdminAdminsPage() {
  const token = (await getAdminToken())!;
  const admins = await fetchAdmins(token);

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-800">管理者管理</h1>
        <Link
          href="/admin/admins/new"
          className="rounded-xl bg-blue-600 text-white font-bold px-4 py-2"
        >
          新規作成
        </Link>
      </div>
      <div className="space-y-2">
        {admins.map((a) => (
          <div
            key={a.id}
            className="bg-white rounded-xl border border-gray-200 p-4 flex justify-between items-center"
          >
            <div>
              <p className="font-bold text-gray-800">{a.displayName}</p>
              <p className="text-xs text-gray-500">{a.email}</p>
            </div>
            <div className="flex gap-3 items-center">
              <Link href={`/admin/admins/${a.id}/edit`} className="text-blue-600 text-sm underline">
                編集
              </Link>
              <DeleteButton path={`admins/${a.id}`} />
            </div>
          </div>
        ))}
        {admins.length === 0 && (
          <p className="text-gray-500 text-sm">管理者がまだ登録されていません。</p>
        )}
      </div>
    </div>
  );
}
