-- 小学校英語 問題データ（5〜6年）

-- ===== アルファベット（5年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-english' AND t.slug = 'alphabet'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','アルファベットで「A」の小文字はどれですか？',1,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「apple」の最初のアルファベットはどれですか？',1,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','アルファベットは全部で何文字ありますか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「B」の次のアルファベットはどれですか？',1,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「Z」の前のアルファベットはどれですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「school」という単語は何文字のアルファベットでできていますか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','大文字の「G」の小文字はどれですか？',2,7 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'A',false,1 FROM q1 UNION ALL SELECT id,'a',true,2 FROM q1 UNION ALL SELECT id,'α',false,3 FROM q1 UNION ALL SELECT id,'e',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'a',true,1 FROM q2 UNION ALL SELECT id,'p',false,2 FROM q2 UNION ALL SELECT id,'l',false,3 FROM q2 UNION ALL SELECT id,'e',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'24文字',false,1 FROM q3 UNION ALL SELECT id,'26文字',true,2 FROM q3 UNION ALL SELECT id,'28文字',false,3 FROM q3 UNION ALL SELECT id,'30文字',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'A',false,1 FROM q4 UNION ALL SELECT id,'C',true,2 FROM q4 UNION ALL SELECT id,'D',false,3 FROM q4 UNION ALL SELECT id,'E',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'X',false,1 FROM q5 UNION ALL SELECT id,'Y',true,2 FROM q5 UNION ALL SELECT id,'W',false,3 FROM q5 UNION ALL SELECT id,'V',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5文字',false,1 FROM q6 UNION ALL SELECT id,'6文字',true,2 FROM q6 UNION ALL SELECT id,'7文字',false,3 FROM q6 UNION ALL SELECT id,'4文字',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'q',false,1 FROM q7 UNION ALL SELECT id,'g',true,2 FROM q7 UNION ALL SELECT id,'p',false,3 FROM q7 UNION ALL SELECT id,'b',false,4 FROM q7),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'英語のアルファベットはA〜Zの26文字（大文字と小文字）があります。' FROM q3)
SELECT 'alphabet done';

-- ===== あいさつ・自己紹介（5年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-english' AND t.slug = 'greetings-self'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「こんにちは」を英語で言うとどれですか？',1,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「私の名前は〇〇です」を英語で言うとどれですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「ありがとう」を英語で言うとどれですか？',1,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「よろしくお願いします」を英語で言うとどれですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「さようなら」を英語で言うとどれですか？',1,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I am from Japan.」はどんな意味ですか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「How are you?」に対する返答はどれですか？',2,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「What is your name?」はどんな意味ですか？',2,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'Good morning',false,1 FROM q1 UNION ALL SELECT id,'Hello / Hi',true,2 FROM q1 UNION ALL SELECT id,'Good night',false,3 FROM q1 UNION ALL SELECT id,'Goodbye',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'I have a name.',false,1 FROM q2 UNION ALL SELECT id,'My name is ○○.',true,2 FROM q2 UNION ALL SELECT id,'I am ○○ name.',false,3 FROM q2 UNION ALL SELECT id,'Name is ○○.',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'Sorry',false,1 FROM q3 UNION ALL SELECT id,'Thank you',true,2 FROM q3 UNION ALL SELECT id,'Hello',false,3 FROM q3 UNION ALL SELECT id,'Please',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'See you.',false,1 FROM q4 UNION ALL SELECT id,'Nice to meet you.',true,2 FROM q4 UNION ALL SELECT id,'Good morning.',false,3 FROM q4 UNION ALL SELECT id,'I am fine.',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'Hello',false,1 FROM q5 UNION ALL SELECT id,'Goodbye / Bye',true,2 FROM q5 UNION ALL SELECT id,'Good morning',false,3 FROM q5 UNION ALL SELECT id,'Thank you',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'私は日本語が得意です。',false,1 FROM q6 UNION ALL SELECT id,'私は日本出身です。',true,2 FROM q6 UNION ALL SELECT id,'私は日本が好きです。',false,3 FROM q6 UNION ALL SELECT id,'日本は私の国です。',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'I am happy.',false,1 FROM q7 UNION ALL SELECT id,'I am fine, thank you.',true,2 FROM q7 UNION ALL SELECT id,'I am Japan.',false,3 FROM q7 UNION ALL SELECT id,'I am Tom.',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'あなたはどこから来ましたか？',false,1 FROM q8 UNION ALL SELECT id,'あなたのお名前は何ですか？',true,2 FROM q8 UNION ALL SELECT id,'あなたは元気ですか？',false,3 FROM q8 UNION ALL SELECT id,'あなたは何歳ですか？',false,4 FROM q8),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'「My name is ○○.」は自分の名前を伝えるときに使います。' FROM q2)
SELECT 'greetings-self done';

-- ===== 数・色・形（5年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-english' AND t.slug = 'numbers-colors'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「one, two, three, ___」の次の数はどれですか？',1,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「red」の意味はどれですか？',1,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「blue」の意味はどれですか？',1,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','10を英語で言うとどれですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「circle」の意味はどれですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「yellow」の意味はどれですか？',1,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「triangle」の意味はどれですか？',2,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「fifteen」は日本語でどれですか？',2,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'four',true,1 FROM q1 UNION ALL SELECT id,'five',false,2 FROM q1 UNION ALL SELECT id,'six',false,3 FROM q1 UNION ALL SELECT id,'seven',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'青',false,1 FROM q2 UNION ALL SELECT id,'赤',true,2 FROM q2 UNION ALL SELECT id,'緑',false,3 FROM q2 UNION ALL SELECT id,'黄色',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'赤',false,1 FROM q3 UNION ALL SELECT id,'青',true,2 FROM q3 UNION ALL SELECT id,'緑',false,3 FROM q3 UNION ALL SELECT id,'黒',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'nine',false,1 FROM q4 UNION ALL SELECT id,'ten',true,2 FROM q4 UNION ALL SELECT id,'eleven',false,3 FROM q4 UNION ALL SELECT id,'twelve',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'三角形',false,1 FROM q5 UNION ALL SELECT id,'円（丸）',true,2 FROM q5 UNION ALL SELECT id,'四角形',false,3 FROM q5 UNION ALL SELECT id,'菱形',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'緑',false,1 FROM q6 UNION ALL SELECT id,'黄色',true,2 FROM q6 UNION ALL SELECT id,'青',false,3 FROM q6 UNION ALL SELECT id,'白',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'四角形',false,1 FROM q7 UNION ALL SELECT id,'三角形',true,2 FROM q7 UNION ALL SELECT id,'円',false,3 FROM q7 UNION ALL SELECT id,'六角形',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'十三',false,1 FROM q8 UNION ALL SELECT id,'十五',true,2 FROM q8 UNION ALL SELECT id,'十七',false,3 FROM q8 UNION ALL SELECT id,'五十',false,4 FROM q8),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'one→two→three→four→five... 4番目はfourです。' FROM q1)
SELECT 'numbers-colors done';

-- ===== 基本文型（6年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-english' AND t.slug = 'basic-sentences'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I like cats.」はどんな意味ですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「Do you like soccer?」への「はい」の返答はどれですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「She plays the piano.」はどんな意味ですか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I don't like natto.」はどんな意味ですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「He is a teacher.」はどんな意味ですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「What do you want?」はどんな意味ですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「Where is the library?」はどんな意味ですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I can swim.」はどんな意味ですか？',2,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'私はネコを持っています。',false,1 FROM q1 UNION ALL SELECT id,'私はネコが好きです。',true,2 FROM q1 UNION ALL SELECT id,'ネコは私が好きです。',false,3 FROM q1 UNION ALL SELECT id,'ネコがいます。',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'No, I don''t.',false,1 FROM q2 UNION ALL SELECT id,'Yes, I do.',true,2 FROM q2 UNION ALL SELECT id,'Yes, you do.',false,3 FROM q2 UNION ALL SELECT id,'Yes, I like.',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'彼女はピアノを持っています。',false,1 FROM q3 UNION ALL SELECT id,'彼女はピアノを弾きます。',true,2 FROM q3 UNION ALL SELECT id,'ピアノは彼女が弾きます。',false,3 FROM q3 UNION ALL SELECT id,'彼女はピアノが好きです。',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'私は納豆が好きです。',false,1 FROM q4 UNION ALL SELECT id,'私は納豆が好きではありません。',true,2 FROM q4 UNION ALL SELECT id,'納豆は私が好きではありません。',false,3 FROM q4 UNION ALL SELECT id,'私は納豆を食べません。',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'彼は先生がいます。',false,1 FROM q5 UNION ALL SELECT id,'彼は先生です。',true,2 FROM q5 UNION ALL SELECT id,'先生は彼です。',false,3 FROM q5 UNION ALL SELECT id,'彼には先生がいます。',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'あなたはどこに行きたいですか？',false,1 FROM q6 UNION ALL SELECT id,'あなたは何が欲しいですか？',true,2 FROM q6 UNION ALL SELECT id,'あなたは何をしたいですか？',false,3 FROM q6 UNION ALL SELECT id,'あなたは何が好きですか？',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'図書館はどうですか？',false,1 FROM q7 UNION ALL SELECT id,'図書館はどこですか？',true,2 FROM q7 UNION ALL SELECT id,'図書館に何がありますか？',false,3 FROM q7 UNION ALL SELECT id,'図書館はいつですか？',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'私は泳いでいます。',false,1 FROM q8 UNION ALL SELECT id,'私は泳ぐことができます。',true,2 FROM q8 UNION ALL SELECT id,'私は泳ぎません。',false,3 FROM q8 UNION ALL SELECT id,'私は泳ぎたいです。',false,4 FROM q8),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'Do you like...? に対して「はい」は Yes, I do. 「いいえ」は No, I don''t. と答えます。' FROM q2),
s8  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'canは「〜できる」という意味。I can swim. ＝ 私は泳ぐことができます。' FROM q8)
SELECT 'basic-sentences done';

-- ===== できること・したいこと（6年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-english' AND t.slug = 'can-want'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I can play the guitar.」はどんな意味ですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I want to eat pizza.」はどんな意味ですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「Can you run fast?」への「はい」の答えはどれですか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I want to be a doctor.」はどんな意味ですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I can''t speak English well.」はどんな意味ですか？',3,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'私はギターがあります。',false,1 FROM q1 UNION ALL SELECT id,'私はギターを弾くことができます。',true,2 FROM q1 UNION ALL SELECT id,'私はギターが好きです。',false,3 FROM q1 UNION ALL SELECT id,'私はギターを弾きたいです。',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'私はピザを持っています。',false,1 FROM q2 UNION ALL SELECT id,'私はピザを食べたいです。',true,2 FROM q2 UNION ALL SELECT id,'私はピザを食べます。',false,3 FROM q2 UNION ALL SELECT id,'私はピザが嫌いです。',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'Yes, you can.',false,1 FROM q3 UNION ALL SELECT id,'Yes, I can.',true,2 FROM q3 UNION ALL SELECT id,'No, you can''t.',false,3 FROM q3 UNION ALL SELECT id,'I can run.',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'私は医者がいます。',false,1 FROM q4 UNION ALL SELECT id,'私は医者になりたいです。',true,2 FROM q4 UNION ALL SELECT id,'医者は私を欲しがっています。',false,3 FROM q4 UNION ALL SELECT id,'私は医者になります。',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'私は英語を上手に話します。',false,1 FROM q5 UNION ALL SELECT id,'私は英語を上手に話すことができません。',true,2 FROM q5 UNION ALL SELECT id,'私は英語が嫌いです。',false,3 FROM q5 UNION ALL SELECT id,'私は英語を話したいです。',false,4 FROM q5),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'want to + 動詞の原形で「〜したい」という意味になります。' FROM q2),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'want to be + 職業で「〜になりたい」という意味。a doctorは医者です。' FROM q4)
SELECT 'can-want done';
