import { Prisma } from "@prisma/client";
import { z } from "zod";
import { prisma } from "@/lib/prisma";
import { HttpError } from "./http";

export const subjectInputSchema = z.object({
  slug: z
    .string()
    .regex(/^[a-z0-9-]+$/, "slugは半角英小文字・数字・ハイフンのみ使用できます"),
  name: z.string().min(1),
  icon: z.string().min(1),
  displayOrder: z.number().int(),
  schoolLevel: z.enum(["elementary", "middle", "exam_prep"]),
  genre: z.enum(["school_education", "certification"]),
});

export type SubjectInput = z.infer<typeof subjectInputSchema>;

export function findAllSubjects() {
  return prisma.subject.findMany({ orderBy: { displayOrder: "asc" } });
}

export async function findSubject(id: number) {
  const subject = await prisma.subject.findUnique({ where: { id } });
  if (!subject) throw new HttpError(404, "Not Found");
  return subject;
}

export async function createSubject(input: SubjectInput) {
  try {
    return await prisma.subject.create({ data: input });
  } catch (err) {
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
      throw new HttpError(409, "このslugはすでに使われています");
    }
    throw err;
  }
}

export async function updateSubject(id: number, input: SubjectInput) {
  try {
    return await prisma.subject.update({ where: { id }, data: input });
  } catch (err) {
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
      throw new HttpError(409, "このslugはすでに使われています");
    }
    throw err;
  }
}

export async function removeSubject(id: number) {
  await prisma.subject.delete({ where: { id } });
  return { ok: true };
}
