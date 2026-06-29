import type { Metadata } from "next";
import GradeSelector from "@/components/GradeSelector";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "受験スタディ | 小学生・中学生の受験対策",
  description:
    "小学生・中学生の受験対策ができるサイトです。5科目（数学・英語・国語・理科・社会）の問題と解説が無料で使えます。スマホ・タブレットで移動中も学習できます。",
};

export default function HomePage() {
  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <section className="mb-8">
        <h1 className="text-2xl font-bold text-gray-800 mb-1">受験スタディ</h1>
        <p className="text-gray-500 text-sm">
          受験の勉強を、スマホで手軽に。全問題・解説が無料です。
        </p>
      </section>

      <GradeSelector />
    </div>
  );
}
