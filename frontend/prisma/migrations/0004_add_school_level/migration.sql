-- CreateEnum
CREATE TYPE "SchoolLevel" AS ENUM ('elementary', 'middle', 'exam_prep');

-- AlterTable
ALTER TABLE "subjects" ADD COLUMN "schoolLevel" "SchoolLevel" NOT NULL DEFAULT 'middle';
