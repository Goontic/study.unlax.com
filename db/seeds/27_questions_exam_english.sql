-- 高校入試対策 英語 問題データ

-- ===== 文法問題 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-english' AND t.slug = 'exam-grammar'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「私はリンゴを食べました」の英語として正しいものはどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「He ( ) soccer every day.」の空欄に入る正しい形はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I have never ( ) Mt. Fuji.」の空欄に入る正しい形はどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「This is the book ( ) I read yesterday.」の空欄に入る関係代名詞はどれですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「If it ( ) tomorrow, we will go hiking.」の空欄はどれですか？',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「This picture was ( ) by my sister.」の空欄に入る正しい形はどれですか？',4,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「She is ( ) than her brother.」の空欄に入るのはどれですか？（tall の比較級）',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「I want ( ) be a doctor.」の空欄に入るのはどれですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'I eat an apple.',false,1 FROM q1 UNION ALL SELECT id,'I ate an apple.',true,2 FROM q1 UNION ALL SELECT id,'I eating an apple.',false,3 FROM q1 UNION ALL SELECT id,'I eaten an apple.',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'play',false,1 FROM q2 UNION ALL SELECT id,'plays',true,2 FROM q2 UNION ALL SELECT id,'played',false,3 FROM q2 UNION ALL SELECT id,'playing',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'climb',false,1 FROM q3 UNION ALL SELECT id,'climbed',false,2 FROM q3 UNION ALL SELECT id,'climbs',false,3 FROM q3 UNION ALL SELECT id,'climbed',true,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'who',false,1 FROM q4 UNION ALL SELECT id,'that / which',true,2 FROM q4 UNION ALL SELECT id','where',false,3 FROM q4 UNION ALL SELECT id,'when',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'will rain',false,1 FROM q5 UNION ALL SELECT id,'rains',true,2 FROM q5 UNION ALL SELECT id','rained',false,3 FROM q5 UNION ALL SELECT id,'is raining',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'draw',false,1 FROM q6 UNION ALL SELECT id,'drawn',true,2 FROM q6 UNION ALL SELECT id','drew',false,3 FROM q6 UNION ALL SELECT id,'drawing',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'tall',false,1 FROM q7 UNION ALL SELECT id,'taller',true,2 FROM q7 UNION ALL SELECT id','tallest',false,3 FROM q7 UNION ALL SELECT id,'more tall',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'for',false,1 FROM q8 UNION ALL SELECT id,'to',true,2 FROM q8 UNION ALL SELECT id','of',false,3 FROM q8 UNION ALL SELECT id,'in',false,4 FROM q8),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'主語が3人称単数(He/She/It)で現在形のとき、動詞にsをつけます。plays。' FROM q2),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'if節（条件節）では未来のことでも現在形を使います。if it rains（もし明日雨が降れば）。' FROM q5),
s6  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'受動態：be動詞＋過去分詞。draw→drawn。was drawn by =〜によって描かれた。' FROM q6)
SELECT 'exam-grammar done';

-- ===== 時制・助動詞 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-english' AND t.slug = 'exam-tense'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「私は今、本を読んでいます」の英語はどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「あなたはここに来るべきです」の英語はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「彼は昨日、学校へ行きました」の英語はどれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「私はその映画を見たことがあります」の英語はどれですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「Can you help me?」の「can」の意味はどれですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「You must not run in the hallway.」はどんな意味ですか？',4,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','現在完了形で「継続」を表すときに使う語句はどれですか？',4,7 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'I read a book now.',false,1 FROM q1 UNION ALL SELECT id,'I am reading a book now.',true,2 FROM q1 UNION ALL SELECT id,'I reads a book.',false,3 FROM q1 UNION ALL SELECT id,'I reading a book.',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'You can come here.',false,1 FROM q2 UNION ALL SELECT id,'You should come here.',true,2 FROM q2 UNION ALL SELECT id','You will come here.',false,3 FROM q2 UNION ALL SELECT id,'You must come here.',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'He goes to school yesterday.',false,1 FROM q3 UNION ALL SELECT id,'He went to school yesterday.',true,2 FROM q3 UNION ALL SELECT id','He has gone to school yesterday.',false,3 FROM q3 UNION ALL SELECT id,'He is going to school yesterday.',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'I see the movie.',false,1 FROM q4 UNION ALL SELECT id,'I have seen the movie.',true,2 FROM q4 UNION ALL SELECT id','I saw the movie.',false,3 FROM q4 UNION ALL SELECT id,'I had seen the movie.',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'〜しなければならない',false,1 FROM q5 UNION ALL SELECT id,'〜できますか（依頼）',true,2 FROM q5 UNION ALL SELECT id','〜するべきだ',false,3 FROM q5 UNION ALL SELECT id,'〜するつもりだ',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'廊下では走ってください。',false,1 FROM q6 UNION ALL SELECT id,'廊下では走ってはいけません。',true,2 FROM q6 UNION ALL SELECT id','廊下では走らなくてもよい。',false,3 FROM q6 UNION ALL SELECT id,'廊下では走れません。',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'already/yet',false,1 FROM q7 UNION ALL SELECT id,'for/since',true,2 FROM q7 UNION ALL SELECT id','ever/never',false,3 FROM q7 UNION ALL SELECT id,'just/before',false,4 FROM q7),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'現在完了（経験）：have/has＋過去分詞。see→seenに変化。I have seen ＝ 見たことがある。' FROM q4),
s7  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'「継続」：for（〜の間）・since（〜から）を使う。例：I have lived here for 3 years.（3年間ここに住んでいる）' FROM q7)
SELECT 'exam-tense done';

-- ===== 比較 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-english' AND t.slug = 'exam-comparison'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「富士山は日本でいちばん高い山です」の英語はどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「この本はあの本よりおもしろい」の英語はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「beautiful」の最上級はどれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「He is as tall as Tom.」はどんな意味ですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「good/well」の比較級はどれですか？',4,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'Mt. Fuji is very high in Japan.',false,1 FROM q1 UNION ALL SELECT id,'Mt. Fuji is the highest mountain in Japan.',true,2 FROM q1 UNION ALL SELECT id','Mt. Fuji is highest than any mountain.',false,3 FROM q1 UNION ALL SELECT id,'Mt. Fuji is more high in Japan.',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'This book is interesting than that one.',false,1 FROM q2 UNION ALL SELECT id,'This book is more interesting than that one.',true,2 FROM q2 UNION ALL SELECT id','This book is the most interesting than that one.',false,3 FROM q2 UNION ALL SELECT id,'This book is interestinger than that one.',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'beautifulest',false,1 FROM q3 UNION ALL SELECT id,'most beautiful',true,2 FROM q3 UNION ALL SELECT id','more beautiful',false,3 FROM q3 UNION ALL SELECT id,'beautifuller',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'彼はトムより背が高い。',false,1 FROM q4 UNION ALL SELECT id,'彼はトムと同じくらい背が高い。',true,2 FROM q4 UNION ALL SELECT id','彼はトムほど背が高くない。',false,3 FROM q4 UNION ALL SELECT id,'彼はトムより背が低い。',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'gooder',false,1 FROM q5 UNION ALL SELECT id,'better',true,2 FROM q5 UNION ALL SELECT id','more good',false,3 FROM q5 UNION ALL SELECT id,'weller',false,4 FROM q5),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'最上級：the＋最上級（-est or most〜）＋in/of。Mt. Fuji is the highest in Japan.（the highestが最高級形）' FROM q1),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'「interesting」は長い形容詞なのでmore/mostを使う。比較級はmore interesting（interestingerとはならない）。' FROM q2)
SELECT 'exam-comparison done';

-- ===== 長文読解 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-english' AND t.slug = 'exam-reading-comp'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','長文読解で下線部の意味を問う問題で最初にすることはどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「He decided to study abroad because he wanted to learn English well.」の下線部「because」の意味はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「however」はどんな意味ですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「for example」はどんな意味ですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「therefore」はどんな意味ですか？',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「in other words」はどんな意味ですか？',4,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'知らない単語を辞書で全部調べる',false,1 FROM q1 UNION ALL SELECT id,'文脈（前後の流れ）から推測する',true,2 FROM q1 UNION ALL SELECT id','最後の段落だけを読む',false,3 FROM q1 UNION ALL SELECT id,'問題の選択肢から逆算する',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'しかし',false,1 FROM q2 UNION ALL SELECT id,'なぜなら〜だから',true,2 FROM q2 UNION ALL SELECT id','それで・だから',false,3 FROM q2 UNION ALL SELECT id,'その結果',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'だから・したがって',false,1 FROM q3 UNION ALL SELECT id,'しかしながら（逆接）',true,2 FROM q3 UNION ALL SELECT id','例えば',false,3 FROM q3 UNION ALL SELECT id,'また・さらに',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'その結果',false,1 FROM q4 UNION ALL SELECT id,'例えば',true,2 FROM q4 UNION ALL SELECT id','しかし',false,3 FROM q4 UNION ALL SELECT id,'言い換えると',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'例えば',false,1 FROM q5 UNION ALL SELECT id,'したがって・だから',true,2 FROM q5 UNION ALL SELECT id','しかし',false,3 FROM q5 UNION ALL SELECT id,'言い換えると',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'その他に',false,1 FROM q6 UNION ALL SELECT id,'言い換えると・つまり',true,2 FROM q6 UNION ALL SELECT id','だから',false,3 FROM q6 UNION ALL SELECT id,'例えば',false,4 FROM q6),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'長文問題では知らない単語があっても前後の文脈から意味を推測するのが基本戦略です。' FROM q1),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'because（なぜなら〜だから）は理由を示す接続詞。後ろに理由が続きます。' FROM q2)
SELECT 'exam-reading-comp done';
