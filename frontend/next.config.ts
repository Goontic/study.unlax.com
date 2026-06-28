import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "standalone",
  async rewrites() {
    const backendUrl = process.env.BACKEND_URL ?? "http://localhost:4001";
    return [
      {
        source: "/api/subjects/:path*",
        destination: `${backendUrl}/subjects/:path*`,
      },
      {
        source: "/api/questions/:path*",
        destination: `${backendUrl}/questions/:path*`,
      },
      {
        source: "/api/progress/:path*",
        destination: `${backendUrl}/progress/:path*`,
      },
      {
        source: "/api/favorites/:path*",
        destination: `${backendUrl}/favorites/:path*`,
      },
    ];
  },
};

export default nextConfig;
