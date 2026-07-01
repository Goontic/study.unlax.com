import Link from "next/link";
import AdminLogoutButton from "./AdminLogoutButton";

export default function AdminNav() {
  return (
    <header className="bg-white border-b border-gray-200">
      <div className="max-w-4xl mx-auto px-4 py-3 flex items-center justify-between">
        <nav className="flex gap-4 text-sm font-medium">
          <Link href="/admin/subjects" className="text-gray-700 hover:text-blue-600">
            科目
          </Link>
          <Link href="/admin/topics" className="text-gray-700 hover:text-blue-600">
            単元
          </Link>
          <Link href="/admin/questions" className="text-gray-700 hover:text-blue-600">
            問題
          </Link>
        </nav>
        <AdminLogoutButton />
      </div>
    </header>
  );
}
