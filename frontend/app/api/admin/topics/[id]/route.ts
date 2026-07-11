import { NextRequest, NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { withAdmin } from "@/lib/admin/http";
import { findTopic, removeTopic, topicInputSchema, updateTopic } from "@/lib/admin/topics";

type RouteContext = { params: Promise<{ id: string }> };

function parseId(raw: string): number | null {
  const id = Number(raw);
  return Number.isInteger(id) && id > 0 ? id : null;
}

export async function GET(_req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    return NextResponse.json(await findTopic(id));
  });
}

export async function PATCH(req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    const parsed = topicInputSchema.safeParse(await req.json().catch(() => null));
    if (!parsed.success) {
      return NextResponse.json({ message: "入力内容が正しくありません" }, { status: 400 });
    }
    const topic = await updateTopic(id, parsed.data);
    revalidatePath("/", "layout");
    return NextResponse.json(topic);
  });
}

export async function DELETE(_req: NextRequest, { params }: RouteContext) {
  return withAdmin(async () => {
    const id = parseId((await params).id);
    if (!id) return NextResponse.json({ message: "Bad Request" }, { status: 400 });
    const result = await removeTopic(id);
    revalidatePath("/", "layout");
    return NextResponse.json(result);
  });
}
