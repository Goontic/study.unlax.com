-- 小学校社会 問題データ（3〜6年）

-- ===== わたしたちのまち（3年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-social' AND t.slug = 'local-community'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','地図で北はどの方向ですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','地図記号で「ゆうびんきょく」を表すのはどれですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','地図の縮尺1:25000で1cmは実際に何mですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','まちのようすを調べるとき、何を使いますか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','地図記号で田（水田）を表すのはどれですか？',2,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'右',false,1 FROM q1 UNION ALL SELECT id,'上',true,2 FROM q1 UNION ALL SELECT id,'左',false,3 FROM q1 UNION ALL SELECT id,'下',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'〒',true,1 FROM q2 UNION ALL SELECT id,'十',false,2 FROM q2 UNION ALL SELECT id,'⊠',false,3 FROM q2 UNION ALL SELECT id,'✕',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'250m',true,1 FROM q3 UNION ALL SELECT id,'25m',false,2 FROM q3 UNION ALL SELECT id,'2500m',false,3 FROM q3 UNION ALL SELECT id,'2.5m',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'辞書',false,1 FROM q4 UNION ALL SELECT id,'地図や見学',true,2 FROM q4 UNION ALL SELECT id,'算数のノート',false,3 FROM q4 UNION ALL SELECT id,'理科の本',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'波線',false,1 FROM q5 UNION ALL SELECT id,'格子状の模様（水田記号）',true,2 FROM q5 UNION ALL SELECT id,'三角',false,3 FROM q5 UNION ALL SELECT id'丸',false,4 FROM q5),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'縮尺1:25000なら、地図の1cm＝実際の25000cm＝250mです。' FROM q3)
SELECT 'local-community done';

-- ===== 都道府県と地方（4年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-social' AND t.slug = 'prefectures-japan'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本には都道府県がいくつありますか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','東北地方にはいくつの県がありますか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本で一番面積が大きい都道府県はどれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','九州地方の県はいくつですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','関東地方の都県はいくつですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','北海道地方は何県何道ですか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の首都はどこですか？',1,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','近畿地方の中心都市はどこですか？',2,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'43',false,1 FROM q1 UNION ALL SELECT id,'47',true,2 FROM q1 UNION ALL SELECT id,'50',false,3 FROM q1 UNION ALL SELECT id,'52',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'5県',false,1 FROM q2 UNION ALL SELECT id,'6県',true,2 FROM q2 UNION ALL SELECT id,'7県',false,3 FROM q2 UNION ALL SELECT id,'4県',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'岩手県',false,1 FROM q3 UNION ALL SELECT id,'北海道',true,2 FROM q3 UNION ALL SELECT id,'長野県',false,3 FROM q3 UNION ALL SELECT id,'新潟県',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'6県',false,1 FROM q4 UNION ALL SELECT id,'7県',true,2 FROM q4 UNION ALL SELECT id,'8県',false,3 FROM q4 UNION ALL SELECT id,'5県',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'6つ',false,1 FROM q5 UNION ALL SELECT id,'7つ',true,2 FROM q5 UNION ALL SELECT id,'8つ',false,3 FROM q5 UNION ALL SELECT id,'5つ',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1県',false,1 FROM q6 UNION ALL SELECT id,'1道',true,2 FROM q6 UNION ALL SELECT id,'1都',false,3 FROM q6 UNION ALL SELECT id,'1府',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'大阪',false,1 FROM q7 UNION ALL SELECT id,'東京',true,2 FROM q7 UNION ALL SELECT id,'名古屋',false,3 FROM q7 UNION ALL SELECT id,'京都',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'名古屋',false,1 FROM q8 UNION ALL SELECT id,'大阪・京都',true,2 FROM q8 UNION ALL SELECT id,'広島',false,3 FROM q8 UNION ALL SELECT id,'福岡',false,4 FROM q8),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'東北地方：青森・岩手・宮城・秋田・山形・福島の6県です。' FROM q2),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'九州地方：福岡・佐賀・長崎・熊本・大分・宮崎・鹿児島・沖縄の8県（沖縄含む）→7県が一般的。福岡・佐賀・長崎・熊本・大分・宮崎・鹿児島の7県です。' FROM q4)
SELECT 'prefectures-japan done';

-- ===== 日本の地形と気候（5年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-social' AND t.slug = 'geography-japan'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本で一番高い山はどれですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本で一番長い川はどれですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の気候の特徴として正しいものはどれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の太平洋側の気候として正しいものはどれですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本で一番面積が広い湖はどれですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本列島を構成する4つの大きな島はどれですか？',3,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','北海道の気候の特徴はどれですか？',3,7 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'北岳',false,1 FROM q1 UNION ALL SELECT id,'富士山',true,2 FROM q1 UNION ALL SELECT id,'奥穂高岳',false,3 FROM q1 UNION ALL SELECT id,'槍ヶ岳',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'利根川',false,1 FROM q2 UNION ALL SELECT id,'信濃川',true,2 FROM q2 UNION ALL SELECT id,'石狩川',false,3 FROM q2 UNION ALL SELECT id,'木曽川',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'年中乾燥している',false,1 FROM q3 UNION ALL SELECT id,'四季がある・梅雨・台風がある',true,2 FROM q3 UNION ALL SELECT id,'常に寒い',false,3 FROM q3 UNION ALL SELECT id,'常に暑い',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'冬に雪が多い',false,1 FROM q4 UNION ALL SELECT id,'夏に雨が多く、冬は晴れが多い',true,2 FROM q4 UNION ALL SELECT id,'年中乾燥',false,3 FROM q4 UNION ALL SELECT id,'夏も冬も雨が多い',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'霞ヶ浦',false,1 FROM q5 UNION ALL SELECT id,'琵琶湖',true,2 FROM q5 UNION ALL SELECT id,'サロマ湖',false,3 FROM q5 UNION ALL SELECT id,'猪苗代湖',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'北海道・本州・四国・九州',true,1 FROM q6 UNION ALL SELECT id,'北海道・本州・四国・沖縄',false,2 FROM q6 UNION ALL SELECT id,'本州・四国・九州・沖縄',false,3 FROM q6 UNION ALL SELECT id,'北海道・本州・九州・沖縄',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'夏が長く暑い',false,1 FROM q7 UNION ALL SELECT id,'梅雨がなく、冬は寒くて雪が多い',true,2 FROM q7 UNION ALL SELECT id,'年中温暖',false,3 FROM q7 UNION ALL SELECT id,'台風が多い',false,4 FROM q7),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'日本は四季があり（春夏秋冬）、梅雨の時期や秋の台風シーズンが特徴的です。' FROM q3)
SELECT 'geography-japan done';

-- ===== 日本の産業（農業・工業）（5年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-social' AND t.slug = 'industry-japan'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本の代表的な農業地帯として有名な都道府県はどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本が主に輸入する農作物はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','自動車工業が盛んな地域として有名なのはどこですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「京浜工業地帯」はどこにありますか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','農業で米の収穫量が最も多い都道府県はどれですか？',3,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'沖縄県',false,1 FROM q1 UNION ALL SELECT id,'北海道',true,2 FROM q1 UNION ALL SELECT id,'東京都',false,3 FROM q1 UNION ALL SELECT id,'大阪府',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'米',false,1 FROM q2 UNION ALL SELECT id,'小麦・大豆・とうもろこし',true,2 FROM q2 UNION ALL SELECT id,'みかん',false,3 FROM q2 UNION ALL SELECT id,'りんご',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'沖縄県',false,1 FROM q3 UNION ALL SELECT id,'愛知県（豊田市）',true,2 FROM q3 UNION ALL SELECT id,'北海道',false,3 FROM q3 UNION ALL SELECT id,'鹿児島県',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'大阪〜神戸',false,1 FROM q4 UNION ALL SELECT id,'東京〜横浜',true,2 FROM q4 UNION ALL SELECT id,'名古屋',false,3 FROM q4 UNION ALL SELECT id,'福岡〜北九州',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'秋田県',false,1 FROM q5 UNION ALL SELECT id,'新潟県',true,2 FROM q5 UNION ALL SELECT id,'北海道',false,3 FROM q5 UNION ALL SELECT id,'青森県',false,4 FROM q5),
s3  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'愛知県豊田市はトヨタ自動車の本拠地で、日本有数の自動車工業の中心地です。' FROM q3)
SELECT 'industry-japan done';

-- ===== 縄文〜奈良時代（6年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-social' AND t.slug = 'history-ancient'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','縄文時代の人々が使っていた器を何といいますか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','弥生時代に始まった農業はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','聖徳太子が作った「十七条の憲法」はいつ作られましたか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','大化の改新はいつ起きましたか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','奈良の都（平城京）を作ったのはだれですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','奈良時代に建てられた「東大寺の大仏」を作ったのはだれですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'弥生土器',false,1 FROM q1 UNION ALL SELECT id,'縄文土器',true,2 FROM q1 UNION ALL SELECT id,'土師器',false,3 FROM q1 UNION ALL SELECT id,'青銅器',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'麦の農業',false,1 FROM q2 UNION ALL SELECT id,'稲作（水田耕作）',true,2 FROM q2 UNION ALL SELECT id,'果樹栽培',false,3 FROM q2 UNION ALL SELECT id,'牧畜',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'593年',false,1 FROM q3 UNION ALL SELECT id,'604年',true,2 FROM q3 UNION ALL SELECT id,'710年',false,3 FROM q3 UNION ALL SELECT id,'645年',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'593年',false,1 FROM q4 UNION ALL SELECT id,'645年',true,2 FROM q4 UNION ALL SELECT id,'710年',false,3 FROM q4 UNION ALL SELECT id,'794年',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'聖武天皇',false,1 FROM q5 UNION ALL SELECT id,'元明天皇',true,2 FROM q5 UNION ALL SELECT id,'推古天皇',false,3 FROM q5 UNION ALL SELECT id,'天武天皇',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'聖徳太子',false,1 FROM q6 UNION ALL SELECT id,'聖武天皇',true,2 FROM q6 UNION ALL SELECT id,'元明天皇',false,3 FROM q6 UNION ALL SELECT id,'中大兄皇子',false,4 FROM q6),
s4  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'大化の改新は645年、中大兄皇子（なかのおおえのおうじ）と中臣鎌足（なかとみのかまたり）によって行われた政治改革です。' FROM q4)
SELECT 'history-ancient done';

-- ===== 江戸〜明治時代（6年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subjectId"
  WHERE s.slug = 'elem-social' AND t.slug = 'history-modern'
),
q1  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','江戸幕府を開いたのはだれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「鎖国」政策で江戸時代に貿易を許されていた国はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','明治維新はいつ始まりましたか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','「殖産興業」の意味はどれですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topicId",type,body,difficulty,"displayOrder") SELECT tid,'multiple_choice','日本最初の憲法（大日本帝国憲法）が発布されたのはいつですか？',3,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'豊臣秀吉',false,1 FROM q1 UNION ALL SELECT id,'徳川家康',true,2 FROM q1 UNION ALL SELECT id,'織田信長',false,3 FROM q1 UNION ALL SELECT id,'徳川秀忠',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'イギリス・フランス',false,1 FROM q2 UNION ALL SELECT id,'オランダ・清（中国）',true,2 FROM q2 UNION ALL SELECT id,'アメリカ・ロシア',false,3 FROM q2 UNION ALL SELECT id,'スペイン・ポルトガル',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1853年',false,1 FROM q3 UNION ALL SELECT id,'1868年',true,2 FROM q3 UNION ALL SELECT id,'1900年',false,3 FROM q3 UNION ALL SELECT id,'1853年',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'農業を盛んにする政策',false,1 FROM q4 UNION ALL SELECT id,'産業や工業を育てて国を豊かにする政策',true,2 FROM q4 UNION ALL SELECT id,'武士道を広める政策',false,3 FROM q4 UNION ALL SELECT id,'鎖国を続ける政策',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("questionId",body,"isCorrect","displayOrder") SELECT id,'1868年',false,1 FROM q5 UNION ALL SELECT id,'1889年',true,2 FROM q5 UNION ALL SELECT id,'1912年',false,3 FROM q5 UNION ALL SELECT id,'1894年',false,4 FROM q5),
s2  AS (INSERT INTO question_steps ("questionId","stepNumber",body) SELECT id,1,'江戸時代の鎖国でもオランダ（出島）と清（中国）との貿易は例外的に続けられました。' FROM q2)
SELECT 'history-modern done';
