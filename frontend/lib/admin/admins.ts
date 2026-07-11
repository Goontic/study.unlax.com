import { Prisma } from "@prisma/client";
import { z } from "zod";
import bcrypt from "bcryptjs";
import { prisma } from "@/lib/prisma";
import { HttpError } from "./http";

const SAFE_SELECT = {
  id: true,
  email: true,
  displayName: true,
  createdAt: true,
  updatedAt: true,
} satisfies Prisma.AdminUserSelect;

export const adminCreateSchema = z.object({
  email: z.email(),
  password: z.string().min(8),
  displayName: z.string().min(1),
});

export const adminUpdateSchema = z.object({
  email: z.email(),
  displayName: z.string().min(1),
  password: z.string().min(8).optional(),
});

export function findAllAdmins() {
  return prisma.adminUser.findMany({ select: SAFE_SELECT, orderBy: { id: "asc" } });
}

export async function findAdmin(id: number) {
  const admin = await prisma.adminUser.findUnique({ where: { id }, select: SAFE_SELECT });
  if (!admin) throw new HttpError(404, "Not Found");
  return admin;
}

export async function createAdmin(input: z.infer<typeof adminCreateSchema>) {
  const passwordHash = await bcrypt.hash(input.password, 10);
  try {
    return await prisma.adminUser.create({
      data: { email: input.email, passwordHash, displayName: input.displayName },
      select: SAFE_SELECT,
    });
  } catch (err) {
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
      throw new HttpError(409, "このメールアドレスはすでに使われています");
    }
    throw err;
  }
}

export async function updateAdmin(id: number, input: z.infer<typeof adminUpdateSchema>) {
  try {
    return await prisma.adminUser.update({
      where: { id },
      data: {
        email: input.email,
        displayName: input.displayName,
        ...(input.password ? { passwordHash: await bcrypt.hash(input.password, 10) } : {}),
      },
      select: SAFE_SELECT,
    });
  } catch (err) {
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
      throw new HttpError(409, "このメールアドレスはすでに使われています");
    }
    throw err;
  }
}

export async function removeAdmin(id: number, currentAdminId: number) {
  if (id === currentAdminId) {
    throw new HttpError(400, "自分自身は削除できません");
  }
  await prisma.adminUser.delete({ where: { id } });
  return { ok: true };
}
