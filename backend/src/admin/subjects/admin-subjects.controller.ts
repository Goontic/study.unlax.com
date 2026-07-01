import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  UseGuards,
} from "@nestjs/common";
import { AdminJwtAuthGuard } from "../../admin-auth/admin-jwt-auth.guard";
import { AdminSubjectsService } from "./admin-subjects.service";
import { CreateSubjectDto } from "./dto/create-subject.dto";
import { UpdateSubjectDto } from "./dto/update-subject.dto";

@Controller("admin/subjects")
@UseGuards(AdminJwtAuthGuard)
export class AdminSubjectsController {
  constructor(private readonly adminSubjectsService: AdminSubjectsService) {}

  @Get()
  findAll() {
    return this.adminSubjectsService.findAll();
  }

  @Get(":id")
  findOne(@Param("id", ParseIntPipe) id: number) {
    return this.adminSubjectsService.findOne(id);
  }

  @Post()
  create(@Body() dto: CreateSubjectDto) {
    return this.adminSubjectsService.create(dto);
  }

  @Patch(":id")
  update(@Param("id", ParseIntPipe) id: number, @Body() dto: UpdateSubjectDto) {
    return this.adminSubjectsService.update(id, dto);
  }

  @Delete(":id")
  remove(@Param("id", ParseIntPipe) id: number) {
    return this.adminSubjectsService.remove(id);
  }
}
