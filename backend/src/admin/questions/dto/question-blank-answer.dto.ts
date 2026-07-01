import { IsInt, IsString } from "class-validator";

export class QuestionBlankAnswerDto {
  @IsInt()
  blankIndex!: number;

  @IsString()
  correctAnswer!: string;
}
