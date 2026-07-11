import Link from "next/link";
import DeleteButton from "@/components/admin/DeleteButton";
import { findAllSubjects } from "@/lib/admin/subjects";

export const dynamic = "force-dynamic";

export default async function AdminSubjectsPage() {
  const subjects = await findAllSubjects();

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-800">科目管理</h1>
        <Link
          href="/admin/subjects/new"
          className="rounded-xl bg-blue-600 text-white font-bold px-4 py-2"
        >
          新規作成
        </Link>
      </div>
      <div className="space-y-2">
        {subjects.map((s) => (
          <div
            key={s.id}
            className="bg-white rounded-xl border border-gray-200 p-4 flex justify-between items-center"
          >
            <div>
              <p className="font-bold text-gray-800">
                {s.icon} {s.name}
              </p>
              <p className="text-xs text-gray-500">
                {s.genre === "certification" ? "検定" : s.schoolLevel} / {s.slug} / 表示順{" "}
                {s.displayOrder}
              </p>
            </div>
            <div className="flex gap-3 items-center">
              <Link href={`/admin/subjects/${s.id}/edit`} className="text-blue-600 text-sm underline">
                編集
              </Link>
              <DeleteButton path={`subjects/${s.id}`} />
            </div>
          </div>
        ))}
        {subjects.length === 0 && (
          <p className="text-gray-500 text-sm">科目がまだ登録されていません。</p>
        )}
      </div>
    </div>
  );
}
