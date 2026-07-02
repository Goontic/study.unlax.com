import { Injectable } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";

@Injectable()
export class SubjectsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.subject.findMany({ orderBy: { displayOrder: "asc" } });
  }

  findOne(slug: string) {
    return this.prisma.subject.findUnique({ where: { slug } });
  }

  getTopics(subjectSlug: string) {
    return this.prisma.topic.findMany({
      where: { subject: { slug: subjectSlug } },
      orderBy: [{ gradeLevel: "asc" }, { displayOrder: "asc" }],
    });
  }

  findTopic(subjectSlug: string, topicSlug: string) {
    return this.prisma.topic.findFirst({
      where: { slug: topicSlug, subject: { slug: subjectSlug } },
    });
  }

  getByGrade(level: number) {
    return this.prisma.subject.findMany({
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

  getByGradeElementary(level: number) {
    return this.prisma.subject.findMany({
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

  getExamPrepSubjects() {
    return this.prisma.subject.findMany({
      where: { genre: "school_education", schoolLevel: "exam_prep" },
      orderBy: { displayOrder: "asc" },
      include: {
        topics: { orderBy: { displayOrder: "asc" } },
      },
    });
  }

  getCertificationSubjects() {
    return this.prisma.subject.findMany({
      where: { genre: "certification" },
      orderBy: { displayOrder: "asc" },
      include: {
        topics: { orderBy: { displayOrder: "asc" } },
      },
    });
  }

  // sitemap.xml 生成用: 全科目→単元→問題ID を1クエリで返す
  getSitemapEntries() {
    return this.prisma.subject.findMany({
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

  getQuestions(subjectSlug: string, topicSlug: string) {
    return this.prisma.question.findMany({
      where: { topic: { slug: topicSlug, subject: { slug: subjectSlug } } },
      orderBy: { displayOrder: "asc" },
      select: {
        id: true,
        type: true,
        body: true,
        difficulty: true,
        displayOrder: true,
      },
    });
  }
}
