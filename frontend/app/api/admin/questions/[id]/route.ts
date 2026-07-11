import { NextRequest, NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { withAdmin } from "@/lib/admin/http";
import {
  findQuestion,
  questionInputSchema,
  removeQuestion,
  updateQuestion,
} from "@/lib/admin/questions";

type RouteContext = { params: Promise<{ id: string }> };

function parseId(raw: string): number | null {
  const id = Number(raw);
  return Number.isInteger(id) && id > 0 ? id : null;
}

export async function GET(_req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    return NextResponse.json(await findQuestion(id));
  });
}

export async function PATCH(req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    const parsed = questionInputSchema.safeParse(await req.json().catch(() => null));
    if (!parsed.success) {
      return NextResponse.json({ message: "入力内容が正しくありません" }, { status: 400 });
    }
    const question = await updateQuestion(id, parsed.data);
    revalidatePath("/", "layout");
    return NextResponse.json(question);
  });
}

export async function DELETE(_req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    const result = await removeQuestion(id);
    revalidatePath("/", "layout");
    return NextResponse.json(result);
  });
}
