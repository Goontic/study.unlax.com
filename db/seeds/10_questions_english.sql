-- 英語：全単元の問題

-- ① 現在形・過去形
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'english' AND t.slug = 'present-past'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の（　）に入る正しい語を選びなさい。　She ___ to school every day.', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の（　）に入る正しい語を選びなさい。　I ___ a movie last night.', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '「go」の過去形は {{1}} である。', 1, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の文を過去の文に書き換えなさい。　He plays tennis every Sunday.', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の質問に対する否定の答えを選びなさい。　Did you see the movie?', 1, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '「eat」の過去形は {{1}}、「write」の過去形は {{2}} である。', 2, 6 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'go',   false, 1 FROM q1 UNION ALL
  SELECT id, 'goes', true,  2 FROM q1 UNION ALL
  SELECT id, 'went', false, 3 FROM q1 UNION ALL
  SELECT id, 'gone', false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'watch',   false, 1 FROM q2 UNION ALL
  SELECT id, 'watches', false, 2 FROM q2 UNION ALL
  SELECT id, 'watched', true,  3 FROM q2 UNION ALL
  SELECT id, 'watching',false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, 'went' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'He play tennis last Sunday.',    false, 1 FROM q4 UNION ALL
  SELECT id, 'He played tennis last Sunday.',  true,  2 FROM q4 UNION ALL
  SELECT id, 'He plays tennis last Sunday.',   false, 3 FROM q4 UNION ALL
  SELECT id, 'He is playing tennis last Sunday.', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'No, I didn''t.',  true,  1 FROM q5 UNION ALL
  SELECT id, 'No, I don''t.',   false, 2 FROM q5 UNION ALL
  SELECT id, 'No, I wasn''t.',  false, 3 FROM q5 UNION ALL
  SELECT id, 'No, I haven''t.', false, 4 FROM q5
),
a6 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, 'ate'   FROM q6 UNION ALL
  SELECT id, 2, 'wrote' FROM q6
),
s1 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '主語が she（三人称単数）で、every day（毎日）という習慣を表しているので現在形を使います。' FROM q1 UNION ALL
  SELECT id, 2, '三人称単数現在形は動詞に -s または -es をつけます。go → goes' FROM q1
)

SELECT 'english present-past done' AS result;

-- ② 比較表現
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'english' AND t.slug = 'comparatives'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　He is ___ than his brother.　（tall を使って）', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　This is the ___ mountain in Japan.　（high を使って）', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '「This bag is as heavy as that one.」の意味は「このかばんはあのかばんと{{1}}重さだ」である。', 1, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「good」の比較級・最上級として正しいものを選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の文と同じ意味の文を選びなさい。　「Ken is the tallest in his class.」', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'tall',    false, 1 FROM q1 UNION ALL
  SELECT id, 'taller',  true,  2 FROM q1 UNION ALL
  SELECT id, 'tallest', false, 3 FROM q1 UNION ALL
  SELECT id, 'more tall', false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'high',      false, 1 FROM q2 UNION ALL
  SELECT id, 'higher',    false, 2 FROM q2 UNION ALL
  SELECT id, 'highest',   true,  3 FROM q2 UNION ALL
  SELECT id, 'most high', false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '同じ' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'good - gooder - goodest',   false, 1 FROM q4 UNION ALL
  SELECT id, 'good - better - best',      true,  2 FROM q4 UNION ALL
  SELECT id, 'good - more good - most good', false, 3 FROM q4 UNION ALL
  SELECT id, 'good - weller - wellest',   false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'No student in his class is taller than Ken.', true,  1 FROM q5 UNION ALL
  SELECT id, 'Ken is taller than any student.',             false, 2 FROM q5 UNION ALL
  SELECT id, 'Ken is not tall in his class.',               false, 3 FROM q5 UNION ALL
  SELECT id, 'All students are taller than Ken.',           false, 4 FROM q5
)

SELECT 'english comparatives done' AS result;

-- ③ 受動態
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'english' AND t.slug = 'passive-voice'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　English is ___ all over the world.', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の文を受動態に書き換えなさい。　Many people love this singer.', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '受動態の文は「be 動詞 + 動詞の{{1}}形」で表す。', 1, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　This book was ___ by Natsume Soseki.', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の受動態の文を能動態に書き換えなさい。　The window was broken by Tom.', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'speak',  false, 1 FROM q1 UNION ALL
  SELECT id, 'speaks', false, 2 FROM q1 UNION ALL
  SELECT id, 'spoken', true,  3 FROM q1 UNION ALL
  SELECT id, 'spoke',  false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'This singer is loved by many people.',   true,  1 FROM q2 UNION ALL
  SELECT id, 'This singer loved by many people.',      false, 2 FROM q2 UNION ALL
  SELECT id, 'Many people are loved by this singer.',  false, 3 FROM q2 UNION ALL
  SELECT id, 'This singer is loving many people.',     false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '過去分詞' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'write',   false, 1 FROM q4 UNION ALL
  SELECT id, 'wrote',   false, 2 FROM q4 UNION ALL
  SELECT id, 'written', true,  3 FROM q4 UNION ALL
  SELECT id, 'writing', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'Tom broke the window.',    true,  1 FROM q5 UNION ALL
  SELECT id, 'Tom breaks the window.',   false, 2 FROM q5 UNION ALL
  SELECT id, 'The window broke Tom.',    false, 3 FROM q5 UNION ALL
  SELECT id, 'Tom is breaking the window.', false, 4 FROM q5
),
s2 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '能動態の目的語（this singer）を主語にします。' FROM q2 UNION ALL
  SELECT id, 2, '動詞を「be動詞 + 過去分詞」にします。love → loved' FROM q2 UNION ALL
  SELECT id, 3, '能動態の主語（many people）を「by ～」で表します。' FROM q2
)

SELECT 'english passive-voice done' AS result;

-- ④ 現在完了形
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'english' AND t.slug = 'present-perfect'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　I have ___ to Kyoto twice.', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　She has already ___ her homework.', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '現在完了形は「have / has + 動詞の{{1}}形」で表す。', 1, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「継続」を表す現在完了形の文を選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　He has lived here ___ ten years.', 1, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'go',   false, 1 FROM q1 UNION ALL
  SELECT id, 'went', false, 2 FROM q1 UNION ALL
  SELECT id, 'been', true,  3 FROM q1 UNION ALL
  SELECT id, 'gone', false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'finish',   false, 1 FROM q2 UNION ALL
  SELECT id, 'finished', true,  2 FROM q2 UNION ALL
  SELECT id, 'finishing',false, 3 FROM q2 UNION ALL
  SELECT id, 'finishes', false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '過去分詞' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'I have just arrived at the station.',  false, 1 FROM q4 UNION ALL
  SELECT id, 'I have been sick for three days.',     true,  2 FROM q4 UNION ALL
  SELECT id, 'I have already eaten lunch.',          false, 3 FROM q4 UNION ALL
  SELECT id, 'Have you ever visited Okinawa?',       false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'ago',   false, 1 FROM q5 UNION ALL
  SELECT id, 'since', false, 2 FROM q5 UNION ALL
  SELECT id, 'for',   true,  3 FROM q5 UNION ALL
  SELECT id, 'at',    false, 4 FROM q5
),
s4 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '現在完了形の「継続」は、過去から今まで続いている状態を表します。' FROM q4 UNION ALL
  SELECT id, 2, '「for（〜の間）」や「since（〜から）」とよく使われます。' FROM q4 UNION ALL
  SELECT id, 3, '「I have been sick for three days.」= 3日間ずっと病気です。（継続）' FROM q4
)

SELECT 'english present-perfect done' AS result;

-- ⑤ 関係代名詞
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'english' AND t.slug = 'relative-clause'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　The man ___ is talking to her is my teacher.', 2, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　This is the book ___ I bought yesterday.', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '先行詞が人のときは関係代名詞{{1}}、ものや動物のときは{{2}}を使う。（どちらにも使えるものは that）', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の2文を関係代名詞でつなぎなさい。　I have a friend. He speaks three languages.', 3, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る語を選びなさい。　She is a singer ___ songs are very popular.', 3, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'which', false, 1 FROM q1 UNION ALL
  SELECT id, 'who',   true,  2 FROM q1 UNION ALL
  SELECT id, 'whose', false, 3 FROM q1 UNION ALL
  SELECT id, 'whom',  false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'who',   false, 1 FROM q2 UNION ALL
  SELECT id, 'whose', false, 2 FROM q2 UNION ALL
  SELECT id, 'which', true,  3 FROM q2 UNION ALL
  SELECT id, 'when',  false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, 'who'   FROM q3 UNION ALL
  SELECT id, 2, 'which' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'I have a friend who speaks three languages.',    true,  1 FROM q4 UNION ALL
  SELECT id, 'I have a friend which speaks three languages.',  false, 2 FROM q4 UNION ALL
  SELECT id, 'I have a friend whose speaks three languages.',  false, 3 FROM q4 UNION ALL
  SELECT id, 'I have a friend that speak three languages.',    false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'who',   false, 1 FROM q5 UNION ALL
  SELECT id, 'which', false, 2 FROM q5 UNION ALL
  SELECT id, 'whose', true,  3 FROM q5 UNION ALL
  SELECT id, 'that',  false, 4 FROM q5
),
s5 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '「songs are very popular」とあり、先行詞 singer の「歌（songs）」を修飾しています。' FROM q5 UNION ALL
  SELECT id, 2, '所有を表す関係代名詞は「whose」を使います。' FROM q5 UNION ALL
  SELECT id, 3, 'whose + 名詞 = 「〜の…」という意味になります。' FROM q5
)

SELECT 'english relative-clause done' AS result;

-- ⑥ 語彙・熟語
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'english' AND t.slug = 'vocabulary'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「fast」の反意語（反対の意味の語）を選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「look after」の意味として正しいものを選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '「arrive」の名詞形は {{1}} である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '（　）に入る前置詞を選びなさい。　I am interested ___ music.', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「give up」の意味として正しいものを選びなさい。', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'slow',  true,  1 FROM q1 UNION ALL
  SELECT id, 'quick', false, 2 FROM q1 UNION ALL
  SELECT id, 'short', false, 3 FROM q1 UNION ALL
  SELECT id, 'soft',  false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '〜を見る',     false, 1 FROM q2 UNION ALL
  SELECT id, '〜の世話をする', true, 2 FROM q2 UNION ALL
  SELECT id, '〜を探す',     false, 3 FROM q2 UNION ALL
  SELECT id, '〜を待つ',     false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, 'arrival' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'at', false, 1 FROM q4 UNION ALL
  SELECT id, 'in', true,  2 FROM q4 UNION ALL
  SELECT id, 'on', false, 3 FROM q4 UNION ALL
  SELECT id, 'to', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '始める',   false, 1 FROM q5 UNION ALL
  SELECT id, '渡す',     false, 2 FROM q5 UNION ALL
  SELECT id, 'あきらめる', true, 3 FROM q5 UNION ALL
  SELECT id, '育てる',   false, 4 FROM q5
)

SELECT 'english vocabulary done' AS result;
