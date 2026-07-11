import { Prisma } from "@prisma/client";
import { z } from "zod";
import { prisma } from "@/lib/prisma";
import { HttpError } from "./http";

export const topicInputSchema = z.object({
  subjectId: z.number().int(),
  slug: z
    .string()
    .regex(/^[a-z0-9-]+$/, "slugは半角英小文字・数字・ハイフンのみ使用できます"),
  name: z.string().min(1),
  gradeLevel: z.number().int(),
  description: z.string().nullish(),
  displayOrder: z.number().int(),
});

export type TopicInput = z.infer<typeof topicInputSchema>;

export function findAllTopics(subjectId?: number) {
  return prisma.topic.findMany({
    where: subjectId ? { subjectId } : undefined,
    orderBy: [{ subjectId: "asc" }, { gradeLevel: "asc" }, { displayOrder: "asc" }],
  });
}

export async function findTopic(id: number) {
  const topic = await prisma.topic.findUnique({ where: { id } });
  if (!topic) throw new HttpError(404, "Not Found");
  return topic;
}

export async function createTopic(input: TopicInput) {
  try {
    return await prisma.topic.create({ data: input });
  } catch (err) {
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
      throw new HttpError(409, "この単元スラッグはすでに使われています");
    }
    throw err;
  }
}

export async function updateTopic(id: number, input: TopicInput) {
  try {
    return await prisma.topic.update({ where: { id }, data: input });
  } catch (err) {
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
      throw new HttpError(409, "この単元スラッグはすでに使われています");
    }
    throw err;
  }
}

export async function removeTopic(id: number) {
  await prisma.topic.delete({ where: { id } });
  return { ok: true };
}
