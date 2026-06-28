-- 数学：正の数・負の数 8問

WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'math' AND t.slug = 'integers'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の計算をしなさい。　(-3) + (-4)', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の計算をしなさい。　5 - (-8)', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'text_input', '次の計算をしなさい。答えを数字で入力してください。　(-6) × 3', 1, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の計算をしなさい。　(-20) ÷ (-4)', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の計算をしなさい。　(-2)⁴', 2, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '絶対値について、|(-7)| = {{1}} である。', 1, 6 FROM topic RETURNING id
),
q7 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'text_input', '-4 より 6 大きい数はいくつですか。答えを数字で入力してください。', 2, 7 FROM topic RETURNING id
),
q8 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の計算をしなさい。　(-3) × (-2) × (-1)', 2, 8 FROM topic RETURNING id
),

-- 選択肢 q1: (-3)+(-4)=-7
c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '-7', true,  1 FROM q1 UNION ALL
  SELECT id, '-1', false, 2 FROM q1 UNION ALL
  SELECT id,  '1', false, 3 FROM q1 UNION ALL
  SELECT id,  '7', false, 4 FROM q1
),
-- 選択肢 q2: 5-(-8)=13
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '-13', false, 1 FROM q2 UNION ALL
  SELECT id,  '-3', false, 2 FROM q2 UNION ALL
  SELECT id,   '3', false, 3 FROM q2 UNION ALL
  SELECT id,  '13', true,  4 FROM q2
),
-- 解答 q3: (-6)×3=-18
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '-18' FROM q3
),
-- 選択肢 q4: (-20)÷(-4)=5
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id,  '-5', false, 1 FROM q4 UNION ALL
  SELECT id,   '5', true,  2 FROM q4 UNION ALL
  SELECT id, '-80', false, 3 FROM q4 UNION ALL
  SELECT id,  '80', false, 4 FROM q4
),
-- 選択肢 q5: (-2)⁴=16
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '-16', false, 1 FROM q5 UNION ALL
  SELECT id,  '-8', false, 2 FROM q5 UNION ALL
  SELECT id,   '8', false, 3 FROM q5 UNION ALL
  SELECT id,  '16', true,  4 FROM q5
),
-- 穴埋め q6: |(-7)|=7
a6 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '7' FROM q6
),
-- 解答 q7: -4+6=2
a7 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '2' FROM q7
),
-- 選択肢 q8: (-3)×(-2)×(-1)=-6
c8 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '-6', true,  1 FROM q8 UNION ALL
  SELECT id,  '6', false, 2 FROM q8 UNION ALL
  SELECT id, '-1', false, 3 FROM q8 UNION ALL
  SELECT id,  '1', false, 4 FROM q8
),

-- 解説
s1 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '負の数どうしのたし算は、絶対値をたして、符号はマイナスにします。' FROM q1 UNION ALL
  SELECT id, 2, '3 + 4 = 7 なので、答えは -7 です。' FROM q1
),
s2 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '負の数をひくことは、正の数をたすことと同じです。' FROM q2 UNION ALL
  SELECT id, 2, '5 - (-8) = 5 + 8 = 13 になります。' FROM q2
),
s5 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '(-2)⁴ は (-2) を4回かけることです。' FROM q5 UNION ALL
  SELECT id, 2, '(-2) × (-2) = 4、さらに × (-2) = -8、さらに × (-2) = 16。' FROM q5 UNION ALL
  SELECT id, 3, '負の数を偶数回かけると正の数になります。答えは 16 です。' FROM q5
),
s8 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '負の数が3つあります。負の数の個数が奇数のときは答えは負になります。' FROM q8 UNION ALL
  SELECT id, 2, '(-3) × (-2) = 6、さらに × (-1) = -6 となります。' FROM q8
)

SELECT 'math integers seed completed' AS result;
