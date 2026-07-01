import { notFound } from "next/navigation";
import { getAdminToken } from "@/lib/admin-auth";
import AdminUserForm from "@/components/admin/AdminUserForm";
import type { AdminUser } from "@/lib/types";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

interface Props {
  params: Promise<{ id: string }>;
}

export default async function EditAdminPage({ params }: Props) {
  const { id } = await params;
  const token = (await getAdminToken())!;
  const res = await fetch(`${API_BASE}/admin/admins/${id}`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!res.ok) notFound();
  const admin = (await res.json()) as AdminUser;

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">管理者の編集</h1>
      <AdminUserForm admin={admin} />
    </div>
  );
}
