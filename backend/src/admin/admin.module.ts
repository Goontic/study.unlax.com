import { Module } from "@nestjs/common";
import { AdminAuthModule } from "../admin-auth/admin-auth.module";
import { AdminSubjectsController } from "./subjects/admin-subjects.controller";
import { AdminSubjectsService } from "./subjects/admin-subjects.service";
import { AdminTopicsController } from "./topics/admin-topics.controller";
import { AdminTopicsService } from "./topics/admin-topics.service";
import { AdminQuestionsController } from "./questions/admin-questions.controller";
import { AdminQuestionsService } from "./questions/admin-questions.service";

@Module({
  imports: [AdminAuthModule],
  controllers: [AdminSubjectsController, AdminTopicsController, AdminQuestionsController],
  providers: [AdminSubjectsService, AdminTopicsService, AdminQuestionsService],
})
export class AdminModule {}
