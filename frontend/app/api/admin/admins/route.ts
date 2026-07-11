import { NextRequest, NextResponse } from "next/server";
import { withAdmin } from "@/lib/admin/http";
import { adminCreateSchema, createAdmin, findAllAdmins } from "@/lib/admin/admins";

export async function GET() {
  return withAdmin(async () => NextResponse.json(await findAllAdmins()));
}

export async function POST(req: NextRequest) {
  return withAdmin(async () => {
    const parsed = adminCreateSchema.safeParse(await req.json().catch(() => null));
    if (!parsed.success) {
      return NextResponse.json({ message: "入力内容が正しくありません" }, { status: 400 });
    }
    const admin = await createAdmin(parsed.data);
    return NextResponse.json(admin, { status: 201 });
  });
}
