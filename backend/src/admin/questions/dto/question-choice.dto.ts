import { IsBoolean, IsInt, IsString } from "class-validator";

export class QuestionChoiceDto {
  @IsString()
  body!: string;

  @IsBoolean()
  isCorrect!: boolean;

  @IsInt()
  displayOrder!: number;
}
