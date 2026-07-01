import { NextRequest, NextResponse } from "next/server";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

export async function POST(req: NextRequest) {
  const body = await req.json();
  const res = await fetch(`${API_BASE}/admin-auth/login`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });

  if (!res.ok) {
    return NextResponse.json({ error: "ログインに失敗しました" }, { status: res.status });
  }

  const data = (await res.json()) as {
    accessToken: string;
    admin: { id: number; email: string; displayName: string };
  };

  const response = NextResponse.json({ admin: data.admin });
  response.cookies.set("admin_token", data.accessToken, {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "strict",
    maxAge: 12 * 60 * 60,
    path: "/",
  });
  return response;
}
