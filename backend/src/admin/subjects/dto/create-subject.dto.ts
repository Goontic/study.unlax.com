import { IsIn, IsInt, IsString, Matches } from "class-validator";

export class CreateSubjectDto {
  @IsString()
  @Matches(/^[a-z0-9-]+$/, { message: "slugは半角英小文字・数字・ハイフンのみ使用できます" })
  slug!: string;

  @IsString()
  name!: string;

  @IsString()
  icon!: string;

  @IsInt()
  displayOrder!: number;

  @IsIn(["elementary", "middle", "exam_prep"])
  schoolLevel!: "elementary" | "middle" | "exam_prep";
}
