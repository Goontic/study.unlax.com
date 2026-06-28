-- 数学：連立方程式 7問

WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'math' AND t.slug = 'simultaneous'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '連立方程式　x + y = 5, x - y = 1　を解きなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '連立方程式　2x + y = 7, x + y = 4　を解きなさい。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '連立方程式　x + 2y = 8, x - y = 2　を解くと x = {{1}}、y = {{2}} である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'y = 2x - 1 を 3x + y = 9 に代入して連立方程式を解きなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '連立方程式　3x + 2y = 16, x + 2y = 8　を解きなさい。', 2, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'ordering', '連立方程式　2x + y = 7, x + y = 4　を加減法で解く手順を並べなさい。', 2, 6 FROM topic RETURNING id
),
q7 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '1本80円の鉛筆と1本120円のボールペンを合わせて10本買ったら、代金は1000円でした。鉛筆は何本ですか。', 3, 7 FROM topic RETURNING id
),

-- 選択肢 q1: x=3, y=2
c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'x = 2, y = 3', false, 1 FROM q1 UNION ALL
  SELECT id, 'x = 3, y = 2', true,  2 FROM q1 UNION ALL
  SELECT id, 'x = 4, y = 1', false, 3 FROM q1 UNION ALL
  SELECT id, 'x = 1, y = 4', false, 4 FROM q1
),
-- 選択肢 q2: x=3, y=1
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'x = 2, y = 3', false, 1 FROM q2 UNION ALL
  SELECT id, 'x = 3, y = 1', true,  2 FROM q2 UNION ALL
  SELECT id, 'x = 1, y = 5', false, 3 FROM q2 UNION ALL
  SELECT id, 'x = 4, y = -1', false, 4 FROM q2
),
-- 穴埋め q3: x=4, y=2
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '4' FROM q3 UNION ALL
  SELECT id, 2, '2' FROM q3
),
-- 選択肢 q4: y=2x-1 を代入 → 3x+2x-1=9 → x=2, y=3
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'x = 1, y = 1', false, 1 FROM q4 UNION ALL
  SELECT id, 'x = 2, y = 3', true,  2 FROM q4 UNION ALL
  SELECT id, 'x = 3, y = 5', false, 3 FROM q4 UNION ALL
  SELECT id, 'x = 4, y = 7', false, 4 FROM q4
),
-- 選択肢 q5: 3x+2y=16 から x+2y=8 を引く → 2x=8 → x=4, y=2
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'x = 3, y = 2', false, 1 FROM q5 UNION ALL
  SELECT id, 'x = 4, y = 2', true,  2 FROM q5 UNION ALL
  SELECT id, 'x = 2, y = 5', false, 3 FROM q5 UNION ALL
  SELECT id, 'x = 5, y = 0', false, 4 FROM q5
),
-- 並べ替え q6
o6 AS (
  INSERT INTO question_order_items ("questionId", body, "correctPosition")
  SELECT id, '①式から②式をひく：(2x+y)-(x+y)=7-4', 1 FROM q6 UNION ALL
  SELECT id, 'x = 3 が求まる', 2 FROM q6 UNION ALL
  SELECT id, 'x=3 を②式に代入：3+y=4', 3 FROM q6 UNION ALL
  SELECT id, 'y = 1 が求まる', 4 FROM q6
),
-- 選択肢 q7: 鉛筆x本、ボールペンy本 → x+y=10, 80x+120y=1000 → x=5
c7 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '3本', false, 1 FROM q7 UNION ALL
  SELECT id, '5本', true,  2 FROM q7 UNION ALL
  SELECT id, '7本', false, 3 FROM q7 UNION ALL
  SELECT id, '8本', false, 4 FROM q7
),

-- 解説
s1 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '2つの式をたしたりひいたりして、1つの文字を消去します（加減法）。' FROM q1 UNION ALL
  SELECT id, 2, '①式＋②式：(x+y)+(x-y)=5+1 → 2x=6 → x=3' FROM q1 UNION ALL
  SELECT id, 3, 'x=3 を①式に代入：3+y=5 → y=2' FROM q1
),
s7 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '鉛筆の本数をx、ボールペンの本数をyとします。' FROM q7 UNION ALL
  SELECT id, 2, '本数の式：x + y = 10' FROM q7 UNION ALL
  SELECT id, 3, '代金の式：80x + 120y = 1000' FROM q7 UNION ALL
  SELECT id, 4, '①式より y = 10-x を②式に代入 → 80x + 120(10-x) = 1000 → -40x = -200 → x = 5' FROM q7
)

SELECT 'math simultaneous seed completed' AS result;
