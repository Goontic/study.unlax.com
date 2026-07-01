import { Module } from "@nestjs/common";
import { ConfigModule } from "@nestjs/config";
import { PrismaModule } from "./prisma/prisma.module";
import { AuthModule } from "./auth/auth.module";
import { SubjectsModule } from "./subjects/subjects.module";
import { ProgressModule } from "./progress/progress.module";
import { FavoritesModule } from "./favorites/favorites.module";
import { AdminAuthModule } from "./admin-auth/admin-auth.module";
import { AdminModule } from "./admin/admin.module";

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    PrismaModule,
    AuthModule,
    SubjectsModule,
    ProgressModule,
    FavoritesModule,
    AdminAuthModule,
    AdminModule,
  ],
})
export class AppModule {}
