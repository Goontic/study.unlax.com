import { IsInt, IsString } from "class-validator";

export class QuestionOrderItemDto {
  @IsString()
  body!: string;

  @IsInt()
  correctPosition!: number;
}
