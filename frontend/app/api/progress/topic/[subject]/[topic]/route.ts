import { NextRequest, NextResponse } from "next/server";
import { getSessionUserId } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

export async function GET(
  _req: NextRequest,
  { params }: { params: Promise<{ subject: string; topic: string }> },
) {
  const userId = await getSessionUserId();
  if (!userId) {
    return NextResponse.json({ answeredIds: [], correctIds: [] });
  }

  const { subject, topic } = await params;
  const answers = await prisma.userAnswer.findMany({
    where: {
      userId,
      question: { topic: { slug: topic, subject: { slug: subject } } },
    },
    select: { questionId: true, isCorrect: true },
  });

  const answeredIds = new Set<number>();
  const correctIds = new Set<number>();
  for (const a of answers) {
    answeredIds.add(a.questionId);
    if (a.isCorrect) correctIds.add(a.questionId);
  }

  return NextResponse.json({
    answeredIds: [...answeredIds],
    correctIds: [...correctIds],
  });
}
