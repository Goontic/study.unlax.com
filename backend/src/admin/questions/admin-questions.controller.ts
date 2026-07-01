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
import { AdminQuestionsService } from "./admin-questions.service";
import { CreateQuestionDto } from "./dto/create-question.dto";
import { UpdateQuestionDto } from "./dto/update-question.dto";

@Controller("admin/questions")
@UseGuards(AdminJwtAuthGuard)
export class AdminQuestionsController {
  constructor(private readonly adminQuestionsService: AdminQuestionsService) {}

  @Get()
  findAll(@Query("subjectId") subjectId?: string, @Query("topicId") topicId?: string) {
    return this.adminQuestionsService.findAll(
      subjectId ? Number(subjectId) : undefined,
      topicId ? Number(topicId) : undefined,
    );
  }

  @Get(":id")
  findOne(@Param("id", ParseIntPipe) id: number) {
    return this.adminQuestionsService.findOne(id);
  }

  @Post()
  create(@Body() dto: CreateQuestionDto) {
    return this.adminQuestionsService.create(dto);
  }

  @Patch(":id")
  update(@Param("id", ParseIntPipe) id: number, @Body() dto: UpdateQuestionDto) {
    return this.adminQuestionsService.update(id, dto);
  }

  @Delete(":id")
  remove(@Param("id", ParseIntPipe) id: number) {
    return this.adminQuestionsService.remove(id);
  }
}
