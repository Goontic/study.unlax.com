import type { Metadata } from "next";
import { Noto_Sans_JP } from "next/font/google";
import Script from "next/script";
import { SessionProvider } from "next-auth/react";
import "./globals.css";
import Header from "@/components/layout/Header";
import BottomNav from "@/components/layout/BottomNav";

const notoSansJP = Noto_Sans_JP({
  variable: "--font-noto-sans-jp",
  subsets: ["latin"],
  weight: ["400", "500", "700"],
});

export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL ?? "https://study.unlax.com"),
  title: {
    default: "ポケスタ | 小中学生の受験対策・無料ドリル5科目",
    template: "%s | ポケスタ",
  },
  description:
    "ポケスタ（ポケット受験スタディ）は小学生・中学生向けの無料受験対策ドリル。数学・英語・国語・理科・社会の5科目をスキマ時間にスマホで学習できます。",
  openGraph: {
    siteName: "ポケスタ",
    locale: "ja_JP",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ja" className={`${notoSansJP.variable} h-full`}>
      <head>
        <Script id="gtm-script" strategy="afterInteractive">
          {`(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-PJ89H8GQ');`}
        </Script>
      </head>
      <body className="min-h-full flex flex-col bg-gray-50 font-sans">
        <noscript>
          <iframe
            src="https://www.googletagmanager.com/ns.html?id=GTM-PJ89H8GQ"
            height="0"
            width="0"
            style={{ display: "none", visibility: "hidden" }}
          />
        </noscript>
        <SessionProvider>
          <Header />
          <main className="flex-1 pb-20">{children}</main>
          <BottomNav />
        </SessionProvider>
      </body>
    </html>
  );
}
