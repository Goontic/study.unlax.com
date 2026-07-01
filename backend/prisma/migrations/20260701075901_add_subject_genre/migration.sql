-- CreateEnum
CREATE TYPE "Genre" AS ENUM ('school_education', 'certification');

-- AlterTable
ALTER TABLE "subjects" ADD COLUMN     "genre" "Genre" NOT NULL DEFAULT 'school_education';
