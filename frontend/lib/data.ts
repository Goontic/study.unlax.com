import { prisma } from "@/lib/prisma";

// 公開ページ用の読み取りクエリ集。
// 旧 NestJS subjects/questions API を Server Components から直接呼ぶ形に置き換えたもの。

export function getSubjects() {
  return prisma.subject.findMany({ orderBy: { displayOrder: "asc" } });
}

export function getSubjectBySlug(slug: string) {
  return prisma.subject.findUnique({ where: { slug } });
}

export function getTopics(subjectSlug: string) {
  return prisma.topic.findMany({
    where: { subject: { slug: subjectSlug } },
    orderBy: [{ gradeLevel: "asc" }, { displayOrder: "asc" }],
  });
}

export function getTopic(subjectSlug: string, topicSlug: string) {
  return prisma.topic.findFirst({
    where: { slug: topicSlug, subject: { slug: subjectSlug } },
  });
}

export function getSubjectsByGrade(level: number) {
  return prisma.subject.findMany({
    where: {
      topics: { some: { gradeLevel: level } },
      genre: "school_education",
      schoolLevel: "middle",
    },
    orderBy: { displayOrder: "asc" },
    include: {
      topics: {
        where: { gradeLevel: level },
        orderBy: { displayOrder: "asc" },
      },
    },
  });
}

export function getSubjectsByGradeElementary(level: number) {
  return prisma.subject.findMany({
    where: {
      topics: { some: { gradeLevel: level } },
      genre: "school_education",
      schoolLevel: "elementary",
    },
    orderBy: { displayOrder: "asc" },
    include: {
      topics: {
        where: { gradeLevel: level },
        orderBy: { displayOrder: "asc" },
      },
    },
  });
}

export function getExamPrepSubjects() {
  return prisma.subject.findMany({
    where: { genre: "school_education", schoolLevel: "exam_prep" },
    orderBy: { displayOrder: "asc" },
    include: {
      topics: { orderBy: { displayOrder: "asc" } },
    },
  });
}

export function getCertificationSubjects() {
  return prisma.subject.findMany({
    where: { genre: "certification" },
    orderBy: { displayOrder: "asc" },
    include: {
      topics: { orderBy: { displayOrder: "asc" } },
    },
  });
}

export function getQuestions(subjectSlug: string, topicSlug: string) {
  return prisma.question.findMany({
    where: { topic: { slug: topicSlug, subject: { slug: subjectSlug } } },
    orderBy: { displayOrder: "asc" },
    select: {
      id: true,
      topicId: true,
      type: true,
      body: true,
      difficulty: true,
      displayOrder: true,
    },
  });
}

export function getQuestion(id: number) {
  return prisma.question.findUnique({
    where: { id },
    include: {
      choices: { orderBy: { displayOrder: "asc" } },
      blankAnswers: { orderBy: { blankIndex: "asc" } },
      orderItems: { orderBy: { correctPosition: "asc" } },
      steps: { orderBy: { stepNumber: "asc" } },
    },
  });
}

// sitemap.xml 生成用: 全科目→単元→問題ID を1クエリで返す
export function getSitemapEntries() {
  return prisma.subject.findMany({
    orderBy: { displayOrder: "asc" },
    select: {
      slug: true,
      topics: {
        orderBy: [{ gradeLevel: "asc" }, { displayOrder: "asc" }],
        select: {
          slug: true,
          questions: {
            orderBy: { displayOrder: "asc" },
            select: { id: true, createdAt: true },
          },
        },
      },
    },
  });
}
