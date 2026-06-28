-- 数学：二次方程式 6問 ／ 二次関数 6問

-- ① 二次方程式
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'math' AND t.slug = 'quadratics'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の二次方程式を解きなさい。　x² = 9', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の二次方程式を解きなさい。　(x - 2)(x + 3) = 0', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の二次方程式を解きなさい。　x² - 5x + 6 = 0', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '二次方程式 x² - 4 = 0 を解くと x = {{1}} または x = {{2}} である。（小さい方から順に）', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の二次方程式を解きなさい。　2x² - 8 = 0', 2, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'ある正方形の1辺の長さを2cm 長くすると、面積が 21 cm² 増えました。もとの正方形の1辺の長さを求めなさい。', 3, 6 FROM topic RETURNING id
),

-- 選択肢 q1: x²=9 → x=±3
c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'x = 3',   false, 1 FROM q1 UNION ALL
  SELECT id, 'x = -3',  false, 2 FROM q1 UNION ALL
  SELECT id, 'x = ±3',  true,  3 FROM q1 UNION ALL
  SELECT id, 'x = ±9',  false, 4 FROM q1
),
-- 選択肢 q2
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'x = -2, x = 3',  false, 1 FROM q2 UNION ALL
  SELECT id, 'x = 2, x = -3',  true,  2 FROM q2 UNION ALL
  SELECT id, 'x = 2, x = 3',   false, 3 FROM q2 UNION ALL
  SELECT id, 'x = -2, x = -3', false, 4 FROM q2
),
-- 選択肢 q3: (x-2)(x-3)=0 → x=2,3
c3 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'x = 1, x = 6',  false, 1 FROM q3 UNION ALL
  SELECT id, 'x = -2, x = -3', false, 2 FROM q3 UNION ALL
  SELECT id, 'x = 2, x = 3',  true,  3 FROM q3 UNION ALL
  SELECT id, 'x = 5, x = -1', false, 4 FROM q3
),
-- 穴埋め q4: x²=4 → x=±2
a4 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '-2' FROM q4 UNION ALL
  SELECT id, 2, '2' FROM q4
),
-- 選択肢 q5: 2x²=8 → x²=4 → x=±2
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'x = ±1', false, 1 FROM q5 UNION ALL
  SELECT id, 'x = ±2', true,  2 FROM q5 UNION ALL
  SELECT id, 'x = ±4', false, 3 FROM q5 UNION ALL
  SELECT id, 'x = ±8', false, 4 FROM q5
),
-- 選択肢 q6: 元の1辺=a → (a+2)²-a²=21 → 4a+4=21 → a=4.25… ではなく
-- (a+2)²=a²+4a+4, 4a+4=21, 4a=17, a≈4.25 → これだと整数にならない
-- 正しくは 面積が増えた=21cm² → (a+2)²-a²=4a+4=21 → 4a=17 → 整数にならないので変更
-- 別の問題: 1辺をxとすると (x+2)²-x²=24 → 4x+4=24 → x=5
q6_fix AS (
  UPDATE questions SET body = 'ある正方形の1辺の長さを 2cm 長くすると、面積が 24 cm² 増えました。もとの正方形の1辺の長さを求めなさい。'
  WHERE id = (SELECT id FROM q6)
  RETURNING id
),
c6 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '3 cm', false, 1 FROM q6 UNION ALL
  SELECT id, '4 cm', false, 2 FROM q6 UNION ALL
  SELECT id, '5 cm', true,  3 FROM q6 UNION ALL
  SELECT id, '6 cm', false, 4 FROM q6
),

-- 解説
s1 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, 'x² = 9 の形は、両辺の平方根をとります。' FROM q1 UNION ALL
  SELECT id, 2, 'x = ±√9 = ±3 が答えです。プラスとマイナスの両方があることに注意しましょう。' FROM q1
),
s3 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, 'たして -5、かけて 6 になる2つの数を探します。' FROM q3 UNION ALL
  SELECT id, 2, '-2 + (-3) = -5、(-2) × (-3) = 6 → (x-2)(x-3) = 0' FROM q3 UNION ALL
  SELECT id, 3, 'x = 2 または x = 3' FROM q3
),
s6 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '元の1辺を x cm とします。' FROM q6 UNION ALL
  SELECT id, 2, '(x+2)² - x² = 24' FROM q6 UNION ALL
  SELECT id, 3, 'x² + 4x + 4 - x² = 24 → 4x + 4 = 24 → 4x = 20 → x = 5' FROM q6
)

SELECT 'quadratics done' AS result;

-- ② 二次関数
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'math' AND t.slug = 'quadratic-func'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = 2x² で x = 3 のとき y の値を求めなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = x² のグラフの特徴として正しいものを選びなさい。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', 'y = (x - 3)² + 2 の頂点は ({{1}}, {{2}}) である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = x² で x が 1 から 3 まで増加するときの変化の割合を求めなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = x² - 4x + 3 を変形して頂点を求めなさい。', 3, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = -x² のグラフの形として正しいものを選びなさい。', 2, 6 FROM topic RETURNING id
),

-- 選択肢 q1
c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id,  '6', false, 1 FROM q1 UNION ALL
  SELECT id, '12', false, 2 FROM q1 UNION ALL
  SELECT id, '18', true,  3 FROM q1 UNION ALL
  SELECT id,  '9', false, 4 FROM q1
),
-- 選択肢 q2
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '原点を頂点とし、上に開く放物線', true,  1 FROM q2 UNION ALL
  SELECT id, '原点を通る直線',                 false, 2 FROM q2 UNION ALL
  SELECT id, '原点を頂点とし、下に開く放物線', false, 3 FROM q2 UNION ALL
  SELECT id, 'x 軸と2点で交わる曲線',          false, 4 FROM q2
),
-- 穴埋め q3
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '3' FROM q3 UNION ALL
  SELECT id, 2, '2' FROM q3
),
-- 選択肢 q4: (3²-1²)/(3-1)=8/2=4
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '2', false, 1 FROM q4 UNION ALL
  SELECT id, '3', false, 2 FROM q4 UNION ALL
  SELECT id, '4', true,  3 FROM q4 UNION ALL
  SELECT id, '8', false, 4 FROM q4
),
-- 選択肢 q5: x²-4x+3=(x-2)²-1 → 頂点(2,-1)
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '頂点 (2, -1)',  true,  1 FROM q5 UNION ALL
  SELECT id, '頂点 (-2, -1)', false, 2 FROM q5 UNION ALL
  SELECT id, '頂点 (2, 1)',   false, 3 FROM q5 UNION ALL
  SELECT id, '頂点 (1, 0)',   false, 4 FROM q5
),
-- 選択肢 q6
c6 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '原点を頂点とし、下に開く放物線', true,  1 FROM q6 UNION ALL
  SELECT id, '原点を頂点とし、上に開く放物線', false, 2 FROM q6 UNION ALL
  SELECT id, '右上がりの直線',                 false, 3 FROM q6 UNION ALL
  SELECT id, '双曲線',                         false, 4 FROM q6
),
-- 解説
s4 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '変化の割合 = (y の増加量) ÷ (x の増加量)' FROM q4 UNION ALL
  SELECT id, 2, 'x=1 のとき y=1、x=3 のとき y=9' FROM q4 UNION ALL
  SELECT id, 3, '変化の割合 = (9-1)÷(3-1) = 8÷2 = 4' FROM q4
),
s5 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '平方完成をして y = (x-p)² + q の形にします。' FROM q5 UNION ALL
  SELECT id, 2, 'y = x² - 4x + 3 = (x² - 4x + 4) - 4 + 3 = (x-2)² - 1' FROM q5 UNION ALL
  SELECT id, 3, '頂点は (2, -1) です。' FROM q5
)

SELECT 'quadratic-func done' AS result;
