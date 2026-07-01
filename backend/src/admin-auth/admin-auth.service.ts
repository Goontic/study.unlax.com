import { Injectable, UnauthorizedException } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import * as bcrypt from "bcrypt";
import { PrismaService } from "../prisma/prisma.service";
import type { AdminLoginDto } from "./dto/admin-login.dto";

@Injectable()
export class AdminAuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
  ) {}

  async login(dto: AdminLoginDto) {
    const admin = await this.prisma.adminUser.findUnique({ where: { email: dto.email } });
    if (!admin) throw new UnauthorizedException("メールアドレスまたはパスワードが違います");

    const valid = await bcrypt.compare(dto.password, admin.passwordHash);
    if (!valid) throw new UnauthorizedException("メールアドレスまたはパスワードが違います");

    const accessToken = this.jwt.sign(
      { sub: admin.id, email: admin.email, scope: "admin" },
      { secret: process.env.ADMIN_JWT_SECRET, expiresIn: "12h" },
    );

    return {
      accessToken,
      admin: { id: admin.id, email: admin.email, displayName: admin.displayName },
    };
  }
}
