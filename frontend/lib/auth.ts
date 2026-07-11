import NextAuth from "next-auth";
import Credentials from "next-auth/providers/credentials";
import bcrypt from "bcryptjs";
import { prisma } from "@/lib/prisma";

export const { handlers, signIn, signOut, auth } = NextAuth({
  trustHost: true,
  session: {
    strategy: "jwt",
    maxAge: 7 * 24 * 60 * 60, // 7日
  },
  providers: [
    Credentials({
      credentials: {
        email: { label: "メールアドレス", type: "email" },
        password: { label: "パスワード", type: "password" },
      },
      async authorize(credentials) {
        if (!credentials?.email || !credentials?.password) return null;
        try {
          const user = await prisma.user.findUnique({
            where: { email: String(credentials.email) },
          });
          if (!user) return null;
          const valid = await bcrypt.compare(String(credentials.password), user.passwordHash);
          if (!valid) return null;
          return {
            id: String(user.id),
            email: user.email,
            name: user.displayName,
          };
        } catch {
          return null;
        }
      },
    }),
  ],
  callbacks: {
    session({ session, token }) {
      if (token.sub) {
        (session.user as { id?: string }).id = token.sub;
      }
      return session;
    },
  },
  pages: {
    signIn: "/login",
  },
});

// ログイン中ユーザーのDB上のIDを返す。未ログインなら null。
export async function getSessionUserId(): Promise<number | null> {
  const session = await auth();
  const id = Number((session?.user as { id?: string } | undefined)?.id);
  return Number.isInteger(id) && id > 0 ? id : null;
}
