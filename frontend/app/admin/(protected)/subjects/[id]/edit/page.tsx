import { notFound } from "next/navigation";
import { getAdminToken } from "@/lib/admin-auth";
import SubjectForm from "@/components/admin/SubjectForm";
import type { Subject } from "@/lib/types";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

interface Props {
  params: Promise<{ id: string }>;
}

export default async function EditSubjectPage({ params }: Props) {
  const { id } = await params;
  const token = (await getAdminToken())!;
  const res = await fetch(`${API_BASE}/admin/subjects/${id}`, {
    headers: { Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!res.ok) notFound();
  const subject = (await res.json()) as Subject;

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">科目の編集</h1>
      <SubjectForm subject={subject} />
    </div>
  );
}
