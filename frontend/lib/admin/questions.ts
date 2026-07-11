import { Prisma } from "@prisma/client";
import { z } from "zod";
import { prisma } from "@/lib/prisma";
import { HttpError } from "./http";

const QUESTION_INCLUDE = {
  choices: { orderBy: { displayOrder: "asc" as const } },
  blankAnswers: { orderBy: { blankIndex: "asc" as const } },
  orderItems: { orderBy: { correctPosition: "asc" as const } },
  steps: { orderBy: { stepNumber: "asc" as const } },
};

export const questionInputSchema = z.object({
  topicId: z.number().int(),
  type: z.enum(["multiple_choice", "text_input", "fill_blank", "ordering"]),
  body: z.string().min(1),
  difficulty: z.number().int().min(1).max(5),
  displayOrder: z.number().int(),
  choices: z
    .array(
      z.object({
        body: z.string(),
        isCorrect: z.boolean(),
        displayOrder: z.number().int(),
      }),
    )
    .optional(),
  blankAnswers: z
    .array(
      z.object({
        blankIndex: z.number().int(),
        correctAnswer: z.string(),
      }),
    )
    .optional(),
  orderItems: z
    .array(
      z.object({
        body: z.string(),
        correctPosition: z.number().int(),
      }),
    )
    .optional(),
  steps: z
    .array(
      z.object({
        stepNumber: z.number().int(),
        body: z.string(),
      }),
    )
    .optional(),
});

export type QuestionInput = z.infer<typeof questionInputSchema>;

export async function findAllQuestions(params: {
  subjectId?: number;
  topicId?: number;
  keyword?: string;
  page?: number;
  pageSize?: number;
}) {
  const page = params.page && params.page > 0 ? Math.floor(params.page) : 1;
  const pageSize =
    params.pageSize && params.pageSize > 0 ? Math.min(Math.floor(params.pageSize), 100) : 20;

  const where: Prisma.QuestionWhereInput = {
    ...(params.topicId ? { topicId: params.topicId } : {}),
    ...(params.subjectId ? { topic: { subjectId: params.subjectId } } : {}),
    ...(params.keyword ? { body: { contains: params.keyword, mode: "insensitive" } } : {}),
  };

  const [items, total] = await Promise.all([
    prisma.question.findMany({
      where,
      orderBy: { displayOrder: "asc" },
      skip: (page - 1) * pageSize,
      take: pageSize,
    }),
    prisma.question.count({ where }),
  ]);

  return { items, total, page, pageSize };
}

export async function findQuestion(id: number) {
  const question = await prisma.question.findUnique({
    where: { id },
    include: QUESTION_INCLUDE,
  });
  if (!question) throw new HttpError(404, "Not Found");
  return question;
}

export async function createQuestion(input: QuestionInput) {
  validateByType(input);
  return prisma.$transaction(async (tx) => {
    const question = await tx.question.create({
      data: {
        topicId: input.topicId,
        type: input.type,
        body: input.body,
        difficulty: input.difficulty,
        displayOrder: input.displayOrder,
      },
    });
    await writeChildren(tx, question.id, input);
    return tx.question.findUniqueOrThrow({
      where: { id: question.id },
      include: QUESTION_INCLUDE,
    });
  });
}

export async function updateQuestion(id: number, input: QuestionInput) {
  validateByType(input);
  return prisma.$transaction(async (tx) => {
    await tx.question.update({
      where: { id },
      data: {
        topicId: input.topicId,
        type: input.type,
        body: input.body,
        difficulty: input.difficulty,
        displayOrder: input.displayOrder,
      },
    });
    await tx.questionChoice.deleteMany({ where: { questionId: id } });
    await tx.questionBlankAnswer.deleteMany({ where: { questionId: id } });
    await tx.questionOrderItem.deleteMany({ where: { questionId: id } });
    await tx.questionStep.deleteMany({ where: { questionId: id } });
    await writeChildren(tx, id, input);
    return tx.question.findUniqueOrThrow({ where: { id }, include: QUESTION_INCLUDE });
  });
}

export async function removeQuestion(id: number) {
  await prisma.question.delete({ where: { id } });
  return { ok: true };
}

function validateByType(input: QuestionInput) {
  switch (input.type) {
    case "multiple_choice":
      if (!input.choices?.length) {
        throw new HttpError(400, "選択肢を1つ以上入力してください");
      }
      if (input.choices.filter((c) => c.isCorrect).length !== 1) {
        throw new HttpError(400, "正解の選択肢を1つだけ指定してください");
      }
      break;
    case "fill_blank":
      if (!input.blankAnswers?.length) {
        throw new HttpError(400, "空欄の正解を1つ以上入力してください");
      }
      break;
    case "ordering":
      if (!input.orderItems || input.orderItems.length < 2) {
        throw new HttpError(400, "並べ替え項目を2つ以上入力してください");
      }
      break;
    case "text_input":
      break;
  }
}

async function writeChildren(
  tx: Prisma.TransactionClient,
  questionId: number,
  input: QuestionInput,
) {
  if (input.choices?.length) {
    await tx.questionChoice.createMany({
      data: input.choices.map((c) => ({ ...c, questionId })),
    });
  }
  if (input.blankAnswers?.length) {
    await tx.questionBlankAnswer.createMany({
      data: input.blankAnswers.map((b) => ({ ...b, questionId })),
    });
  }
  if (input.orderItems?.length) {
    await tx.questionOrderItem.createMany({
      data: input.orderItems.map((o) => ({ ...o, questionId })),
    });
  }
  if (input.steps?.length) {
    await tx.questionStep.createMany({
      data: input.steps.map((s) => ({ ...s, questionId })),
    });
  }
}
