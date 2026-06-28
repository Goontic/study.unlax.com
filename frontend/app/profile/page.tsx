import { auth } from "@/lib/auth";
import { redirect } from "next/navigation";
import type { Metadata } from "next";
import SignOutButton from "./SignOutButton";

export const metadata: Metadata = {
  title: "マイページ",
};

export default async function ProfilePage() {
  const session = await auth();
  if (!session?.user) redirect("/login");

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <h1 className="text-2xl font-bold text-gray-800 mb-6">マイページ</h1>

      <div className="bg-white rounded-xl border border-gray-200 p-5 shadow-sm mb-6">
        <p className="font-bold text-lg text-gray-800">{session.user.name}</p>
        <p className="text-gray-500 text-sm">{session.user.email}</p>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-5 shadow-sm mb-6">
        <h2 className="font-bold text-gray-700 mb-3">学習統計</h2>
        <p className="text-gray-500 text-sm">
          統計データは学習を進めると表示されます。
        </p>
      </div>

      <SignOutButton />
    </div>
  );
}
