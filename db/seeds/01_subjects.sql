-- 中学校科目（既存）
INSERT INTO subjects (slug, name, icon, "display_order", "school_level") VALUES
  ('math',    '数学', '🔢', 1, 'middle'),
  ('english', '英語', '🔤', 2, 'middle'),
  ('japanese','国語', '📖', 3, 'middle'),
  ('science', '理科', '🔬', 4, 'middle'),
  ('social',  '社会', '🌏', 5, 'middle')
ON CONFLICT (slug) DO UPDATE SET "school_level" = EXCLUDED."school_level";

-- 小学校科目
INSERT INTO subjects (slug, name, icon, "display_order", "school_level") VALUES
  ('elem-math',    '算数', '🔢', 11, 'elementary'),
  ('elem-japanese','国語', '📖', 12, 'elementary'),
  ('elem-science', '理科', '🔬', 13, 'elementary'),
  ('elem-social',  '社会', '🌏', 14, 'elementary'),
  ('elem-english', '英語', '🔤', 15, 'elementary')
ON CONFLICT (slug) DO NOTHING;

-- 高校入試対策科目
INSERT INTO subjects (slug, name, icon, "display_order", "school_level") VALUES
  ('exam-math',    '数学', '🔢', 21, 'exam_prep'),
  ('exam-english', '英語', '🔤', 22, 'exam_prep'),
  ('exam-japanese','国語', '📖', 23, 'exam_prep'),
  ('exam-science', '理科', '🔬', 24, 'exam_prep'),
  ('exam-social',  '社会', '🌏', 25, 'exam_prep')
ON CONFLICT (slug) DO NOTHING;
