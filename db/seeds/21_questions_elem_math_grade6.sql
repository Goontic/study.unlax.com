-- 小学校算数 6年生 問題データ

-- ===== 分数の四則計算 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'fractions-all'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1/3＋1/6はいくつですか？（通分）',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3/4－1/6はいくつですか？（通分）',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','2/3×3/5はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','4/5÷2/3はいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1/2＋2/3はいくつですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','5/6－1/4はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3/8×4/9はいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','2/3÷4/9はいくつですか？',3,8 FROM topic RETURNING id),
q9  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1と2/3＋2と1/3はいくつですか？',3,9 FROM topic RETURNING id),
q10 AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3/4×8÷6はいくつですか？',3,10 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2/9',false,1 FROM q1 UNION ALL SELECT id,'1/2',true,2 FROM q1 UNION ALL SELECT id,'2/6',false,3 FROM q1 UNION ALL SELECT id,'3/6',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5/12',false,1 FROM q2 UNION ALL SELECT id,'7/12',true,2 FROM q2 UNION ALL SELECT id,'2/3',false,3 FROM q2 UNION ALL SELECT id,'1/2',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5/15',false,1 FROM q3 UNION ALL SELECT id,'2/5',true,2 FROM q3 UNION ALL SELECT id,'6/15',false,3 FROM q3 UNION ALL SELECT id,'3/8',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'8/15',false,1 FROM q4 UNION ALL SELECT id,'6/5',true,2 FROM q4 UNION ALL SELECT id,'4/15',false,3 FROM q4 UNION ALL SELECT id,'2/3',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'3/5',false,1 FROM q5 UNION ALL SELECT id,'7/6',true,2 FROM q5 UNION ALL SELECT id,'2/5',false,3 FROM q5 UNION ALL SELECT id,'1',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'4/10',false,1 FROM q6 UNION ALL SELECT id,'7/12',true,2 FROM q6 UNION ALL SELECT id,'2/3',false,3 FROM q6 UNION ALL SELECT id,'3/4',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'7/36',false,1 FROM q7 UNION ALL SELECT id,'1/6',true,2 FROM q7 UNION ALL SELECT id,'12/72',false,3 FROM q7 UNION ALL SELECT id,'2/9',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'8/27',false,1 FROM q8 UNION ALL SELECT id,'3/2',true,2 FROM q8 UNION ALL SELECT id,'6/27',false,3 FROM q8 UNION ALL SELECT id,'2/3',false,4 FROM q8),
c9  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'3と2/3',false,1 FROM q9 UNION ALL SELECT id,'4',true,2 FROM q9 UNION ALL SELECT id,'3と3/3',false,3 FROM q9 UNION ALL SELECT id,'4と1/3',false,4 FROM q9),
c10 AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1/2',false,1 FROM q10 UNION ALL SELECT id,'1',true,2 FROM q10 UNION ALL SELECT id,'3/2',false,3 FROM q10 UNION ALL SELECT id,'2',false,4 FROM q10),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'1/3＋1/6：通分→2/6＋1/6＝3/6＝1/2です。' FROM q1),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'3/4－1/6：通分→9/12－2/12＝7/12です。' FROM q2),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'1/2＋2/3：通分→3/6＋4/6＝7/6です。' FROM q5),
s10 AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'3/4×8÷6＝3/4×8×1/6＝24/24＝1です。' FROM q10)
SELECT 'fractions-all done';

-- ===== 比と比例・反比例 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'ratio-proportion-6'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','6:9の比を最も簡単な整数の比にするとどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3:4＝9:□の□はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','yがxに比例し、x＝3のときy＝12です。x＝5のときyはいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','yがxに反比例し、x＝2のときy＝10です。x＝5のときyはいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','比例のとき、xが2倍になるとyはどうなりますか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','60人を3:2にわけると、それぞれ何人になりますか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','12:8を簡単な整数の比にするとどれですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','y＝4xのとき、x＝6のyはいくつですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1:2',false,1 FROM q1 UNION ALL SELECT id,'2:3',true,2 FROM q1 UNION ALL SELECT id,'3:4',false,3 FROM q1 UNION ALL SELECT id,'6:9',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'10',false,1 FROM q2 UNION ALL SELECT id,'12',true,2 FROM q2 UNION ALL SELECT id,'14',false,3 FROM q2 UNION ALL SELECT id,'8',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'15',false,1 FROM q3 UNION ALL SELECT id,'20',true,2 FROM q3 UNION ALL SELECT id,'25',false,3 FROM q3 UNION ALL SELECT id,'10',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2',false,1 FROM q4 UNION ALL SELECT id,'4',true,2 FROM q4 UNION ALL SELECT id,'6',false,3 FROM q4 UNION ALL SELECT id,'8',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2分の1になる',false,1 FROM q5 UNION ALL SELECT id,'2倍になる',true,2 FROM q5 UNION ALL SELECT id,'変わらない',false,3 FROM q5 UNION ALL SELECT id,'4倍になる',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'30人と30人',false,1 FROM q6 UNION ALL SELECT id,'36人と24人',true,2 FROM q6 UNION ALL SELECT id,'40人と20人',false,3 FROM q6 UNION ALL SELECT id,'35人と25人',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'4:3',false,1 FROM q7 UNION ALL SELECT id,'3:2',true,2 FROM q7 UNION ALL SELECT id,'2:1',false,3 FROM q7 UNION ALL SELECT id,'6:4',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'20',false,1 FROM q8 UNION ALL SELECT id,'24',true,2 FROM q8 UNION ALL SELECT id,'28',false,3 FROM q8 UNION ALL SELECT id,'18',false,4 FROM q8),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'比例定数k＝y/x＝12/3＝4。y＝4x → x＝5のとき y＝20です。' FROM q3),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'反比例：x×y＝一定。2×10＝20。5×y＝20 → y＝4です。' FROM q4),
s6  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'3＋2＝5。60÷5＝12。3×12＝36人、2×12＝24人です。' FROM q6)
SELECT 'ratio-proportion-6 done';

-- ===== 文字と式 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'algebra-basics'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','x＋5＝12のとき、xはいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','3x＝21のとき、xはいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','x＝4のとき、2x＋3はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1個x円のりんごを5個買ったときの代金を式で表すとどれですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','縦がacm、横が7cmの長方形の面積を式で表すとどれですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','x－8＝15のとき、xはいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','x÷4＝6のとき、xはいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','a＝3のとき、5a－7はいくつですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'6',false,1 FROM q1 UNION ALL SELECT id,'7',true,2 FROM q1 UNION ALL SELECT id,'8',false,3 FROM q1 UNION ALL SELECT id,'17',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'6',false,1 FROM q2 UNION ALL SELECT id,'7',true,2 FROM q2 UNION ALL SELECT id,'8',false,3 FROM q2 UNION ALL SELECT id,'9',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'9',false,1 FROM q3 UNION ALL SELECT id,'11',true,2 FROM q3 UNION ALL SELECT id,'12',false,3 FROM q3 UNION ALL SELECT id,'10',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'x＋5',false,1 FROM q4 UNION ALL SELECT id,'5x',true,2 FROM q4 UNION ALL SELECT id,'x÷5',false,3 FROM q4 UNION ALL SELECT id,'x×x×x×x×x',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'a＋7',false,1 FROM q5 UNION ALL SELECT id,'7a',true,2 FROM q5 UNION ALL SELECT id,'a÷7',false,3 FROM q5 UNION ALL SELECT id,'a－7',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'7',false,1 FROM q6 UNION ALL SELECT id,'23',true,2 FROM q6 UNION ALL SELECT id,'22',false,3 FROM q6 UNION ALL SELECT id,'24',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'10',false,1 FROM q7 UNION ALL SELECT id,'24',true,2 FROM q7 UNION ALL SELECT id,'2',false,3 FROM q7 UNION ALL SELECT id,'20',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'6',false,1 FROM q8 UNION ALL SELECT id,'8',true,2 FROM q8 UNION ALL SELECT id,'9',false,3 FROM q8 UNION ALL SELECT id,'7',false,4 FROM q8),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'x＋5＝12 → x＝12－5＝7です。' FROM q1),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'2×4＋3＝8＋3＝11です。' FROM q3),
s8  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'5×3－7＝15－7＝8です。' FROM q8)
SELECT 'algebra-basics done';

-- ===== 場合の数 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'probability-basic-6'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','A・B・Cの3人で1列に並ぶとき、並び方は何通りありますか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','4人の中から2人を選ぶ選び方は何通りありますか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','コインを2回投げたとき、表・裏の出方は全部で何通りですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','サイコロを1回ふったとき、3以上の目が出る確率はどれですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1、2、3の数字を使って3けたの整数を作るとき（各数字1回ずつ）何通りできますか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','2つのサイコロをふったとき、出る目の和が7になる場合は何通りですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','4人でじゃんけんをするとき、全部の手の組み合わせは何通りですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','5人の中から委員長と副委員長を選ぶ方法は何通りですか？',3,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'3通り',false,1 FROM q1 UNION ALL SELECT id,'6通り',true,2 FROM q1 UNION ALL SELECT id,'9通り',false,3 FROM q1 UNION ALL SELECT id,'12通り',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'4通り',false,1 FROM q2 UNION ALL SELECT id,'6通り',true,2 FROM q2 UNION ALL SELECT id,'8通り',false,3 FROM q2 UNION ALL SELECT id,'12通り',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2通り',false,1 FROM q3 UNION ALL SELECT id,'4通り',true,2 FROM q3 UNION ALL SELECT id,'6通り',false,3 FROM q3 UNION ALL SELECT id,'8通り',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1/3',false,1 FROM q4 UNION ALL SELECT id,'4/6（2/3）',true,2 FROM q4 UNION ALL SELECT id,'3/6（1/2）',false,3 FROM q4 UNION ALL SELECT id,'1/6',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'3通り',false,1 FROM q5 UNION ALL SELECT id,'6通り',true,2 FROM q5 UNION ALL SELECT id,'9通り',false,3 FROM q5 UNION ALL SELECT id,'12通り',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'4通り',false,1 FROM q6 UNION ALL SELECT id,'6通り',true,2 FROM q6 UNION ALL SELECT id,'5通り',false,3 FROM q6 UNION ALL SELECT id,'7通り',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'12通り',false,1 FROM q7 UNION ALL SELECT id,'81通り',true,2 FROM q7 UNION ALL SELECT id,'24通り',false,3 FROM q7 UNION ALL SELECT id,'27通り',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'10通り',false,1 FROM q8 UNION ALL SELECT id,'20通り',true,2 FROM q8 UNION ALL SELECT id,'25通り',false,3 FROM q8 UNION ALL SELECT id,'15通り',false,4 FROM q8),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'3×2×1＝6通り（3の階乗）です。' FROM q1),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'4人から2人選ぶ：(4×3)÷2＝6通りです。' FROM q2),
s6  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'和が7になる組合せ：(1,6)(2,5)(3,4)(4,3)(5,2)(6,1)の6通りです。' FROM q6),
s8  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'委員長5通り×副委員長4通り＝20通りです。' FROM q8)
SELECT 'probability-basic-6 done';

-- ===== 円の面積 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'circle-area'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','半径5cmの円の面積はいくつですか？（円周率π≒3.14）',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','直径10cmの円の円周はいくつですか？（π≒3.14）',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','面積が78.5cm²の円の半径は何cmですか？（π≒3.14）',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','半径3cmの円の面積はいくつですか？（π≒3.14）',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','円の面積の公式はどれですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','半径4cmの半円の面積はいくつですか？（π≒3.14）',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','直径8cmの円の面積はいくつですか？（π≒3.14）',3,7 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'31.4cm²',false,1 FROM q1 UNION ALL SELECT id,'78.5cm²',true,2 FROM q1 UNION ALL SELECT id,'157cm²',false,3 FROM q1 UNION ALL SELECT id,'25cm²',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'15.7cm',false,1 FROM q2 UNION ALL SELECT id,'31.4cm',true,2 FROM q2 UNION ALL SELECT id,'62.8cm',false,3 FROM q2 UNION ALL SELECT id,'28.6cm',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'3cm',false,1 FROM q3 UNION ALL SELECT id,'5cm',true,2 FROM q3 UNION ALL SELECT id,'7cm',false,3 FROM q3 UNION ALL SELECT id,'10cm',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'18.84cm²',false,1 FROM q4 UNION ALL SELECT id,'28.26cm²',true,2 FROM q4 UNION ALL SELECT id,'37.68cm²',false,3 FROM q4 UNION ALL SELECT id,'9.42cm²',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'直径×π',false,1 FROM q5 UNION ALL SELECT id,'半径×半径×π',true,2 FROM q5 UNION ALL SELECT id,'直径×直径×π',false,3 FROM q5 UNION ALL SELECT id,'半径×π',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'12.56cm²',false,1 FROM q6 UNION ALL SELECT id,'25.12cm²',true,2 FROM q6 UNION ALL SELECT id,'50.24cm²',false,3 FROM q6 UNION ALL SELECT id,'6.28cm²',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'25.12cm²',false,1 FROM q7 UNION ALL SELECT id,'50.24cm²',true,2 FROM q7 UNION ALL SELECT id,'100.48cm²',false,3 FROM q7 UNION ALL SELECT id,'200.96cm²',false,4 FROM q7),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'円の面積＝半径×半径×π＝5×5×3.14＝78.5cm²です。' FROM q1),
s6  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'4×4×3.14÷2＝50.24÷2＝25.12cm²です。' FROM q6),
s7  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'直径8cm→半径4cm。4×4×3.14＝50.24cm²です。' FROM q7)
SELECT 'circle-area done';

-- ===== 角柱・円柱の体積 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-math' AND t.slug = 'solid-volume-6'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','底面積が24cm²、高さが5cmの三角柱の体積はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','半径3cm、高さ10cmの円柱の体積はいくつですか？（π≒3.14）',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','角柱・円柱の体積の公式はどれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','底辺6cm・高さ4cmの三角形を底面とし、高さ8cmの三角柱の体積はいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','直径4cm、高さ7cmの円柱の体積はいくつですか？（π≒3.14）',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','底面積が50cm²、高さが6cmの四角柱の体積はいくつですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'90cm³',false,1 FROM q1 UNION ALL SELECT id,'120cm³',true,2 FROM q1 UNION ALL SELECT id,'150cm³',false,3 FROM q1 UNION ALL SELECT id,'60cm³',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'188.4cm³',false,1 FROM q2 UNION ALL SELECT id,'282.6cm³',true,2 FROM q2 UNION ALL SELECT id,'376.8cm³',false,3 FROM q2 UNION ALL SELECT id,'94.2cm³',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'底面積＋高さ',false,1 FROM q3 UNION ALL SELECT id,'底面積×高さ',true,2 FROM q3 UNION ALL SELECT id,'底面積×高さ÷2',false,3 FROM q3 UNION ALL SELECT id,'底面積×高さ×2',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'48cm³',false,1 FROM q4 UNION ALL SELECT id,'96cm³',true,2 FROM q4 UNION ALL SELECT id,'192cm³',false,3 FROM q4 UNION ALL SELECT id,'72cm³',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'43.96cm³',false,1 FROM q5 UNION ALL SELECT id,'87.92cm³',true,2 FROM q5 UNION ALL SELECT id,'175.84cm³',false,3 FROM q5 UNION ALL SELECT id,'56cm³',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'200cm³',false,1 FROM q6 UNION ALL SELECT id,'300cm³',true,2 FROM q6 UNION ALL SELECT id,'400cm³',false,3 FROM q6 UNION ALL SELECT id,'250cm³',false,4 FROM q6),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'3×3×3.14×10＝9×3.14×10＝282.6cm³です。' FROM q2),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'底面積＝6×4÷2＝12cm²。体積＝12×8＝96cm³です。' FROM q4),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'半径＝2cm。2×2×3.14×7＝87.92cm³です。' FROM q5)
SELECT 'solid-volume-6 done';
