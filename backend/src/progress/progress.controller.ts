import { Controller, Post, Get, Param, Body, UseGuards, Req } from "@nestjs/common";
import type { Request } from "express";
import { JwtAuthGuard } from "../auth/jwt-auth.guard";
import { ProgressService } from "./progress.service";

interface AuthUser {
  id: number;
  email: string;
}

@Controller("progress")
@UseGuards(JwtAuthGuard)
export class ProgressController {
  constructor(private readonly progressService: ProgressService) {}

  @Post()
  record(
    @Req() req: Request & { user: AuthUser },
    @Body() body: { questionId: number; isCorrect: boolean },
  ) {
    return this.progressService.record(req.user.id, body.questionId, body.isCorrect);
  }

  @Get("stats")
  getStats(@Req() req: Request & { user: AuthUser }) {
    return this.progressService.getStats(req.user.id);
  }

  @Get("topic/:subjectSlug/:topicSlug")
  getTopicProgress(
    @Req() req: Request & { user: AuthUser },
    @Param("subjectSlug") subjectSlug: string,
    @Param("topicSlug") topicSlug: string,
  ) {
    return this.progressService.getTopicProgress(req.user.id, subjectSlug, topicSlug);
  }

  @Get(":subjectSlug")
  getBySubject(
    @Req() req: Request & { user: AuthUser },
    @Param("subjectSlug") subjectSlug: string,
  ) {
    return this.progressService.getBySubject(req.user.id, subjectSlug);
  }
}
