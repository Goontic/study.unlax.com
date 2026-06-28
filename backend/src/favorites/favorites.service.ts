import { Injectable, ConflictException } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";

@Injectable()
export class FavoritesService {
  constructor(private readonly prisma: PrismaService) {}

  findAll(userId: number) {
    return this.prisma.userFavorite.findMany({
      where: { userId },
      include: {
        question: { select: { id: true, body: true, type: true, difficulty: true } },
      },
      orderBy: { createdAt: "desc" },
    });
  }

  async add(userId: number, questionId: number) {
    try {
      return await this.prisma.userFavorite.create({ data: { userId, questionId } });
    } catch {
      throw new ConflictException("すでにお気に入りに追加されています");
    }
  }

  remove(userId: number, questionId: number) {
    return this.prisma.userFavorite.deleteMany({ where: { userId, questionId } });
  }
}
