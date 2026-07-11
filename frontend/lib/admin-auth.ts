import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { SignJWT, jwtVerify } from "jose";

export interface AdminTokenPayload {
  id: number;
  email: string;
}

function secret(): Uint8Array {
  return new TextEncoder().encode(process.env.ADMIN_JWT_SECRET ?? "change-me-admin");
}

export async function signAdminToken(admin: { id: number; email: string }): Promise<string> {
  return new SignJWT({ email: admin.email, scope: "admin" })
    .setProtectedHeader({ alg: "HS256" })
    .setSubject(String(admin.id))
    .setIssuedAt()
    .setExpirationTime("12h")
    .sign(secret());
}

export async function verifyAdminToken(token: string): Promise<AdminTokenPayload | null> {
  try {
    const { payload } = await jwtVerify(token, secret());
    if (payload.scope !== "admin" || !payload.sub) return null;
    return { id: Number(payload.sub), email: String(payload.email ?? "") };
  } catch {
    return null;
  }
}

// Cookie から管理者を取得。未ログイン・トークン不正なら null。
export async function getAdmin(): Promise<AdminTokenPayload | null> {
  const token = (await cookies()).get("admin_token")?.value;
  if (!token) return null;
  return verifyAdminToken(token);
}

// 管理ページ(Server Component)用。未認証なら /admin/login へリダイレクト。
export async function requireAdmin(): Promise<AdminTokenPayload> {
  const admin = await getAdmin();
  if (!admin) redirect("/admin/login");
  return admin;
}
