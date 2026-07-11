import { notFound } from "next/navigation";
import AdminUserForm from "@/components/admin/AdminUserForm";
import { prisma } from "@/lib/prisma";
import type { AdminUser } from "@/lib/types";

export const dynamic = "force-dynamic";

interface Props {
  params: Promise<{ id: string }>;
}

export default async function EditAdminPage({ params }: Props) {
  const { id } = await params;
  const record = await prisma.adminUser.findUnique({
    where: { id: Number(id) },
    select: { id: true, email: true, displayName: true, createdAt: true, updatedAt: true },
  });
  if (!record) notFound();
  const admin: AdminUser = {
    ...record,
    createdAt: record.createdAt.toISOString(),
    updatedAt: record.updatedAt.toISOString(),
  };

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">管理者の編集</h1>
      <AdminUserForm admin={admin} />
    </div>
  );
}
