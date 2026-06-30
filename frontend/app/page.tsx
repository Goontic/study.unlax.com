import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import GradeSelector from "@/components/GradeSelector";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "ポケスタ | スキマ時間で合格を掴む！小中学生の無料受験対策ドリル",
  description:
    "ポケスタは小学生・中学生向けの完全無料受験対策ドリル。5科目（数学・英語・国語・理科・社会）をスキマ時間にスマホで学習。登録なしでいますぐ始められます！",
};

const FEATURES = [
  {
    num: 1,
    icon: "⏰",
    title: "スキマ時間を有効活用",
    desc: "電車・バス・待ち時間…5分から始められる",
  },
  {
    num: 2,
    icon: "📚",
    title: "豊富な問題数・5科目対応",
    desc: "算数から英語まで小・中・入試対策を網羅",
  },
  {
    num: 3,
    icon: "💡",
    title: "わかりやすい解説付き",
    desc: "正解・不正解どちらも丁寧な解説で理解が深まる",
  },
  {
    num: 4,
    icon: "🎉",
    title: "完全無料！登録なしOK",
    desc: "ずっと0円。今すぐスマホで始められる",
  },
];

const CATEGORIES = [
  {
    href: "/#start",
    label: "小学校",
    sub: "算数・国語・理科・社会・英語",
    gradient: "from-amber-400 to-orange-500",
    image: "/images/cat-elementary.png",
    icon: "🎒",
  },
  {
    href: "/#start",
    label: "中学校",
    sub: "数学・英語・国語・理科・社会",
    gradient: "from-sky-400 to-blue-500",
    image: "/images/cat-middle.png",
    icon: "🏫",
  },
  {
    href: "/exam-prep",
    label: "高校入試対策",
    sub: "5科目・入試頻出問題",
    gradient: "from-rose-500 to-red-600",
    image: "/images/cat-exam.png",
    icon: "🎯",
  },
];

export default function HomePage() {
  return (
    <div className="bg-white">
      {/* ヒーローセクション */}
      <section className="relative overflow-hidden min-h-[400px]">
        {/* 背景画像 */}
        <Image
          src="/images/hero-bg.png"
          alt=""
          fill
          className="object-cover object-center"
          priority
          unoptimized
        />
        {/* テキストオーバーレイ（中央） */}
        <div className="relative z-10 flex flex-col items-center justify-center min-h-[400px] px-4 py-10 text-center">
          <h1 className="text-4xl sm:text-5xl font-black text-gray-800 leading-snug mb-3">
            スキマ時間で合格へ！<br />
            <span className="text-emerald-600">完全無料の学習ドリル</span>
          </h1>
          <p className="text-gray-600 text-sm font-medium mb-6 leading-relaxed">
            電車の中、待ち時間、寝る前、<br />どこでも効率よく学べる。
          </p>
          <Link
            href="#start"
            className="inline-block bg-emerald-500 text-white font-black text-sm px-8 py-3 rounded-full shadow-lg hover:bg-emerald-600 active:scale-95 transition-all"
          >
            今すぐ無料で始める →
          </Link>
        </div>
      </section>

      {/* 特徴セクション */}
      <section className="max-w-2xl mx-auto px-4 pt-10 pb-8">
        <h2 className="text-xl font-black text-gray-800 text-center mb-6">
          ポケスタの特徴
        </h2>
        <div className="grid grid-cols-2 gap-3">
          {FEATURES.map((f) => (
            <div
              key={f.num}
              className="bg-white rounded-2xl shadow-sm border border-gray-100 p-4"
            >
              <div className="flex items-center gap-2 mb-2">
                <span className="flex-shrink-0 w-6 h-6 rounded-full bg-emerald-500 text-white text-xs font-black flex items-center justify-center">
                  {f.num}
                </span>
                <span className="text-xl" aria-hidden>{f.icon}</span>
              </div>
              <p className="font-black text-sm text-gray-800 mb-1 leading-snug">{f.title}</p>
              <p className="text-xs text-gray-500 leading-relaxed">{f.desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* 学習カテゴリーセクション */}
      <section className="max-w-2xl mx-auto px-4 pb-8">
        <h2 className="text-xl font-black text-gray-800 text-center mb-5">
          主な学習カテゴリー
        </h2>
        <div className="grid grid-cols-3 gap-3">
          {CATEGORIES.map((cat) => (
            <Link key={cat.label} href={cat.href} className="group">
              <div
                className={`relative bg-gradient-to-br ${cat.gradient} rounded-2xl overflow-hidden shadow-md min-h-[110px] flex flex-col items-center justify-end pb-3 pt-2 group-active:opacity-80 transition-opacity`}
              >
                {/* カテゴリー画像（/public/images/cat-*.png を配置） */}
                <div className="absolute inset-0">
                  <Image
                    src={cat.image}
                    alt={cat.label}
                    fill
                    className="object-cover opacity-30"
                    unoptimized
                  />
                </div>
                <span className="relative text-3xl mb-1" aria-hidden>{cat.icon}</span>
                <span className="relative font-black text-sm text-white text-center leading-tight">
                  {cat.label}
                </span>
                <span className="relative text-[10px] text-white/80 text-center leading-tight mt-0.5 px-1">
                  {cat.sub}
                </span>
              </div>
            </Link>
          ))}
        </div>
      </section>

      {/* 学年・科目セレクター */}
      <section id="start" className="max-w-2xl mx-auto px-4 pb-10">
        <div className="flex items-center gap-2 mb-4">
          <span className="text-2xl" aria-hidden>📚</span>
          <h2 className="text-lg font-black text-gray-800">学年を選んでね！</h2>
        </div>
        <GradeSelector />
      </section>
    </div>
  );
}
