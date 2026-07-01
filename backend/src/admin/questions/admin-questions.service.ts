import { BadRequestException, Injectable, NotFoundException } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { PrismaService } from "../../prisma/prisma.service";
import type { CreateQuestionDto } from "./dto/create-question.dto";
import type { UpdateQuestionDto } from "./dto/update-question.dto";

const QUESTION_INCLUDE = {
  choices: { orderBy: { displayOrder: "asc" as const } },
  blankAnswers: { orderBy: { blankIndex: "asc" as const } },
  orderItems: { orderBy: { correctPosition: "asc" as const } },
  steps: { orderBy: { stepNumber: "asc" as const } },
};

@Injectable()
export class AdminQuestionsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll(subjectId?: number, topicId?: number) {
    return this.prisma.question.findMany({
      where: {
        ...(topicId ? { topicId } : {}),
        ...(subjectId ? { topic: { subjectId } } : {}),
      },
      orderBy: { displayOrder: "asc" },
    });
  }

  async findOne(id: number) {
    const question = await this.prisma.question.findUnique({
      where: { id },
      include: QUESTION_INCLUDE,
    });
    if (!question) throw new NotFoundException();
    return question;
  }

  async create(dto: CreateQuestionDto) {
    this.validateByType(dto);
    return this.prisma.$transaction(async (tx) => {
      const question = await tx.question.create({
        data: {
          topicId: dto.topicId,
          type: dto.type,
          body: dto.body,
          difficulty: dto.difficulty,
          displayOrder: dto.displayOrder,
        },
      });
      await this.writeChildren(tx, question.id, dto);
      return tx.question.findUniqueOrThrow({ where: { id: question.id }, include: QUESTION_INCLUDE });
    });
  }

  async update(id: number, dto: UpdateQuestionDto) {
    this.validateByType(dto);
    return this.prisma.$transaction(async (tx) => {
      await tx.question.update({
        where: { id },
        data: {
          topicId: dto.topicId,
          type: dto.type,
          body: dto.body,
          difficulty: dto.difficulty,
          displayOrder: dto.displayOrder,
        },
      });
      await tx.questionChoice.deleteMany({ where: { questionId: id } });
      await tx.questionBlankAnswer.deleteMany({ where: { questionId: id } });
      await tx.questionOrderItem.deleteMany({ where: { questionId: id } });
      await tx.questionStep.deleteMany({ where: { questionId: id } });
      await this.writeChildren(tx, id, dto);
      return tx.question.findUniqueOrThrow({ where: { id }, include: QUESTION_INCLUDE });
    });
  }

  async remove(id: number) {
    await this.prisma.question.delete({ where: { id } });
    return { ok: true };
  }

  private validateByType(dto: CreateQuestionDto) {
    switch (dto.type) {
      case "multiple_choice":
        if (!dto.choices?.length) {
          throw new BadRequestException("選択肢を1つ以上入力してください");
        }
        if (dto.choices.filter((c) => c.isCorrect).length !== 1) {
          throw new BadRequestException("正解の選択肢を1つだけ指定してください");
        }
        break;
      case "fill_blank":
        if (!dto.blankAnswers?.length) {
          throw new BadRequestException("空欄の正解を1つ以上入力してください");
        }
        break;
      case "ordering":
        if (!dto.orderItems || dto.orderItems.length < 2) {
          throw new BadRequestException("並べ替え項目を2つ以上入力してください");
        }
        break;
      case "text_input":
        break;
    }
  }

  private async writeChildren(
    tx: Prisma.TransactionClient,
    questionId: number,
    dto: CreateQuestionDto,
  ) {
    if (dto.choices?.length) {
      await tx.questionChoice.createMany({
        data: dto.choices.map((c) => ({ ...c, questionId })),
      });
    }
    if (dto.blankAnswers?.length) {
      await tx.questionBlankAnswer.createMany({
        data: dto.blankAnswers.map((b) => ({ ...b, questionId })),
      });
    }
    if (dto.orderItems?.length) {
      await tx.questionOrderItem.createMany({
        data: dto.orderItems.map((o) => ({ ...o, questionId })),
      });
    }
    if (dto.steps?.length) {
      await tx.questionStep.createMany({
        data: dto.steps.map((s) => ({ ...s, questionId })),
      });
    }
  }
}
