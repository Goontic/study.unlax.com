import { Injectable } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";

@Injectable()
export class ProgressService {
  constructor(private readonly prisma: PrismaService) {}

  record(userId: number, questionId: number, isCorrect: boolean) {
    return this.prisma.userAnswer.create({
      data: { userId, questionId, isCorrect },
    });
  }

  async getStats(userId: number) {
    const [total, correct] = await Promise.all([
      this.prisma.userAnswer.count({ where: { userId } }),
      this.prisma.userAnswer.count({ where: { userId, isCorrect: true } }),
    ]);
    return { total, correct, accuracy: total > 0 ? Math.round((correct / total) * 100) : 0 };
  }

  async getBySubject(userId: number, subjectSlug: string) {
    const answers = await this.prisma.userAnswer.findMany({
      where: { userId, question: { topic: { subject: { slug: subjectSlug } } } },
      include: { question: { select: { id: true, body: true, type: true, topicId: true } } },
      orderBy: { answeredAt: "desc" },
    });
    return answers;
  }

  async getTopicProgress(userId: number, subjectSlug: string, topicSlug: string) {
    const answers = await this.prisma.userAnswer.findMany({
      where: {
        userId,
        question: { topic: { slug: topicSlug, subject: { slug: subjectSlug } } },
      },
      select: { questionId: true, isCorrect: true },
    });

    const answeredIds = new Set<number>();
    const correctIds = new Set<number>();
    for (const a of answers) {
      answeredIds.add(a.questionId);
      if (a.isCorrect) correctIds.add(a.questionId);
    }

    return {
      answeredIds: [...answeredIds],
      correctIds: [...correctIds],
    };
  }
}
