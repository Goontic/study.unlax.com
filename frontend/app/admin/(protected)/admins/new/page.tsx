import AdminUserForm from "@/components/admin/AdminUserForm";

export default function NewAdminPage() {
  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800 mb-6">管理者の新規作成</h1>
      <AdminUserForm />
    </div>
  );
}
