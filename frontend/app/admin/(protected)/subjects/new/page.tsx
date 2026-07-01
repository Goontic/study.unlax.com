import SubjectForm from "@/components/admin/SubjectForm";

export default function NewSubjectPage() {
  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">科目の新規作成</h1>
      <SubjectForm />
    </div>
  );
}
