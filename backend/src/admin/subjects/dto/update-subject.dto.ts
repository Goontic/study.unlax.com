import { IsIn, IsInt, IsString, Matches } from "class-validator";

export class UpdateSubjectDto {
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

  @IsIn(["school_education", "certification"])
  genre!: "school_education" | "certification";
}
