import { ConflictException, Injectable, NotFoundException } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { PrismaService } from "../../prisma/prisma.service";
import type { CreateSubjectDto } from "./dto/create-subject.dto";
import type { UpdateSubjectDto } from "./dto/update-subject.dto";

@Injectable()
export class AdminSubjectsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.subject.findMany({ orderBy: { displayOrder: "asc" } });
  }

  async findOne(id: number) {
    const subject = await this.prisma.subject.findUnique({ where: { id } });
    if (!subject) throw new NotFoundException();
    return subject;
  }

  async create(dto: CreateSubjectDto) {
    try {
      return await this.prisma.subject.create({ data: dto });
    } catch (err) {
      if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
        throw new ConflictException("このslugはすでに使われています");
      }
      throw err;
    }
  }

  async update(id: number, dto: UpdateSubjectDto) {
    try {
      return await this.prisma.subject.update({ where: { id }, data: dto });
    } catch (err) {
      if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
        throw new ConflictException("このslugはすでに使われています");
      }
      throw err;
    }
  }

  async remove(id: number) {
    await this.prisma.subject.delete({ where: { id } });
    return { ok: true };
  }
}
