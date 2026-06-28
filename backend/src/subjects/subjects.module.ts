import { Module } from "@nestjs/common";
import { SubjectsController } from "./subjects.controller";
import { SubjectsService } from "./subjects.service";
import { QuestionsController } from "./questions.controller";

@Module({
  controllers: [SubjectsController, QuestionsController],
  providers: [SubjectsService],
})
export class SubjectsModule {}
