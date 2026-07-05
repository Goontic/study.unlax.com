import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

export async function POST(req: NextRequest) {
  const session = await auth();
  const accessToken = (session as { accessToken?: string } | null)?.accessToken;
  if (!accessToken) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const res = await fetch(`${API_BASE}/progress`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${accessToken}`,
    },
    body: JSON.stringify(body),
  });
  const data = await res.json();
  return NextResponse.json(data, { status: res.status });
}
