-- =============================================
-- 高校入試対策 数学 トピック
-- =============================================
INSERT INTO topics ("subjectId", slug, name, "gradeLevel", "displayOrder")
SELECT s.id, t.slug, t.name, 3, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('exam-numbers-calc',      '数の計算・正負の数',            1),
  ('exam-linear-eq',         '一次方程式・連立方程式',          2),
  ('exam-inequalities',      '不等式',                      3),
  ('exam-functions',         '関数（比例・反比例・一次関数）',    4),
  ('exam-quadratic-func',    '二次関数',                     5),
  ('exam-plane-geometry',    '平面図形・証明',                6),
  ('exam-space-geometry',    '空間図形・体積・表面積',          7),
  ('exam-similarity',        '相似・三平方の定理',             8),
  ('exam-probability',       '確率',                        9),
  ('exam-data-statistics',   'データの活用・統計',            10),
  ('exam-polynomials',       '多項式・因数分解',              11),
  ('exam-quadratic-eq',      '二次方程式',                   12)
) AS t(slug, name, display_order)
WHERE s.slug = 'exam-math'
ON CONFLICT ("subjectId", slug) DO NOTHING;

-- =============================================
-- 高校入試対策 英語 トピック
-- =============================================
INSERT INTO topics ("subjectId", slug, name, "gradeLevel", "displayOrder")
SELECT s.id, t.slug, t.name, 3, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('exam-reading-comp',    '長文読解',                      1),
  ('exam-grammar',         '文法問題',                      2),
  ('exam-writing',         '英作文・条件作文',                3),
  ('exam-dialogue',        '会話文読解',                    4),
  ('exam-vocab',           '語句・語彙',                    5),
  ('exam-tense',           '時制・助動詞',                   6),
  ('exam-passive',         '受け身・不定詞・動名詞',           7),
  ('exam-comparison',      '比較',                         8),
  ('exam-relative',        '関係代名詞・接続詞',              9),
  ('exam-listening',       '聞き取り対策',                  10)
) AS t(slug, name, display_order)
WHERE s.slug = 'exam-english'
ON CONFLICT ("subjectId", slug) DO NOTHING;

-- =============================================
-- 高校入試対策 国語 トピック
-- =============================================
INSERT INTO topics ("subjectId", slug, name, "gradeLevel", "displayOrder")
SELECT s.id, t.slug, t.name, 3, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('exam-kanji-vocab',     '漢字・語句',                    1),
  ('exam-modern-prose',    '現代文読解（説明文・論説文）',     2),
  ('exam-story',           '現代文読解（物語・随筆）',         3),
  ('exam-classical-prose', '古文読解',                      4),
  ('exam-classical-poem',  '漢詩・詩の鑑賞',                5),
  ('exam-expression',      '表現・記述問題',                 6),
  ('exam-grammar-jp',      '文法（品詞・文の組み立て）',       7),
  ('exam-writing-jp',      '作文',                         8)
) AS t(slug, name, display_order)
WHERE s.slug = 'exam-japanese'
ON CONFLICT ("subjectId", slug) DO NOTHING;

-- =============================================
-- 高校入試対策 理科 トピック
-- =============================================
INSERT INTO topics ("subjectId", slug, name, "gradeLevel", "displayOrder")
SELECT s.id, t.slug, t.name, 3, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('exam-physics-motion',  '力と運動',                      1),
  ('exam-physics-energy',  'エネルギー・仕事',               2),
  ('exam-physics-waves',   '音・光・電磁波',                  3),
  ('exam-electricity',     '電流と磁界',                    4),
  ('exam-chemistry-matter','物質の性質・分類',               5),
  ('exam-chemistry-react', '化学変化・化学式',               6),
  ('exam-chemistry-ion',   'イオン・中和',                   7),
  ('exam-biology-cell',    '細胞・生殖・遺伝',               8),
  ('exam-biology-body',    '植物・動物のつくりとはたらき',    9),
  ('exam-earth-weather',   '天気と大気の変化',              10),
  ('exam-earth-astro',     '天体（地球・月・太陽）',          11),
  ('exam-earth-geol',      '地層・岩石・地震',               12)
) AS t(slug, name, display_order)
WHERE s.slug = 'exam-science'
ON CONFLICT ("subjectId", slug) DO NOTHING;

-- =============================================
-- 高校入試対策 社会 トピック
-- =============================================
INSERT INTO topics ("subjectId", slug, name, "gradeLevel", "displayOrder")
SELECT s.id, t.slug, t.name, 3, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('exam-geo-japan',       '地理・日本の地形と気候',          1),
  ('exam-geo-regions',     '地理・日本の各地方',              2),
  ('exam-geo-world',       '地理・世界の地域',               3),
  ('exam-hist-ancient',    '歴史・古代〜奈良・平安',           4),
  ('exam-hist-medieval',   '歴史・鎌倉〜室町・戦国',           5),
  ('exam-hist-early-mod',  '歴史・江戸時代',                  6),
  ('exam-hist-modern',     '歴史・明治〜大正',               7),
  ('exam-hist-contemp',    '歴史・昭和〜現代',               8),
  ('exam-civics-politics', '公民・政治のしくみ',              9),
  ('exam-civics-economy',  '公民・経済のしくみ',             10),
  ('exam-civics-global',   '公民・国際社会',                 11)
) AS t(slug, name, display_order)
WHERE s.slug = 'exam-social'
ON CONFLICT ("subjectId", slug) DO NOTHING;
