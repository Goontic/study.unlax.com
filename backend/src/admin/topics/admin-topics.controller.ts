import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  Query,
  UseGuards,
} from "@nestjs/common";
import { AdminJwtAuthGuard } from "../../admin-auth/admin-jwt-auth.guard";
import { AdminTopicsService } from "./admin-topics.service";
import { CreateTopicDto } from "./dto/create-topic.dto";
import { UpdateTopicDto } from "./dto/update-topic.dto";

@Controller("admin/topics")
@UseGuards(AdminJwtAuthGuard)
export class AdminTopicsController {
  constructor(private readonly adminTopicsService: AdminTopicsService) {}

  @Get()
  findAll(@Query("subjectId") subjectId?: string) {
    return this.adminTopicsService.findAll(subjectId ? Number(subjectId) : undefined);
  }

  @Get(":id")
  findOne(@Param("id", ParseIntPipe) id: number) {
    return this.adminTopicsService.findOne(id);
  }

  @Post()
  create(@Body() dto: CreateTopicDto) {
    return this.adminTopicsService.create(dto);
  }

  @Patch(":id")
  update(@Param("id", ParseIntPipe) id: number, @Body() dto: UpdateTopicDto) {
    return this.adminTopicsService.update(id, dto);
  }

  @Delete(":id")
  remove(@Param("id", ParseIntPipe) id: number) {
    return this.adminTopicsService.remove(id);
  }
}
