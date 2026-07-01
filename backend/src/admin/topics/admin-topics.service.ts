import { ConflictException, Injectable, NotFoundException } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { PrismaService } from "../../prisma/prisma.service";
import type { CreateTopicDto } from "./dto/create-topic.dto";
import type { UpdateTopicDto } from "./dto/update-topic.dto";

@Injectable()
export class AdminTopicsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll(subjectId?: number) {
    return this.prisma.topic.findMany({
      where: subjectId ? { subjectId } : undefined,
      orderBy: [{ subjectId: "asc" }, { gradeLevel: "asc" }, { displayOrder: "asc" }],
    });
  }

  async findOne(id: number) {
    const topic = await this.prisma.topic.findUnique({ where: { id } });
    if (!topic) throw new NotFoundException();
    return topic;
  }

  async create(dto: CreateTopicDto) {
    try {
      return await this.prisma.topic.create({ data: dto });
    } catch (err) {
      if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
        throw new ConflictException("この単元スラッグはすでに使われています");
      }
      throw err;
    }
  }

  async update(id: number, dto: UpdateTopicDto) {
    try {
      return await this.prisma.topic.update({ where: { id }, data: dto });
    } catch (err) {
      if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
        throw new ConflictException("この単元スラッグはすでに使われています");
      }
      throw err;
    }
  }

  async remove(id: number) {
    await this.prisma.topic.delete({ where: { id } });
    return { ok: true };
  }
}
