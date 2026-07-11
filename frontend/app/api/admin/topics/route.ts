import { NextRequest, NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { withAdmin } from "@/lib/admin/http";
import { createTopic, findAllTopics, topicInputSchema } from "@/lib/admin/topics";

export async function GET(req: NextRequest) {
  return withAdmin(async () => {
    const subjectId = req.nextUrl.searchParams.get("subjectId");
    return NextResponse.json(await findAllTopics(subjectId ? Number(subjectId) : undefined));
  });
}

export async function POST(req: NextRequest) {
  return withAdmin(async () => {
    const parsed = topicInputSchema.safeParse(await req.json().catch(() => null));
    if (!parsed.success) {
      return NextResponse.json({ message: "入力内容が正しくありません" }, { status: 400 });
    }
    const topic = await createTopic(parsed.data);
    revalidatePath("/", "layout");
    return NextResponse.json(topic, { status: 201 });
  });
}
