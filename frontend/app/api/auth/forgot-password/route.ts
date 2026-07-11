import { NextRequest, NextResponse } from "next/server";
import crypto from "crypto";
import { z } from "zod";
import { prisma } from "@/lib/prisma";
import { sendPasswordReset } from "@/lib/mail";

const schema = z.object({ email: z.email() });

const APP_URL = process.env.APP_URL ?? process.env.NEXTAUTH_URL ?? "http://localhost:3000";

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => null);
  const parsed = schema.safeParse(body);
  if (!parsed.success) {
    return NextResponse.json({ message: "入力内容が正しくありません" }, { status: 400 });
  }

  const user = await prisma.user.findUnique({ where: { email: parsed.data.email } });
  // メールアドレスの存在を漏らさないため、未登録でも正常終了を返す
  if (!user) return NextResponse.json({ ok: true });

  const token = crypto.randomBytes(32).toString("hex");
  const expiresAt = new Date(Date.now() + 60 * 60 * 1000); // 1時間

  await prisma.passwordResetToken.create({
    data: { userId: user.id, token, expiresAt },
  });

  try {
    await sendPasswordReset(user.email, `${APP_URL}/reset-password?token=${token}`);
  } catch (err) {
    console.error("Failed to send password reset email", err);
    return NextResponse.json({ message: "メールの送信に失敗しました" }, { status: 500 });
  }

  return NextResponse.json({ ok: true });
}
