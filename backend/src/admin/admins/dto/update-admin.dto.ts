import { IsEmail, IsOptional, IsString, MinLength } from "class-validator";

export class UpdateAdminDto {
  @IsEmail()
  email!: string;

  @IsString()
  displayName!: string;

  @IsOptional()
  @IsString()
  @MinLength(8)
  password?: string;
}
