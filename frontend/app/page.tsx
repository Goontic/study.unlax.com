import type { Metadata } from "next";
import GradeSelector from "@/components/GradeSelector";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "ポケスタ | スキマ時間で合格を掴む！小中学生の無料受験対策ドリル",
  description:
    "ポケスタは小学生・中学生向けの完全無料受験対策ドリル。5科目（数学・英語・国語・理科・社会）をスキマ時間にスマホで学習。登録なしでいますぐ始められます！",
};

export default function HomePage() {
  return (
    <div className="bg-white">
      {/* ヒーローバナー */}
      <section className="relative overflow-hidden bg-gradient-to-br from-yellow-300 via-orange-300 to-pink-400 px-4 pt-10 pb-16 text-center">
        {/* 浮遊キャラクター（背景装飾） */}
        <span className="absolute top-3 left-3 text-4xl select-none opacity-70" aria-hidden>🌟</span>
        <span className="absolute top-5 right-5 text-3xl select-none opacity-70" aria-hidden>✨</span>
        <span className="absolute top-14 left-10 text-2xl select-none opacity-60" aria-hidden>🎵</span>
        <span className="absolute bottom-5 left-5 text-3xl select-none opacity-70" aria-hidden>🎈</span>
        <span className="absolute bottom-4 right-8 text-3xl select-none opacity-70" aria-hidden>⭐</span>
        <span className="absolute top-8 right-16 text-2xl select-none opacity-50" aria-hidden>💫</span>

        {/* 無料バッジ */}
        <div className="inline-flex items-center gap-2 bg-white rounded-full px-5 py-2.5 mb-5 shadow-lg">
          <span className="text-2xl" aria-hidden>🎉</span>
          <span className="font-black text-xl text-orange-500 tracking-wide">全部 無料！</span>
          <span className="text-2xl" aria-hidden>🎉</span>
        </div>

        <h1 className="text-3xl font-black text-white drop-shadow mb-3 leading-snug">
          勉強、<br />たのしくいこう！
        </h1>
        <p className="text-white font-bold text-base mb-7 drop-shadow-sm">
          スマホで5分から♪ 受験対策アプリ
        </p>

        {/* キャラクター行 */}
        <div className="flex justify-center gap-3 text-5xl mb-2" aria-hidden>
          <span>🦁</span>
          <span>🐰</span>
          <span>🐻</span>
          <span>🐼</span>
          <span>🐨</span>
        </div>
      </section>

      {/* 特徴カード（ヒーロー下に重ねる） */}
      <div className="max-w-2xl mx-auto px-4">
        <div className="grid grid-cols-3 gap-3 -mt-6 mb-8 relative z-10">
          <div className="bg-white rounded-2xl shadow-lg p-4 text-center border-t-4 border-yellow-400">
            <div className="text-3xl mb-1" aria-hidden>💰</div>
            <div className="text-xs font-black text-yellow-600">完全無料</div>
            <div className="text-xs text-gray-500 mt-0.5">ずっと0円</div>
          </div>
          <div className="bg-white rounded-2xl shadow-lg p-4 text-center border-t-4 border-pink-400">
            <div className="text-3xl mb-1" aria-hidden>📱</div>
            <div className="text-xs font-black text-pink-600">スマホOK</div>
            <div className="text-xs text-gray-500 mt-0.5">移動中でも</div>
          </div>
          <div className="bg-white rounded-2xl shadow-lg p-4 text-center border-t-4 border-green-400">
            <div className="text-3xl mb-1" aria-hidden>⚡</div>
            <div className="text-xs font-black text-green-600">すぐ開始</div>
            <div className="text-xs text-gray-500 mt-0.5">登録なしOK</div>
          </div>
        </div>

        {/* かんたん3ステップ */}
        <section className="mb-8 bg-gradient-to-br from-sky-50 to-indigo-50 rounded-3xl p-5 border border-sky-100">
          <div className="flex items-center gap-2 mb-4">
            <span className="text-2xl" aria-hidden>🐱</span>
            <h2 className="text-base font-black text-sky-700">こんなにカンタン！</h2>
          </div>
          <div className="space-y-3">
            <div className="flex items-center gap-3 bg-white rounded-2xl px-4 py-3 shadow-sm">
              <span className="flex-shrink-0 w-8 h-8 rounded-full bg-sky-400 text-white font-black text-sm flex items-center justify-center">1</span>
              <div>
                <span className="text-2xl mr-2" aria-hidden>🎯</span>
                <span className="font-bold text-gray-700 text-sm">学年と科目を選ぶ</span>
              </div>
            </div>
            <div className="flex items-center gap-3 bg-white rounded-2xl px-4 py-3 shadow-sm">
              <span className="flex-shrink-0 w-8 h-8 rounded-full bg-pink-400 text-white font-black text-sm flex items-center justify-center">2</span>
              <div>
                <span className="text-2xl mr-2" aria-hidden>💪</span>
                <span className="font-bold text-gray-700 text-sm">問題にチャレンジ！</span>
              </div>
            </div>
            <div className="flex items-center gap-3 bg-white rounded-2xl px-4 py-3 shadow-sm">
              <span className="flex-shrink-0 w-8 h-8 rounded-full bg-green-400 text-white font-black text-sm flex items-center justify-center">3</span>
              <div>
                <span className="text-2xl mr-2" aria-hidden>💡</span>
                <span className="font-bold text-gray-700 text-sm">わかりやすい解説で理解！</span>
              </div>
            </div>
          </div>
        </section>

        {/* 学年・科目セレクター */}
        <div className="mb-6">
          <div className="flex items-center gap-2 mb-4">
            <span className="text-2xl" aria-hidden>📚</span>
            <h2 className="text-lg font-black text-gray-800">学年を選んでね！</h2>
            <span className="text-2xl" aria-hidden>👇</span>
          </div>
          <GradeSelector />
        </div>
      </div>
    </div>
  );
}
