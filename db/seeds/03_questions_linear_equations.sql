-- 一次方程式 10問のサンプルデータ
-- 問題ID は自動採番なので、CTEを使って topic_id を解決する

WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t
  JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'math' AND t.slug = 'linear-equations'
),

-- 問題を挿入
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '次の方程式を解きなさい。　3x = 12', 1, 1 FROM topic
  RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'text_input', '次の方程式を解きなさい。　x + 5 = 9', 1, 2 FROM topic
  RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '次の方程式を解きなさい。　2x - 6 = 0', 1, 3 FROM topic
  RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'text_input', '次の方程式を解きなさい。　5x + 3 = 18', 2, 4 FROM topic
  RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '次の方程式を解きなさい。　4x - 2 = 2x + 6', 2, 5 FROM topic
  RETURNING id
),
q6 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '一次方程式 3x + 1 = 7 の解は x = {{1}} である。', 2, 6 FROM topic
  RETURNING id
),
q7 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '方程式 2(x - 3) = 4 の解を求めなさい。', 2, 7 FROM topic
  RETURNING id
),
q8 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'text_input', '次の方程式を解きなさい。　3(x + 2) = 2x + 9', 3, 8 FROM topic
  RETURNING id
),
q9 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'ordering', '一次方程式 2x + 4 = 10 を解く手順を正しい順番に並べなさい。', 3, 9 FROM topic
  RETURNING id
),
q10 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', 'ある数を3倍して5をひくと16になる。この数を x として方程式を作り、解を求めなさい。', 3, 10 FROM topic
  RETURNING id
),

-- 選択肢を挿入 (q1: 3x=12 → x=4)
c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, 'x = 3', false, 1 FROM q1
  UNION ALL
  SELECT id, 'x = 4', true,  2 FROM q1
  UNION ALL
  SELECT id, 'x = 6', false, 3 FROM q1
  UNION ALL
  SELECT id, 'x = 9', false, 4 FROM q1
),

-- 解答 (q2: x+5=9 → x=4)
a2 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '4' FROM q2
),

-- 選択肢 (q3: 2x-6=0 → x=3)
c3 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, 'x = 2', false, 1 FROM q3
  UNION ALL
  SELECT id, 'x = 3', true,  2 FROM q3
  UNION ALL
  SELECT id, 'x = 4', false, 3 FROM q3
  UNION ALL
  SELECT id, 'x = 6', false, 4 FROM q3
),

-- 解答 (q4: 5x+3=18 → x=3)
a4 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '3' FROM q4
),

-- 選択肢 (q5: 4x-2=2x+6 → x=4)
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, 'x = 2', false, 1 FROM q5
  UNION ALL
  SELECT id, 'x = 3', false, 2 FROM q5
  UNION ALL
  SELECT id, 'x = 4', true,  3 FROM q5
  UNION ALL
  SELECT id, 'x = 5', false, 4 FROM q5
),

-- 穴埋め (q6: 3x+1=7 → x=2)
a6 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '2' FROM q6
),

-- 選択肢 (q7: 2(x-3)=4 → x=5)
c7 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, 'x = 3', false, 1 FROM q7
  UNION ALL
  SELECT id, 'x = 4', false, 2 FROM q7
  UNION ALL
  SELECT id, 'x = 5', true,  3 FROM q7
  UNION ALL
  SELECT id, 'x = 7', false, 4 FROM q7
),

-- 解答 (q8: 3(x+2)=2x+9 → x=3)
a8 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '3' FROM q8
),

-- 並べ替え (q9: 2x+4=10 の解き方)
o9 AS (
  INSERT INTO question_order_items ("question_id", body, "correct_position")
  SELECT id, '両辺から4をひく：2x = 6', 1 FROM q9
  UNION ALL
  SELECT id, '両辺を2でわる：x = 3', 2 FROM q9
  UNION ALL
  SELECT id, '確認：2×3+4 = 10 ✓', 3 FROM q9
),

-- 選択肢 (q10: 3x-5=16 → x=7)
c10 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, 'x = 5', false, 1 FROM q10
  UNION ALL
  SELECT id, 'x = 6', false, 2 FROM q10
  UNION ALL
  SELECT id, 'x = 7', true,  3 FROM q10
  UNION ALL
  SELECT id, 'x = 8', false, 4 FROM q10
),

-- 解説ステップ (q1)
s1 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '両辺を x の係数「3」でわります。' FROM q1
  UNION ALL
  SELECT id, 2, '3x ÷ 3 = 12 ÷ 3 より、x = 4 になります。' FROM q1
),

-- 解説 (q2)
s2 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '両辺から 5 をひきます：x + 5 - 5 = 9 - 5' FROM q2
  UNION ALL
  SELECT id, 2, 'x = 4 が答えです。確認：4 + 5 = 9 ✓' FROM q2
),

-- 解説 (q5)
s5 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '右辺の 2x を左辺に移項します：4x - 2x = 6 + 2' FROM q5
  UNION ALL
  SELECT id, 2, '2x = 8 となります。' FROM q5
  UNION ALL
  SELECT id, 3, '両辺を 2 でわります：x = 4' FROM q5
),

-- 解説 (q7)
s7 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, 'まず括弧を展開します：2(x-3) = 2x - 6' FROM q7
  UNION ALL
  SELECT id, 2, '方程式は 2x - 6 = 4 になります。' FROM q7
  UNION ALL
  SELECT id, 3, '6 を右辺に移項：2x = 10' FROM q7
  UNION ALL
  SELECT id, 4, '両辺を 2 でわる：x = 5' FROM q7
),

-- 解説 (q10)
s10 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '「ある数を x」として方程式を立てます：3x - 5 = 16' FROM q10
  UNION ALL
  SELECT id, 2, '-5 を右辺に移項：3x = 21' FROM q10
  UNION ALL
  SELECT id, 3, '両辺を 3 でわる：x = 7' FROM q10
)

SELECT 'seed completed' AS result;
