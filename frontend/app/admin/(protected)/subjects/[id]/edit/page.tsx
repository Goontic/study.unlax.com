import { notFound } from "next/navigation";
import SubjectForm from "@/components/admin/SubjectForm";
import { prisma } from "@/lib/prisma";

export const dynamic = "force-dynamic";

interface Props {
  params: Promise<{ id: string }>;
}

export default async function EditSubjectPage({ params }: Props) {
  const { id } = await params;
  const subject = await prisma.subject.findUnique({ where: { id: Number(id) } });
  if (!subject) notFound();

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">科目の編集</h1>
      <SubjectForm subject={subject} />
    </div>
  );
}
