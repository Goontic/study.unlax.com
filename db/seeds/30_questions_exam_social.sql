-- 高校入試対策 社会 問題データ

-- ===== 地理・日本の地形と気候 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-social' AND t.slug = 'exam-geo-japan'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の標準時子午線（時間の基準）はどの経度ですか？',4,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「フォッサマグナ」とは何ですか？',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本海側の気候の特徴はどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','瀬戸内海式気候の特徴はどれですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の排他的経済水域（EEZ）の範囲はどこまでですか？',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の最南端の島はどれですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'140度',false,1 FROM q1 UNION ALL SELECT id,'東経135度',true,2 FROM q1 UNION ALL SELECT id','東経125度',false,3 FROM q1 UNION ALL SELECT id,'東経150度',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'日本一深い湖',false,1 FROM q2 UNION ALL SELECT id,'本州を東西に分断する大地溝帯',true,2 FROM q2 UNION ALL SELECT id','日本最大の火山',false,3 FROM q2 UNION ALL SELECT id,'本州の最も細い部分',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'年間を通じて雨が少ない',false,1 FROM q3 UNION ALL SELECT id,'冬に雪・雨が多く、夏は晴れが多い',true,2 FROM q3 UNION ALL SELECT id','常に高温多湿',false,3 FROM q3 UNION ALL SELECT id,'夏に雨が多く、冬は少ない',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'冬に雪が多い',false,1 FROM q4 UNION ALL SELECT id,'年間を通じて降水量が少なく温暖',true,2 FROM q4 UNION ALL SELECT id','夏に雨が非常に多い',false,3 FROM q4 UNION ALL SELECT id,'常に気温が低い',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'海岸線から100海里',false,1 FROM q5 UNION ALL SELECT id,'海岸線から200海里',true,2 FROM q5 UNION ALL SELECT id','海岸線から50海里',false,3 FROM q5 UNION ALL SELECT id'海岸線から400海里',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'与那国島',false,1 FROM q6 UNION ALL SELECT id,'沖ノ鳥島',true,2 FROM q6 UNION ALL SELECT id','南鳥島',false,3 FROM q6 UNION ALL SELECT id,'択捉島',false,4 FROM q6),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'日本の標準時子午線は東経135度（兵庫県明石市付近）を通ります。日本はUTC+9（協定世界時より9時間進む）です。' FROM q1)
SELECT 'exam-geo-japan done';

-- ===== 地理・世界の地域 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-social' AND t.slug = 'exam-geo-world'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','世界最大の面積を持つ国はどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','赤道が通る大陸はどれですか？',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','アマゾン川が流れる国はどれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','EUの本部はどこにありますか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','世界で最も人口が多い国はどれですか？（2024年現在）',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「BRICS」に含まれる国として正しいのはどれですか？',4,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'カナダ',false,1 FROM q1 UNION ALL SELECT id,'ロシア',true,2 FROM q1 UNION ALL SELECT id','中国',false,3 FROM q1 UNION ALL SELECT id,'アメリカ',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'ヨーロッパ・オーストラリア',false,1 FROM q2 UNION ALL SELECT id,'アフリカ・南アメリカ・アジア',true,2 FROM q2 UNION ALL SELECT id','北アメリカのみ',false,3 FROM q2 UNION ALL SELECT id,'南極大陸',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'アルゼンチン',false,1 FROM q3 UNION ALL SELECT id,'ブラジル',true,2 FROM q3 UNION ALL SELECT id','ペルー',false,3 FROM q3 UNION ALL SELECT id,'コロンビア',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'ロンドン',false,1 FROM q4 UNION ALL SELECT id,'ブリュッセル（ベルギー）',true,2 FROM q4 UNION ALL SELECT id','パリ',false,3 FROM q4 UNION ALL SELECT id,'ベルリン',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'中国',false,1 FROM q5 UNION ALL SELECT id,'インド',true,2 FROM q5 UNION ALL SELECT id','アメリカ',false,3 FROM q5 UNION ALL SELECT id','インドネシア',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'日本・アメリカ・カナダ・EU',false,1 FROM q6 UNION ALL SELECT id,'ブラジル・ロシア・インド・中国・南アフリカ',true,2 FROM q6 UNION ALL SELECT id','フランス・ドイツ・イギリス・アメリカ・日本',false,3 FROM q6 UNION ALL SELECT id','G7諸国',false,4 FROM q6),
s5  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'2024年現在、インドが中国を抜いて世界最多人口国になりました。14億人を超えています。' FROM q5)
SELECT 'exam-geo-world done';

-- ===== 歴史・鎌倉〜室町・戦国 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-social' AND t.slug = 'exam-hist-medieval'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','鎌倉幕府を開いたのはだれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「元寇」はいつ起きましたか？',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','室町幕府を開いたのはだれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','応仁の乱はいつ始まりましたか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','戦国時代に「楽市楽座」を行ったのはだれですか？',4,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「本能寺の変」で織田信長を討ったのはだれですか？',4,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'平清盛',false,1 FROM q1 UNION ALL SELECT id,'源頼朝',true,2 FROM q1 UNION ALL SELECT id','北条時宗',false,3 FROM q1 UNION ALL SELECT id,'足利尊氏',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1221年',false,1 FROM q2 UNION ALL SELECT id,'1274年・1281年',true,2 FROM q2 UNION ALL SELECT id','1336年',false,3 FROM q2 UNION ALL SELECT id'1467年',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'源頼朝',false,1 FROM q3 UNION ALL SELECT id,'足利尊氏',true,2 FROM q3 UNION ALL SELECT id','北条時宗',false,3 FROM q3 UNION ALL SELECT id,'後醍醐天皇',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1336年',false,1 FROM q4 UNION ALL SELECT id,'1467年',true,2 FROM q4 UNION ALL SELECT id','1573年',false,3 FROM q4 UNION ALL SELECT id'1600年',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'豊臣秀吉',false,1 FROM q5 UNION ALL SELECT id,'織田信長',true,2 FROM q5 UNION ALL SELECT id','徳川家康',false,3 FROM q5 UNION ALL SELECT id,'足利義昭',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'豊臣秀吉',false,1 FROM q6 UNION ALL SELECT id,'明智光秀',true,2 FROM q6 UNION ALL SELECT id','徳川家康',false,3 FROM q6 UNION ALL SELECT id,'柴田勝家',false,4 FROM q6),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'元寇は2回ありました。1274年（文永の役）と1281年（弘安の役）。北条時宗が執権として防衛しました。' FROM q2)
SELECT 'exam-hist-medieval done';

-- ===== 歴史・昭和〜現代 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-social' AND t.slug = 'exam-hist-contemp'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','太平洋戦争が始まったのはいつですか？',4,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本が第二次世界大戦で降伏したのはいつですか？',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本国憲法が施行されたのはいつですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','1960〜70年代の日本の急速な経済成長を何といいますか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「バブル経済」はいつごろの日本の出来事ですか？',4,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1939年',false,1 FROM q1 UNION ALL SELECT id,'1941年',true,2 FROM q1 UNION ALL SELECT id','1943年',false,3 FROM q1 UNION ALL SELECT id'1937年',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1943年8月15日',false,1 FROM q2 UNION ALL SELECT id,'1945年8月15日',true,2 FROM q2 UNION ALL SELECT id','1944年8月15日',false,3 FROM q2 UNION ALL SELECT id'1946年8月15日',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1945年',false,1 FROM q3 UNION ALL SELECT id,'1947年5月3日',true,2 FROM q3 UNION ALL SELECT id','1948年',false,3 FROM q3 UNION ALL SELECT id'1952年',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'経済成長率（けいざい）',false,1 FROM q4 UNION ALL SELECT id,'高度経済成長',true,2 FROM q4 UNION ALL SELECT id','産業革命',false,3 FROM q4 UNION ALL SELECT id'バブル経済',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1960年代',false,1 FROM q5 UNION ALL SELECT id,'1980年代後半〜1990年代初頭',true,2 FROM q5 UNION ALL SELECT id','2000年代',false,3 FROM q5 UNION ALL SELECT id'1950年代',false,4 FROM q5),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'1941年12月8日（日本時間）、真珠湾攻撃によって太平洋戦争（対米英戦争）が始まりました。' FROM q1),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'日本国憲法は1946年11月3日に公布され、1947年5月3日に施行されました。' FROM q3)
SELECT 'exam-hist-contemp done';

-- ===== 公民・政治のしくみ =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'exam-social' AND t.slug = 'exam-civics-politics'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本国憲法の三大原則はどれですか？',4,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の国会は衆議院と参議院の二院制ですが、衆議院の優越が認められている事項はどれですか？',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','内閣の仕事として正しいものはどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','裁判員制度とはどのような制度ですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の選挙権は何歳以上ですか？（2016年改正後）',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「三権分立」とはどのような制度ですか？',4,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'自由・平等・博愛',false,1 FROM q1 UNION ALL SELECT id,'国民主権・基本的人権の尊重・平和主義',true,2 FROM q1 UNION ALL SELECT id','民主主義・資本主義・三権分立',false,3 FROM q1 UNION ALL SELECT id'自由・人権・法の下の平等',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'外交条約の批准',false,1 FROM q2 UNION ALL SELECT id,'予算の先議権・法律の再可決・内閣総理大臣の指名',true,2 FROM q2 UNION ALL SELECT id','最高裁判所裁判官の任命',false,3 FROM q2 UNION ALL SELECT id'憲法改正の発議',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'法律を作る',false,1 FROM q3 UNION ALL SELECT id,'法律を執行し、政策を実施する（行政権）',true,2 FROM q3 UNION ALL SELECT id','争いを裁く',false,3 FROM q3 UNION ALL SELECT id'条約を批准する',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'国民が国政に関与する制度',false,1 FROM q4 UNION ALL SELECT id,'くじで選ばれた国民が刑事裁判に参加する制度',true,2 FROM q4 UNION ALL SELECT id','国民が法律を作る制度',false,3 FROM q4 UNION ALL SELECT id'国民が政治家を直接選ぶ制度',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'20歳以上',false,1 FROM q5 UNION ALL SELECT id,'18歳以上',true,2 FROM q5 UNION ALL SELECT id','25歳以上',false,3 FROM q5 UNION ALL SELECT id'16歳以上',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'3つの政党が権力を分け合う制度',false,1 FROM q6 UNION ALL SELECT id,'立法・行政・司法が互いを監視し権力の集中を防ぐ制度',true,2 FROM q6 UNION ALL SELECT id','3人の首相が交代で政治を行う制度',false,3 FROM q6 UNION ALL SELECT id'3つの地方が独立して政治を行う制度',false,4 FROM q6),
s1  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'日本国憲法の三大原則：国民主権（政治の権力は国民にある）・基本的人権の尊重・平和主義（戦争の放棄）です。' FROM q1),
s6  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'三権分立：立法（国会）・行政（内閣）・司法（裁判所）が互いに監視し合い、権力の専制を防ぎます。' FROM q6)
SELECT 'exam-civics-politics done';
