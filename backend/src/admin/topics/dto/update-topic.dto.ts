import { IsInt, IsOptional, IsString, Matches } from "class-validator";

export class UpdateTopicDto {
  @IsInt()
  subjectId!: number;

  @IsString()
  @Matches(/^[a-z0-9-]+$/, { message: "slugは半角英小文字・数字・ハイフンのみ使用できます" })
  slug!: string;

  @IsString()
  name!: string;

  @IsInt()
  gradeLevel!: number;

  @IsOptional()
  @IsString()
  description?: string | null;

  @IsInt()
  displayOrder!: number;
}
