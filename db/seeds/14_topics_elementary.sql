-- =============================================
-- 小学校 算数 トピック（学年1〜6）
-- =============================================
INSERT INTO topics ("subject_id", slug, name, "grade_level", "display_order")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  -- 1年生
  ('numbers-1-10',         '10までの数',           1,  1),
  ('addition-10',          'たし算（10まで）',      1,  2),
  ('subtraction-10',       'ひき算（10まで）',      1,  3),
  ('numbers-to-20',        '20までの数',           1,  4),
  ('addition-subtraction-20', 'たし算・ひき算（20まで）', 1, 5),
  ('shapes-basic',         'かたちの勉強',         1,  6),
  -- 2年生
  ('addition-2digit',      '2けたのたし算',         2,  7),
  ('subtraction-2digit',   '2けたのひき算',         2,  8),
  ('multiplication-table', 'かけ算（九九）',         2,  9),
  ('length-basic',         '長さ',                 2, 10),
  ('time-basic',           '時刻と時間',           2, 11),
  -- 3年生
  ('division-basic',       'わり算',               3, 12),
  ('large-numbers-3',      '大きな数（万）',         3, 13),
  ('fractions-intro',      '分数のきほん',          3, 14),
  ('decimals-intro',       '小数のきほん',          3, 15),
  ('weight-basic',         '重さ',                 3, 16),
  ('time-calc',            '時間の計算',           3, 17),
  -- 4年生
  ('large-numbers-4',      '大きな数（億・兆）',     4, 18),
  ('decimals-calc',        '小数の計算',           4, 19),
  ('fractions-calc-4',     '分数の計算',           4, 20),
  ('area-basic',           '面積',                 4, 21),
  ('angles-geometry',      '角とその大きさ',        4, 22),
  ('division-calc',        'わり算の筆算',          4, 23),
  -- 5年生
  ('fractions-mult-div',   '分数のかけ算・わり算',   5, 24),
  ('decimals-mult-div',    '小数のかけ算・わり算',   5, 25),
  ('ratio-percentage',     '割合・百分率',          5, 26),
  ('speed-basics',         '速さ',                 5, 27),
  ('area-shapes',          '三角形・四角形の面積',   5, 28),
  ('volume-3d',            '体積',                 5, 29),
  -- 6年生
  ('fractions-all',        '分数の四則計算',        6, 30),
  ('ratio-proportion-6',   '比と比例・反比例',      6, 31),
  ('algebra-basics',       '文字と式',             6, 32),
  ('probability-basic-6',  '場合の数',             6, 33),
  ('circle-area',          '円の面積',             6, 34),
  ('solid-volume-6',       '角柱・円柱の体積',      6, 35)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'elem-math'
ON CONFLICT ("subject_id", slug) DO NOTHING;

-- =============================================
-- 小学校 国語 トピック（学年1〜6）
-- =============================================
INSERT INTO topics ("subject_id", slug, name, "grade_level", "display_order")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  -- 1年生
  ('hiragana',             'ひらがな・カタカナ',     1,  1),
  ('kanji-grade1',         '漢字（1年）',           1,  2),
  ('sentence-basic-1',     '文の読み取り（1年）',    1,  3),
  -- 2年生
  ('kanji-grade2',         '漢字（2年）',           2,  4),
  ('reading-comp-2',       '文章の読み取り（2年）',  2,  5),
  ('vocab-basic',          '言葉の学習',            2,  6),
  -- 3年生
  ('kanji-grade3',         '漢字（3年）',           3,  7),
  ('reading-comp-3',       '文章の読み取り（3年）',  3,  8),
  ('idioms-basic',         '慣用句・ことわざ',       3,  9),
  -- 4年生
  ('kanji-grade4',         '漢字（4年）',           4, 10),
  ('reading-comp-4',       '文章の読み取り（4年）',  4, 11),
  ('poem-reading',         '詩の読み取り',          4, 12),
  ('grammar-basic',        '文法のきほん',          4, 13),
  -- 5年生
  ('kanji-grade5',         '漢字（5年）',           5, 14),
  ('reading-comp-5',       '説明文の読み取り',       5, 15),
  ('story-reading-5',      '物語の読み取り',         5, 16),
  ('classical-intro',      '古典の入門',            5, 17),
  -- 6年生
  ('kanji-grade6',         '漢字（6年）',           6, 18),
  ('reading-comp-6',       '論説文の読み取り',       6, 19),
  ('story-reading-6',      '物語・随筆の読み取り',   6, 20),
  ('classical-basic-6',    '古典のきほん',          6, 21),
  ('grammar-advanced',     '文法（敬語・品詞）',     6, 22)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'elem-japanese'
ON CONFLICT ("subject_id", slug) DO NOTHING;

-- =============================================
-- 小学校 理科 トピック（学年3〜6）
-- =============================================
INSERT INTO topics ("subject_id", slug, name, "grade_level", "display_order")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  -- 3年生
  ('plants-basic',         '植物のそだち方',         3,  1),
  ('animals-basic',        '身近な生き物',           3,  2),
  ('light-sound',          '光と音',                3,  3),
  ('magnets',              '磁石のふしぎ',           3,  4),
  -- 4年生
  ('plants-seasonal',      '季節と植物',             4,  5),
  ('weather-water',        '天気と水のへんかん',       4,  6),
  ('electricity-basic',    '電気のはたらき',          4,  7),
  ('human-body-basic',     '体のつくりとはたらき',    4,  8),
  -- 5年生
  ('plants-growth',        '植物の成長と水',          5,  9),
  ('clouds-weather',       '雲と天気の変化',          5, 10),
  ('human-body-5',         '人のたんじょう',          5, 11),
  ('flow-water',           '流れる水のはたらき',       5, 12),
  ('dissolving',           'もののとけ方',            5, 13),
  -- 6年生
  ('plants-photosynthesis','植物のはたらき（光合成）', 6, 14),
  ('human-body-6',         '体のつくりとはたらき（6年）', 6, 15),
  ('electricity-advanced', '電気の利用',              6, 16),
  ('earth-moon',           '月と太陽',               6, 17),
  ('environment-life',     '生物と環境',              6, 18)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'elem-science'
ON CONFLICT ("subject_id", slug) DO NOTHING;

-- =============================================
-- 小学校 社会 トピック（学年3〜6）
-- =============================================
INSERT INTO topics ("subject_id", slug, name, "grade_level", "display_order")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  -- 3年生
  ('local-community',      'わたしたちのまち',        3,  1),
  ('local-industry',       '地いきの仕事',           3,  2),
  ('local-safety',         '安全なくらし',           3,  3),
  -- 4年生
  ('prefectures-japan',    '都道府県と地方',          4,  4),
  ('water-environment',    '水と環境',               4,  5),
  ('waste-disposal',       'ごみとリサイクル',        4,  6),
  ('natural-disaster',     '自然災害と地いき',        4,  7),
  -- 5年生
  ('geography-japan',      '日本の地形と気候',        5,  8),
  ('industry-japan',       '日本の産業（農業・工業）', 5,  9),
  ('trade-global',         '貿易と国際関係',          5, 10),
  ('media-information',    '情報とメディア',          5, 11),
  -- 6年生
  ('history-ancient',      '縄文〜奈良時代',          6, 12),
  ('history-medieval',     '平安〜戦国時代',          6, 13),
  ('history-modern',       '江戸〜明治時代',          6, 14),
  ('history-modern2',      '大正〜現代',             6, 15),
  ('civics-basic',         '日本の政治のしくみ',      6, 16),
  ('world-basic',          '世界の国々',             6, 17)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'elem-social'
ON CONFLICT ("subject_id", slug) DO NOTHING;

-- =============================================
-- 小学校 英語 トピック（学年5〜6）
-- =============================================
INSERT INTO topics ("subject_id", slug, name, "grade_level", "display_order")
SELECT s.id, t.slug, t.name, t.grade_level, t.display_order
FROM subjects s
CROSS JOIN (VALUES
  -- 5年生
  ('alphabet',             'アルファベット',          5,  1),
  ('greetings-self',       'あいさつ・自己紹介',       5,  2),
  ('daily-life-5',         '日常表現（5年）',          5,  3),
  ('numbers-colors',       '数・色・形',              5,  4),
  ('food-animals',         '食べ物・動物',            5,  5),
  -- 6年生
  ('basic-sentences',      '基本文型',               6,  6),
  ('school-life',          '学校・行事',              6,  7),
  ('can-want',             'できること・したいこと',    6,  8),
  ('past-present',         '過去・現在の表現',         6,  9),
  ('reading-basic',        '英文読解（入門）',         6, 10)
) AS t(slug, name, grade_level, display_order)
WHERE s.slug = 'elem-english'
ON CONFLICT ("subject_id", slug) DO NOTHING;
