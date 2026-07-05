INSERT INTO topics ("subject_id", slug, name, "grade_level", "display_order")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  ('integers',          '正の数・負の数',    1, 1),
  ('linear-equations',  '一次方程式',        2, 2),
  ('simultaneous',      '連立方程式',        2, 3),
  ('functions',         '比例・反比例',      1, 4),
  ('linear-functions',  '一次関数',          2, 5),
  ('quadratics',        '二次方程式',        3, 6),
  ('quadratic-func',    '二次関数',          3, 7),
  ('plane-geometry',    '平面図形',          1, 8),
  ('space-geometry',    '空間図形',          1, 9),
  ('probability',       '確率',              2, 10)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'math'
ON CONFLICT ("subject_id", slug) DO NOTHING;
