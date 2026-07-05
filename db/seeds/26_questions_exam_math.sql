-- 高校入試対策 数学 問題データ

-- ===== 数の計算・正負の数 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-math' AND t.slug = 'exam-numbers-calc'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','(-3)＋(+7)はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','(-5)×(-4)はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','(-12)÷(-3)はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','(-2)³はいくつですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','絶対値|-7|はいくつですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','(-3)²はいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','3－(+8)はいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','2×(-3)＋4÷(-2)はいくつですか？',4,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'－10',false,1 FROM q1 UNION ALL SELECT id,'＋4',true,2 FROM q1 UNION ALL SELECT id,'10',false,3 FROM q1 UNION ALL SELECT id,'－4',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'－20',false,1 FROM q2 UNION ALL SELECT id,'＋20',true,2 FROM q2 UNION ALL SELECT id,'－9',false,3 FROM q2 UNION ALL SELECT id,'9',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'－4',false,1 FROM q3 UNION ALL SELECT id,'＋4',true,2 FROM q3 UNION ALL SELECT id,'4.3',false,3 FROM q3 UNION ALL SELECT id,'36',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'6',false,1 FROM q4 UNION ALL SELECT id,'－8',true,2 FROM q4 UNION ALL SELECT id,'8',false,3 FROM q4 UNION ALL SELECT id,'－6',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'－7',false,1 FROM q5 UNION ALL SELECT id,'7',true,2 FROM q5 UNION ALL SELECT id,'0',false,3 FROM q5 UNION ALL SELECT id,'14',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'－9',false,1 FROM q6 UNION ALL SELECT id,'9',true,2 FROM q6 UNION ALL SELECT id,'6',false,3 FROM q6 UNION ALL SELECT id,'－6',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'11',false,1 FROM q7 UNION ALL SELECT id,'－5',true,2 FROM q7 UNION ALL SELECT id,'5',false,3 FROM q7 UNION ALL SELECT id,'－11',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'－4',false,1 FROM q8 UNION ALL SELECT id,'－8',true,2 FROM q8 UNION ALL SELECT id,'4',false,3 FROM q8 UNION ALL SELECT id,'8',false,4 FROM q8),
s2  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'負×負＝正。(-5)×(-4)＝+(5×4)＝+20です。' FROM q2),
s4  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'(-2)³＝(-2)×(-2)×(-2)＝4×(-2)＝-8。負の数の奇数乗は負になります。' FROM q4),
s8  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'掛け算・割り算を先に計算。2×(-3)＝-6、4÷(-2)＝-2。-6＋(-2)＝-8です。' FROM q8)
SELECT 'exam-numbers-calc done';

-- ===== 一次方程式・連立方程式 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-math' AND t.slug = 'exam-linear-eq'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','3x＋7＝22のxの値はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','2x－5＝x＋3のxの値はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','連立方程式 x＋y＝7、x－y＝3 を解くとxはいくつですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','連立方程式 x＋y＝7、x－y＝3 を解くとyはいくつですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','5x－3＝2x＋9のxはいくつですか？',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','x/3＝4のxはいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','ある数xを2倍して3をたすと13になる。xはいくつですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','連立方程式 2x＋y＝8、x＋2y＝7 を解くとxはいくつですか？',4,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'4',false,1 FROM q1 UNION ALL SELECT id,'5',true,2 FROM q1 UNION ALL SELECT id,'6',false,3 FROM q1 UNION ALL SELECT id,'3',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'6',false,1 FROM q2 UNION ALL SELECT id,'8',true,2 FROM q2 UNION ALL SELECT id,'4',false,3 FROM q2 UNION ALL SELECT id,'10',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3',false,1 FROM q3 UNION ALL SELECT id,'5',true,2 FROM q3 UNION ALL SELECT id,'4',false,3 FROM q3 UNION ALL SELECT id,'6',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1',false,1 FROM q4 UNION ALL SELECT id,'2',true,2 FROM q4 UNION ALL SELECT id,'3',false,3 FROM q4 UNION ALL SELECT id,'4',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3',false,1 FROM q5 UNION ALL SELECT id,'4',true,2 FROM q5 UNION ALL SELECT id,'5',false,3 FROM q5 UNION ALL SELECT id,'2',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'10',false,1 FROM q6 UNION ALL SELECT id,'12',true,2 FROM q6 UNION ALL SELECT id,'8',false,3 FROM q6 UNION ALL SELECT id,'4/3',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'4',false,1 FROM q7 UNION ALL SELECT id,'5',true,2 FROM q7 UNION ALL SELECT id,'6',false,3 FROM q7 UNION ALL SELECT id,'3',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2',false,1 FROM q8 UNION ALL SELECT id,'3',true,2 FROM q8 UNION ALL SELECT id,'4',false,3 FROM q8 UNION ALL SELECT id,'1',false,4 FROM q8),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'3x＝22－7＝15。x＝15÷3＝5です。' FROM q1),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'2つの式を足すと2x＝10。x＝5です。' FROM q3),
s8  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'①×2－②：4x＋2y－x－2y＝16－7 → 3x＝9 → x＝3です。' FROM q8)
SELECT 'exam-linear-eq done';

-- ===== 関数（比例・一次関数） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-math' AND t.slug = 'exam-functions'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','y＝3xで、x＝4のときyはいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','一次関数y＝2x＋3の傾きはいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','一次関数y＝2x＋3のy切片はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','y＝-2x＋5でx＝3のときyはいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','傾きが3で、点(0,2)を通る一次関数の式はどれですか？',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','反比例y＝6/xで、x＝2のときyはいくつですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','2点(1,5)と(3,9)を通る一次関数の傾きはいくつですか？',4,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','y＝-x＋4とy＝x－2の交点のx座標はいくつですか？',4,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'10',false,1 FROM q1 UNION ALL SELECT id,'12',true,2 FROM q1 UNION ALL SELECT id,'8',false,3 FROM q1 UNION ALL SELECT id,'16',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3',false,1 FROM q2 UNION ALL SELECT id,'2',true,2 FROM q2 UNION ALL SELECT id,'1',false,3 FROM q2 UNION ALL SELECT id,'4',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2',false,1 FROM q3 UNION ALL SELECT id,'3',true,2 FROM q3 UNION ALL SELECT id,'1',false,3 FROM q3 UNION ALL SELECT id,'5',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'-1',true,1 FROM q4 UNION ALL SELECT id,'1',false,2 FROM q4 UNION ALL SELECT id,'11',false,3 FROM q4 UNION ALL SELECT id,'-11',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'y＝3x',false,1 FROM q5 UNION ALL SELECT id,'y＝3x＋2',true,2 FROM q5 UNION ALL SELECT id,'y＝2x＋3',false,3 FROM q5 UNION ALL SELECT id,'y＝3x－2',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2',false,1 FROM q6 UNION ALL SELECT id,'3',true,2 FROM q6 UNION ALL SELECT id,'4',false,3 FROM q6 UNION ALL SELECT id,'12',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1',false,1 FROM q7 UNION ALL SELECT id,'2',true,2 FROM q7 UNION ALL SELECT id,'3',false,3 FROM q7 UNION ALL SELECT id,'4',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2',false,1 FROM q8 UNION ALL SELECT id,'3',true,2 FROM q8 UNION ALL SELECT id,'4',false,3 FROM q8 UNION ALL SELECT id,'1',false,4 FROM q8),
s4  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'y＝-2×3＋5＝-6＋5＝-1です。' FROM q4),
s7  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'傾き＝(9-5)÷(3-1)＝4÷2＝2です。' FROM q7),
s8  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'-x＋4＝x－2 → 6＝2x → x＝3です。' FROM q8)
SELECT 'exam-functions done';

-- ===== 確率 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-math' AND t.slug = 'exam-probability'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1つのサイコロをふったとき、3の倍数が出る確率はいくつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1枚のコインを投げたとき、表が出る確率はいくつですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','赤玉3個・白玉2個の袋から1個取り出すとき、白玉を取り出す確率はいくつですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','2枚のコインを同時に投げたとき、2枚とも表になる確率はいくつですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1〜9の整数を1枚ずつ書いたカードから1枚引くとき、偶数を引く確率はいくつですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','サイコロを2回ふったとき、目の和が5になる確率はいくつですか？',4,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「確率0」はどんな意味ですか？',3,7 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/6',false,1 FROM q1 UNION ALL SELECT id,'1/3',true,2 FROM q1 UNION ALL SELECT id,'1/2',false,3 FROM q1 UNION ALL SELECT id,'2/3',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/4',false,1 FROM q2 UNION ALL SELECT id,'1/2',true,2 FROM q2 UNION ALL SELECT id,'1',false,3 FROM q2 UNION ALL SELECT id,'0',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/5',false,1 FROM q3 UNION ALL SELECT id,'2/5',true,2 FROM q3 UNION ALL SELECT id,'3/5',false,3 FROM q3 UNION ALL SELECT id,'1/2',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/2',false,1 FROM q4 UNION ALL SELECT id,'1/4',true,2 FROM q4 UNION ALL SELECT id,'1/3',false,3 FROM q4 UNION ALL SELECT id,'3/4',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/3',false,1 FROM q5 UNION ALL SELECT id,'4/9',true,2 FROM q5 UNION ALL SELECT id,'1/2',false,3 FROM q5 UNION ALL SELECT id,'5/9',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1/9',false,1 FROM q6 UNION ALL SELECT id,'1/9',false,2 FROM q6 UNION ALL SELECT id,'1/12',false,3 FROM q6 UNION ALL SELECT id,'1/9',true,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'必ず起こる',false,1 FROM q7 UNION ALL SELECT id,'絶対に起こらない',true,2 FROM q7 UNION ALL SELECT id,'半々',false,3 FROM q7 UNION ALL SELECT id,'まれに起こる',false,4 FROM q7),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'3の倍数はサイコロの目で3と6の2つ。確率＝2/6＝1/3です。' FROM q1),
s4  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'全組み合わせは(表表)(表裏)(裏表)(裏裏)の4通り。2枚とも表は1通り。確率＝1/4です。' FROM q4),
s6  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'和が5になる組合せ：(1,4)(2,3)(3,2)(4,1)の4通り。全体36通り。確率＝4/36＝1/9です。' FROM q6)
SELECT 'exam-probability done';

-- ===== 平面図形・証明 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-math' AND t.slug = 'exam-plane-geometry'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','二等辺三角形の底角の性質として正しいものはどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','正三角形の内角はいくつですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','平行四辺形の性質として正しいものはどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','三角形の合同条件「2辺夾角相等」とはどれですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','円の接線と半径の関係はどれですか？',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','円周角の定理：同じ弧に対する円周角は、中心角の何倍ですか？',4,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'頂角と底角が等しい',false,1 FROM q1 UNION ALL SELECT id,'2つの底角が互いに等しい',true,2 FROM q1 UNION ALL SELECT id,'3つの角がすべて等しい',false,3 FROM q1 UNION ALL SELECT id,'底角と頂角の和が180°',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'45°',false,1 FROM q2 UNION ALL SELECT id,'60°',true,2 FROM q2 UNION ALL SELECT id,'90°',false,3 FROM q2 UNION ALL SELECT id,'120°',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'対角が等しい・対辺が等しい・対角線が互いに中点で交わる',true,1 FROM q3 UNION ALL SELECT id,'4つの角がすべて90°',false,2 FROM q3 UNION ALL SELECT id,'4つの辺がすべて等しい',false,3 FROM q3 UNION ALL SELECT id,'対角線が垂直に交わる',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3辺がそれぞれ等しい（SSS）',false,1 FROM q4 UNION ALL SELECT id,'2辺とその間の角が等しい（SAS）',true,2 FROM q4 UNION ALL SELECT id,'1辺と両端の角が等しい（ASA）',false,3 FROM q4 UNION ALL SELECT id,'2角と1辺が等しい',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'平行',false,1 FROM q5 UNION ALL SELECT id,'垂直（直交）',true,2 FROM q5 UNION ALL SELECT id,'同じ長さ',false,3 FROM q5 UNION ALL SELECT id,'平行でも垂直でもない',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'同じ（1倍）',false,1 FROM q6 UNION ALL SELECT id,'1/2倍',true,2 FROM q6 UNION ALL SELECT id,'2倍',false,3 FROM q6 UNION ALL SELECT id,'1/3倍',false,4 FROM q6),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'平行四辺形：対辺が平行で等しく、対角が等しく、対角線が互いの中点で交わる。これが入試頻出の性質です。' FROM q3),
s6  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'円周角の定理：同じ弧に対する円周角は中心角の半分（1/2倍）です。' FROM q6)
SELECT 'exam-plane-geometry done';

-- ===== 相似・三平方の定理 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-math' AND t.slug = 'exam-similarity'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','直角三角形で直角をはさむ2辺が3cm・4cmのとき、斜辺は何cmですか？',4,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','三平方の定理の式はどれですか？（直角三角形の2辺a,b・斜辺c）',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','相似比1:2の三角形の面積の比はどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','直角三角形で斜辺が13cm・他の1辺が5cmのとき、残りの辺は何cmですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','1辺が6cmの正三角形の高さは何cmですか？（√3≒1.73）',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','相似の三角形の条件として正しいものはどれですか？',4,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'6cm',false,1 FROM q1 UNION ALL SELECT id,'5cm',true,2 FROM q1 UNION ALL SELECT id,'7cm',false,3 FROM q1 UNION ALL SELECT id,'8cm',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'a+b=c',false,1 FROM q2 UNION ALL SELECT id,'a²+b²=c²',true,2 FROM q2 UNION ALL SELECT id,'a×b=c',false,3 FROM q2 UNION ALL SELECT id,'a+b=c²',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'1:2',false,1 FROM q3 UNION ALL SELECT id,'1:4',true,2 FROM q3 UNION ALL SELECT id,'1:3',false,3 FROM q3 UNION ALL SELECT id,'2:3',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'10cm',false,1 FROM q4 UNION ALL SELECT id,'12cm',true,2 FROM q4 UNION ALL SELECT id,'11cm',false,3 FROM q4 UNION ALL SELECT id,'8cm',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3√3cm（約5.2cm）',true,1 FROM q5 UNION ALL SELECT id,'6cm',false,2 FROM q5 UNION ALL SELECT id,'4cm',false,3 FROM q5 UNION ALL SELECT id,'2√3cm（約3.5cm）',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'3辺がそれぞれ比例・2辺比例でその間の角が等しい・2角が等しい',true,1 FROM q6 UNION ALL SELECT id,'3辺がすべて等しい',false,2 FROM q6 UNION ALL SELECT id,'2角と1辺が等しい',false,3 FROM q6 UNION ALL SELECT id,'1辺と2角が等しい',false,4 FROM q6),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'3²+4²＝9+16＝25＝5²。斜辺c＝5cmです。（3-4-5の直角三角形）' FROM q1),
s4  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'5²+b²＝13² → 25+b²＝169 → b²＝144 → b＝12cmです。（5-12-13の直角三角形）' FROM q4),
s5  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'正三角形の高さ＝（辺の長さ）×√3/2＝6×√3/2＝3√3cmです。' FROM q5)
SELECT 'exam-similarity done';
