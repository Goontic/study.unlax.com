import { NextResponse } from "next/server";
import { getAdmin, type AdminTokenPayload } from "@/lib/admin-auth";

// サービス層が投げるHTTPステータス付きエラー
export class HttpError extends Error {
  constructor(
    public readonly status: number,
    message: string,
  ) {
    super(message);
  }
}

// 管理APIルートの共通ラッパー: 認証チェックと HttpError → JSONレスポンス変換
export async function withAdmin(
  handler: (admin: AdminTokenPayload) => Promise<NextResponse>,
): Promise<NextResponse> {
  const admin = await getAdmin();
  if (!admin) {
    return NextResponse.json({ message: "Unauthorized" }, { status: 401 });
  }
  try {
    return await handler(admin);
  } catch (err) {
    if (err instanceof HttpError) {
      return NextResponse.json({ message: err.message }, { status: err.status });
    }
    console.error(err);
    return NextResponse.json({ message: "Internal Server Error" }, { status: 500 });
  }
}
