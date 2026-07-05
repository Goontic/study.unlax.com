-- 数学：平面図形 6問 ／ 空間図形 5問 ／ 確率 6問

-- ① 平面図形
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'math' AND t.slug = 'plane-geometry'
),
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '三角形の内角の和は何度ですか。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '正六角形の1つの内角は {{1}} 度である。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '円周角の定理について正しいものを選びなさい。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '底辺 8 cm、高さ 5 cm の三角形の面積を求めなさい。', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '相似な2つの三角形の辺の比が 2:3 のとき、面積比を求めなさい。', 3, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '半径 5 cm の円の面積は {{1}} π cm² である。', 2, 6 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '90°',  false, 1 FROM q1 UNION ALL
  SELECT id, '180°', true,  2 FROM q1 UNION ALL
  SELECT id, '270°', false, 3 FROM q1 UNION ALL
  SELECT id, '360°', false, 4 FROM q1
),
a2 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '120' FROM q2
),
c3 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '円周角は中心角の2倍になる',      false, 1 FROM q3 UNION ALL
  SELECT id, '円周角は中心角の半分になる',      true,  2 FROM q3 UNION ALL
  SELECT id, '同じ弧に対する円周角はすべて異なる', false, 3 FROM q3 UNION ALL
  SELECT id, '円周角は弧の長さに関係しない',   false, 4 FROM q3
),
c4 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '20 cm²', true,  1 FROM q4 UNION ALL
  SELECT id, '40 cm²', false, 2 FROM q4 UNION ALL
  SELECT id, '13 cm²', false, 3 FROM q4 UNION ALL
  SELECT id, '16 cm²', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '2:3',  false, 1 FROM q5 UNION ALL
  SELECT id, '4:6',  false, 2 FROM q5 UNION ALL
  SELECT id, '4:9',  true,  3 FROM q5 UNION ALL
  SELECT id, '8:27', false, 4 FROM q5
),
a6 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '25' FROM q6
),
s2 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '多角形の内角の和 = 180° × (辺の数 - 2)' FROM q2 UNION ALL
  SELECT id, 2, '正六角形の内角の和 = 180° × (6-2) = 720°' FROM q2 UNION ALL
  SELECT id, 3, '1つの内角 = 720° ÷ 6 = 120°' FROM q2
),
s5 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '相似な図形の面積比は、相似比の2乗になります。' FROM q5 UNION ALL
  SELECT id, 2, '辺の比が 2:3 なので、面積比は 2²:3² = 4:9 です。' FROM q5
)

SELECT 'plane-geometry done' AS result;

-- ② 空間図形
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'math' AND t.slug = 'space-geometry'
),
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '立方体の辺の数はいくつですか。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '三角柱の面の数は {{1}} つ、辺の数は {{2}} 本である。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '半径 3 cm の球の体積を求めなさい。（π を使って答えなさい）', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '底面の半径 3 cm、高さ 4 cm の円柱の体積を求めなさい。（π を使って答えなさい）', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '底面積 12 cm²、高さ 5 cm の三角錐の体積を求めなさい。', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id,  '6', false, 1 FROM q1 UNION ALL
  SELECT id,  '8', false, 2 FROM q1 UNION ALL
  SELECT id, '12', true,  3 FROM q1 UNION ALL
  SELECT id, '16', false, 4 FROM q1
),
a2 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '5' FROM q2 UNION ALL
  SELECT id, 2, '9' FROM q2
),
c3 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '12π cm³',  false, 1 FROM q3 UNION ALL
  SELECT id, '27π cm³',  false, 2 FROM q3 UNION ALL
  SELECT id, '36π cm³',  true,  3 FROM q3 UNION ALL
  SELECT id, '108π cm³', false, 4 FROM q3
),
c4 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '12π cm³', false, 1 FROM q4 UNION ALL
  SELECT id, '24π cm³', false, 2 FROM q4 UNION ALL
  SELECT id, '36π cm³', true,  3 FROM q4 UNION ALL
  SELECT id, '48π cm³', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '10 cm³', false, 1 FROM q5 UNION ALL
  SELECT id, '20 cm³', true,  2 FROM q5 UNION ALL
  SELECT id, '30 cm³', false, 3 FROM q5 UNION ALL
  SELECT id, '60 cm³', false, 4 FROM q5
),
s3 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '球の体積 = (4/3)πr³ で求めます。' FROM q3 UNION ALL
  SELECT id, 2, 'r=3 を代入：(4/3)π × 3³ = (4/3)π × 27 = 36π cm³' FROM q3
),
s5 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '錐体の体積 = (底面積 × 高さ) ÷ 3 で求めます。' FROM q5 UNION ALL
  SELECT id, 2, '(12 × 5) ÷ 3 = 60 ÷ 3 = 20 cm³' FROM q5
)

SELECT 'space-geometry done' AS result;

-- ③ 確率
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'math' AND t.slug = 'probability'
),
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', 'コインを1回投げて表が出る確率を求めなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', 'さいころを1回投げて3以下の目が出る確率を求めなさい。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '2枚のコインを同時に投げて2枚とも表になる確率は {{1}} である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '赤玉3個、青玉2個が入った袋から1個取り出すとき、青玉が出る確率を求めなさい。', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', 'さいころを1回投げて偶数の目が出る確率を求めなさい。', 1, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '1から5までの数字が書かれたカードが1枚ずつあります。この中から2枚引くとき、2枚の数の和が6以上になる確率を求めなさい。', 3, 6 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '1/4', false, 1 FROM q1 UNION ALL
  SELECT id, '1/2', true,  2 FROM q1 UNION ALL
  SELECT id, '2/3', false, 3 FROM q1 UNION ALL
  SELECT id,  '1',  false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '1/6', false, 1 FROM q2 UNION ALL
  SELECT id, '1/3', false, 2 FROM q2 UNION ALL
  SELECT id, '1/2', true,  3 FROM q2 UNION ALL
  SELECT id, '2/3', false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '1/4' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '1/5', false, 1 FROM q4 UNION ALL
  SELECT id, '2/5', true,  2 FROM q4 UNION ALL
  SELECT id, '3/5', false, 3 FROM q4 UNION ALL
  SELECT id, '1/2', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '1/6', false, 1 FROM q5 UNION ALL
  SELECT id, '1/3', false, 2 FROM q5 UNION ALL
  SELECT id, '1/2', true,  3 FROM q5 UNION ALL
  SELECT id, '2/3', false, 4 FROM q5
),
-- q6: 全組み合わせC(5,2)=10, 和≥6: (1,5)(2,4)(2,5)(3,4)(3,5)(4,5)=6通り → 6/10=3/5
c6 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '2/5', false, 1 FROM q6 UNION ALL
  SELECT id, '1/2', false, 2 FROM q6 UNION ALL
  SELECT id, '3/5', true,  3 FROM q6 UNION ALL
  SELECT id, '7/10', false, 4 FROM q6
),
s3 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '2枚のコインの出方は (表表)(表裏)(裏表)(裏裏) の4通りです。' FROM q3 UNION ALL
  SELECT id, 2, '2枚とも表になるのは (表表) の1通りです。' FROM q3 UNION ALL
  SELECT id, 3, '確率 = 1/4 になります。' FROM q3
),
s6 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '5枚から2枚引く全組み合わせ = 5×4÷2 = 10 通り' FROM q6 UNION ALL
  SELECT id, 2, '和が6以上になる組み合わせ：(1,5)(2,4)(2,5)(3,4)(3,5)(4,5) → 6通り' FROM q6 UNION ALL
  SELECT id, 3, '確率 = 6/10 = 3/5' FROM q6
)

SELECT 'probability done' AS result;
