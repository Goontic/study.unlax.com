import { Controller, Get, Post, Delete, Param, UseGuards, Req, ParseIntPipe } from "@nestjs/common";
import type { Request } from "express";
import { JwtAuthGuard } from "../auth/jwt-auth.guard";
import { FavoritesService } from "./favorites.service";

interface AuthUser {
  id: number;
  email: string;
}

@Controller("favorites")
@UseGuards(JwtAuthGuard)
export class FavoritesController {
  constructor(private readonly favoritesService: FavoritesService) {}

  @Get()
  findAll(@Req() req: Request & { user: AuthUser }) {
    return this.favoritesService.findAll(req.user.id);
  }

  @Post(":questionId")
  add(
    @Req() req: Request & { user: AuthUser },
    @Param("questionId", ParseIntPipe) questionId: number,
  ) {
    return this.favoritesService.add(req.user.id, questionId);
  }

  @Delete(":questionId")
  remove(
    @Req() req: Request & { user: AuthUser },
    @Param("questionId", ParseIntPipe) questionId: number,
  ) {
    return this.favoritesService.remove(req.user.id, questionId);
  }
}
