-- 理科：全単元の問題

-- ① 細胞・生物のつくり
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'science' AND t.slug = 'cells'
),
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '植物の細胞にあって、動物の細胞にはないものを選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '細胞の中にあり、遺伝情報（DNA）をもつ部分を選びなさい。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '細胞内で呼吸（酸素を使ってエネルギーをつくる）を行う部分を{{1}}という。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '顕微鏡の使い方として正しい手順を選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '多細胞生物の体のつくりとして、細胞 → 組織 → 器官 → 個体の順のうち、「器官」の例として正しいものを選びなさい。', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '細胞膜',           false, 1 FROM q1 UNION ALL
  SELECT id, '細胞壁・葉緑体',   true,  2 FROM q1 UNION ALL
  SELECT id, '核',               false, 3 FROM q1 UNION ALL
  SELECT id, 'ミトコンドリア',   false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '細胞膜',           false, 1 FROM q2 UNION ALL
  SELECT id, '液胞',             false, 2 FROM q2 UNION ALL
  SELECT id, '核',               true,  3 FROM q2 UNION ALL
  SELECT id, '葉緑体',           false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, 'ミトコンドリア' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '高倍率のレンズをつけてから低倍率に換える',           false, 1 FROM q4 UNION ALL
  SELECT id, '低倍率で全体を確認してから高倍率にする',             true,  2 FROM q4 UNION ALL
  SELECT id, '接眼レンズを先にのぞいてから対物レンズを調節する', false, 3 FROM q4 UNION ALL
  SELECT id, 'ピントはステージを上から下へ動かして合わせる',       false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '筋肉の細胞',   false, 1 FROM q5 UNION ALL
  SELECT id, '筋肉（筋）組織', false, 2 FROM q5 UNION ALL
  SELECT id, '胃・心臓',     true,  3 FROM q5 UNION ALL
  SELECT id, 'ヒト',         false, 4 FROM q5
),
s1 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '植物細胞と動物細胞に共通してあるもの：核・細胞膜・ミトコンドリア・液胞（動物では小さい）' FROM q1 UNION ALL
  SELECT id, 2, '植物細胞だけにあるもの：細胞壁・葉緑体（光合成をするため）' FROM q1
)

SELECT 'science cells done' AS result;

-- ② 植物のしくみ
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'science' AND t.slug = 'plants'
),
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '光合成に必要なものをすべて選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '光合成でつくられるものは{{1}}（栄養分）と{{2}}（気体）である。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '葉の気孔について正しいものを選びなさい。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', 'アブラナの花のつくりとして、外側から順番に正しいものを選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '双子葉類と単子葉類の葉脈について正しいものを選びなさい。', 1, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '水と酸素',                   false, 1 FROM q1 UNION ALL
  SELECT id, '二酸化炭素・水・光エネルギー', true, 2 FROM q1 UNION ALL
  SELECT id, '酸素・水・光エネルギー',     false, 3 FROM q1 UNION ALL
  SELECT id, '窒素・二酸化炭素・水',       false, 4 FROM q1
),
a2 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, 'デンプン（ブドウ糖）' FROM q2 UNION ALL
  SELECT id, 2, '酸素' FROM q2
),
c3 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '気孔は主に葉の表側に多い',                false, 1 FROM q3 UNION ALL
  SELECT id, '気孔は蒸散・ガス交換に使われる',          true,  2 FROM q3 UNION ALL
  SELECT id, '気孔は2つの孔辺細胞で囲まれていない',     false, 3 FROM q3 UNION ALL
  SELECT id, '気孔は常に開いている',                    false, 4 FROM q3
),
c4 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, 'がく → 花びら → おしべ → めしべ', true,  1 FROM q4 UNION ALL
  SELECT id, '花びら → がく → めしべ → おしべ', false, 2 FROM q4 UNION ALL
  SELECT id, 'めしべ → おしべ → 花びら → がく', false, 3 FROM q4 UNION ALL
  SELECT id, 'おしべ → めしべ → がく → 花びら', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '双子葉類は平行脈、単子葉類は網状脈',    false, 1 FROM q5 UNION ALL
  SELECT id, '双子葉類は網状脈、単子葉類は平行脈',    true,  2 FROM q5 UNION ALL
  SELECT id, 'どちらも平行脈',                        false, 3 FROM q5 UNION ALL
  SELECT id, 'どちらも網状脈',                        false, 4 FROM q5
)

SELECT 'science plants done' AS result;

-- ③ 運動と力
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'science' AND t.slug = 'motion-force'
),
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '慣性の法則について正しいものを選びなさい。', 2, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', 'ニュートンの運動の第三法則は「{{1}}の法則」と呼ばれる。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '質量 5 kg の物体にはたらく重力を求めなさい。（重力加速度 = 10 m/s²）', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'text_input', '10 N の力を加えて物体を 3 m 動かしたときの仕事（J）を数字で答えなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '摩擦力について正しいものを選びなさい。', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '力を加えなくても運動している物体は止まる',               false, 1 FROM q1 UNION ALL
  SELECT id, '物体は外から力がはたらかない限り、静止または等速直線運動を続ける', true, 2 FROM q1 UNION ALL
  SELECT id, '重い物体ほど慣性が小さい',                              false, 3 FROM q1 UNION ALL
  SELECT id, '慣性は摩擦力が大きいほど大きくなる',                    false, 4 FROM q1
),
a2 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '作用・反作用' FROM q2
),
c3 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '5 N',  false, 1 FROM q3 UNION ALL
  SELECT id, '10 N', false, 2 FROM q3 UNION ALL
  SELECT id, '50 N', true,  3 FROM q3 UNION ALL
  SELECT id, '500 N',false, 4 FROM q3
),
a4 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '30' FROM q4
),
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '摩擦力は運動の向きと同じ向きにはたらく',        false, 1 FROM q5 UNION ALL
  SELECT id, '摩擦力は運動の向きと反対向きにはたらく',        true,  2 FROM q5 UNION ALL
  SELECT id, 'なめらかな面では摩擦力は最大になる',            false, 3 FROM q5 UNION ALL
  SELECT id, '摩擦力は物体の重さに関係しない',                false, 4 FROM q5
),
s3 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '重力（N）＝質量（kg）× 重力加速度（m/s²）' FROM q3 UNION ALL
  SELECT id, 2, '5 × 10 = 50 N' FROM q3
),
s4 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '仕事（J）＝力（N）× 距離（m）' FROM q4 UNION ALL
  SELECT id, 2, '10 × 3 = 30 J' FROM q4
)

SELECT 'science motion-force done' AS result;

-- ④ 電流と電圧
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'science' AND t.slug = 'electricity'
),
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', 'オームの法則として正しいものを選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'text_input', '電圧 12 V、電流 3 A のとき、抵抗（Ω）を数字で答えなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '直列回路の電流について正しいものを選びなさい。', 1, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '並列回路では、各部分の{{1}}はすべて等しい。', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '電圧 100 V、電流 2 A のときの電力（W）を求めなさい。', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, 'V = I ÷ R', false, 1 FROM q1 UNION ALL
  SELECT id, 'V = I × R', true,  2 FROM q1 UNION ALL
  SELECT id, 'V = R ÷ I', false, 3 FROM q1 UNION ALL
  SELECT id, 'I = V × R', false, 4 FROM q1
),
a2 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '4' FROM q2
),
c3 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '各部分で電流の大きさが異なる',       false, 1 FROM q3 UNION ALL
  SELECT id, 'どこでも電流の大きさは同じ',         true,  2 FROM q3 UNION ALL
  SELECT id, '分岐した部分で電流が増える',         false, 3 FROM q3 UNION ALL
  SELECT id, '電流の大きさは抵抗に反比例する',     false, 4 FROM q3
),
a4 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '電圧' FROM q4
),
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id,  '50 W', false, 1 FROM q5 UNION ALL
  SELECT id, '100 W', false, 2 FROM q5 UNION ALL
  SELECT id, '200 W', true,  3 FROM q5 UNION ALL
  SELECT id, '102 W', false, 4 FROM q5
),
s2 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, 'オームの法則：V = I × R より R = V ÷ I' FROM q2 UNION ALL
  SELECT id, 2, 'R = 12 ÷ 3 = 4 Ω' FROM q2
)

SELECT 'science electricity done' AS result;

-- ⑤ 化学変化
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'science' AND t.slug = 'chemical-change'
),
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '水を電気分解すると生成される気体を選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '鉄が酸素と化合してできる酸化鉄の化学式は{{1}}である。（Fe と O を使って）', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '「還元」の説明として正しいものを選びなさい。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '炭酸水素ナトリウムを加熱したときに生成されないものを選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '化学反応式 2H₂ + O₂ → 2H₂O の説明として正しいものを選びなさい。', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '水素と二酸化炭素',   false, 1 FROM q1 UNION ALL
  SELECT id, '水素と酸素',         true,  2 FROM q1 UNION ALL
  SELECT id, '酸素と窒素',         false, 3 FROM q1 UNION ALL
  SELECT id, '二酸化炭素と酸素',   false, 4 FROM q1
),
a2 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, 'Fe₂O₃' FROM q2
),
c3 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '物質が酸素と化合すること',         false, 1 FROM q3 UNION ALL
  SELECT id, '物質から酸素がうばわれること',     true,  2 FROM q3 UNION ALL
  SELECT id, '物質が燃えること',                 false, 3 FROM q3 UNION ALL
  SELECT id, '原子が分解されること',             false, 4 FROM q3
),
c4 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '炭酸ナトリウム',   false, 1 FROM q4 UNION ALL
  SELECT id, '水',               false, 2 FROM q4 UNION ALL
  SELECT id, '二酸化炭素',       false, 3 FROM q4 UNION ALL
  SELECT id, '塩化ナトリウム',   true,  4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '水素2分子と酸素2分子から水1分子ができる',     false, 1 FROM q5 UNION ALL
  SELECT id, '水素2分子と酸素1分子から水2分子ができる',     true,  2 FROM q5 UNION ALL
  SELECT id, '水素1分子と酸素1分子から水2分子ができる',     false, 3 FROM q5 UNION ALL
  SELECT id, '水素4分子と酸素2分子から水2分子ができる',     false, 4 FROM q5
),
s1 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '水の電気分解：2H₂O → 2H₂ + O₂' FROM q1 UNION ALL
  SELECT id, 2, '陰極（マイナス極）から水素、陽極（プラス極）から酸素が発生します。' FROM q1 UNION ALL
  SELECT id, 3, '水素と酸素の体積比は 2:1 になります。' FROM q1
)

SELECT 'science chemical done' AS result;

-- ⑥ 天気と気象
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subject_id" = s.id
  WHERE s.slug = 'science' AND t.slug = 'weather'
),
q1 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '高気圧・低気圧と天気の関係について正しいものを選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '寒冷前線が通過したあとの天気の変化として正しいものを選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'fill_blank', '気温 20℃ での飽和水蒸気量が 17.3 g/m³ で、実際の水蒸気量が 8.65 g/m³ のとき、湿度は{{1}}％ である。', 3, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '日本の冬の気候の特徴として正しいものを選びなさい。', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topic_id", type, body, difficulty, "display_order")
  SELECT topic_id, 'multiple_choice', '台風の発生場所として正しいものを選びなさい。', 1, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '高気圧は下降気流で曇り、低気圧は上昇気流で晴れ',     false, 1 FROM q1 UNION ALL
  SELECT id, '高気圧は下降気流で晴れ、低気圧は上昇気流で雨・雲',   true,  2 FROM q1 UNION ALL
  SELECT id, '高気圧も低気圧も天気には関係しない',                 false, 3 FROM q1 UNION ALL
  SELECT id, '高気圧は上昇気流で晴れ、低気圧は下降気流で雨',       false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '気温が上がり、おだやかな雨が続く',                 false, 1 FROM q2 UNION ALL
  SELECT id, '急に気温が下がり、強い雨が降ってから晴れる',       true,  2 FROM q2 UNION ALL
  SELECT id, 'ゆっくり気温が上がり、霧が発生する',               false, 3 FROM q2 UNION ALL
  SELECT id, '風向きは南風になり、気温が上昇する',               false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("question_id", "blank_index", "correct_answer")
  SELECT id, 1, '50' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '南東の季節風が吹き、太平洋側が雪になる',             false, 1 FROM q4 UNION ALL
  SELECT id, '北西の季節風が吹き、日本海側が雪になりやすい',       true,  2 FROM q4 UNION ALL
  SELECT id, '偏西風の影響で西日本だけに雨が降る',               false, 3 FROM q4 UNION ALL
  SELECT id, '台風が多く発生して日本に上陸する',                 false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("question_id", body, "is_correct", "display_order")
  SELECT id, '北極付近の寒冷な海',               false, 1 FROM q5 UNION ALL
  SELECT id, '赤道付近の暖かい熱帯の海',         true,  2 FROM q5 UNION ALL
  SELECT id, '日本の近くの日本海',               false, 3 FROM q5 UNION ALL
  SELECT id, 'インド洋の冷たい海',               false, 4 FROM q5
),
s3 AS (
  INSERT INTO question_steps ("question_id", "step_number", body)
  SELECT id, 1, '湿度（％）＝（実際の水蒸気量 ÷ 飽和水蒸気量）× 100' FROM q3 UNION ALL
  SELECT id, 2, '8.65 ÷ 17.3 × 100 = 0.5 × 100 = 50 ％' FROM q3
)

SELECT 'science weather done' AS result;
