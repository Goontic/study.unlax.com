-- 小学校 国語 全学年 問題データ

-- ============================================================
-- 1年生: ひらがな・カタカナ (hiragana)
-- ============================================================
WITH t AS (
  SELECT topics.id AS topic_id
  FROM topics
  JOIN subjects ON subjects.id = topics."subjectId"
  WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'hiragana'
),
q AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder") VALUES
    ((SELECT topic_id FROM t), 'multiple_choice', '「つ」に濁点をつけると、どのような文字になりますか？', 1, 1),
    ((SELECT topic_id FROM t), 'multiple_choice', '「は」のカタカナはどれですか？', 1, 2),
    ((SELECT topic_id FROM t), 'multiple_choice', '「か」に濁点をつけると、どのような文字になりますか？', 1, 3),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ほ」のカタカナはどれですか？', 1, 4),
    ((SELECT topic_id FROM t), 'multiple_choice', '「は」に半濁点をつけると、どのような文字になりますか？', 1, 5),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ア」のひらがなはどれですか？', 1, 6),
    ((SELECT topic_id FROM t), 'multiple_choice', '「さ」に濁点をつけると、どのような文字になりますか？', 1, 7),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ミ」のひらがなはどれですか？', 1, 8),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ふ」に半濁点をつけると、どのような文字になりますか？', 1, 9),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ネ」のひらがなはどれですか？', 1, 10),
    ((SELECT topic_id FROM t), 'multiple_choice', '「て」に濁点をつけると、どのような文字になりますか？', 1, 11),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ユ」のひらがなはどれですか？', 1, 12),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ち」に濁点をつけると、どのような文字になりますか？', 1, 13),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ソ」のひらがなはどれですか？', 1, 14),
    ((SELECT topic_id FROM t), 'multiple_choice', '「へ」のカタカナはどれですか？', 1, 15),
    ((SELECT topic_id FROM t), 'multiple_choice', '「こ」のカタカナはどれですか？', 1, 16),
    ((SELECT topic_id FROM t), 'multiple_choice', '「す」に濁点をつけると、どのような文字になりますか？', 1, 17),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ロ」のひらがなはどれですか？', 1, 18),
    ((SELECT topic_id FROM t), 'multiple_choice', '「に」のカタカナはどれですか？', 1, 19),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ぱ」はどの文字に半濁点をつけたものですか？', 1, 20),
    ((SELECT topic_id FROM t), 'multiple_choice', '「シ」のひらがなはどれですか？', 1, 21),
    ((SELECT topic_id FROM t), 'multiple_choice', '「き」に濁点をつけると、どのような文字になりますか？', 1, 22),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ヲ」のひらがなはどれですか？', 1, 23),
    ((SELECT topic_id FROM t), 'multiple_choice', '「せ」のカタカナはどれですか？', 1, 24),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ぺ」はどの文字に半濁点をつけたものですか？', 1, 25)
  RETURNING id, "displayOrder"
)
INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
SELECT q.id, v.body, v.is_correct, v.disp
FROM q
JOIN (VALUES
  (1, 'づ', true,  1), (1, 'ず', false, 2), (1, 'ぜ', false, 3), (1, 'ぞ', false, 4),
  (2, 'ハ', true,  1), (2, 'ヒ', false, 2), (2, 'ホ', false, 3), (2, 'ヘ', false, 4),
  (3, 'が', true,  1), (3, 'ぎ', false, 2), (3, 'ぐ', false, 3), (3, 'げ', false, 4),
  (4, 'ホ', true,  1), (4, 'ヒ', false, 2), (4, 'ハ', false, 3), (4, 'ヘ', false, 4),
  (5, 'ぱ', true,  1), (5, 'ば', false, 2), (5, 'ぴ', false, 3), (5, 'ぶ', false, 4),
  (6, 'あ', true,  1), (6, 'い', false, 2), (6, 'う', false, 3), (6, 'え', false, 4),
  (7, 'ざ', true,  1), (7, 'ぞ', false, 2), (7, 'ず', false, 3), (7, 'ぜ', false, 4),
  (8, 'み', true,  1), (8, 'む', false, 2), (8, 'も', false, 3), (8, 'め', false, 4),
  (9, 'ぷ', true,  1), (9, 'ぶ', false, 2), (9, 'ぽ', false, 3), (9, 'ぱ', false, 4),
  (10, 'ね', true,  1), (10, 'め', false, 2), (10, 'の', false, 3), (10, 'に', false, 4),
  (11, 'で', true,  1), (11, 'だ', false, 2), (11, 'ど', false, 3), (11, 'づ', false, 4),
  (12, 'ゆ', true,  1), (12, 'よ', false, 2), (12, 'や', false, 3), (12, 'え', false, 4),
  (13, 'ぢ', true,  1), (13, 'づ', false, 2), (13, 'じ', false, 3), (13, 'ず', false, 4),
  (14, 'そ', true,  1), (14, 'し', false, 2), (14, 'す', false, 3), (14, 'さ', false, 4),
  (15, 'ヘ', true,  1), (15, 'ハ', false, 2), (15, 'ヒ', false, 3), (15, 'ホ', false, 4),
  (16, 'コ', true,  1), (16, 'ク', false, 2), (16, 'ケ', false, 3), (16, 'カ', false, 4),
  (17, 'ず', true,  1), (17, 'づ', false, 2), (17, 'ぜ', false, 3), (17, 'ぞ', false, 4),
  (18, 'ろ', true,  1), (18, 'る', false, 2), (18, 'れ', false, 3), (18, 'ら', false, 4),
  (19, 'ニ', true,  1), (19, 'ヌ', false, 2), (19, 'ナ', false, 3), (19, 'ネ', false, 4),
  (20, 'は', true,  1), (20, 'ほ', false, 2), (20, 'へ', false, 3), (20, 'ひ', false, 4),
  (21, 'し', true,  1), (21, 'す', false, 2), (21, 'さ', false, 3), (21, 'せ', false, 4),
  (22, 'ぎ', true,  1), (22, 'が', false, 2), (22, 'ぐ', false, 3), (22, 'げ', false, 4),
  (23, 'を', true,  1), (23, 'お', false, 2), (23, 'わ', false, 3), (23, 'う', false, 4),
  (24, 'セ', true,  1), (24, 'サ', false, 2), (24, 'シ', false, 3), (24, 'ソ', false, 4),
  (25, 'へ', true,  1), (25, 'ほ', false, 2), (25, 'は', false, 3), (25, 'ひ', false, 4)
) AS v(dorder, body, is_correct, disp) ON q."displayOrder" = v.dorder;

WITH q AS (
  SELECT id, "displayOrder" FROM questions
  WHERE "topicId" = (
    SELECT topics.id FROM topics JOIN subjects ON subjects.id = topics."subjectId"
    WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'hiragana'
  )
)
INSERT INTO question_steps ("questionId", "stepNumber", body)
SELECT q.id, v.step, v.body
FROM q
JOIN (VALUES
  (1,  1, '「つ」に濁点をつけると「づ」になります。「ず」は「す」に濁点をつけた文字です。'),
  (2,  1, '「は」のカタカナは「ハ」です。形がにている「ヒ」「ホ」「ヘ」と区別しましょう。'),
  (3,  1, '「か」に濁点をつけると「が」になります。'),
  (4,  1, '「ほ」のカタカナは「ホ」です。'),
  (5,  1, '「は」に半濁点（゜）をつけると「ぱ」になります。'),
  (6,  1, '「ア」のひらがなは「あ」です。'),
  (7,  1, '「さ」に濁点をつけると「ざ」になります。'),
  (8,  1, '「ミ」のひらがなは「み」です。'),
  (9,  1, '「ふ」に半濁点をつけると「ぷ」になります。'),
  (10, 1, '「ネ」のひらがなは「ね」です。「め」と形がにているので注意しましょう。'),
  (11, 1, '「て」に濁点をつけると「で」になります。'),
  (12, 1, '「ユ」のひらがなは「ゆ」です。'),
  (13, 1, '「ち」に濁点をつけると「ぢ」になります。「じ」は「し」に濁点をつけた文字です。'),
  (14, 1, '「ソ」のひらがなは「そ」です。「シ」と形がにているので注意しましょう。'),
  (15, 1, '「へ」のカタカナは「ヘ」です。ひらがなとほぼ同じ形です。'),
  (16, 1, '「こ」のカタカナは「コ」です。'),
  (17, 1, '「す」に濁点をつけると「ず」になります。「づ」は「つ」に濁点をつけた文字です。'),
  (18, 1, '「ロ」のひらがなは「ろ」です。'),
  (19, 1, '「に」のカタカナは「ニ」です。'),
  (20, 1, '「ぱ」は「は」に半濁点をつけた文字です。'),
  (21, 1, '「シ」のひらがなは「し」です。「ツ」と「シ」、「ン」と「ソ」は形がにているので注意しましょう。'),
  (22, 1, '「き」に濁点をつけると「ぎ」になります。'),
  (23, 1, '「ヲ」のひらがなは「を」です。助詞として使われることが多い文字です。'),
  (24, 1, '「せ」のカタカナは「セ」です。'),
  (25, 1, '「ぺ」は「へ」に半濁点をつけた文字です。')
) AS v(dorder, step, body) ON q."displayOrder" = v.dorder;

-- ============================================================
-- 1年生: 漢字（1年） (kanji-grade1)
-- ============================================================
WITH t AS (
  SELECT topics.id AS topic_id
  FROM topics
  JOIN subjects ON subjects.id = topics."subjectId"
  WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'kanji-grade1'
),
q AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder") VALUES
    ((SELECT topic_id FROM t), 'multiple_choice', '「山」の読み方はどれですか？', 1, 1),
    ((SELECT topic_id FROM t), 'multiple_choice', '「川」の読み方はどれですか？', 1, 2),
    ((SELECT topic_id FROM t), 'multiple_choice', '「日」の読み方として正しいものはどれですか？', 1, 3),
    ((SELECT topic_id FROM t), 'multiple_choice', '「月」の読み方はどれですか？', 1, 4),
    ((SELECT topic_id FROM t), 'multiple_choice', '「火」の読み方はどれですか？', 1, 5),
    ((SELECT topic_id FROM t), 'multiple_choice', '「水」の読み方はどれですか？', 1, 6),
    ((SELECT topic_id FROM t), 'multiple_choice', '「木」の読み方はどれですか？', 1, 7),
    ((SELECT topic_id FROM t), 'multiple_choice', '「金」の読み方として正しいものはどれですか？', 1, 8),
    ((SELECT topic_id FROM t), 'multiple_choice', '「土」の読み方はどれですか？', 1, 9),
    ((SELECT topic_id FROM t), 'multiple_choice', '「大」の読み方はどれですか？', 1, 10),
    ((SELECT topic_id FROM t), 'multiple_choice', '「小」の読み方はどれですか？', 1, 11),
    ((SELECT topic_id FROM t), 'multiple_choice', '「上」の読み方として正しいものはどれですか？', 1, 12),
    ((SELECT topic_id FROM t), 'multiple_choice', '「下」の読み方として正しいものはどれですか？', 1, 13),
    ((SELECT topic_id FROM t), 'multiple_choice', '「左」の読み方はどれですか？', 1, 14),
    ((SELECT topic_id FROM t), 'multiple_choice', '「右」の読み方はどれですか？', 1, 15),
    ((SELECT topic_id FROM t), 'multiple_choice', '「学」の読み方はどれですか？', 1, 16),
    ((SELECT topic_id FROM t), 'multiple_choice', '「先」の読み方はどれですか？', 1, 17),
    ((SELECT topic_id FROM t), 'multiple_choice', '「生」の読み方として正しいものはどれですか？', 1, 18),
    ((SELECT topic_id FROM t), 'multiple_choice', '「花」の読み方はどれですか？', 1, 19),
    ((SELECT topic_id FROM t), 'multiple_choice', '「草」の読み方はどれですか？', 1, 20),
    ((SELECT topic_id FROM t), 'multiple_choice', '「犬」の読み方はどれですか？', 1, 21),
    ((SELECT topic_id FROM t), 'multiple_choice', '「虫」の読み方はどれですか？', 1, 22),
    ((SELECT topic_id FROM t), 'multiple_choice', '「手」の読み方はどれですか？', 1, 23),
    ((SELECT topic_id FROM t), 'multiple_choice', '「足」の読み方はどれですか？', 1, 24),
    ((SELECT topic_id FROM t), 'multiple_choice', '「目」の読み方はどれですか？', 1, 25)
  RETURNING id, "displayOrder"
)
INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
SELECT q.id, v.body, v.is_correct, v.disp
FROM q
JOIN (VALUES
  (1,  'やま', true,  1), (1,  'かわ', false, 2), (1,  'もり', false, 3), (1,  'はな', false, 4),
  (2,  'かわ', true,  1), (2,  'やま', false, 2), (2,  'うみ', false, 3), (2,  'いけ', false, 4),
  (3,  'ひ', true,   1), (3,  'つき', false, 2), (3,  'ほし', false, 3), (3,  'そら', false, 4),
  (4,  'つき', true,  1), (4,  'ひ', false,  2), (4,  'ほし', false, 3), (4,  'そら', false, 4),
  (5,  'ひ', true,   1), (5,  'みず', false, 2), (5,  'かぜ', false, 3), (5,  'つち', false, 4),
  (6,  'みず', true,  1), (6,  'ひ', false,  2), (6,  'かぜ', false, 3), (6,  'つち', false, 4),
  (7,  'き', true,   1), (7,  'もり', false, 2), (7,  'はな', false, 3), (7,  'くさ', false, 4),
  (8,  'かね', true,  1), (8,  'かな', false, 2), (8,  'きん', false, 3), (8,  'てつ', false, 4),
  (9,  'つち', true,  1), (9,  'いし', false, 2), (9,  'すな', false, 3), (9,  'みち', false, 4),
  (10, 'おお', true,  1), (10, 'おお（きい）', false, 2), (10, 'だい', false, 3), (10, 'たい', false, 4),
  (11, 'ちい（さい）', true, 1), (11, 'おお（きい）', false, 2), (11, 'ひく（い）', false, 3), (11, 'すく（ない）', false, 4),
  (12, 'うえ', true,  1), (12, 'した', false, 2), (12, 'ひだり', false, 3), (12, 'みぎ', false, 4),
  (13, 'した', true,  1), (13, 'うえ', false, 2), (13, 'ひだり', false, 3), (13, 'みぎ', false, 4),
  (14, 'ひだり', true, 1), (14, 'みぎ', false, 2), (14, 'うえ', false, 3), (14, 'した', false, 4),
  (15, 'みぎ', true,  1), (15, 'ひだり', false, 2), (15, 'うえ', false, 3), (15, 'した', false, 4),
  (16, 'がく', true,  1), (16, 'がっ（こう）', false, 2), (16, 'まな（ぶ）', false, 3), (16, 'がん', false, 4),
  (17, 'さき', true,  1), (17, 'まえ', false, 2), (17, 'あと', false, 3), (17, 'うしろ', false, 4),
  (18, 'せい', true,  1), (18, 'しょう', false, 2), (18, 'いき（る）', false, 3), (18, 'うまれ', false, 4),
  (19, 'はな', true,  1), (19, 'くさ', false, 2), (19, 'き', false, 3), (19, 'め', false, 4),
  (20, 'くさ', true,  1), (20, 'はな', false, 2), (20, 'き', false, 3), (20, 'は', false, 4),
  (21, 'いぬ', true,  1), (21, 'ねこ', false, 2), (21, 'うし', false, 3), (21, 'うま', false, 4),
  (22, 'むし', true,  1), (22, 'とり', false, 2), (22, 'さかな', false, 3), (22, 'いぬ', false, 4),
  (23, 'て', true,   1), (23, 'あし', false, 2), (23, 'め', false, 4), (23, 'みみ', false, 3),
  (24, 'あし', true,  1), (24, 'て', false, 2), (24, 'め', false, 3), (24, 'くち', false, 4),
  (25, 'め', true,   1), (25, 'みみ', false, 2), (25, 'くち', false, 3), (25, 'て', false, 4)
) AS v(dorder, body, is_correct, disp) ON q."displayOrder" = v.dorder;

WITH q AS (
  SELECT id, "displayOrder" FROM questions
  WHERE "topicId" = (
    SELECT topics.id FROM topics JOIN subjects ON subjects.id = topics."subjectId"
    WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'kanji-grade1'
  )
)
INSERT INTO question_steps ("questionId", "stepNumber", body)
SELECT q.id, v.step, v.body
FROM q
JOIN (VALUES
  (1,  1, '「山」は「やま」と読みます。「さん」という音読みもあります。'),
  (2,  1, '「川」は「かわ」と読みます。「せん」という音読みもあります（例：利根川→とねがわ）。'),
  (3,  1, '「日」は「ひ」と読みます。「にち」「じつ」という音読みもあります。'),
  (4,  1, '「月」は「つき」と読みます。「げつ」「がつ」という音読みもあります。'),
  (5,  1, '「火」は「ひ」と読みます。火曜日の「か」という音読みもあります。'),
  (6,  1, '「水」は「みず」と読みます。水曜日の「すい」という音読みもあります。'),
  (7,  1, '「木」は「き」と読みます。木曜日の「もく」という音読みもあります。'),
  (8,  1, '「金」は「かね」と読みます。金曜日の「きん」という音読みもあります。'),
  (9,  1, '「土」は「つち」と読みます。土曜日の「ど」という音読みもあります。'),
  (10, 1, '「大」は「おお」と読みます（例：大きい）。「だい」「たい」という音読みもあります。'),
  (11, 1, '「小」は「ちい（さい）」と読みます。「しょう」という音読みもあります。'),
  (12, 1, '「上」は「うえ」と読みます。「じょう」「うわ」という読み方もあります。'),
  (13, 1, '「下」は「した」と読みます。「か」「げ」という音読みもあります。'),
  (14, 1, '「左」は「ひだり」と読みます。「さ」という音読みもあります。'),
  (15, 1, '「右」は「みぎ」と読みます。「う」「ゆう」という音読みもあります。'),
  (16, 1, '「学」は「がく」と読みます。「まな（ぶ）」という訓読みもあります。'),
  (17, 1, '「先」は「さき」と読みます。先生の「せん」という音読みもあります。'),
  (18, 1, '「生」は「せい」と読みます。「い（きる）」「う（まれる）」という訓読みもあります。'),
  (19, 1, '「花」は「はな」と読みます。「か」という音読みもあります（例：花瓶→かびん）。'),
  (20, 1, '「草」は「くさ」と読みます。「そう」という音読みもあります。'),
  (21, 1, '「犬」は「いぬ」と読みます。「けん」という音読みもあります（例：愛犬→あいけん）。'),
  (22, 1, '「虫」は「むし」と読みます。「ちゅう」という音読みもあります（例：昆虫→こんちゅう）。'),
  (23, 1, '「手」は「て」と読みます。「しゅ」という音読みもあります（例：手術→しゅじゅつ）。'),
  (24, 1, '「足」は「あし」と読みます。「そく」という音読みもあります（例：足跡→そくせき）。'),
  (25, 1, '「目」は「め」と読みます。「もく」「ぼく」という音読みもあります。')
) AS v(dorder, step, body) ON q."displayOrder" = v.dorder;

-- ============================================================
-- 1年生: 文の読み取り（1年） (sentence-basic-1)
-- ============================================================
WITH t AS (
  SELECT topics.id AS topic_id
  FROM topics
  JOIN subjects ON subjects.id = topics."subjectId"
  WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'sentence-basic-1'
),
q AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder") VALUES
    ((SELECT topic_id FROM t), 'multiple_choice', '「たろうくんは　がっこうへ　いきました。」この文で、たろうくんはどこへ行きましたか？', 1, 1),
    ((SELECT topic_id FROM t), 'multiple_choice', '「はなこさんは　りんごを　たべました。」はなこさんは何をしましたか？', 1, 2),
    ((SELECT topic_id FROM t), 'multiple_choice', '「いぬが　にわで　あそんでいます。」いぬはどこにいますか？', 1, 3),
    ((SELECT topic_id FROM t), 'multiple_choice', '「きのう　あめが　ふりました。」いつ雨がふりましたか？', 1, 4),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ねこは　くろくて　かわいいです。」ねこはどんな色ですか？', 1, 5),
    ((SELECT topic_id FROM t), 'multiple_choice', '「おかあさんが　おいしい　ごはんを　つくりました。」だれがごはんをつくりましたか？', 1, 6),
    ((SELECT topic_id FROM t), 'multiple_choice', '「じろうくんは　あかい　ボールを　もっています。」ボールはどんな色ですか？', 1, 7),
    ((SELECT topic_id FROM t), 'multiple_choice', '「みさきさんは　ほんを　よみました。」みさきさんは何をしましたか？', 1, 8),
    ((SELECT topic_id FROM t), 'multiple_choice', '「そらは　あおくて　きれいです。」そらはどんなようすですか？', 1, 9),
    ((SELECT topic_id FROM t), 'multiple_choice', '「えんぴつが　つくえの　うえに　あります。」えんぴつはどこにありますか？', 1, 10),
    ((SELECT topic_id FROM t), 'multiple_choice', '「こうえんで　こどもたちが　あそんでいます。」どこで遊んでいますか？', 1, 11),
    ((SELECT topic_id FROM t), 'multiple_choice', '「おとうさんは　しごとへ　いきました。」おとうさんはどこへ行きましたか？', 1, 12),
    ((SELECT topic_id FROM t), 'multiple_choice', '「あさ　ともだちと　がっこうへ　いきます。」いつ学校へ行きますか？', 1, 13),
    ((SELECT topic_id FROM t), 'multiple_choice', '「うさぎは　しろくて　ふわふわです。」うさぎはどんな色ですか？', 1, 14),
    ((SELECT topic_id FROM t), 'multiple_choice', '「たなかさんは　おおきな　こえで　うたいました。」たなかさんはどんな声で歌いましたか？', 1, 15),
    ((SELECT topic_id FROM t), 'multiple_choice', '「みかんが　かごに　みっつ　あります。」みかんはいくつありますか？', 1, 16),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ゆきが　しろく　つもっています。」ゆきはどんな色ですか？', 1, 17),
    ((SELECT topic_id FROM t), 'multiple_choice', '「すずきさんは　はやく　はしりました。」すずきさんはどのようにはしりましたか？', 1, 18),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ひまわりが　にわに　さいています。」どこにひまわりがさいていますか？', 1, 19),
    ((SELECT topic_id FROM t), 'multiple_choice', '「いもうとは　かわいい　にんぎょうを　もっています。」だれがにんぎょうをもっていますか？', 1, 20),
    ((SELECT topic_id FROM t), 'multiple_choice', '「あした　うみへ　いきます。」いつ海へ行きますか？', 1, 21),
    ((SELECT topic_id FROM t), 'multiple_choice', '「きいろい　ちょうちょが　はなに　とまっています。」ちょうちょはどんな色ですか？', 1, 22),
    ((SELECT topic_id FROM t), 'multiple_choice', '「おにいさんは　たかい　やまに　のぼりました。」おにいさんはどこにのぼりましたか？', 1, 23),
    ((SELECT topic_id FROM t), 'multiple_choice', '「さかなが　かわを　およいでいます。」さかなはどこを泳いでいますか？', 1, 24),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ともこさんは　にっきを　まいにち　かいています。」ともこさんは何をしていますか？', 1, 25)
  RETURNING id, "displayOrder"
)
INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
SELECT q.id, v.body, v.is_correct, v.disp
FROM q
JOIN (VALUES
  (1,  'がっこう', true, 1), (1,  'こうえん', false, 2), (1,  'おうち', false, 3), (1,  'みせ', false, 4),
  (2,  'りんごをたべた', true, 1), (2,  'りんごをかった', false, 2), (2,  'りんごをなげた', false, 3), (2,  'りんごをみた', false, 4),
  (3,  'にわ', true, 1), (3,  'へや', false, 2), (3,  'こうえん', false, 3), (3,  'みち', false, 4),
  (4,  'きのう', true, 1), (4,  'きょう', false, 2), (4,  'あした', false, 3), (4,  'けさ', false, 4),
  (5,  'くろ', true, 1), (5,  'しろ', false, 2), (5,  'きいろ', false, 3), (5,  'ちゃいろ', false, 4),
  (6,  'おかあさん', true, 1), (6,  'おとうさん', false, 2), (6,  'おばあさん', false, 3), (6,  'こども', false, 4),
  (7,  'あか', true, 1), (7,  'あお', false, 2), (7,  'きいろ', false, 3), (7,  'みどり', false, 4),
  (8,  'ほんをよんだ', true, 1), (8,  'ほんをかいた', false, 2), (8,  'ほんをかった', false, 3), (8,  'ほんをもった', false, 4),
  (9,  'あおくてきれい', true, 1), (9,  'くもっている', false, 2), (9,  'くらい', false, 3), (9,  'しろい', false, 4),
  (10, 'つくえのうえ', true, 1), (10, 'つくえのした', false, 2), (10, 'かばんのなか', false, 3), (10, 'まどのそば', false, 4),
  (11, 'こうえん', true, 1), (11, 'がっこう', false, 2), (11, 'うみ', false, 3), (11, 'にわ', false, 4),
  (12, 'しごと', true, 1), (12, 'がっこう', false, 2), (12, 'こうえん', false, 3), (12, 'みせ', false, 4),
  (13, 'あさ', true, 1), (13, 'ひる', false, 2), (13, 'よる', false, 3), (13, 'ゆうがた', false, 4),
  (14, 'しろ', true, 1), (14, 'くろ', false, 2), (14, 'ちゃいろ', false, 3), (14, 'きいろ', false, 4),
  (15, 'おおきな声', true, 1), (15, 'ちいさな声', false, 2), (15, 'しずかな声', false, 3), (15, 'やさしい声', false, 4),
  (16, 'みっつ', true, 1), (16, 'ふたつ', false, 2), (16, 'よっつ', false, 3), (16, 'ひとつ', false, 4),
  (17, 'しろ', true, 1), (17, 'あお', false, 2), (17, 'きいろ', false, 3), (17, 'くろ', false, 4),
  (18, 'はやく', true, 1), (18, 'ゆっくり', false, 2), (18, 'たのしく', false, 3), (18, 'かなしく', false, 4),
  (19, 'にわ', true, 1), (19, 'こうえん', false, 2), (19, 'のはら', false, 3), (19, 'やま', false, 4),
  (20, 'いもうと', true, 1), (20, 'おねえさん', false, 2), (20, 'おかあさん', false, 3), (20, 'ともだち', false, 4),
  (21, 'あした', true, 1), (21, 'きょう', false, 2), (21, 'きのう', false, 3), (21, 'あさって', false, 4),
  (22, 'きいろ', true, 1), (22, 'あか', false, 2), (22, 'しろ', false, 3), (22, 'あお', false, 4),
  (23, 'たかいやま', true, 1), (23, 'ひくいやま', false, 2), (23, 'うみ', false, 3), (23, 'かわ', false, 4),
  (24, 'かわ', true, 1), (24, 'うみ', false, 2), (24, 'いけ', false, 3), (24, 'みず', false, 4),
  (25, 'にっきをかいている', true, 1), (25, 'にっきをよんでいる', false, 2), (25, 'えをかいている', false, 3), (25, 'ほんをよんでいる', false, 4)
) AS v(dorder, body, is_correct, disp) ON q."displayOrder" = v.dorder;

WITH q AS (
  SELECT id, "displayOrder" FROM questions
  WHERE "topicId" = (
    SELECT topics.id FROM topics JOIN subjects ON subjects.id = topics."subjectId"
    WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'sentence-basic-1'
  )
)
INSERT INTO question_steps ("questionId", "stepNumber", body)
SELECT q.id, v.step, v.body
FROM q
JOIN (VALUES
  (1,  1, '文に「がっこうへ いきました」とあるので、学校へ行ったことがわかります。'),
  (2,  1, '文に「りんごを たべました」とあるので、りんごを食べたことがわかります。'),
  (3,  1, '文に「にわで あそんでいます」とあるので、にわにいることがわかります。'),
  (4,  1, '文に「きのう」とあるので、昨日のことを話しています。'),
  (5,  1, '文に「くろくて かわいい」とあるので、黒い色のねこだとわかります。'),
  (6,  1, '文に「おかあさんが」とあるので、おかあさんがごはんをつくったことがわかります。'),
  (7,  1, '文に「あかい ボール」とあるので、赤いボールだとわかります。'),
  (8,  1, '文に「ほんを よみました」とあるので、本を読んだことがわかります。'),
  (9,  1, '文に「あおくて きれい」とあるので、青くてきれいなようすだとわかります。'),
  (10, 1, '文に「つくえの うえに あります」とあるので、机の上にあることがわかります。'),
  (11, 1, '文に「こうえんで」とあるので、公園で遊んでいることがわかります。'),
  (12, 1, '文に「しごとへ いきました」とあるので、仕事へ行ったことがわかります。'),
  (13, 1, '文に「あさ」とあるので、朝のことを話しています。'),
  (14, 1, '文に「しろくて」とあるので、白い色のうさぎだとわかります。'),
  (15, 1, '文に「おおきな こえで」とあるので、大きな声で歌ったことがわかります。'),
  (16, 1, '文に「みっつ あります」とあるので、3つあることがわかります。'),
  (17, 1, '文に「しろく つもっています」とあるので、雪は白いことがわかります。'),
  (18, 1, '文に「はやく はしりました」とあるので、速く走ったことがわかります。'),
  (19, 1, '文に「にわに さいています」とあるので、にわに咲いていることがわかります。'),
  (20, 1, '文に「いもうとは」とあるので、いもうとがにんぎょうを持っていることがわかります。'),
  (21, 1, '文に「あした」とあるので、明日のことを話しています。'),
  (22, 1, '文に「きいろい ちょうちょ」とあるので、黄色いちょうちょだとわかります。'),
  (23, 1, '文に「たかい やまに のぼりました」とあるので、高い山にのぼったことがわかります。'),
  (24, 1, '文に「かわを およいでいます」とあるので、川を泳いでいることがわかります。'),
  (25, 1, '文に「にっきを まいにち かいています」とあるので、日記を書いていることがわかります。')
) AS v(dorder, step, body) ON q."displayOrder" = v.dorder;

-- ============================================================
-- 2年生: 漢字（2年） (kanji-grade2)
-- ============================================================
WITH t AS (
  SELECT topics.id AS topic_id
  FROM topics
  JOIN subjects ON subjects.id = topics."subjectId"
  WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'kanji-grade2'
),
q AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder") VALUES
    ((SELECT topic_id FROM t), 'multiple_choice', '「朝」の読み方はどれですか？', 1, 1),
    ((SELECT topic_id FROM t), 'multiple_choice', '「夜」の読み方はどれですか？', 1, 2),
    ((SELECT topic_id FROM t), 'multiple_choice', '「昼」の読み方はどれですか？', 1, 3),
    ((SELECT topic_id FROM t), 'multiple_choice', '「東」の読み方はどれですか？', 1, 4),
    ((SELECT topic_id FROM t), 'multiple_choice', '「西」の読み方はどれですか？', 1, 5),
    ((SELECT topic_id FROM t), 'multiple_choice', '「南」の読み方はどれですか？', 1, 6),
    ((SELECT topic_id FROM t), 'multiple_choice', '「北」の読み方はどれですか？', 1, 7),
    ((SELECT topic_id FROM t), 'multiple_choice', '「春」の読み方はどれですか？', 1, 8),
    ((SELECT topic_id FROM t), 'multiple_choice', '「夏」の読み方はどれですか？', 1, 9),
    ((SELECT topic_id FROM t), 'multiple_choice', '「秋」の読み方はどれですか？', 1, 10),
    ((SELECT topic_id FROM t), 'multiple_choice', '「冬」の読み方はどれですか？', 1, 11),
    ((SELECT topic_id FROM t), 'multiple_choice', '「親」の読み方はどれですか？', 1, 12),
    ((SELECT topic_id FROM t), 'multiple_choice', '「友」の読み方はどれですか？', 1, 13),
    ((SELECT topic_id FROM t), 'multiple_choice', '「父」の読み方はどれですか？', 1, 14),
    ((SELECT topic_id FROM t), 'multiple_choice', '「母」の読み方はどれですか？', 1, 15),
    ((SELECT topic_id FROM t), 'multiple_choice', '「食」の読み方はどれですか？', 1, 16),
    ((SELECT topic_id FROM t), 'multiple_choice', '「色」の読み方はどれですか？', 1, 17),
    ((SELECT topic_id FROM t), 'multiple_choice', '「形」の読み方はどれですか？', 1, 18),
    ((SELECT topic_id FROM t), 'multiple_choice', '「明」の読み方として正しいものはどれですか？', 1, 19),
    ((SELECT topic_id FROM t), 'multiple_choice', '「強」の読み方はどれですか？', 1, 20),
    ((SELECT topic_id FROM t), 'multiple_choice', '「弱」の読み方はどれですか？', 1, 21),
    ((SELECT topic_id FROM t), 'multiple_choice', '「多」の読み方はどれですか？', 1, 22),
    ((SELECT topic_id FROM t), 'multiple_choice', '「少」の読み方はどれですか？', 1, 23),
    ((SELECT topic_id FROM t), 'multiple_choice', '「新」の読み方はどれですか？', 1, 24),
    ((SELECT topic_id FROM t), 'multiple_choice', '「古」の読み方はどれですか？', 1, 25)
  RETURNING id, "displayOrder"
)
INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
SELECT q.id, v.body, v.is_correct, v.disp
FROM q
JOIN (VALUES
  (1,  'あさ', true,  1), (1,  'ひる', false, 2), (1,  'よる', false, 3), (1,  'ゆう', false, 4),
  (2,  'よる', true,  1), (2,  'あさ', false, 2), (2,  'ひる', false, 3), (2,  'ゆうがた', false, 4),
  (3,  'ひる', true,  1), (3,  'あさ', false, 2), (3,  'よる', false, 3), (3,  'まひる', false, 4),
  (4,  'ひがし', true, 1), (4,  'にし', false, 2), (4,  'みなみ', false, 3), (4,  'きた', false, 4),
  (5,  'にし', true,  1), (5,  'ひがし', false, 2), (5,  'みなみ', false, 3), (5,  'きた', false, 4),
  (6,  'みなみ', true, 1), (6,  'きた', false, 2), (6,  'ひがし', false, 3), (6,  'にし', false, 4),
  (7,  'きた', true,  1), (7,  'みなみ', false, 2), (7,  'ひがし', false, 3), (7,  'にし', false, 4),
  (8,  'はる', true,  1), (8,  'なつ', false, 2), (8,  'あき', false, 3), (8,  'ふゆ', false, 4),
  (9,  'なつ', true,  1), (9,  'はる', false, 2), (9,  'あき', false, 3), (9,  'ふゆ', false, 4),
  (10, 'あき', true,  1), (10, 'はる', false, 2), (10, 'なつ', false, 3), (10, 'ふゆ', false, 4),
  (11, 'ふゆ', true,  1), (11, 'はる', false, 2), (11, 'なつ', false, 3), (11, 'あき', false, 4),
  (12, 'おや', true,  1), (12, 'ちち', false, 2), (12, 'はは', false, 3), (12, 'こ', false, 4),
  (13, 'とも', true,  1), (13, 'おや', false, 2), (13, 'きょうだい', false, 3), (13, 'むすこ', false, 4),
  (14, 'ちち', true,  1), (14, 'はは', false, 2), (14, 'おや', false, 3), (14, 'そふ', false, 4),
  (15, 'はは', true,  1), (15, 'ちち', false, 2), (15, 'おや', false, 3), (15, 'そぼ', false, 4),
  (16, 'しょく', true, 1), (16, 'た（べる）', false, 2), (16, 'のむ', false, 3), (16, 'のこす', false, 4),
  (17, 'いろ', true,  1), (17, 'かたち', false, 2), (17, 'おと', false, 3), (17, 'にほひ', false, 4),
  (18, 'かたち', true, 1), (18, 'いろ', false, 2), (18, 'おおきさ', false, 3), (18, 'おもさ', false, 4),
  (19, 'あか（るい）', true, 1), (19, 'くら（い）', false, 2), (19, 'あたら（しい）', false, 3), (19, 'ふる（い）', false, 4),
  (20, 'つよ（い）', true, 1), (20, 'よわ（い）', false, 2), (20, 'かた（い）', false, 3), (20, 'やわ（らかい）', false, 4),
  (21, 'よわ（い）', true, 1), (21, 'つよ（い）', false, 2), (21, 'かた（い）', false, 3), (21, 'やわ（らかい）', false, 4),
  (22, 'おお（い）', true, 1), (22, 'すく（ない）', false, 2), (22, 'おお（きい）', false, 3), (22, 'ちい（さい）', false, 4),
  (23, 'すく（ない）', true, 1), (23, 'おお（い）', false, 2), (23, 'ちい（さい）', false, 3), (23, 'ひく（い）', false, 4),
  (24, 'あたら（しい）', true, 1), (24, 'ふる（い）', false, 2), (24, 'おお（きい）', false, 3), (24, 'ちい（さい）', false, 4),
  (25, 'ふる（い）', true, 1), (25, 'あたら（しい）', false, 2), (25, 'おお（きい）', false, 3), (25, 'ちい（さい）', false, 4)
) AS v(dorder, body, is_correct, disp) ON q."displayOrder" = v.dorder;

WITH q AS (
  SELECT id, "displayOrder" FROM questions
  WHERE "topicId" = (
    SELECT topics.id FROM topics JOIN subjects ON subjects.id = topics."subjectId"
    WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'kanji-grade2'
  )
)
INSERT INTO question_steps ("questionId", "stepNumber", body)
SELECT q.id, v.step, v.body
FROM q
JOIN (VALUES
  (1,  1, '「朝」は「あさ」と読みます。「ちょう」という音読みもあります（例：朝食→ちょうしょく）。'),
  (2,  1, '「夜」は「よる」と読みます。「や」という音読みもあります（例：夜中→やちゅう）。'),
  (3,  1, '「昼」は「ひる」と読みます。「ちゅう」という音読みもあります（例：昼食→ちゅうしょく）。'),
  (4,  1, '「東」は「ひがし」と読みます。「とう」という音読みもあります（例：東京→とうきょう）。'),
  (5,  1, '「西」は「にし」と読みます。「せい」という音読みもあります（例：西洋→せいよう）。'),
  (6,  1, '「南」は「みなみ」と読みます。「なん」という音読みもあります（例：南極→なんきょく）。'),
  (7,  1, '「北」は「きた」と読みます。「ほく」という音読みもあります（例：北極→ほっきょく）。'),
  (8,  1, '「春」は「はる」と読みます。「しゅん」という音読みもあります（例：春分→しゅんぶん）。'),
  (9,  1, '「夏」は「なつ」と読みます。「か」という音読みもあります（例：夏休み→なつやすみ）。'),
  (10, 1, '「秋」は「あき」と読みます。「しゅう」という音読みもあります（例：秋分→しゅうぶん）。'),
  (11, 1, '「冬」は「ふゆ」と読みます。「とう」という音読みもあります（例：冬至→とうじ）。'),
  (12, 1, '「親」は「おや」と読みます。「しん」という音読みもあります（例：親切→しんせつ）。'),
  (13, 1, '「友」は「とも」と読みます。「ゆう」という音読みもあります（例：友人→ゆうじん）。'),
  (14, 1, '「父」は「ちち」と読みます。「ふ」という音読みもあります（例：父母→ふぼ）。'),
  (15, 1, '「母」は「はは」と読みます。「ぼ」という音読みもあります（例：父母→ふぼ）。'),
  (16, 1, '「食」は「しょく」と読みます。「た（べる）」という訓読みもあります。'),
  (17, 1, '「色」は「いろ」と読みます。「しょく」「しき」という音読みもあります（例：色彩→しきさい）。'),
  (18, 1, '「形」は「かたち」と読みます。「けい」「ぎょう」という音読みもあります。'),
  (19, 1, '「明」は「あか（るい）」と読みます。「めい」という音読みもあります（例：明日→あした/みょうにち）。'),
  (20, 1, '「強」は「つよ（い）」と読みます。「きょう」「ごう」という音読みもあります。'),
  (21, 1, '「弱」は「よわ（い）」と読みます。「じゃく」という音読みもあります（例：弱点→じゃくてん）。'),
  (22, 1, '「多」は「おお（い）」と読みます。「た」という音読みもあります（例：多数→たすう）。'),
  (23, 1, '「少」は「すく（ない）」と読みます。「しょう」という音読みもあります（例：少量→しょうりょう）。'),
  (24, 1, '「新」は「あたら（しい）」と読みます。「しん」という音読みもあります（例：新幹線→しんかんせん）。'),
  (25, 1, '「古」は「ふる（い）」と読みます。「こ」という音読みもあります（例：古典→こてん）。')
) AS v(dorder, step, body) ON q."displayOrder" = v.dorder;

-- ============================================================
-- 2年生: 文章の読み取り（2年） (reading-comp-2)
-- ============================================================
WITH t AS (
  SELECT topics.id AS topic_id
  FROM topics
  JOIN subjects ON subjects.id = topics."subjectId"
  WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'reading-comp-2'
),
q AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder") VALUES
    ((SELECT topic_id FROM t), 'multiple_choice', '「たろうくんは　学校から　帰ってきました。かばんを　おいてから、すぐに　こうえんへ　行きました。」たろうくんは、学校から帰ってきたあとに何をしましたか？', 2, 1),
    ((SELECT topic_id FROM t), 'multiple_choice', '「はなこさんは　本が　だいすきです。まい日、寝る前に　本を　よみます。」はなこさんはいつ本を読みますか？', 2, 2),
    ((SELECT topic_id FROM t), 'multiple_choice', '「そらが　くもってきました。かぜも　ふいてきました。もうすぐ　雨が　ふりそうです。」この文から、これからどうなりそうですか？', 2, 3),
    ((SELECT topic_id FROM t), 'multiple_choice', '「たなかさんは　テストで100てんを　とりました。とても　うれしくて、家に　帰ったら　お母さんに　話しました。」たなかさんが　お母さんに　話したのは　なぜですか？', 2, 4),
    ((SELECT topic_id FROM t), 'multiple_choice', '「犬が　ほえています。ゆうびんやさんが　来たからです。」犬がほえているのはなぜですか？', 2, 5),
    ((SELECT topic_id FROM t), 'multiple_choice', '「あした　遠足があります。みんな　たのしみに　しています。」みんなはどんな気持ちですか？', 2, 6),
    ((SELECT topic_id FROM t), 'multiple_choice', '「りんごが　5つ　ありました。3つ　食べたら、いくつ　のこりますか？」のこったりんごはいくつですか？', 2, 7),
    ((SELECT topic_id FROM t), 'multiple_choice', '「先生が　「しずかに　してください。」と　言いました。子どもたちは　しずかに　なりました。」子どもたちはなぜしずかになったのですか？', 2, 8),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ねこが　木の上に　のぼっています。なかなか　おりて　きません。」ねこはどこにいますか？', 2, 9),
    ((SELECT topic_id FROM t), 'multiple_choice', '「春になると、花が　さきます。チョウチョが　とんできます。公園が　にぎやかに　なります。」春になると公園はどうなりますか？', 2, 10),
    ((SELECT topic_id FROM t), 'multiple_choice', '「山田さんは　まいあさ6時に　おきます。そして、7時に　学校へ　出かけます。」山田さんが学校へ出かけるのは何時ですか？', 2, 11),
    ((SELECT topic_id FROM t), 'multiple_choice', '「あめが　ふっているので、そとで　あそべません。だから、うちで　本を　よんでいます。」なぜ家で本を読んでいるのですか？', 2, 12),
    ((SELECT topic_id FROM t), 'multiple_choice', '「おかあさんは　にっこり　わらいました。」おかあさんはどんな気持ちですか？', 2, 13),
    ((SELECT topic_id FROM t), 'multiple_choice', '「あきらくんは　サッカーが　とくいです。でも、じゅうどうは　にがてです。」あきらくんが得意なのは何ですか？', 2, 14),
    ((SELECT topic_id FROM t), 'multiple_choice', '「みんなで　力を　あわせて　そうじをしました。教室が　ぴかぴかに　なりました。」みんなで何をしましたか？', 2, 15),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ゆきが　ふりました。地面が　しろく　なりました。子どもたちが　そとに　とびだしました。」子どもたちはなぜ外に出たのですか？', 2, 16),
    ((SELECT topic_id FROM t), 'multiple_choice', '「おなかが　すいたので、おやつを　食べました。」おやつを食べたのはなぜですか？', 2, 17),
    ((SELECT topic_id FROM t), 'multiple_choice', '「えみさんは　なみだを　ながしていました。きのう、だいじな　人形が　こわれてしまったからです。」えみさんが泣いているのはなぜですか？', 2, 18),
    ((SELECT topic_id FROM t), 'multiple_choice', '「虫が　葉っぱの　うらに　かくれています。なかなか　見つかりません。」虫はどこにいますか？', 2, 19),
    ((SELECT topic_id FROM t), 'multiple_choice', '「ともだちが　てつだってくれたので、はやく　しゅくだいが　おわりました。」宿題がはやく終わったのはなぜですか？', 2, 20),
    ((SELECT topic_id FROM t), 'multiple_choice', '「きのうは　どんよりとした　くもりぞらでした。今日は　ぬけるような　青空です。」今日のそらはどんなようすですか？', 2, 21),
    ((SELECT topic_id FROM t), 'multiple_choice', '「けんじくんは　「ありがとう」と　言いました。もらった人は　うれしそうに　わらいました。」もらった人はどんな気持ちですか？', 2, 22),
    ((SELECT topic_id FROM t), 'multiple_choice', '「花だんに　赤・黄色・白の　花が　さいています。いちばん多いのは　赤い花です。」花だんで一番多い花は何色ですか？', 2, 23),
    ((SELECT topic_id FROM t), 'multiple_choice', '「電車が　おくれました。だから、学校に　ちこくしてしまいました。」学校に遅刻したのはなぜですか？', 2, 24),
    ((SELECT topic_id FROM t), 'multiple_choice', '「夏休みに　おじいちゃんの　うちに　行きました。川で　魚を　つかまえました。とても　たのしかったです。」夏休みにどこへ行きましたか？', 2, 25)
  RETURNING id, "displayOrder"
)
INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
SELECT q.id, v.body, v.is_correct, v.disp
FROM q
JOIN (VALUES
  (1,  'こうえんへ行った', true, 1), (1,  'べんきょうした', false, 2), (1,  'ごはんを食べた', false, 3), (1,  'テレビを見た', false, 4),
  (2,  '寝る前', true, 1), (2,  '朝おきてから', false, 2), (2,  '学校から帰ったら', false, 3), (2,  '昼ごはんのあと', false, 4),
  (3,  '雨がふる', true, 1), (3,  '晴れる', false, 2), (3,  '雪がふる', false, 3), (3,  '風がやむ', false, 4),
  (4,  'うれしかったから', true, 1), (4,  'こわかったから', false, 2), (4,  'かなしかったから', false, 3), (4,  'おこっていたから', false, 4),
  (5,  'ゆうびんやさんが来たから', true, 1), (5,  '知らない人が来たから', false, 2), (5,  'お腹がすいたから', false, 3), (5,  '遊びたかったから', false, 4),
  (6,  'たのしみにしている', true, 1), (6,  'しんぱいしている', false, 2), (6,  'かなしんでいる', false, 3), (6,  'おこっている', false, 4),
  (7,  '2つ', true, 1), (7,  '3つ', false, 2), (7,  '4つ', false, 3), (7,  '1つ', false, 4),
  (8,  '先生がしずかにするよう言ったから', true, 1), (8,  'みんながねむかったから', false, 2), (8,  'べんきょうがはじまったから', false, 3), (8,  'チャイムがなったから', false, 4),
  (9,  '木の上', true, 1), (9,  '木の下', false, 2), (9,  'えだの上', false, 3), (9,  'にわ', false, 4),
  (10, 'にぎやかになる', true, 1), (10, 'しずかになる', false, 2), (10, '人がいなくなる', false, 3), (10, 'くらくなる', false, 4),
  (11, '7時', true, 1), (11, '6時', false, 2), (11, '8時', false, 3), (11, '9時', false, 4),
  (12, '雨がふっているから', true, 1), (12, 'つかれているから', false, 2), (12, 'ともだちがいないから', false, 3), (12, 'おなかが痛いから', false, 4),
  (13, 'うれしい・楽しい', true, 1), (13, 'かなしい', false, 2), (13, 'おこっている', false, 3), (13, 'しんぱいしている', false, 4),
  (14, 'サッカー', true, 1), (14, 'じゅうどう', false, 2), (14, '水泳', false, 3), (14, '野球', false, 4),
  (15, 'そうじ', true, 1), (15, 'べんきょう', false, 2), (15, '運動', false, 3), (15, 'ゲーム', false, 4),
  (16, '雪がふって外で遊びたかったから', true, 1), (16, 'おなかがすいたから', false, 2), (16, '学校に行くから', false, 3), (16, 'おかあさんにたのまれたから', false, 4),
  (17, 'おなかがすいたから', true, 1), (17, 'ともだちにあげるため', false, 2), (17, 'つかれたから', false, 3), (17, 'おいしそうだったから', false, 4),
  (18, '大事な人形がこわれてしまったから', true, 1), (18, 'ともだちとけんかしたから', false, 2), (18, 'テストがわるかったから', false, 3), (18, 'おなかが痛いから', false, 4),
  (19, '葉っぱのうら', true, 1), (19, '葉っぱの上', false, 2), (19, '土の中', false, 3), (19, '草の下', false, 4),
  (20, 'ともだちがてつだってくれたから', true, 1), (20, 'しゅくだいがすくなかったから', false, 2), (20, 'はやくあそびたかったから', false, 3), (20, '先生がてつだってくれたから', false, 4),
  (21, '青空で晴れている', true, 1), (21, 'くもっている', false, 2), (21, '雨がふっている', false, 3), (21, '雪がふっている', false, 4),
  (22, 'うれしい', true, 1), (22, 'かなしい', false, 2), (22, 'おこっている', false, 3), (22, 'びっくりした', false, 4),
  (23, '赤', true, 1), (23, '黄色', false, 2), (23, '白', false, 3), (23, 'ピンク', false, 4),
  (24, '電車がおくれたから', true, 1), (24, 'おきるのがおそかったから', false, 2), (24, 'みちにまよったから', false, 3), (24, 'わすれものをしたから', false, 4),
  (25, 'おじいちゃんの家', true, 1), (25, 'うみ', false, 2), (25, 'やま', false, 3), (25, 'こうえん', false, 4)
) AS v(dorder, body, is_correct, disp) ON q."displayOrder" = v.dorder;

WITH q AS (
  SELECT id, "displayOrder" FROM questions
  WHERE "topicId" = (
    SELECT topics.id FROM topics JOIN subjects ON subjects.id = topics."subjectId"
    WHERE subjects.slug = 'elem-japanese' AND topics.slug = 'reading-comp-2'
  )
)
INSERT INTO question_steps ("questionId", "stepNumber", body)
SELECT q.id, v.step, v.body
FROM q
JOIN (VALUES
  (1,  1, '「帰ってきました。かばんをおいてから、すぐに こうえんへ 行きました」とあるので、公園へ行ったことがわかります。'),
  (2,  1, '「寝る前に 本をよみます」とあるので、寝る前に読むことがわかります。'),
  (3,  1, '「もうすぐ雨がふりそう」とあるので、雨がふることが予想されます。'),
  (4,  1, '「100てんをとってとても うれしくて」とあるので、うれしいから話したことがわかります。'),
  (5,  1, '「ゆうびんやさんが来たからです」と理由が書いてあります。'),
  (6,  1, '「たのしみに しています」とあるので、楽しみにしていることがわかります。'),
  (7,  1, '5つから3つ食べると、5－3＝2つ残ります。'),
  (8,  1, '「先生が しずかにしてください と言った」のが理由です。'),
  (9,  1, '「木の上に のぼっています」とあるので、木の上にいることがわかります。'),
  (10, 1, '「公園が にぎやかに なります」とあるので、にぎやかになることがわかります。'),
  (11, 1, '「7時に 学校へ 出かけます」とあるので、7時に出かけることがわかります。'),
  (12, 1, '「あめが ふっているので」が理由です。「ので」の前が理由を表します。'),
  (13, 1, '「にっこり わらいました」は、うれしいときの表情です。'),
  (14, 1, '「サッカーが とくいです」とあるので、得意なのはサッカーです。'),
  (15, 1, '「みんなで 力を あわせて そうじをしました」とあります。'),
  (16, 1, '雪がふって地面が白くなったので、外で雪遊びをしたくて飛び出したと考えられます。'),
  (17, 1, '「おなかが すいたので」が理由です。「ので」の前が理由を表します。'),
  (18, 1, '「だいじな 人形が こわれてしまったからです」と理由が書いてあります。'),
  (19, 1, '「葉っぱの うらに かくれています」とあるので、葉っぱの裏にいることがわかります。'),
  (20, 1, '「ともだちが てつだってくれたので」が理由です。'),
  (21, 1, '「ぬけるような 青空」は、雲一つない晴れた空を表す言葉です。'),
  (22, 1, '「うれしそうに わらいました」から、うれしい気持ちがわかります。'),
  (23, 1, '「いちばん多いのは 赤い花です」とはっきり書かれています。'),
  (24, 1, '「電車が おくれました。だから、ちこくしてしまいました」と書かれています。'),
  (25, 1, '「おじいちゃんの うちに 行きました」とあるので、おじいちゃんの家へ行ったことがわかります。')
) AS v(dorder, step, body) ON q."displayOrder" = v.dorder;
