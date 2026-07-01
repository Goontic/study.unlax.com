"use client";

import { useSearchParams } from "next/navigation";
import Link from "next/link";

const SIBLING_COUNT = 1;
const ELLIPSIS = "ellipsis" as const;

function range(start: number, end: number): number[] {
  return Array.from({ length: end - start + 1 }, (_, i) => start + i);
}

function buildPageList(page: number, totalPages: number): (number | typeof ELLIPSIS)[] {
  const totalNumbers = SIBLING_COUNT * 2 + 5;
  if (totalPages <= totalNumbers) return range(1, totalPages);

  const leftSibling = Math.max(page - SIBLING_COUNT, 1);
  const rightSibling = Math.min(page + SIBLING_COUNT, totalPages);
  const showLeftEllipsis = leftSibling > 2;
  const showRightEllipsis = rightSibling < totalPages - 1;

  if (!showLeftEllipsis && showRightEllipsis) {
    return [...range(1, 3 + SIBLING_COUNT * 2), ELLIPSIS, totalPages];
  }
  if (showLeftEllipsis && !showRightEllipsis) {
    return [1, ELLIPSIS, ...range(totalPages - (2 + SIBLING_COUNT * 2), totalPages)];
  }
  return [1, ELLIPSIS, ...range(leftSibling, rightSibling), ELLIPSIS, totalPages];
}

export default function Pagination({
  basePath,
  page,
  totalPages,
}: {
  basePath: string;
  page: number;
  totalPages: number;
}) {
  const searchParams = useSearchParams();

  if (totalPages <= 1) return null;

  const hrefFor = (targetPage: number) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set("page", String(targetPage));
    return `${basePath}?${params.toString()}`;
  };

  const pages = buildPageList(page, totalPages);

  return (
    <div className="flex justify-center items-center gap-1 mt-6 text-sm">
      {page > 1 ? (
        <Link href={hrefFor(page - 1)} className="px-2 py-1 text-blue-600">
          &lt;
        </Link>
      ) : (
        <span className="px-2 py-1 text-gray-300">&lt;</span>
      )}

      {pages.map((p, i) =>
        p === ELLIPSIS ? (
          <span key={`ellipsis-${i}`} className="px-2 py-1 text-gray-400">
            …
          </span>
        ) : (
          <Link
            key={p}
            href={hrefFor(p)}
            className={
              p === page
                ? "px-3 py-1 rounded-lg bg-blue-600 text-white font-bold"
                : "px-3 py-1 rounded-lg text-gray-700 hover:bg-gray-100"
            }
          >
            {p}
          </Link>
        ),
      )}

      {page < totalPages ? (
        <Link href={hrefFor(page + 1)} className="px-2 py-1 text-blue-600">
          &gt;
        </Link>
      ) : (
        <span className="px-2 py-1 text-gray-300">&gt;</span>
      )}
    </div>
  );
}
