import { BadRequestException, ConflictException, Injectable, NotFoundException } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import * as bcrypt from "bcrypt";
import { PrismaService } from "../../prisma/prisma.service";
import type { CreateAdminDto } from "./dto/create-admin.dto";
import type { UpdateAdminDto } from "./dto/update-admin.dto";

const SAFE_SELECT = {
  id: true,
  email: true,
  displayName: true,
  createdAt: true,
  updatedAt: true,
} satisfies Prisma.AdminUserSelect;

@Injectable()
export class AdminAdminsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.adminUser.findMany({ select: SAFE_SELECT, orderBy: { id: "asc" } });
  }

  async findOne(id: number) {
    const admin = await this.prisma.adminUser.findUnique({ where: { id }, select: SAFE_SELECT });
    if (!admin) throw new NotFoundException();
    return admin;
  }

  async create(dto: CreateAdminDto) {
    const passwordHash = await bcrypt.hash(dto.password, 10);
    try {
      return await this.prisma.adminUser.create({
        data: { email: dto.email, passwordHash, displayName: dto.displayName },
        select: SAFE_SELECT,
      });
    } catch (err) {
      if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
        throw new ConflictException("このメールアドレスはすでに使われています");
      }
      throw err;
    }
  }

  async update(id: number, dto: UpdateAdminDto) {
    try {
      return await this.prisma.adminUser.update({
        where: { id },
        data: {
          email: dto.email,
          displayName: dto.displayName,
          ...(dto.password ? { passwordHash: await bcrypt.hash(dto.password, 10) } : {}),
        },
        select: SAFE_SELECT,
      });
    } catch (err) {
      if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
        throw new ConflictException("このメールアドレスはすでに使われています");
      }
      throw err;
    }
  }

  async remove(id: number, currentAdminId: number) {
    if (id === currentAdminId) {
      throw new BadRequestException("自分自身は削除できません");
    }
    await this.prisma.adminUser.delete({ where: { id } });
    return { ok: true };
  }
}
