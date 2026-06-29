-- 高校入試対策 理科 問題データ

-- ===== 力と運動 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-science' AND t.slug = 'exam-physics-motion'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','力の単位はどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','慣性の法則とはどれですか？',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','作用・反作用の法則で正しいものはどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','質量200gの物体にかかる重力（地球上）は何Nですか？（g＝10m/s²）',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','ニュートンの運動の法則「F＝ma」のaは何ですか？',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','速度の単位はどれですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'Pa（パスカル）',false,1 FROM q1 UNION ALL SELECT id,'N（ニュートン）',true,2 FROM q1 UNION ALL SELECT id,'J（ジュール）',false,3 FROM q1 UNION ALL SELECT id,'W（ワット）',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'力は常に一定方向に働く',false,1 FROM q2 UNION ALL SELECT id,'外から力が働かなければ、物体は静止し続けるか等速直線運動を続ける',true,2 FROM q2 UNION ALL SELECT id,'力が大きいほど速く動く',false,3 FROM q2 UNION ALL SELECT id,'重い物ほど速く落ちる',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'2つの物体に働く力は常に同じ大きさ・同じ向き',false,1 FROM q3 UNION ALL SELECT id,'物体Aが物体Bに力を加えると、BもAに等しい大きさの反対向きの力を加える',true,2 FROM q3 UNION ALL SELECT id,'力は一方向にしか働かない',false,3 FROM q3 UNION ALL SELECT id,'反作用は必ず大きくなる',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1N',false,1 FROM q4 UNION ALL SELECT id,'2N',true,2 FROM q4 UNION ALL SELECT id,'0.2N',false,3 FROM q4 UNION ALL SELECT id,'20N',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'面積',false,1 FROM q5 UNION ALL SELECT id,'加速度',true,2 FROM q5 UNION ALL SELECT id,'質量',false,3 FROM q5 UNION ALL SELECT id,'力',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'N（ニュートン）',false,1 FROM q6 UNION ALL SELECT id,'m/s（メートル毎秒）',true,2 FROM q6 UNION ALL SELECT id,'kg（キログラム）',false,3 FROM q6 UNION ALL SELECT id,'J（ジュール）',false,4 FROM q6),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'重力F＝mg＝0.2kg×10m/s²＝2N。質量200g＝0.2kgに変換してから計算します。' FROM q4)
SELECT 'exam-physics-motion done';

-- ===== 化学変化・化学式 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-science' AND t.slug = 'exam-chemistry-react'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','水を電気分解したとき、陽極に発生する気体はどれですか？',4,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','化学式で水は何と表しますか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','炭素が酸素と結びついて燃焼するとき生じるものはどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','酸化銅を炭素で還元したとき生じるものはどれですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','化学変化で質量が保存される法則を何といいますか？',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','二酸化炭素の化学式はどれですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'水素',false,1 FROM q1 UNION ALL SELECT id,'酸素',true,2 FROM q1 UNION ALL SELECT id,'二酸化炭素',false,3 FROM q1 UNION ALL SELECT id,'窒素',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'HO',false,1 FROM q2 UNION ALL SELECT id,'H₂O',true,2 FROM q2 UNION ALL SELECT id,'OH₂',false,3 FROM q2 UNION ALL SELECT id,'H₂O₂',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'一酸化炭素（CO）のみ',false,1 FROM q3 UNION ALL SELECT id,'二酸化炭素（CO₂）と水（H₂O）',true,2 FROM q3 UNION ALL SELECT id,'酸素のみ',false,3 FROM q3 UNION ALL SELECT id,'炭酸ガス',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'酸化銅と酸素',false,1 FROM q4 UNION ALL SELECT id,'銅と二酸化炭素',true,2 FROM q4 UNION ALL SELECT id,'銅と酸素',false,3 FROM q4 UNION ALL SELECT id,'炭素と水',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'エネルギー保存の法則',false,1 FROM q5 UNION ALL SELECT id,'質量保存の法則',true,2 FROM q5 UNION ALL SELECT id,'慣性の法則',false,3 FROM q5 UNION ALL SELECT id,'定比例の法則',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'CO',false,1 FROM q6 UNION ALL SELECT id,'CO₂',true,2 FROM q6 UNION ALL SELECT id,'C₂O',false,3 FROM q6 UNION ALL SELECT id,'O₂C',false,4 FROM q6),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'水の電気分解：陰極→水素(H₂)、陽極→酸素(O₂)。発生量は水素:酸素＝2:1です。' FROM q1),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'酸化銅(CuO)＋炭素(C) → 銅(Cu)＋二酸化炭素(CO₂)。炭素が酸素を奪い（還元）、銅が析出します。' FROM q4)
SELECT 'exam-chemistry-react done';

-- ===== 細胞・生殖・遺伝 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-science' AND t.slug = 'exam-biology-cell'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','細胞の中で遺伝情報を持つのはどの部分ですか？',4,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','有性生殖と無性生殖の違いとして正しいものはどれですか？',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','メンデルの法則「顕性の法則」とはどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','染色体の数が半分になる細胞分裂を何といいますか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','Aa（顕性Aと潜性a）を自家受粉したとき、次世代でAaの割合はいくつですか？',4,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'細胞膜',false,1 FROM q1 UNION ALL SELECT id,'核（DNA）',true,2 FROM q1 UNION ALL SELECT id,'葉緑体',false,3 FROM q1 UNION ALL SELECT id,'ミトコンドリア',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'有性生殖は1つの親だけで増える',false,1 FROM q2 UNION ALL SELECT id,'有性生殖は雌雄の配偶子が合体（受精）、無性生殖は1個体だけで増える',true,2 FROM q2 UNION ALL SELECT id,'無性生殖は2つの親が必要',false,3 FROM q2 UNION ALL SELECT id,'どちらも変わらない',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'どちらの親の性質も現れる',false,1 FROM q3 UNION ALL SELECT id,'対になる遺伝子のうち、顕性のほうだけが表れる',true,2 FROM q3 UNION ALL SELECT id,'潜性のほうだけが表れる',false,3 FROM q3 UNION ALL SELECT id,'両親の中間の性質が表れる',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'体細胞分裂',false,1 FROM q4 UNION ALL SELECT id,'減数分裂',true,2 FROM q4 UNION ALL SELECT id,'核分裂',false,3 FROM q4 UNION ALL SELECT id,'細胞分裂',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1/4',false,1 FROM q5 UNION ALL SELECT id,'2/4（1/2）',true,2 FROM q5 UNION ALL SELECT id,'3/4',false,3 FROM q5 UNION ALL SELECT id,'1/1（全部）',false,4 FROM q5),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'Aa×Aaの掛け合わせ：AA:Aa:aa＝1:2:1の比で生まれる。Aaの割合は2/4＝1/2です。' FROM q5)
SELECT 'exam-biology-cell done';

-- ===== 天体（地球・月・太陽） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-science' AND t.slug = 'exam-earth-astro'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本で太陽が南中するのはいつですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','地球の公転周期はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','月が地球から見て太陽と同じ方向にあるとき、月はどのように見えますか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日食が起こるのはどのような位置関係のときですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','夏至の日、日本での昼の長さはどうなりますか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','太陽系の惑星の数は何個ですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'正午（12時ごろ）',true,1 FROM q1 UNION ALL SELECT id,'朝6時ごろ',false,2 FROM q1 UNION ALL SELECT id,'夕方6時ごろ',false,3 FROM q1 UNION ALL SELECT id,'深夜',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'24時間',false,1 FROM q2 UNION ALL SELECT id,'約365日',true,2 FROM q2 UNION ALL SELECT id,'約30日',false,3 FROM q2 UNION ALL SELECT id,'7日',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'満月',false,1 FROM q3 UNION ALL SELECT id,'新月（見えない）',true,2 FROM q3 UNION ALL SELECT id,'三日月',false,3 FROM q3 UNION ALL SELECT id,'半月',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'太陽・月・地球の順に並んだとき',false,1 FROM q4 UNION ALL SELECT id,'太陽・月・地球の順（月が太陽を隠す）',true,2 FROM q4 UNION ALL SELECT id,'太陽・地球・月の順',false,3 FROM q4 UNION ALL SELECT id,'月・地球・太陽の順',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'最も短い',false,1 FROM q5 UNION ALL SELECT id,'最も長い',true,2 FROM q5 UNION ALL SELECT id,'同じ長さ',false,3 FROM q5 UNION ALL SELECT id,'変わらない',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'7個',false,1 FROM q6 UNION ALL SELECT id,'8個',true,2 FROM q6 UNION ALL SELECT id,'9個',false,3 FROM q6 UNION ALL SELECT id,'10個',false,4 FROM q6),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'月が太陽と同じ方向（合）にあるとき、月の太陽側が光っており地球からは見えない→新月です。' FROM q3),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'日食：太陽・月・地球の順に一直線に並び、月が太陽を隠す現象です。新月のときに起こります。' FROM q4)
SELECT 'exam-earth-astro done';

-- ===== 地層・岩石・地震 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-science' AND t.slug = 'exam-earth-geol'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','地震のゆれで最初に届く波を何といいますか？',4,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','P波とS波の違いとして正しいものはどれですか？',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','堆積岩のうち生き物の化石や殻が固まったものはどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','マグマが地表に出たものを何といいますか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','地層の逆転がない場合、下にある層のほうが古いことを何の法則といいますか？',4,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'S波',false,1 FROM q1 UNION ALL SELECT id,'P波',true,2 FROM q1 UNION ALL SELECT id,'X波',false,3 FROM q1 UNION ALL SELECT id,'M波',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'P波の方が遅くて大きなゆれ',false,1 FROM q2 UNION ALL SELECT id,'P波は速く縦波（小さなゆれ）、S波は遅く横波（大きなゆれ）',true,2 FROM q2 UNION ALL SELECT id,'両方とも同じ速さ',false,3 FROM q2 UNION ALL SELECT id,'S波の方が速い',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'チャート',false,1 FROM q3 UNION ALL SELECT id,'石灰岩',true,2 FROM q3 UNION ALL SELECT id,'砂岩',false,3 FROM q3 UNION ALL SELECT id,'泥岩',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'マグマ',false,1 FROM q4 UNION ALL SELECT id,'溶岩',true,2 FROM q4 UNION ALL SELECT id,'火山灰',false,3 FROM q4 UNION ALL SELECT id,'岩石',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'慣性の法則',false,1 FROM q5 UNION ALL SELECT id,'地層累重の法則',true,2 FROM q5 UNION ALL SELECT id,'化石の法則',false,3 FROM q5 UNION ALL SELECT id,'断層の法則',false,4 FROM q5),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'P波（Primary wave）は縦波で速く届き小さくゆれる（初期微動）。S波（Secondary wave）は横波で遅く届き大きくゆれる（主要動）。' FROM q2)
SELECT 'exam-earth-geol done';
