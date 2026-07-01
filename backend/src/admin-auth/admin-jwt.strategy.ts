import { Injectable, UnauthorizedException } from "@nestjs/common";
import { PassportStrategy } from "@nestjs/passport";
import { ExtractJwt, Strategy } from "passport-jwt";

interface AdminJwtPayload {
  sub: number;
  email: string;
  scope: "admin";
}

@Injectable()
export class AdminJwtStrategy extends PassportStrategy(Strategy, "admin-jwt") {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: process.env.ADMIN_JWT_SECRET ?? "change-me-admin",
    });
  }

  validate(payload: AdminJwtPayload) {
    if (payload.scope !== "admin") throw new UnauthorizedException();
    return { id: payload.sub, email: payload.email, scope: "admin" as const };
  }
}
