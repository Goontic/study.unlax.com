import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export async function getAdminToken(): Promise<string | undefined> {
  return (await cookies()).get("admin_token")?.value;
}

export async function requireAdmin(): Promise<string> {
  const token = await getAdminToken();
  if (!token) redirect("/admin/login");
  return token;
}
