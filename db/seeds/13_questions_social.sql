-- 社会：全単元の問題

-- ① 日本の地理
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'social' AND t.slug = 'japan-geography'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '日本で最も長い川を選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '日本最大の平野を選びなさい。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '日本の国土面積は約{{1}}万 km² で、世界第{{2}}位の島国である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '日本の気候の特徴について正しいものを選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '三大工業地帯に含まれないものを選びなさい。', 2, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '農業について、稲作がさかんな地域として正しいものを選びなさい。', 1, 6 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '利根川', false, 1 FROM q1 UNION ALL
  SELECT id, '信濃川', true,  2 FROM q1 UNION ALL
  SELECT id, '石狩川', false, 3 FROM q1 UNION ALL
  SELECT id, '木曽川', false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '大阪平野', false, 1 FROM q2 UNION ALL
  SELECT id, '濃尾平野', false, 2 FROM q2 UNION ALL
  SELECT id, '関東平野', true,  3 FROM q2 UNION ALL
  SELECT id, '仙台平野', false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '38'  FROM q3 UNION ALL
  SELECT id, 2, '61'  FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '1年中乾燥した砂漠気候である',                         false, 1 FROM q4 UNION ALL
  SELECT id, '四季がはっきりしており、梅雨・台風など季節変化がある', true,  2 FROM q4 UNION ALL
  SELECT id, 'どの地域も気候は同じである',                           false, 3 FROM q4 UNION ALL
  SELECT id, '日本海側は年間を通して晴れが多い',                     false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '京浜工業地帯', false, 1 FROM q5 UNION ALL
  SELECT id, '阪神工業地帯', false, 2 FROM q5 UNION ALL
  SELECT id, '中京工業地帯', false, 3 FROM q5 UNION ALL
  SELECT id, '北九州工業地帯', true, 4 FROM q5
),
c6 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '北海道・東北地方', true,  1 FROM q6 UNION ALL
  SELECT id, '近畿・中国地方',   false, 2 FROM q6 UNION ALL
  SELECT id, '九州南部',         false, 3 FROM q6 UNION ALL
  SELECT id, '関東南部',         false, 4 FROM q6
)

SELECT 'social japan-geography done' AS result;

-- ② 世界の地理
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'social' AND t.slug = 'world-geography'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '世界で最も面積が大きい大陸を選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '赤道が通る大陸として正しいものをすべて含む選択肢を選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '世界最大の川（流域面積）は南アメリカの{{1}}川である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '日本の標準時は東経何度の経線を基準にしているか選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', 'EU（ヨーロッパ連合）について正しいものを選びなさい。', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'アフリカ大陸',     false, 1 FROM q1 UNION ALL
  SELECT id, 'ユーラシア大陸',   true,  2 FROM q1 UNION ALL
  SELECT id, '北アメリカ大陸',   false, 3 FROM q1 UNION ALL
  SELECT id, '南アメリカ大陸',   false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'アフリカ大陸・南アメリカ大陸のみ',                   false, 1 FROM q2 UNION ALL
  SELECT id, 'アフリカ大陸・南アメリカ大陸・アジア（インドネシアなど）', true, 2 FROM q2 UNION ALL
  SELECT id, 'アジアのみ',                                         false, 3 FROM q2 UNION ALL
  SELECT id, 'オーストラリア大陸のみ',                             false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, 'アマゾン' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '東経120度', false, 1 FROM q4 UNION ALL
  SELECT id, '東経135度', true,  2 FROM q4 UNION ALL
  SELECT id, '東経140度', false, 3 FROM q4 UNION ALL
  SELECT id, '東経150度', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '加盟国間で共通通貨ユーロが全国で使われている',     false, 1 FROM q5 UNION ALL
  SELECT id, '加盟国間では原則として国境での通行が自由になっている', true, 2 FROM q5 UNION ALL
  SELECT id, 'アメリカも加盟している',                           false, 3 FROM q5 UNION ALL
  SELECT id, '軍事同盟として設立された組織である',               false, 4 FROM q5
)

SELECT 'social world-geography done' AS result;

-- ③ 古代（縄文〜平安）
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'social' AND t.slug = 'ancient-japan'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '奈良時代に都が置かれた場所を選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '聖徳太子が定めたものを選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '大化の改新が起きた年は{{1}}年で、中心人物は中大兄皇子と{{2}}である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '平安時代に栄えた文化として正しいものを選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '「源氏物語」の作者を選びなさい。', 1, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '平城京（奈良）', true,  1 FROM q1 UNION ALL
  SELECT id, '平安京（京都）', false, 2 FROM q1 UNION ALL
  SELECT id, '藤原京（橿原）', false, 3 FROM q1 UNION ALL
  SELECT id, '難波宮（大阪）', false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '参勤交代と鎖国',                         false, 1 FROM q2 UNION ALL
  SELECT id, '冠位十二階と十七条の憲法',               true,  2 FROM q2 UNION ALL
  SELECT id, '班田収授法と墾田永年私財法',             false, 3 FROM q2 UNION ALL
  SELECT id, '武家諸法度と禁中並公家諸法度',           false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '645'   FROM q3 UNION ALL
  SELECT id, 2, '中臣鎌足' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '天平文化（仏教文化）',   false, 1 FROM q4 UNION ALL
  SELECT id, '国風文化（かな文字など）', true, 2 FROM q4 UNION ALL
  SELECT id, '桃山文化（豪華な文化）', false, 3 FROM q4 UNION ALL
  SELECT id, '元禄文化（町人文化）',   false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '清少納言', false, 1 FROM q5 UNION ALL
  SELECT id, '紫式部',   true,  2 FROM q5 UNION ALL
  SELECT id, '和泉式部', false, 3 FROM q5 UNION ALL
  SELECT id, '小野小町', false, 4 FROM q5
)

SELECT 'social ancient done' AS result;

-- ④ 中世・近世（鎌倉〜江戸）
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'social' AND t.slug = 'medieval-japan'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '鎌倉幕府を開いた人物を選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '元寇（蒙古襲来）が起きた時代を選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '江戸幕府を開いた人物は{{1}}で、3代将軍は{{2}}である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '江戸幕府が大名を統制するために定めた制度を選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '室町時代に起きた「応仁の乱」について正しいものを選びなさい。', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '平清盛', false, 1 FROM q1 UNION ALL
  SELECT id, '源頼朝', true,  2 FROM q1 UNION ALL
  SELECT id, '源義経', false, 3 FROM q1 UNION ALL
  SELECT id, '北条時宗', false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '平安時代', false, 1 FROM q2 UNION ALL
  SELECT id, '鎌倉時代', true,  2 FROM q2 UNION ALL
  SELECT id, '室町時代', false, 3 FROM q2 UNION ALL
  SELECT id, '江戸時代', false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '徳川家康'   FROM q3 UNION ALL
  SELECT id, 2, '徳川家光'   FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '分国法',     false, 1 FROM q4 UNION ALL
  SELECT id, '参勤交代',   true,  2 FROM q4 UNION ALL
  SELECT id, '惣村制度',   false, 3 FROM q4 UNION ALL
  SELECT id, '株仲間の公認', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '1467年に起き、戦国時代のきっかけとなった', true,  1 FROM q5 UNION ALL
  SELECT id, '1338年に起き、南北朝の合一がなされた',     false, 2 FROM q5 UNION ALL
  SELECT id, '1573年に起き、室町幕府が滅亡した',         false, 3 FROM q5 UNION ALL
  SELECT id, '元寇への対応をきっかけに起きた内乱',       false, 4 FROM q5
)

SELECT 'social medieval done' AS result;

-- ⑤ 近代・現代（明治以降）
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'social' AND t.slug = 'modern-japan'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '明治維新が始まった年を選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '日清戦争（1894年）の講和条約を選びなさい。', 2, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '日本国憲法が施行されたのは{{1}}年{{2}}月3日である。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '第二次世界大戦後に日本を占領した連合国の機関を選びなさい。', 2, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '日本の高度経済成長期はいつごろか選びなさい。', 2, 5 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '1853年', false, 1 FROM q1 UNION ALL
  SELECT id, '1868年', true,  2 FROM q1 UNION ALL
  SELECT id, '1889年', false, 3 FROM q1 UNION ALL
  SELECT id, '1912年', false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'ポーツマス条約', false, 1 FROM q2 UNION ALL
  SELECT id, '下関条約',       true,  2 FROM q2 UNION ALL
  SELECT id, '日米安全保障条約', false, 3 FROM q2 UNION ALL
  SELECT id, 'サンフランシスコ平和条約', false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '1947' FROM q3 UNION ALL
  SELECT id, 2, '5'    FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, 'NATO（北大西洋条約機構）', false, 1 FROM q4 UNION ALL
  SELECT id, 'GHQ（連合国軍最高司令官総司令部）', true, 2 FROM q4 UNION ALL
  SELECT id, 'PKO（国連平和維持活動）', false, 3 FROM q4 UNION ALL
  SELECT id, 'IMF（国際通貨基金）',     false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '1930年代',             false, 1 FROM q5 UNION ALL
  SELECT id, '1955年〜1973年ごろ',   true,  2 FROM q5 UNION ALL
  SELECT id, '1980年代のバブル期',   false, 3 FROM q5 UNION ALL
  SELECT id, '2000年以降',           false, 4 FROM q5
)

SELECT 'social modern done' AS result;

-- ⑥ 日本国憲法・政治
WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t JOIN subjects s ON t."subjectId" = s.id
  WHERE s.slug = 'social' AND t.slug = 'constitution'
),
q1 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '日本国憲法の三大原則をすべて含むものを選びなさい。', 1, 1 FROM topic RETURNING id
),
q2 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '国会の役割として正しいものを選びなさい。', 1, 2 FROM topic RETURNING id
),
q3 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'fill_blank', '三権分立のうち、法律をつくる権限（{{1}}権）は国会、法を執行する（{{2}}権）は内閣、争いを裁く（{{3}}権）は裁判所が担う。', 2, 3 FROM topic RETURNING id
),
q4 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '日本の選挙権が与えられる年齢を選びなさい。', 1, 4 FROM topic RETURNING id
),
q5 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'multiple_choice', '衆議院と参議院の違いとして正しいものを選びなさい。', 2, 5 FROM topic RETURNING id
),
q6 AS (
  INSERT INTO questions ("topicId", type, body, difficulty, "displayOrder")
  SELECT topic_id, 'ordering', '日本国憲法の改正手順を正しい順番に並べなさい。', 3, 6 FROM topic RETURNING id
),

c1 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '国民主権・基本的人権の尊重・平和主義', true,  1 FROM q1 UNION ALL
  SELECT id, '国民主権・法の支配・三権分立',         false, 2 FROM q1 UNION ALL
  SELECT id, '平和主義・民主主義・資本主義',         false, 3 FROM q1 UNION ALL
  SELECT id, '基本的人権・社会主義・平和主義',       false, 4 FROM q1
),
c2 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '法律を執行する行政を行う',         false, 1 FROM q2 UNION ALL
  SELECT id, '法律をつくる立法を行う',           true,  2 FROM q2 UNION ALL
  SELECT id, '裁判によって争いを解決する',       false, 3 FROM q2 UNION ALL
  SELECT id, '条約を締結する',                   false, 4 FROM q2
),
a3 AS (
  INSERT INTO question_blank_answers ("questionId", "blankIndex", "correctAnswer")
  SELECT id, 1, '立法' FROM q3 UNION ALL
  SELECT id, 2, '行政' FROM q3 UNION ALL
  SELECT id, 3, '司法' FROM q3
),
c4 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '16歳以上', false, 1 FROM q4 UNION ALL
  SELECT id, '18歳以上', true,  2 FROM q4 UNION ALL
  SELECT id, '20歳以上', false, 3 FROM q4 UNION ALL
  SELECT id, '25歳以上', false, 4 FROM q4
),
c5 AS (
  INSERT INTO question_choices ("questionId", body, "isCorrect", "displayOrder")
  SELECT id, '衆議院の任期は6年、参議院は4年', false, 1 FROM q5 UNION ALL
  SELECT id, '衆議院には解散があるが、参議院にはない', true, 2 FROM q5 UNION ALL
  SELECT id, '参議院の議員数の方が多い',        false, 3 FROM q5 UNION ALL
  SELECT id, 'どちらも任期・権限は同じ',        false, 4 FROM q5
),
o6 AS (
  INSERT INTO question_order_items ("questionId", body, "correctPosition")
  SELECT id, '各議院の総議員の3分の2以上の賛成で発議', 1 FROM q6 UNION ALL
  SELECT id, '国民投票で有効投票の過半数の賛成',         2 FROM q6 UNION ALL
  SELECT id, '天皇が国民の名で公布',                     3 FROM q6
),
s1 AS (
  INSERT INTO question_steps ("questionId", "stepNumber", body)
  SELECT id, 1, '日本国憲法の三大原則は、①国民主権 ②基本的人権の尊重 ③平和主義（戦争放棄）の3つです。' FROM q1 UNION ALL
  SELECT id, 2, '第9条に「戦争の放棄・戦力の不保持・交戦権の否認」が定められています。' FROM q1
)

SELECT 'social constitution done' AS result;
