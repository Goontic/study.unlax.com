import { NextRequest, NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { withAdmin } from "@/lib/admin/http";
import { createSubject, findAllSubjects, subjectInputSchema } from "@/lib/admin/subjects";

export async function GET() {
  return withAdmin(async () => NextResponse.json(await findAllSubjects()));
}

export async function POST(req: NextRequest) {
  return withAdmin(async () => {
    const parsed = subjectInputSchema.safeParse(await req.json().catch(() => null));
    if (!parsed.success) {
      return NextResponse.json({ message: "入力内容が正しくありません" }, { status: 400 });
    }
    const subject = await createSubject(parsed.data);
    revalidatePath("/", "layout");
    return NextResponse.json(subject, { status: 201 });
  });
}
