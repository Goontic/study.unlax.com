INSERT INTO subjects (slug, name, icon, display_order) VALUES
  ('math',    '数学', '🔢', 1),
  ('english', '英語', '🔤', 2),
  ('japanese','国語', '📖', 3),
  ('science', '理科', '🔬', 4),
  ('social',  '社会', '🌏', 5)
ON CONFLICT (slug) DO NOTHING;
