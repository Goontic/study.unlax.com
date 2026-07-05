-- 小学校算数 3年生 問題データ

-- ===== わり算 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-math' AND t.slug = 'division-basic'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','12÷3はいくつですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','24÷6はいくつですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','36÷4はいくつですか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','45÷9はいくつですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','56÷7はいくつですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','17÷4の答えは何あまりいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','25÷7の答えは何あまりいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','クッキーが24まいあります。6人で等しくわけると、1人何まいになりますか？',2,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','えんぴつが35本あります。7本ずつ入れると何ふくろできますか？',2,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','63÷9はいくつですか？',2,10 FROM topic RETURNING id),
q11 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','48÷8はいくつですか？',2,11 FROM topic RETURNING id),
q12 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','20÷6の答えは何あまりいくつですか？',3,12 FROM topic RETURNING id),
q13 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','42÷6はいくつですか？',2,13 FROM topic RETURNING id),
q14 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','30÷5はいくつですか？',2,14 FROM topic RETURNING id),
q15 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','りんごが32こあります。1人に8こずつわけると、何人にわけられますか？',3,15 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3',false,1 FROM q1 UNION ALL SELECT id,'4',true,2 FROM q1 UNION ALL SELECT id,'5',false,3 FROM q1 UNION ALL SELECT id,'6',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3',false,1 FROM q2 UNION ALL SELECT id,'4',true,2 FROM q2 UNION ALL SELECT id,'5',false,3 FROM q2 UNION ALL SELECT id,'6',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'7',false,1 FROM q3 UNION ALL SELECT id,'8',false,2 FROM q3 UNION ALL SELECT id,'9',true,3 FROM q3 UNION ALL SELECT id,'10',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'4',false,1 FROM q4 UNION ALL SELECT id,'5',true,2 FROM q4 UNION ALL SELECT id,'6',false,3 FROM q4 UNION ALL SELECT id,'7',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'7',false,1 FROM q5 UNION ALL SELECT id,'8',true,2 FROM q5 UNION ALL SELECT id,'9',false,3 FROM q5 UNION ALL SELECT id,'6',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3あまり5',false,1 FROM q6 UNION ALL SELECT id,'4あまり1',true,2 FROM q6 UNION ALL SELECT id,'4あまり2',false,3 FROM q6 UNION ALL SELECT id,'5あまり3',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3あまり4',true,1 FROM q7 UNION ALL SELECT id,'3あまり6',false,2 FROM q7 UNION ALL SELECT id,'4あまり2',false,3 FROM q7 UNION ALL SELECT id,'2あまり5',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3まい',false,1 FROM q8 UNION ALL SELECT id,'4まい',true,2 FROM q8 UNION ALL SELECT id,'5まい',false,3 FROM q8 UNION ALL SELECT id,'6まい',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'4ふくろ',false,1 FROM q9 UNION ALL SELECT id,'5ふくろ',true,2 FROM q9 UNION ALL SELECT id,'6ふくろ',false,3 FROM q9 UNION ALL SELECT id,'7ふくろ',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'6',false,1 FROM q10 UNION ALL SELECT id,'7',true,2 FROM q10 UNION ALL SELECT id,'8',false,3 FROM q10 UNION ALL SELECT id,'9',false,4 FROM q10),
c11 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'5',false,1 FROM q11 UNION ALL SELECT id,'6',true,2 FROM q11 UNION ALL SELECT id,'7',false,3 FROM q11 UNION ALL SELECT id,'8',false,4 FROM q11),
c12 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3あまり2',true,1 FROM q12 UNION ALL SELECT id,'4あまり1',false,2 FROM q12 UNION ALL SELECT id,'3あまり4',false,3 FROM q12 UNION ALL SELECT id,'2あまり8',false,4 FROM q12),
c13 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'6',false,1 FROM q13 UNION ALL SELECT id,'7',true,2 FROM q13 UNION ALL SELECT id,'8',false,3 FROM q13 UNION ALL SELECT id,'5',false,4 FROM q13),
c14 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'5',false,1 FROM q14 UNION ALL SELECT id,'6',true,2 FROM q14 UNION ALL SELECT id,'7',false,3 FROM q14 UNION ALL SELECT id,'4',false,4 FROM q14),
c15 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3人',false,1 FROM q15 UNION ALL SELECT id,'4人',true,2 FROM q15 UNION ALL SELECT id,'5人',false,3 FROM q15 UNION ALL SELECT id,'6人',false,4 FROM q15),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'12÷3は九九の「3の段」で考えます。3×4＝12なので、12÷3＝4です。' FROM q1),
s6  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'4×4＝16、4×5＝20。17は16より1大きいので、17÷4＝4あまり1です。' FROM q6),
s8  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'24÷6＝4 なので1人4まいです。' FROM q8)
SELECT 'division-basic done';

-- ===== 大きな数（万） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-math' AND t.slug = 'large-numbers-3'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','3000＋700＋20＋5は何ですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「いちまんにせんさんびゃくよんじゅうご」を数字で書くとどれですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','4567の千の位の数字はいくつですか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','8000より1000大きい数はなんですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','10000は1000がいくつ集まった数ですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','5万は50000ですか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','12345の百の位の数字はいくつですか？',2,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','7890と9870を比べると、どちらが大きいですか？',2,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','3万6千は何ですか？',2,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','9999より1大きい数はなんですか？',3,10 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3725',false,1 FROM q1 UNION ALL SELECT id,'3725',false,2 FROM q1 UNION ALL SELECT id,'3725',true,3 FROM q1 UNION ALL SELECT id,'3705',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'12305',false,1 FROM q2 UNION ALL SELECT id,'12345',true,2 FROM q2 UNION ALL SELECT id,'12435',false,3 FROM q2 UNION ALL SELECT id,'12354',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3',false,1 FROM q3 UNION ALL SELECT id,'4',true,2 FROM q3 UNION ALL SELECT id,'5',false,3 FROM q3 UNION ALL SELECT id,'6',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'8100',false,1 FROM q4 UNION ALL SELECT id,'9000',true,2 FROM q4 UNION ALL SELECT id,'8010',false,3 FROM q4 UNION ALL SELECT id,'80000',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'100こ',false,1 FROM q5 UNION ALL SELECT id,'10こ',true,2 FROM q5 UNION ALL SELECT id,'1000こ',false,3 FROM q5 UNION ALL SELECT id,'5こ',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'5000',false,1 FROM q6 UNION ALL SELECT id,'50000',true,2 FROM q6 UNION ALL SELECT id,'500000',false,3 FROM q6 UNION ALL SELECT id,'500',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1',false,1 FROM q7 UNION ALL SELECT id,'3',true,2 FROM q7 UNION ALL SELECT id,'4',false,3 FROM q7 UNION ALL SELECT id,'2',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'7890',false,1 FROM q8 UNION ALL SELECT id,'9870',true,2 FROM q8 UNION ALL SELECT id,'同じ',false,3 FROM q8 UNION ALL SELECT id,'比べられない',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3600',false,1 FROM q9 UNION ALL SELECT id,'36000',true,2 FROM q9 UNION ALL SELECT id,'360000',false,3 FROM q9 UNION ALL SELECT id,'3060',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'9999',false,1 FROM q10 UNION ALL SELECT id,'10000',true,2 FROM q10 UNION ALL SELECT id,'10001',false,3 FROM q10 UNION ALL SELECT id,'9998',false,4 FROM q10),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'4567の千の位は、一番左の「4」です。' FROM q3),
s10 AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'9999に1を足すと10000（いちまん）になります。' FROM q10)
SELECT 'large-numbers-3 done';

-- ===== 分数のきほん =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-math' AND t.slug = 'fractions-intro'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1/2はどんな大きさですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1/3と1/4のどちらが大きいですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1mの3/4はいくつですか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1/4と2/4のどちらが大きいですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1/6・1/3・1/2の中で一番大きい分数はどれですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','ピザを4等分して2まいたべました。食べた量は全体の何分の何ですか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1/2と3/6は同じ大きさですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','分子と分母が同じ分数（例:3/3）はいくつに等しいですか？',3,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1/8より小さい分数はどれですか？',3,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','3/5はどんな大きさですか？',2,10 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1を3等分した1つ分',false,1 FROM q1 UNION ALL SELECT id,'1を2等分した1つ分',true,2 FROM q1 UNION ALL SELECT id,'1を4等分した1つ分',false,3 FROM q1 UNION ALL SELECT id,'2の半分',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/3',true,1 FROM q2 UNION ALL SELECT id,'1/4',false,2 FROM q2 UNION ALL SELECT id,'同じ',false,3 FROM q2 UNION ALL SELECT id,'比べられない',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'50cm',false,1 FROM q3 UNION ALL SELECT id,'75cm',true,2 FROM q3 UNION ALL SELECT id,'80cm',false,3 FROM q3 UNION ALL SELECT id,'60cm',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/4',false,1 FROM q4 UNION ALL SELECT id,'2/4',true,2 FROM q4 UNION ALL SELECT id,'同じ',false,3 FROM q4 UNION ALL SELECT id,'どちらも1より大きい',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/6',false,1 FROM q5 UNION ALL SELECT id,'1/3',false,2 FROM q5 UNION ALL SELECT id,'1/2',true,3 FROM q5 UNION ALL SELECT id,'すべて同じ',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/4',false,1 FROM q6 UNION ALL SELECT id,'2/4（1/2）',true,2 FROM q6 UNION ALL SELECT id,'3/4',false,3 FROM q6 UNION ALL SELECT id,'4/2',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'同じ',true,1 FROM q7 UNION ALL SELECT id,'1/2の方が大きい',false,2 FROM q7 UNION ALL SELECT id,'3/6の方が大きい',false,3 FROM q7 UNION ALL SELECT id,'比べられない',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'0',false,1 FROM q8 UNION ALL SELECT id,'1',true,2 FROM q8 UNION ALL SELECT id,'2',false,3 FROM q8 UNION ALL SELECT id,'分母の数',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/6',false,1 FROM q9 UNION ALL SELECT id,'1/7',false,2 FROM q9 UNION ALL SELECT id,'1/9',true,3 FROM q9 UNION ALL SELECT id,'1/8',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'5を3等分した3つ分',false,1 FROM q10 UNION ALL SELECT id,'1を5等分した3つ分',true,2 FROM q10 UNION ALL SELECT id,'3を5倍した数',false,3 FROM q10 UNION ALL SELECT id,'5を3倍した数',false,4 FROM q10),
s2  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'分母が大きいほど1つ分が小さくなります。1/3より1/4の方が1つ分が小さいので、1/3の方が大きいです。' FROM q2),
s5  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'分母が小さいほど1つ分が大きくなります。分母2→3→6の順に小さくなるので、1/2が最大です。' FROM q5)
SELECT 'fractions-intro done';

-- ===== 小数のきほん =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-math' AND t.slug = 'decimals-intro'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','0.1を5こ集めた数はいくつですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','0.5と0.3ではどちらが大きいですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1.2＋0.5はいくつですか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','2.7－0.3はいくつですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','0.8は整数のいくつに等しいですか？（10倍すると？）',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','3と0.7をたした数はいくつですか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1.5＞□のとき、□に入る最大の一位の小数（小数第1位の数）はいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','次の中で最大の数はどれですか？',2,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','2.0と2では大きさは同じですか？',2,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','0.4＋0.7はいくつですか？',3,10 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'0.15',false,1 FROM q1 UNION ALL SELECT id,'0.5',true,2 FROM q1 UNION ALL SELECT id,'5',false,3 FROM q1 UNION ALL SELECT id,'0.05',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'0.3',false,1 FROM q2 UNION ALL SELECT id,'0.5',true,2 FROM q2 UNION ALL SELECT id,'同じ',false,3 FROM q2 UNION ALL SELECT id,'比べられない',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1.5',false,1 FROM q3 UNION ALL SELECT id,'1.7',true,2 FROM q3 UNION ALL SELECT id,'1.8',false,3 FROM q3 UNION ALL SELECT id,'0.7',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2.1',false,1 FROM q4 UNION ALL SELECT id,'2.4',true,2 FROM q4 UNION ALL SELECT id,'2.5',false,3 FROM q4 UNION ALL SELECT id,'3.0',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'0.8',false,1 FROM q5 UNION ALL SELECT id,'8',true,2 FROM q5 UNION ALL SELECT id,'80',false,3 FROM q5 UNION ALL SELECT id,'0.08',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3.0',false,1 FROM q6 UNION ALL SELECT id,'3.7',true,2 FROM q6 UNION ALL SELECT id,'4.0',false,3 FROM q6 UNION ALL SELECT id,'0.37',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1.3',false,1 FROM q7 UNION ALL SELECT id,'1.4',true,2 FROM q7 UNION ALL SELECT id,'1.5',false,3 FROM q7 UNION ALL SELECT id,'1.6',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'0.9',false,1 FROM q8 UNION ALL SELECT id,'1.0',false,2 FROM q8 UNION ALL SELECT id,'1.1',true,3 FROM q8 UNION ALL SELECT id,'0.99',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'同じ',true,1 FROM q9 UNION ALL SELECT id,'2.0の方が大きい',false,2 FROM q9 UNION ALL SELECT id,'2の方が大きい',false,3 FROM q9 UNION ALL SELECT id,'どちらも0',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'0.11',false,1 FROM q10 UNION ALL SELECT id,'1.1',true,2 FROM q10 UNION ALL SELECT id,'1.01',false,3 FROM q10 UNION ALL SELECT id,'0.7',false,4 FROM q10),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'0.1が5こ → 0.1×5＝0.5 です。' FROM q1),
s10 AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'0.4＋0.7＝1.1 です。1より大きくなります。' FROM q10)
SELECT 'decimals-intro done';

-- ===== 重さ =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-math' AND t.slug = 'weight-basic'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1kg＝何gですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','3000gは何kgですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','2kg500gは何gですか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','りんご1個が350g、みかん1個が120gのとき、2つあわせると何gですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','5kg－2kg300gは何kg何gですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1500gは1kgと何gですか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','重さの単位として正しいものはどれですか？',1,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','800gと1200gではどちらが重いですか？',2,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','体重が25kg400gの人は何gですか？',2,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','4kg700g＋2kg600gは何kg何gですか？',3,10 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'100g',false,1 FROM q1 UNION ALL SELECT id,'1000g',true,2 FROM q1 UNION ALL SELECT id,'10000g',false,3 FROM q1 UNION ALL SELECT id,'500g',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'30kg',false,1 FROM q2 UNION ALL SELECT id,'3kg',true,2 FROM q2 UNION ALL SELECT id,'0.3kg',false,3 FROM q2 UNION ALL SELECT id,'300kg',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'250g',false,1 FROM q3 UNION ALL SELECT id,'2500g',true,2 FROM q3 UNION ALL SELECT id,'25000g',false,3 FROM q3 UNION ALL SELECT id,'2005g',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'370g',false,1 FROM q4 UNION ALL SELECT id,'470g',true,2 FROM q4 UNION ALL SELECT id,'480g',false,3 FROM q4 UNION ALL SELECT id,'460g',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2kg500g',false,1 FROM q5 UNION ALL SELECT id,'2kg700g',true,2 FROM q5 UNION ALL SELECT id,'3kg300g',false,3 FROM q5 UNION ALL SELECT id,'2kg300g',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1kgと150g',false,1 FROM q6 UNION ALL SELECT id,'1kgと500g',true,2 FROM q6 UNION ALL SELECT id,'1kgと50g',false,3 FROM q6 UNION ALL SELECT id,'0kgと1500g',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'cm',false,1 FROM q7 UNION ALL SELECT id,'L',false,2 FROM q7 UNION ALL SELECT id,'g・kg',true,3 FROM q7 UNION ALL SELECT id,'℃',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'800g',false,1 FROM q8 UNION ALL SELECT id,'1200g',true,2 FROM q8 UNION ALL SELECT id,'同じ',false,3 FROM q8 UNION ALL SELECT id,'比べられない',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2540g',false,1 FROM q9 UNION ALL SELECT id,'25400g',true,2 FROM q9 UNION ALL SELECT id,'254g',false,3 FROM q9 UNION ALL SELECT id,'2504g',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'6kg300g',false,1 FROM q10 UNION ALL SELECT id,'7kg300g',true,2 FROM q10 UNION ALL SELECT id,'7kg200g',false,3 FROM q10 UNION ALL SELECT id,'6kg700g',false,4 FROM q10),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'2kg500g ＝ 2000g＋500g＝2500gです。' FROM q3),
s10 AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'700g＋600g＝1300g＝1kg300g。4kg＋2kg＋1kg＝7kg。答えは7kg300gです。' FROM q10)
SELECT 'weight-basic done';

-- ===== 時間の計算 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-math' AND t.slug = 'time-calc'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','午前10時30分の1時間後は何時何分ですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','午後2時から午後5時まで何時間ですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1時間45分＋30分は何時間何分ですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','2時間20分－50分は何時間何分ですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1分＝何秒ですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','3時間＝何分ですか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','午前9時15分から40分たつと何時何分ですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','180分は何時間ですか？',2,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1時間10分は何分ですか？',2,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','授業が午前8時45分に始まり、45分後に終わりました。終わりは何時何分ですか？',3,10 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'午前11時20分',false,1 FROM q1 UNION ALL SELECT id,'午前11時30分',true,2 FROM q1 UNION ALL SELECT id,'午後11時30分',false,3 FROM q1 UNION ALL SELECT id,'午前10時60分',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2時間',false,1 FROM q2 UNION ALL SELECT id,'3時間',true,2 FROM q2 UNION ALL SELECT id,'4時間',false,3 FROM q2 UNION ALL SELECT id,'7時間',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1時間55分',false,1 FROM q3 UNION ALL SELECT id,'2時間15分',true,2 FROM q3 UNION ALL SELECT id,'2時間20分',false,3 FROM q3 UNION ALL SELECT id,'1時間75分',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1時間30分',true,1 FROM q4 UNION ALL SELECT id,'1時間40分',false,2 FROM q4 UNION ALL SELECT id,'2時間10分',false,3 FROM q4 UNION ALL SELECT id,'1時間20分',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'10秒',false,1 FROM q5 UNION ALL SELECT id,'60秒',true,2 FROM q5 UNION ALL SELECT id,'100秒',false,3 FROM q5 UNION ALL SELECT id,'24秒',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'30分',false,1 FROM q6 UNION ALL SELECT id,'180分',true,2 FROM q6 UNION ALL SELECT id,'300分',false,3 FROM q6 UNION ALL SELECT id,'1800分',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'午前9時50分',false,1 FROM q7 UNION ALL SELECT id,'午前9時55分',true,2 FROM q7 UNION ALL SELECT id,'午前10時',false,3 FROM q7 UNION ALL SELECT id,'午前9時45分',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1時間',false,1 FROM q8 UNION ALL SELECT id,'3時間',true,2 FROM q8 UNION ALL SELECT id,'18時間',false,3 FROM q8 UNION ALL SELECT id,'30時間',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'60分',false,1 FROM q9 UNION ALL SELECT id,'70分',true,2 FROM q9 UNION ALL SELECT id,'110分',false,3 FROM q9 UNION ALL SELECT id,'11分',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'午前9時30分',true,1 FROM q10 UNION ALL SELECT id,'午前9時25分',false,2 FROM q10 UNION ALL SELECT id,'午前9時45分',false,3 FROM q10 UNION ALL SELECT id,'午前9時50分',false,4 FROM q10),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'1時間45分＋30分＝1時間75分＝2時間15分です（60分＝1時間）。' FROM q3),
s4  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'2時間20分を1時間80分に直してから50分ひきます。1時間80分－50分＝1時間30分。' FROM q4),
s10 AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'8時45分＋45分＝8時90分＝9時30分です。' FROM q10)
SELECT 'time-calc done';
