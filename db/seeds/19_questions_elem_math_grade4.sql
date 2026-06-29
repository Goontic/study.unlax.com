-- 小学校算数 4年生 問題データ

-- ===== 大きな数（億・兆） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'large-numbers-4'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1億は1万がいくつ集まった数ですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1兆は1億がいくつ集まった数ですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「にひゃくさんじゅうよんおくごせんまん」を数字で表すとどれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','56億7000万を数字で表すとどれですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3000億と5000億では、どちらが大きいですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','10000000000（100億）は10の何乗ですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1億より1000万少ない数はなんですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の人口は約何人ですか？（億の位で）',2,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'100こ',false,1 FROM q1 UNION ALL SELECT id,'10000こ',true,2 FROM q1 UNION ALL SELECT id,'1000こ',false,3 FROM q1 UNION ALL SELECT id,'100000こ',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'100こ',false,1 FROM q2 UNION ALL SELECT id,'10000こ',false,2 FROM q2 UNION ALL SELECT id,'1000こ',false,3 FROM q2 UNION ALL SELECT id,'10こ',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'23405000000',false,1 FROM q3 UNION ALL SELECT id,'23450000000',true,2 FROM q3 UNION ALL SELECT id,'234500000',false,3 FROM q3 UNION ALL SELECT id,'23405000',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5670000000',false,1 FROM q4 UNION ALL SELECT id,'56700000000',false,2 FROM q4 UNION ALL SELECT id,'5,670,000,000',false,3 FROM q4 UNION ALL SELECT id,'56700000000',true,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'3000億',false,1 FROM q5 UNION ALL SELECT id,'5000億',true,2 FROM q5 UNION ALL SELECT id,'同じ',false,3 FROM q5 UNION ALL SELECT id,'比べられない',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'9乗',false,1 FROM q6 UNION ALL SELECT id,'10乗',true,2 FROM q6 UNION ALL SELECT id,'11乗',false,3 FROM q6 UNION ALL SELECT id,'8乗',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'8000万',false,1 FROM q7 UNION ALL SELECT id,'9000万',true,2 FROM q7 UNION ALL SELECT id,'1億1000万',false,3 FROM q7 UNION ALL SELECT id,'1億1000',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'約1億',false,1 FROM q8 UNION ALL SELECT id,'約1億2000万',true,2 FROM q8 UNION ALL SELECT id,'約2億',false,3 FROM q8 UNION ALL SELECT id,'約5000万',false,4 FROM q8),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'1万×10000＝1億。1億は1万の10000倍です。' FROM q1),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'1兆＝1000000000000（12桁）。1億が1000×10＝10000こで1兆になります。' FROM q2)
SELECT 'large-numbers-4 done';

-- ===== 小数の計算 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'decimals-calc'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3.5＋2.4はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','7.8－3.6はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','5.2＋1.9はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','8.0－3.5はいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1.6×3はいくつですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','2.5×4はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','0.6＋0.7はいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','リボンが2.4mあります。0.7m使いました。のこりは何mですか？',3,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3.2＋4.8はいくつですか？',3,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1.5×6はいくつですか？',3,10 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5.8',false,1 FROM q1 UNION ALL SELECT id,'5.9',true,2 FROM q1 UNION ALL SELECT id,'6.0',false,3 FROM q1 UNION ALL SELECT id,'5.7',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'4.1',false,1 FROM q2 UNION ALL SELECT id,'4.2',true,2 FROM q2 UNION ALL SELECT id,'4.3',false,3 FROM q2 UNION ALL SELECT id,'3.2',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'6.9',false,1 FROM q3 UNION ALL SELECT id,'7.1',true,2 FROM q3 UNION ALL SELECT id,'7.2',false,3 FROM q3 UNION ALL SELECT id,'6.1',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'4.0',false,1 FROM q4 UNION ALL SELECT id,'4.5',true,2 FROM q4 UNION ALL SELECT id,'5.5',false,3 FROM q4 UNION ALL SELECT id,'4.4',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'4.6',false,1 FROM q5 UNION ALL SELECT id,'4.8',true,2 FROM q5 UNION ALL SELECT id,'5.0',false,3 FROM q5 UNION ALL SELECT id,'4.2',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'9.0',false,1 FROM q6 UNION ALL SELECT id,'10.0',true,2 FROM q6 UNION ALL SELECT id,'11.0',false,3 FROM q6 UNION ALL SELECT id,'8.5',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1.1',false,1 FROM q7 UNION ALL SELECT id,'1.3',true,2 FROM q7 UNION ALL SELECT id,'1.2',false,3 FROM q7 UNION ALL SELECT id,'0.13',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1.5m',false,1 FROM q8 UNION ALL SELECT id,'1.7m',true,2 FROM q8 UNION ALL SELECT id,'1.6m',false,3 FROM q8 UNION ALL SELECT id,'2.1m',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'7.8',false,1 FROM q9 UNION ALL SELECT id,'8.0',true,2 FROM q9 UNION ALL SELECT id,'8.2',false,3 FROM q9 UNION ALL SELECT id,'7.0',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'8.0',false,1 FROM q10 UNION ALL SELECT id,'9.0',true,2 FROM q10 UNION ALL SELECT id,'10.0',false,3 FROM q10 UNION ALL SELECT id,'7.5',false,4 FROM q10),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'1.6×3＝4.8。小数点は積の1桁目に付けます。' FROM q5),
s9  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'3.2＋4.8＝8.0。小数点をそろえて計算します。' FROM q9)
SELECT 'decimals-calc done';

-- ===== 分数の計算（4年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'fractions-calc-4'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1/4＋2/4はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','5/6－2/6はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3/5＋4/5はいくつですか？（仮分数でもよい）',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','7/4を帯分数に直すとどれですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','2と1/3を仮分数に直すとどれですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1と1/2＋1と1/2はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','4/8を約分するとどれですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3/4と2/4ではどちらが大きいですか？',2,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2/4',false,1 FROM q1 UNION ALL SELECT id,'3/4',true,2 FROM q1 UNION ALL SELECT id,'3/8',false,3 FROM q1 UNION ALL SELECT id,'4/4',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2/6',false,1 FROM q2 UNION ALL SELECT id,'3/6',true,2 FROM q2 UNION ALL SELECT id,'7/6',false,3 FROM q2 UNION ALL SELECT id,'1/2',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1と1/5',false,1 FROM q3 UNION ALL SELECT id,'7/5',true,2 FROM q3 UNION ALL SELECT id,'7/10',false,3 FROM q3 UNION ALL SELECT id,'12/5',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1と2/4',false,1 FROM q4 UNION ALL SELECT id,'1と3/4',true,2 FROM q4 UNION ALL SELECT id,'2と1/4',false,3 FROM q4 UNION ALL SELECT id,'1と1/2',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5/3',false,1 FROM q5 UNION ALL SELECT id,'6/3',false,2 FROM q5 UNION ALL SELECT id,'7/3',true,3 FROM q5 UNION ALL SELECT id,'8/3',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2と1/2',false,1 FROM q6 UNION ALL SELECT id,'3',true,2 FROM q6 UNION ALL SELECT id,'2と2/2',false,3 FROM q6 UNION ALL SELECT id,'4',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2/4',false,1 FROM q7 UNION ALL SELECT id,'1/2',true,2 FROM q7 UNION ALL SELECT id,'2/8',false,3 FROM q7 UNION ALL SELECT id,'4/8',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2/4',false,1 FROM q8 UNION ALL SELECT id,'3/4',true,2 FROM q8 UNION ALL SELECT id,'同じ',false,3 FROM q8 UNION ALL SELECT id,'比べられない',false,4 FROM q8),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'7÷4＝1あまり3なので、7/4＝1と3/4（1と4分の3）です。' FROM q4),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'2と1/3 → 分母3×整数2＋分子1＝7 → 7/3です。' FROM q5)
SELECT 'fractions-calc-4 done';

-- ===== 面積 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'area-basic'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','縦3cm、横5cmの長方形の面積はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','一辺が6cmの正方形の面積はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1m²は何cm²ですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','面積が24cm²で縦が4cmの長方形の横は何cmですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1a（アール）は何m²ですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','縦8cm、横7cmの長方形の面積はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','50000cm²は何m²ですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','一辺が10cmの正方形の面積は何cm²ですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'8cm²',false,1 FROM q1 UNION ALL SELECT id,'15cm²',true,2 FROM q1 UNION ALL SELECT id,'16cm²',false,3 FROM q1 UNION ALL SELECT id,'30cm²',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'12cm²',false,1 FROM q2 UNION ALL SELECT id,'24cm²',false,2 FROM q2 UNION ALL SELECT id,'36cm²',true,3 FROM q2 UNION ALL SELECT id,'48cm²',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'100cm²',false,1 FROM q3 UNION ALL SELECT id,'1000cm²',false,2 FROM q3 UNION ALL SELECT id,'10000cm²',true,3 FROM q3 UNION ALL SELECT id,'100000cm²',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5cm',false,1 FROM q4 UNION ALL SELECT id,'6cm',true,2 FROM q4 UNION ALL SELECT id,'8cm',false,3 FROM q4 UNION ALL SELECT id,'4cm',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'10m²',false,1 FROM q5 UNION ALL SELECT id,'100m²',true,2 FROM q5 UNION ALL SELECT id,'1000m²',false,3 FROM q5 UNION ALL SELECT id,'10000m²',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'56cm²',true,1 FROM q6 UNION ALL SELECT id,'30cm²',false,2 FROM q6 UNION ALL SELECT id,'64cm²',false,3 FROM q6 UNION ALL SELECT id,'50cm²',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'0.5m²',false,1 FROM q7 UNION ALL SELECT id,'5m²',true,2 FROM q7 UNION ALL SELECT id,'50m²',false,3 FROM q7 UNION ALL SELECT id,'500m²',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'40cm²',false,1 FROM q8 UNION ALL SELECT id,'100cm²',true,2 FROM q8 UNION ALL SELECT id,'1000cm²',false,3 FROM q8 UNION ALL SELECT id,'20cm²',false,4 FROM q8),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'長方形の面積＝縦×横 ＝ 3×5 ＝ 15cm²です。' FROM q1),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'1m＝100cm なので、1m²＝100cm×100cm＝10000cm²です。' FROM q3),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'面積＝縦×横 → 横＝面積÷縦＝24÷4＝6cmです。' FROM q4)
SELECT 'area-basic done';

-- ===== 角とその大きさ =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'angles-geometry'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','直角は何度ですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','三角形の3つの角の和は何度ですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','四角形の4つの角の和は何度ですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','三角形の2つの角が45°と75°のとき、残りの角は何度ですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','正三角形の1つの角は何度ですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','180°の角はどんな形ですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','長方形の1つの角は何度ですか？',2,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','四角形の3つの角が90°・80°・70°のとき、残りの角は何度ですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'45°',false,1 FROM q1 UNION ALL SELECT id,'90°',true,2 FROM q1 UNION ALL SELECT id,'180°',false,3 FROM q1 UNION ALL SELECT id,'60°',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'90°',false,1 FROM q2 UNION ALL SELECT id,'180°',true,2 FROM q2 UNION ALL SELECT id,'270°',false,3 FROM q2 UNION ALL SELECT id,'360°',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'270°',false,1 FROM q3 UNION ALL SELECT id,'360°',true,2 FROM q3 UNION ALL SELECT id,'180°',false,3 FROM q3 UNION ALL SELECT id,'540°',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'50°',false,1 FROM q4 UNION ALL SELECT id,'60°',true,2 FROM q4 UNION ALL SELECT id,'70°',false,3 FROM q4 UNION ALL SELECT id,'80°',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'45°',false,1 FROM q5 UNION ALL SELECT id,'60°',true,2 FROM q5 UNION ALL SELECT id,'90°',false,3 FROM q5 UNION ALL SELECT id,'120°',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'直角',false,1 FROM q6 UNION ALL SELECT id,'一直線',true,2 FROM q6 UNION ALL SELECT id,'鋭角',false,3 FROM q6 UNION ALL SELECT id,'鈍角',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'45°',false,1 FROM q7 UNION ALL SELECT id,'90°',true,2 FROM q7 UNION ALL SELECT id,'60°',false,3 FROM q7 UNION ALL SELECT id,'120°',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'100°',false,1 FROM q8 UNION ALL SELECT id,'120°',true,2 FROM q8 UNION ALL SELECT id,'130°',false,3 FROM q8 UNION ALL SELECT id,'110°',false,4 FROM q8),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'三角形の内角の和は必ず180°になります。' FROM q2),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'180°－45°－75°＝60°です。' FROM q4),
s8  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'360°－90°－80°－70°＝120°です。' FROM q8)
SELECT 'angles-geometry done';

-- ===== わり算の筆算 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'division-calc'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','72÷6はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','95÷5はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','132÷4はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','216÷6はいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','186÷3はいくつですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','84÷7はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','96÷8はいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','248÷8はいくつですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'11',false,1 FROM q1 UNION ALL SELECT id,'12',true,2 FROM q1 UNION ALL SELECT id,'13',false,3 FROM q1 UNION ALL SELECT id,'14',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'17',false,1 FROM q2 UNION ALL SELECT id,'18',false,2 FROM q2 UNION ALL SELECT id,'19',true,3 FROM q2 UNION ALL SELECT id,'20',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'31',false,1 FROM q3 UNION ALL SELECT id,'33',true,2 FROM q3 UNION ALL SELECT id,'34',false,3 FROM q3 UNION ALL SELECT id,'32',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'34',false,1 FROM q4 UNION ALL SELECT id,'36',true,2 FROM q4 UNION ALL SELECT id,'38',false,3 FROM q4 UNION ALL SELECT id,'32',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'61',false,1 FROM q5 UNION ALL SELECT id,'62',true,2 FROM q5 UNION ALL SELECT id,'63',false,3 FROM q5 UNION ALL SELECT id,'60',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'11',false,1 FROM q6 UNION ALL SELECT id,'12',true,2 FROM q6 UNION ALL SELECT id,'13',false,3 FROM q6 UNION ALL SELECT id,'14',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'11',false,1 FROM q7 UNION ALL SELECT id,'12',true,2 FROM q7 UNION ALL SELECT id,'13',false,3 FROM q7 UNION ALL SELECT id,'10',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'29',false,1 FROM q8 UNION ALL SELECT id,'31',true,2 FROM q8 UNION ALL SELECT id,'32',false,3 FROM q8 UNION ALL SELECT id,'30',false,4 FROM q8),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'132÷4：100÷4＝25、32÷4＝8。25＋8＝33です。' FROM q3),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'186÷3：180÷3＝60、6÷3＝2。60＋2＝62です。' FROM q5)
SELECT 'division-calc done';
