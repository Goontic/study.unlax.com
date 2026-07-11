import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";
import { getSessionUserId } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

const schema = z.object({
  questionId: z.number().int().positive(),
  isCorrect: z.boolean(),
});

export async function POST(req: NextRequest) {
  const userId = await getSessionUserId();
  if (!userId) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json().catch(() => null);
  const parsed = schema.safeParse(body);
  if (!parsed.success) {
    return NextResponse.json({ error: "Bad Request" }, { status: 400 });
  }

  const answer = await prisma.userAnswer.create({
    data: {
      userId,
      questionId: parsed.data.questionId,
      isCorrect: parsed.data.isCorrect,
    },
  });
  return NextResponse.json(answer, { status: 201 });
}
