import nodemailer from "nodemailer";

function createTransport() {
  return nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: Number(process.env.SMTP_PORT ?? 587),
    secure: process.env.SMTP_SECURE === "true",
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS,
    },
  });
}

export async function sendPasswordReset(to: string, resetUrl: string): Promise<void> {
  const transporter = createTransport();
  await transporter.sendMail({
    from: `"study.unlax.com" <${process.env.SMTP_FROM ?? process.env.SMTP_USER}>`,
    to,
    subject: "パスワード再設定のご案内",
    text: `
パスワード再設定のリクエストを受け付けました。

下記のURLをクリックして、新しいパスワードを設定してください。
このURLの有効期限は1時間です。

${resetUrl}

このメールに心当たりがない場合は、無視していただいて構いません。

---
study.unlax.com
`.trim(),
    html: `
<p>パスワード再設定のリクエストを受け付けました。</p>
<p>下記のボタンをクリックして、新しいパスワードを設定してください。<br>
このURLの有効期限は<strong>1時間</strong>です。</p>
<p style="margin: 24px 0;">
  <a href="${resetUrl}"
     style="background:#2563eb;color:#fff;padding:12px 24px;border-radius:8px;text-decoration:none;font-weight:bold;">
    パスワードを再設定する
  </a>
</p>
<p style="color:#6b7280;font-size:13px;">
  このメールに心当たりがない場合は、無視していただいて構いません。
</p>
<hr style="border:none;border-top:1px solid #e5e7eb;margin-top:24px;">
<p style="color:#9ca3af;font-size:12px;">study.unlax.com</p>
`.trim(),
  });
}
