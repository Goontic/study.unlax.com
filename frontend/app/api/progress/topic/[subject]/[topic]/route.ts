import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";

const API_BASE = process.env.BACKEND_URL ?? "http://localhost:4001";

export async function GET(
  _req: NextRequest,
  { params }: { params: Promise<{ subject: string; topic: string }> },
) {
  const session = await auth();
  const accessToken = (session as { accessToken?: string }).accessToken;
  if (!accessToken) {
    return NextResponse.json({ answeredIds: [], correctIds: [] });
  }

  const { subject, topic } = await params;
  const res = await fetch(`${API_BASE}/progress/topic/${subject}/${topic}`, {
    headers: { Authorization: `Bearer ${accessToken}` },
    cache: "no-store",
  });
  if (!res.ok) return NextResponse.json({ answeredIds: [], correctIds: [] });
  return NextResponse.json(await res.json());
}
