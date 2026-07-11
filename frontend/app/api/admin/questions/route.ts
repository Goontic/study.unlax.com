import { NextRequest, NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { withAdmin } from "@/lib/admin/http";
import { createQuestion, findAllQuestions, questionInputSchema } from "@/lib/admin/questions";

export async function GET(req: NextRequest) {
  return withAdmin(async () => {
    const q = req.nextUrl.searchParams;
    const result = await findAllQuestions({
      subjectId: q.get("subjectId") ? Number(q.get("subjectId")) : undefined,
      topicId: q.get("topicId") ? Number(q.get("topicId")) : undefined,
      keyword: q.get("keyword")?.trim() || undefined,
      page: q.get("page") ? Number(q.get("page")) : undefined,
      pageSize: q.get("pageSize") ? Number(q.get("pageSize")) : undefined,
    });
    return NextResponse.json(result);
  });
}

export async function POST(req: NextRequest) {
  return withAdmin(async () => {
    const parsed = questionInputSchema.safeParse(await req.json().catch(() => null));
    if (!parsed.success) {
      return NextResponse.json({ message: "入力内容が正しくありません" }, { status: 400 });
    }
    const question = await createQuestion(parsed.data);
    revalidatePath("/", "layout");
    return NextResponse.json(question, { status: 201 });
  });
}
