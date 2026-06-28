-- 数学：比例・反比例 6問 ／ 一次関数 6問

-- ① 比例・反比例
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'math' AND t.slug = 'functions'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = 3x で x = 4 のとき、y の値を求めなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y は x に比例し、x = 2 のとき y = 6 です。x = 5 のとき y の値を求めなさい。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'text_input', '反比例 y = 12/x で x = 3 のとき y の値を数字で答えなさい。', 1, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', 'y は x に比例し、x = 4 のとき y = -8 です。比例定数は {{1}} である。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '反比例のグラフについて正しいものを選びなさい。', 2, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = -6/x で x = 2 のとき y の値を求めなさい。', 2, 6 FROM topic RETURNING id
),

-- 選択肢 q1
c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id,  '7', false, 1 FROM q1 UNION ALL
  SELECT id, '12', true,  2 FROM q1 UNION ALL
  SELECT id, '16', false, 3 FROM q1 UNION ALL
  SELECT id,  '3', false, 4 FROM q1
),
-- 選択肢 q2: 比例定数=3, x=5→y=15
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '10', false, 1 FROM q2 UNION ALL
  SELECT id, '12', false, 2 FROM q2 UNION ALL
  SELECT id, '15', true,  3 FROM q2 UNION ALL
  SELECT id, '18', false, 4 FROM q2
),
-- 解答 q3
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '4' FROM q3
),
-- 穴埋め q4: -8/4=-2
a4 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '-2' FROM q4
),
-- 選択肢 q5
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '直線のグラフになる', false, 1 FROM q5 UNION ALL
  SELECT id, '双曲線のグラフになる', true,  2 FROM q5 UNION ALL
  SELECT id, '原点を通る', false, 3 FROM q5 UNION ALL
  SELECT id, 'x 軸と交わる', false, 4 FROM q5
),
-- 選択肢 q6: y=-6/2=-3
c6 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id,  '3', false, 1 FROM q6 UNION ALL
  SELECT id, '-3', true,  2 FROM q6 UNION ALL
  SELECT id, '-8', false, 3 FROM q6 UNION ALL
  SELECT id, '12', false, 4 FROM q6
),
-- 解説
s2 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, 'y が x に比例するとき y = ax（a は比例定数）と表せます。' FROM q2 UNION ALL
  SELECT id, 2, 'x=2, y=6 を代入：6 = 2a → a = 3' FROM q2 UNION ALL
  SELECT id, 3, 'y = 3x に x=5 を代入：y = 3×5 = 15' FROM q2
)

SELECT 'functions done' AS result;

-- ② 一次関数
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'math' AND t.slug = 'linear-functions'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = 2x + 3 で x = 4 のとき y の値を求めなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '一次関数 y = -3x + 5 の傾きは {{1}}、y 切片は {{2}} である。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '2点 (0, 1) と (2, 5) を通る直線の式を求めなさい。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'text_input', '傾きが 3、y 切片が -2 の一次関数の式を y=ax+b の形で答えなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '一次関数 y = 2x - 1 で x が 1 から 4 まで増加するとき、変化の割合を求めなさい。', 2, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = x + 2 と y = -x + 4 の交点の座標を求めなさい。', 3, 6 FROM topic RETURNING id
),

-- 選択肢 q1
c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id,  '5', false, 1 FROM q1 UNION ALL
  SELECT id,  '9', false, 2 FROM q1 UNION ALL
  SELECT id, '11', true,  3 FROM q1 UNION ALL
  SELECT id, '14', false, 4 FROM q1
),
-- 穴埋め q2
a2 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '-3' FROM q2 UNION ALL
  SELECT id, 2, '5' FROM q2
),
-- 選択肢 q3: 傾き=(5-1)/(2-0)=2, 切片=1 → y=2x+1
c3 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'y = x + 1',   false, 1 FROM q3 UNION ALL
  SELECT id, 'y = 2x + 1',  true,  2 FROM q3 UNION ALL
  SELECT id, 'y = 2x - 1',  false, 3 FROM q3 UNION ALL
  SELECT id, 'y = 3x + 1',  false, 4 FROM q3
),
-- 解答 q4
a4 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, 'y=3x-2' FROM q4
),
-- 選択肢 q5: 変化の割合=傾き=2
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '1', false, 1 FROM q5 UNION ALL
  SELECT id, '2', true,  2 FROM q5 UNION ALL
  SELECT id, '3', false, 3 FROM q5 UNION ALL
  SELECT id, '6', false, 4 FROM q5
),
-- 選択肢 q6: x+2=-x+4 → 2x=2 → x=1, y=3
c6 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '(0, 2)',  false, 1 FROM q6 UNION ALL
  SELECT id, '(1, 3)',  true,  2 FROM q6 UNION ALL
  SELECT id, '(2, 2)',  false, 3 FROM q6 UNION ALL
  SELECT id, '(3, 1)',  false, 4 FROM q6
),
-- 解説
s3 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '2点を通る直線の傾き a = (y₂-y₁)÷(x₂-x₁) で求めます。' FROM q3 UNION ALL
  SELECT id, 2, 'a = (5-1)÷(2-0) = 4÷2 = 2' FROM q3 UNION ALL
  SELECT id, 3, 'x=0 のとき y=1 なので y 切片は 1。よって y = 2x + 1' FROM q3
),
s6 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '2つの式を連立方程式として解きます。' FROM q6 UNION ALL
  SELECT id, 2, 'x + 2 = -x + 4 → 2x = 2 → x = 1' FROM q6 UNION ALL
  SELECT id, 3, 'y = 1 + 2 = 3。交点は (1, 3) です。' FROM q6
)

SELECT 'linear-functions done' AS result;
