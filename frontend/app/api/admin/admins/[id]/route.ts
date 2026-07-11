import { NextRequest, NextResponse } from "next/server";
import { withAdmin } from "@/lib/admin/http";
import { adminUpdateSchema, findAdmin, removeAdmin, updateAdmin } from "@/lib/admin/admins";

type RouteContext = { params: Promise<{ id: string }> };

function parseId(raw: string): number | null {
  const id = Number(raw);
  return Number.isInteger(id) && id > 0 ? id : null;
}

export async function GET(_req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    return NextResponse.json(await findAdmin(id));
  });
}

export async function PATCH(req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    const parsed = adminUpdateSchema.safeParse(await req.json().catch(() => null));
    if (!parsed.success) {
      return NextResponse.json({ message: "入力内容が正しくありません" }, { status: 400 });
    }
    return NextResponse.json(await updateAdmin(id, parsed.data));
  });
}

export async function DELETE(_req: NextRequest, { params }: RouteContext) {
  return withAdmin(async (currentAdmin) => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    return NextResponse.json(await removeAdmin(id, currentAdmin.id));
  });
}
