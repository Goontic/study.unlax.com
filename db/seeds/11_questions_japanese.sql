-- 国語：全単元の問題

-- ① 漢字の読み書き
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'japanese' AND t.slug = 'kanji'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「貢献」の読み方を選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「把握」の読み方を選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '「感謝」の読み方は「{{1}}」である。', 1, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「確認」の読み方を選びなさい。', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「水」を部首にもつ漢字を選びなさい。', 2, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '「矛盾」の読み方は「{{1}}」である。', 3, 6 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'こうけん', true,  1 FROM q1 UNION ALL
  SELECT id, 'こうへん', false, 2 FROM q1 UNION ALL
  SELECT id, 'きょうけん', false, 3 FROM q1 UNION ALL
  SELECT id, 'きょうへん', false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'はあく', true,  1 FROM q2 UNION ALL
  SELECT id, 'はわく', false, 2 FROM q2 UNION ALL
  SELECT id, 'きあく', false, 3 FROM q2 UNION ALL
  SELECT id, 'きわく', false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, 'かんしゃ' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'かくにん', true,  1 FROM q4 UNION ALL
  SELECT id, 'かくめい', false, 2 FROM q4 UNION ALL
  SELECT id, 'かんにん', false, 3 FROM q4 UNION ALL
  SELECT id, 'かんめい', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '林', false, 1 FROM q5 UNION ALL
  SELECT id, '油', true,  2 FROM q5 UNION ALL
  SELECT id, '花', false, 3 FROM q5 UNION ALL
  SELECT id, '空', false, 4 FROM q5
),
a6 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, 'むじゅん' FROM q6
)

SELECT 'japanese kanji done' AS result;

-- ② 文法（品詞）
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'japanese' AND t.slug = 'grammar'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「きれいだ」の品詞を選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「走る」の活用形のうち、「走ら（ない）」の形を何形というか選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '「彼は　本を　読んでいる」で、主語は「{{1}}」、述語は「{{2}}」である。', 1, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '次の文の「ない」が形容詞（独立語）として使われているものを選びなさい。', 3, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「しかし」「だから」「つまり」のうち、逆接の接続詞を選びなさい。', 1, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '動詞「食べる」の連用形は「{{1}}」、連体形は「{{2}}」である。', 2, 6 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '形容詞',   false, 1 FROM q1 UNION ALL
  SELECT id, '形容動詞', true,  2 FROM q1 UNION ALL
  SELECT id, '副詞',     false, 3 FROM q1 UNION ALL
  SELECT id, '名詞',     false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '未然形', true,  1 FROM q2 UNION ALL
  SELECT id, '連用形', false, 2 FROM q2 UNION ALL
  SELECT id, '終止形', false, 3 FROM q2 UNION ALL
  SELECT id, '仮定形', false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '彼は'   FROM q3 UNION ALL
  SELECT id, 2, '読んでいる' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '今日は来ない',         false, 1 FROM q4 UNION ALL
  SELECT id, 'お金がない',           true,  2 FROM q4 UNION ALL
  SELECT id, '食べたくない',         false, 3 FROM q4 UNION ALL
  SELECT id, '静かじゃない',         false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'しかし', true,  1 FROM q5 UNION ALL
  SELECT id, 'だから', false, 2 FROM q5 UNION ALL
  SELECT id, 'つまり', false, 3 FROM q5 UNION ALL
  SELECT id, 'また',   false, 4 FROM q5
),
a6 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '食べ'   FROM q6 UNION ALL
  SELECT id, 2, '食べる' FROM q6
),
s1 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '形容詞は「美しい・かわいい」などのように「い」で終わります。' FROM q1 UNION ALL
  SELECT id, 2, '形容動詞は「きれいだ・静かだ・便利だ」などのように「だ（な）」で終わります。' FROM q1 UNION ALL
  SELECT id, 3, '「きれいだ」は「きれいな花」のように「な」に変化するので形容動詞です。' FROM q1
)

SELECT 'japanese grammar done' AS result;

-- ③ 古文
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'japanese' AND t.slug = 'classical-japanese'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「いとをかし」の意味として正しいものを選びなさい。', 2, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「あはれなり」の意味として正しいものを選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '歴史的仮名遣いで「言ふ」を現代仮名遣いに直すと「{{1}}」となる。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「枕草子」の作者を選びなさい。', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「徒然草」の冒頭「つれづれなるままに」の「つれづれ」の意味を選びなさい。', 3, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '「竹取物語」は日本最古の{{1}}といわれる。', 2, 6 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'とても悲しい',       false, 1 FROM q1 UNION ALL
  SELECT id, 'とても趣がある・おもしろい', true, 2 FROM q1 UNION ALL
  SELECT id, 'ひどく恐ろしい',     false, 3 FROM q1 UNION ALL
  SELECT id, 'たいそう美しい',     false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '明るく楽しい',             false, 1 FROM q2 UNION ALL
  SELECT id, 'しみじみとした感動・趣がある', true, 2 FROM q2 UNION ALL
  SELECT id, '恐ろしくて怖い',           false, 3 FROM q2 UNION ALL
  SELECT id, 'にぎやかで楽しい',         false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, 'いう' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '紫式部',   false, 1 FROM q4 UNION ALL
  SELECT id, '清少納言', true,  2 FROM q4 UNION ALL
  SELECT id, '和泉式部', false, 3 FROM q4 UNION ALL
  SELECT id, '兼好法師', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'いそがしい', false, 1 FROM q5 UNION ALL
  SELECT id, 'たいくつ・することがない', true, 2 FROM q5 UNION ALL
  SELECT id, 'うれしい',  false, 3 FROM q5 UNION ALL
  SELECT id, '楽しい',    false, 4 FROM q5
),
a6 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '物語' FROM q6
),
s1 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '「いと」は「たいそう・とても」という意味の古語です。' FROM q1 UNION ALL
  SELECT id, 2, '「をかし」は「趣がある・おもしろい・美しい」という意味です。' FROM q1 UNION ALL
  SELECT id, 3, 'まとめると「とても趣がある・おもしろい」という意味になります。' FROM q1
)

SELECT 'japanese classical done' AS result;

-- ④ 慣用句・ことわざ
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'japanese' AND t.slug = 'idioms'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「七転び八起き」の意味として正しいものを選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「猫に小判」の意味として正しいものを選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '「口が{{1}}」とは、なかなか話さないことを意味する慣用句である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「石の上にも三年」の意味として正しいものを選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「棚からぼたもち」の意味として正しいものを選びなさい。', 2, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「頭が上がらない」の意味として正しいものを選びなさい。', 2, 6 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '何度失敗しても立ち上がること', true,  1 FROM q1 UNION ALL
  SELECT id, '運動が得意なこと',             false, 2 FROM q1 UNION ALL
  SELECT id, '七回転んで八回休むこと',       false, 3 FROM q1 UNION ALL
  SELECT id, 'あきらめることも大切だということ', false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'どんな人でも宝を好むということ',         false, 1 FROM q2 UNION ALL
  SELECT id, '価値のわからない者に貴重なものを与えても無意味', true, 2 FROM q2 UNION ALL
  SELECT id, '猫でも宝を見つけることができる',         false, 3 FROM q2 UNION ALL
  SELECT id, '小さいものが大きいものに勝つ',           false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '重い' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '辛抱強く続ければ成功する',     true,  1 FROM q4 UNION ALL
  SELECT id, '三年間勉強すれば賢くなる',     false, 2 FROM q4 UNION ALL
  SELECT id, '石のように固い意志を持つ',     false, 3 FROM q4 UNION ALL
  SELECT id, '長い時間がかかっても無駄なこと', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '努力して手に入れること',           false, 1 FROM q5 UNION ALL
  SELECT id, '思いがけない幸運が転がり込むこと', true,  2 FROM q5 UNION ALL
  SELECT id, '食べ物に困らないこと',             false, 3 FROM q5 UNION ALL
  SELECT id, '棚の整理をすること',               false, 4 FROM q5
),
c6 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '頭が痛いこと',                       false, 1 FROM q6 UNION ALL
  SELECT id, '相手に引け目を感じて対等に振る舞えない', true, 2 FROM q6 UNION ALL
  SELECT id, '背が低いこと',                       false, 3 FROM q6 UNION ALL
  SELECT id, '上を向けないほど疲れている',         false, 4 FROM q6
)

SELECT 'japanese idioms done' AS result;
