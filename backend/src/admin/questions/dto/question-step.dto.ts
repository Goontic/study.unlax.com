import { IsInt, IsString } from "class-validator";

export class QuestionStepDto {
  @IsInt()
  stepNumber!: number;

  @IsString()
  body!: string;
}
