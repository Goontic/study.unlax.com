import { Type } from "class-transformer";
import {
  IsArray,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  Min,
  ValidateNested,
} from "class-validator";
import { QuestionChoiceDto } from "./question-choice.dto";
import { QuestionBlankAnswerDto } from "./question-blank-answer.dto";
import { QuestionOrderItemDto } from "./question-order-item.dto";
import { QuestionStepDto } from "./question-step.dto";

export class CreateQuestionDto {
  @IsInt()
  topicId!: number;

  @IsIn(["multiple_choice", "text_input", "fill_blank", "ordering"])
  type!: "multiple_choice" | "text_input" | "fill_blank" | "ordering";

  @IsString()
  body!: string;

  @IsInt()
  @Min(1)
  @Max(5)
  difficulty!: number;

  @IsInt()
  displayOrder!: number;

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => QuestionChoiceDto)
  choices?: QuestionChoiceDto[];

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => QuestionBlankAnswerDto)
  blankAnswers?: QuestionBlankAnswerDto[];

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => QuestionOrderItemDto)
  orderItems?: QuestionOrderItemDto[];

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => QuestionStepDto)
  steps?: QuestionStepDto[];
}
