import { requireAdmin } from "@/lib/admin-auth";
import AdminNav from "@/components/admin/AdminNav";

export default async function AdminProtectedLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  await requireAdmin();
  return (
    <div className="min-h-screen bg-gray-50">
      <AdminNav />
      <main className="max-w-4xl mx-auto px-4 py-6">{children}</main>
    </div>
  );
}
