import type { MetadataRoute } from "next";
import { apiFetch } from "@/lib/api";

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL ?? "https://study.unlax.com";

// 1時間ごとに再生成（問題追加を自動反映）
export const revalidate = 3600;

interface SitemapEntry {
  slug: string;
  topics: {
    slug: string;
    questions: { id: number; createdAt: string }[];
  }[];
}

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const entries: MetadataRoute.Sitemap = [
    { url: `${SITE_URL}/`, changeFrequency: "daily", priority: 1 },
    { url: `${SITE_URL}/exam-prep`, changeFrequency: "weekly", priority: 0.9 },
    { url: `${SITE_URL}/certification`, changeFrequency: "weekly", priority: 0.7 },
    ...[1, 2, 3].map((level) => ({
      url: `${SITE_URL}/grade/${level}`,
      changeFrequency: "weekly" as const,
      priority: 0.9,
    })),
    ...[1, 2, 3, 4, 5, 6].map((grade) => ({
      url: `${SITE_URL}/elementary/${grade}`,
      changeFrequency: "weekly" as const,
      priority: 0.9,
    })),
  ];

  let subjects: SitemapEntry[] = [];
  try {
    subjects = await apiFetch<SitemapEntry[]>("/subjects/sitemap-entries");
  } catch {
    // バックエンド停止中でも静的ページ分は返す
    return entries;
  }

  for (const subject of subjects) {
    if (subject.topics.length === 0) continue;
    entries.push({
      url: `${SITE_URL}/${subject.slug}`,
      changeFrequency: "weekly",
      priority: 0.8,
    });
    for (const topic of subject.topics) {
      entries.push({
        url: `${SITE_URL}/${subject.slug}/${topic.slug}`,
        changeFrequency: "weekly",
        priority: 0.7,
      });
      for (const question of topic.questions) {
        entries.push({
          url: `${SITE_URL}/${subject.slug}/${topic.slug}/${question.id}`,
          lastModified: new Date(question.createdAt),
          changeFrequency: "monthly",
          priority: 0.6,
        });
      }
    }
  }

  return entries;
}
