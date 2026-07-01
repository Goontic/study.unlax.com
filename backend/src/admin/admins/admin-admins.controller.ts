import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  Req,
  UseGuards,
} from "@nestjs/common";
import type { Request } from "express";
import { AdminJwtAuthGuard } from "../../admin-auth/admin-jwt-auth.guard";
import { AdminAdminsService } from "./admin-admins.service";
import { CreateAdminDto } from "./dto/create-admin.dto";
import { UpdateAdminDto } from "./dto/update-admin.dto";

@Controller("admin/admins")
@UseGuards(AdminJwtAuthGuard)
export class AdminAdminsController {
  constructor(private readonly adminAdminsService: AdminAdminsService) {}

  @Get()
  findAll() {
    return this.adminAdminsService.findAll();
  }

  @Get(":id")
  findOne(@Param("id", ParseIntPipe) id: number) {
    return this.adminAdminsService.findOne(id);
  }

  @Post()
  create(@Body() dto: CreateAdminDto) {
    return this.adminAdminsService.create(dto);
  }

  @Patch(":id")
  update(@Param("id", ParseIntPipe) id: number, @Body() dto: UpdateAdminDto) {
    return this.adminAdminsService.update(id, dto);
  }

  @Delete(":id")
  remove(
    @Param("id", ParseIntPipe) id: number,
    @Req() req: Request & { user: { id: number; email: string } },
  ) {
    return this.adminAdminsService.remove(id, req.user.id);
  }
}
