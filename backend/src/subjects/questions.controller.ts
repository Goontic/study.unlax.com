import { Controller, Get, Param, NotFoundException, ParseIntPipe } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";

@Controller("questions")
export class QuestionsController {
  constructor(private readonly prisma: PrismaService) {}

  @Get(":id")
  async findOne(@Param("id", ParseIntPipe) id: number) {
    const question = await this.prisma.question.findUnique({
      where: { id },
      include: {
        choices: { orderBy: { displayOrder: "asc" } },
        blankAnswers: { orderBy: { blankIndex: "asc" } },
        orderItems: { orderBy: { correctPosition: "asc" } },
        steps: { orderBy: { stepNumber: "asc" } },
      },
    });
    if (!question) throw new NotFoundException();
    return question;
  }
}
