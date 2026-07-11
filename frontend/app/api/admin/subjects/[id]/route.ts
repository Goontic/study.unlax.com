import { NextRequest, NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { withAdmin } from "@/lib/admin/http";
import {
  findSubject,
  removeSubject,
  subjectInputSchema,
  updateSubject,
} from "@/lib/admin/subjects";

type RouteContext = { params: Promise<{ id: string }> };

function parseId(raw: string): number | null {
  const id = Number(raw);
  return Number.isInteger(id) && id > 0 ? id : null;
}

export async function GET(_req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    return NextResponse.json(await findSubject(id));
  });
}

export async function PATCH(req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    const parsed = subjectInputSchema.safeParse(await req.json().catch(() => null));
    if (!parsed.success) {
      return NextResponse.json({ message: "入力内容が正しくありません" }, { status: 400 });
    }
    const subject = await updateSubject(id, parsed.data);
    revalidatePath("/", "layout");
    return NextResponse.json(subject);
  });
}

export async function DELETE(_req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    const result = await removeSubject(id);
    revalidatePath("/", "layout");
    return NextResponse.json(result);
  });
}
