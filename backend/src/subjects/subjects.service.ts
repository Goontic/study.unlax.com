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
      where: { topics: { some: { gradeLevel: level } } },
      orderBy: { displayOrder: "asc" },
      include: {
        topics: {
          where: { gradeLevel: level },
          orderBy: { displayOrder: "asc" },
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
