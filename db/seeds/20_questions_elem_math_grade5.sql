-- 小学校算数 5年生 問題データ

-- ===== 分数のかけ算・わり算 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'fractions-mult-div'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','2/3×3/4はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','5/6÷5/3はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3/4×8はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','4/5÷2はいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1/2×1/3はいくつですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','6/7÷3/7はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','2/3×3はいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3/5÷6/5はいくつですか？',3,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','4/9×3/2はいくつですか？',3,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','分数のわり算をするとき、わる数はどうしますか？',3,10 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5/12',false,1 FROM q1 UNION ALL SELECT id,'1/2',true,2 FROM q1 UNION ALL SELECT id,'3/7',false,3 FROM q1 UNION ALL SELECT id,'6/7',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'25/18',false,1 FROM q2 UNION ALL SELECT id,'1/2',true,2 FROM q2 UNION ALL SELECT id,'2/3',false,3 FROM q2 UNION ALL SELECT id,'5/18',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5',false,1 FROM q3 UNION ALL SELECT id,'6',true,2 FROM q3 UNION ALL SELECT id,'4',false,3 FROM q3 UNION ALL SELECT id,'7',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'8/5',false,1 FROM q4 UNION ALL SELECT id,'2/5',true,2 FROM q4 UNION ALL SELECT id,'4/10',false,3 FROM q4 UNION ALL SELECT id,'1/5',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2/6',false,1 FROM q5 UNION ALL SELECT id,'1/6',true,2 FROM q5 UNION ALL SELECT id,'1/5',false,3 FROM q5 UNION ALL SELECT id,'1/3',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'18/49',false,1 FROM q6 UNION ALL SELECT id,'2',true,2 FROM q6 UNION ALL SELECT id,'1/2',false,3 FROM q6 UNION ALL SELECT id,'3/7',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1',false,1 FROM q7 UNION ALL SELECT id,'2',true,2 FROM q7 UNION ALL SELECT id,'3/2',false,3 FROM q7 UNION ALL SELECT id,'6/3',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'18/25',false,1 FROM q8 UNION ALL SELECT id,'1/2',true,2 FROM q8 UNION ALL SELECT id,'5/18',false,3 FROM q8 UNION ALL SELECT id,'3/25',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'7/18',false,1 FROM q9 UNION ALL SELECT id,'2/3',true,2 FROM q9 UNION ALL SELECT id,'12/18',false,3 FROM q9 UNION ALL SELECT id,'8/27',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'そのままかける',false,1 FROM q10 UNION ALL SELECT id,'逆数をかける',true,2 FROM q10 UNION ALL SELECT id,'分母だけかける',false,3 FROM q10 UNION ALL SELECT id,'分子だけかける',false,4 FROM q10),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'2/3×3/4＝(2×3)/(3×4)＝6/12＝1/2です。' FROM q1),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'5/6÷5/3＝5/6×3/5＝15/30＝1/2です。' FROM q2),
s6  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'6/7÷3/7＝6/7×7/3＝42/21＝2です。' FROM q6),
s10 AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'分数のわり算はわる数の逆数（分子と分母をひっくり返した数）をかけます。' FROM q10)
SELECT 'fractions-mult-div done';

-- ===== 小数のかけ算・わり算 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'decimals-mult-div'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','2.5×4はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1.8×3はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','7.2÷4はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','6.3÷2.1はいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','0.4×0.8はいくつですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3.6÷0.9はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1mあたり2.5kgの棒が3.2mあります。全部で何kgですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','0.12×5はいくつですか？',3,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','5.4÷1.8はいくつですか？',3,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','2.4×1.5はいくつですか？',3,10 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'8',false,1 FROM q1 UNION ALL SELECT id,'10',true,2 FROM q1 UNION ALL SELECT id,'12',false,3 FROM q1 UNION ALL SELECT id,'9',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'4.8',false,1 FROM q2 UNION ALL SELECT id,'5.4',true,2 FROM q2 UNION ALL SELECT id,'5.8',false,3 FROM q2 UNION ALL SELECT id,'4.4',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1.6',false,1 FROM q3 UNION ALL SELECT id,'1.8',true,2 FROM q3 UNION ALL SELECT id,'2.0',false,3 FROM q3 UNION ALL SELECT id,'1.4',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2',false,1 FROM q4 UNION ALL SELECT id,'3',true,2 FROM q4 UNION ALL SELECT id,'4',false,3 FROM q4 UNION ALL SELECT id,'3.3',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'0.28',false,1 FROM q5 UNION ALL SELECT id,'0.32',true,2 FROM q5 UNION ALL SELECT id,'3.2',false,3 FROM q5 UNION ALL SELECT id,'0.40',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'3',false,1 FROM q6 UNION ALL SELECT id,'4',true,2 FROM q6 UNION ALL SELECT id,'5',false,3 FROM q6 UNION ALL SELECT id,'4.5',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'6.5kg',false,1 FROM q7 UNION ALL SELECT id,'8.0kg',true,2 FROM q7 UNION ALL SELECT id,'7.8kg',false,3 FROM q7 UNION ALL SELECT id,'7.0kg',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'0.55',false,1 FROM q8 UNION ALL SELECT id,'0.60',true,2 FROM q8 UNION ALL SELECT id,'0.65',false,3 FROM q8 UNION ALL SELECT id,'0.50',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2',false,1 FROM q9 UNION ALL SELECT id,'3',true,2 FROM q9 UNION ALL SELECT id,'4',false,3 FROM q9 UNION ALL SELECT id,'2.5',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'3.2',false,1 FROM q10 UNION ALL SELECT id,'3.6',true,2 FROM q10 UNION ALL SELECT id,'4.0',false,3 FROM q10 UNION ALL SELECT id,'2.8',false,4 FROM q10),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'0.4×0.8：整数になおすと4×8＝32。小数点は2桁分左→0.32です。' FROM q5),
s7  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'2.5×3.2＝8.0kgです。' FROM q7)
SELECT 'decimals-mult-div done';

-- ===== 割合・百分率 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'ratio-percentage'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','50%を小数で表すとどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','0.25を百分率（%）で表すとどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','100人の40%は何人ですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','60人が全体の75%のとき、全体は何人ですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','定価1000円の商品が20%引きで売られています。売値は何円ですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','割合を求める公式はどれですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','ある学校の生徒200人のうち、女子が90人います。女子の割合は何%ですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1割5分は何%ですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5',false,1 FROM q1 UNION ALL SELECT id,'0.5',true,2 FROM q1 UNION ALL SELECT id,'0.05',false,3 FROM q1 UNION ALL SELECT id,'50',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2.5%',false,1 FROM q2 UNION ALL SELECT id,'25%',true,2 FROM q2 UNION ALL SELECT id,'250%',false,3 FROM q2 UNION ALL SELECT id,'0.25%',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'30人',false,1 FROM q3 UNION ALL SELECT id,'40人',true,2 FROM q3 UNION ALL SELECT id,'50人',false,3 FROM q3 UNION ALL SELECT id,'60人',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'70人',false,1 FROM q4 UNION ALL SELECT id,'80人',true,2 FROM q4 UNION ALL SELECT id,'90人',false,3 FROM q4 UNION ALL SELECT id,'75人',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'700円',false,1 FROM q5 UNION ALL SELECT id,'800円',true,2 FROM q5 UNION ALL SELECT id,'850円',false,3 FROM q5 UNION ALL SELECT id,'900円',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'割合＝全体×部分',false,1 FROM q6 UNION ALL SELECT id,'割合＝部分÷全体',true,2 FROM q6 UNION ALL SELECT id,'割合＝全体÷部分',false,3 FROM q6 UNION ALL SELECT id,'割合＝部分＋全体',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'40%',false,1 FROM q7 UNION ALL SELECT id,'45%',true,2 FROM q7 UNION ALL SELECT id,'50%',false,3 FROM q7 UNION ALL SELECT id,'55%',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1.5%',false,1 FROM q8 UNION ALL SELECT id,'15%',true,2 FROM q8 UNION ALL SELECT id,'150%',false,3 FROM q8 UNION ALL SELECT id,'0.15%',false,4 FROM q8),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'100人×0.4＝40人。（40%＝0.4）' FROM q3),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'全体＝部分÷割合＝60÷0.75＝80人です。' FROM q4),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'20%引き→80%の値段。1000×0.8＝800円です。' FROM q5),
s8  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'1割＝10%、1分＝1%なので、1割5分＝15%です。' FROM q8)
SELECT 'ratio-percentage done';

-- ===== 速さ =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'speed-basics'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','60kmを2時間で走りました。時速は何kmですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','時速80kmで3時間走りました。何km進みましたか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','時速60kmで120km進むには何時間かかりますか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','分速200mで走っています。1時間に何km進みますか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','秒速5mは分速何mですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','速さ・時間・距離の関係式として正しいものはどれですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','時速36kmは秒速何mですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','Aは時速4km、Bは時速6kmで同じ方向に歩いています。1時間後の差は何kmですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'20km',false,1 FROM q1 UNION ALL SELECT id,'30km',true,2 FROM q1 UNION ALL SELECT id,'40km',false,3 FROM q1 UNION ALL SELECT id,'120km',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'160km',false,1 FROM q2 UNION ALL SELECT id,'240km',true,2 FROM q2 UNION ALL SELECT id,'280km',false,3 FROM q2 UNION ALL SELECT id,'200km',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1時間',false,1 FROM q3 UNION ALL SELECT id,'2時間',true,2 FROM q3 UNION ALL SELECT id,'3時間',false,3 FROM q3 UNION ALL SELECT id,'4時間',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'10km',false,1 FROM q4 UNION ALL SELECT id,'12km',true,2 FROM q4 UNION ALL SELECT id,'15km',false,3 FROM q4 UNION ALL SELECT id,'20km',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'50m',false,1 FROM q5 UNION ALL SELECT id,'300m',true,2 FROM q5 UNION ALL SELECT id,'500m',false,3 FROM q5 UNION ALL SELECT id,'3000m',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'速さ＝距離＋時間',false,1 FROM q6 UNION ALL SELECT id,'距離＝速さ×時間',true,2 FROM q6 UNION ALL SELECT id,'時間＝速さ×距離',false,3 FROM q6 UNION ALL SELECT id,'速さ＝距離×時間',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5m',false,1 FROM q7 UNION ALL SELECT id,'10m',true,2 FROM q7 UNION ALL SELECT id,'15m',false,3 FROM q7 UNION ALL SELECT id,'20m',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1km',false,1 FROM q8 UNION ALL SELECT id,'2km',true,2 FROM q8 UNION ALL SELECT id,'3km',false,3 FROM q8 UNION ALL SELECT id,'10km',false,4 FROM q8),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'速さ＝距離÷時間＝60÷2＝30km/hです。' FROM q1),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'分速200m×60分＝12000m＝12kmです。' FROM q4),
s7  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'36000m÷3600秒＝10m/sです。' FROM q7)
SELECT 'speed-basics done';

-- ===== 三角形・四角形の面積 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'area-shapes'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','底辺6cm、高さ4cmの三角形の面積はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','底辺8cm、高さ5cmの平行四辺形の面積はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','対角線が6cmと8cmのひし形の面積はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','上底5cm、下底7cm、高さ4cmの台形の面積はいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','三角形の面積の公式はどれですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','底辺10cm、高さ9cmの三角形の面積はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','対角線が10cmと12cmのひし形の面積はいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','底辺7cm、高さ6cmの平行四辺形の面積はいくつですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'10cm²',false,1 FROM q1 UNION ALL SELECT id,'12cm²',true,2 FROM q1 UNION ALL SELECT id,'24cm²',false,3 FROM q1 UNION ALL SELECT id,'16cm²',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'32cm²',false,1 FROM q2 UNION ALL SELECT id,'40cm²',true,2 FROM q2 UNION ALL SELECT id,'45cm²',false,3 FROM q2 UNION ALL SELECT id,'35cm²',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'14cm²',false,1 FROM q3 UNION ALL SELECT id,'24cm²',true,2 FROM q3 UNION ALL SELECT id,'48cm²',false,3 FROM q3 UNION ALL SELECT id,'28cm²',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'20cm²',false,1 FROM q4 UNION ALL SELECT id,'24cm²',true,2 FROM q4 UNION ALL SELECT id,'28cm²',false,3 FROM q4 UNION ALL SELECT id,'30cm²',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'底辺×高さ',false,1 FROM q5 UNION ALL SELECT id,'底辺×高さ÷2',true,2 FROM q5 UNION ALL SELECT id,'底辺×底辺÷2',false,3 FROM q5 UNION ALL SELECT id,'底辺＋高さ÷2',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'40cm²',false,1 FROM q6 UNION ALL SELECT id,'45cm²',true,2 FROM q6 UNION ALL SELECT id,'50cm²',false,3 FROM q6 UNION ALL SELECT id,'90cm²',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'50cm²',false,1 FROM q7 UNION ALL SELECT id,'60cm²',true,2 FROM q7 UNION ALL SELECT id,'120cm²',false,3 FROM q7 UNION ALL SELECT id,'70cm²',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'36cm²',false,1 FROM q8 UNION ALL SELECT id,'42cm²',true,2 FROM q8 UNION ALL SELECT id,'48cm²',false,3 FROM q8 UNION ALL SELECT id,'30cm²',false,4 FROM q8),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'三角形の面積＝底辺×高さ÷2＝6×4÷2＝12cm²です。' FROM q1),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'ひし形の面積＝対角線×対角線÷2＝6×8÷2＝24cm²です。' FROM q3),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'台形の面積＝(上底＋下底)×高さ÷2＝(5＋7)×4÷2＝24cm²です。' FROM q4)
SELECT 'area-shapes done';

-- ===== 体積 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'volume-3d'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','縦3cm、横4cm、高さ5cmの直方体の体積はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','一辺が4cmの立方体の体積はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1L（リットル）は何cm³ですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','体積が120cm³で底面積が20cm²の直方体の高さはいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1m³は何cm³ですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','縦5cm、横6cm、高さ7cmの直方体の体積はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','一辺が5cmの立方体の体積はいくつですか？',3,7 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'40cm³',false,1 FROM q1 UNION ALL SELECT id,'60cm³',true,2 FROM q1 UNION ALL SELECT id,'80cm³',false,3 FROM q1 UNION ALL SELECT id,'70cm³',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'12cm³',false,1 FROM q2 UNION ALL SELECT id,'64cm³',true,2 FROM q2 UNION ALL SELECT id,'16cm³',false,3 FROM q2 UNION ALL SELECT id,'48cm³',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'100cm³',false,1 FROM q3 UNION ALL SELECT id,'1000cm³',true,2 FROM q3 UNION ALL SELECT id,'10000cm³',false,3 FROM q3 UNION ALL SELECT id,'10cm³',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'4cm',false,1 FROM q4 UNION ALL SELECT id,'6cm',true,2 FROM q4 UNION ALL SELECT id,'8cm',false,3 FROM q4 UNION ALL SELECT id,'5cm',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1000cm³',false,1 FROM q5 UNION ALL SELECT id,'1000000cm³',true,2 FROM q5 UNION ALL SELECT id,'100000cm³',false,3 FROM q5 UNION ALL SELECT id,'10000cm³',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'180cm³',false,1 FROM q6 UNION ALL SELECT id,'210cm³',true,2 FROM q6 UNION ALL SELECT id,'240cm³',false,3 FROM q6 UNION ALL SELECT id,'165cm³',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'25cm³',false,1 FROM q7 UNION ALL SELECT id,'125cm³',true,2 FROM q7 UNION ALL SELECT id,'100cm³',false,3 FROM q7 UNION ALL SELECT id,'75cm³',false,4 FROM q7),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'直方体の体積＝縦×横×高さ＝3×4×5＝60cm³です。' FROM q1),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'高さ＝体積÷底面積＝120÷20＝6cmです。' FROM q4),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'1m＝100cmなので、1m³＝100×100×100＝1000000cm³です。' FROM q5)
SELECT 'volume-3d done';
