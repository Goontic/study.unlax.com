-- 英語・国語・理科・社会の単元を登録

INSERT INTO topics ("subjectId", slug, name, "gradeLevel", "displayOrder")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('present-past',    '現在形・過去形',  1, 1),
  ('comparatives',    '比較表現',        2, 2),
  ('passive-voice',   '受動態',          3, 3),
  ('present-perfect', '現在完了形',      3, 4),
  ('relative-clause', '関係代名詞',      3, 5),
  ('vocabulary',      '語彙・熟語',      2, 6)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'english'
ON CONFLICT ("subjectId", slug) DO NOTHING;

INSERT INTO topics ("subjectId", slug, name, "gradeLevel", "displayOrder")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('kanji',             '漢字の読み書き',    1, 1),
  ('grammar',           '文法（品詞）',      2, 2),
  ('classical-japanese','古文',              3, 3),
  ('idioms',            '慣用句・ことわざ',  2, 4)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'japanese'
ON CONFLICT ("subjectId", slug) DO NOTHING;

INSERT INTO topics ("subjectId", slug, name, "gradeLevel", "displayOrder")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('cells',           '細胞・生物のつくり', 1, 1),
  ('plants',          '植物のしくみ',       1, 2),
  ('motion-force',    '運動と力',           3, 3),
  ('electricity',     '電流と電圧',         2, 4),
  ('chemical-change', '化学変化',           2, 5),
  ('weather',         '天気と気象',         2, 6)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'science'
ON CONFLICT ("subjectId", slug) DO NOTHING;

INSERT INTO topics ("subjectId", slug, name, "gradeLevel", "displayOrder")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('japan-geography', '日本の地理',       1, 1),
  ('world-geography', '世界の地理',       1, 2),
  ('ancient-japan',   '古代（縄文〜平安）', 1, 3),
  ('medieval-japan',  '中世・近世（鎌倉〜江戸）', 2, 4),
  ('modern-japan',    '近代・現代（明治以降）', 3, 5),
  ('constitution',    '日本国憲法・政治', 3, 6)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'social'
ON CONFLICT ("subjectId", slug) DO NOTHING;
