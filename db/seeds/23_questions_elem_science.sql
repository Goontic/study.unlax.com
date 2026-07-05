-- 小学校理科 問題データ（3〜6年）

-- ===== 植物のそだち方（3年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-science' AND t.slug = 'plants-basic'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','たねをまいてから最初に出てくる葉を何といいますか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','植物が成長するために必要なものはどれですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','ホウセンカのたねはどの形ですか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','植物の根のはたらきは何ですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','花が咲いたあと、たねになる部分はどれですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','植物の茎のはたらきは何ですか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','アサガオは1日のうちいつ花を咲かせますか？',2,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','植物の葉のはたらきとして正しいものはどれですか？',2,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'本葉',false,1 FROM q1 UNION ALL SELECT id,'子葉',true,2 FROM q1 UNION ALL SELECT id,'花びら',false,3 FROM q1 UNION ALL SELECT id,'がく',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'水・光・空気（土）',true,1 FROM q2 UNION ALL SELECT id,'水だけ',false,2 FROM q2 UNION ALL SELECT id,'光だけ',false,3 FROM q2 UNION ALL SELECT id,'土だけ',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'丸い形',false,1 FROM q3 UNION ALL SELECT id,'楕円の茶色いたね',true,2 FROM q3 UNION ALL SELECT id,'三角の形',false,3 FROM q3 UNION ALL SELECT id,'白くて細長い形',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'光合成をする',false,1 FROM q4 UNION ALL SELECT id,'水や養分を吸う',true,2 FROM q4 UNION ALL SELECT id,'酸素を出す',false,3 FROM q4 UNION ALL SELECT id,'花を咲かせる',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'花びら',false,1 FROM q5 UNION ALL SELECT id,'めしべの根元（子房）',true,2 FROM q5 UNION ALL SELECT id,'おしべ',false,3 FROM q5 UNION ALL SELECT id,'がく',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'光合成をする',false,1 FROM q6 UNION ALL SELECT id,'水や養分を全体に運ぶ',true,2 FROM q6 UNION ALL SELECT id,'水を吸い上げる',false,3 FROM q6 UNION ALL SELECT id,'酸素を取り入れる',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'昼ごろ',false,1 FROM q7 UNION ALL SELECT id,'朝早く',true,2 FROM q7 UNION ALL SELECT id,'夜',false,3 FROM q7 UNION ALL SELECT id,'夕方',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'水を吸い上げる',false,1 FROM q8 UNION ALL SELECT id,'光合成をして養分をつくる',true,2 FROM q8 UNION ALL SELECT id,'根から水を取り込む',false,3 FROM q8 UNION ALL SELECT id,'花を咲かせる',false,4 FROM q8),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'たねから最初に出る葉を「子葉」といいます。アサガオは子葉が2枚です。' FROM q1),
s4  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'根は地中に広がり、土から水や養分を吸い上げます。' FROM q4)
SELECT 'plants-basic done';

-- ===== 身近な生き物（3年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-science' AND t.slug = 'animals-basic'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','こん虫のからだは何つに分かれていますか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','バッタのあしは何本ですか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','こん虫ではないのはどれですか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','アゲハチョウのたまごはどこにうみつけられますか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','こん虫が成長する順序として正しいものはどれですか？',2,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','カブトムシの幼虫はどこに住んでいますか？',2,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','こん虫のはねは何枚のものが多いですか？',2,7 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2つ',false,1 FROM q1 UNION ALL SELECT id,'3つ（頭・むね・はら）',true,2 FROM q1 UNION ALL SELECT id,'4つ',false,3 FROM q1 UNION ALL SELECT id,'6つ',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'4本',false,1 FROM q2 UNION ALL SELECT id,'6本',true,2 FROM q2 UNION ALL SELECT id,'8本',false,3 FROM q2 UNION ALL SELECT id,'10本',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'トンボ',false,1 FROM q3 UNION ALL SELECT id,'クモ',true,2 FROM q3 UNION ALL SELECT id,'チョウ',false,3 FROM q3 UNION ALL SELECT id,'カブトムシ',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'地面の穴',false,1 FROM q4 UNION ALL SELECT id,'サンショウなどの葉の裏',true,2 FROM q4 UNION ALL SELECT id,'木のうろ',false,3 FROM q4 UNION ALL SELECT id,'水の中',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'たまご→成虫→さなぎ',false,1 FROM q5 UNION ALL SELECT id,'たまご→幼虫→さなぎ→成虫',true,2 FROM q5 UNION ALL SELECT id,'幼虫→たまご→成虫',false,3 FROM q5 UNION ALL SELECT id,'たまご→さなぎ→幼虫→成虫',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'木の上',false,1 FROM q6 UNION ALL SELECT id,'土の中・腐葉土',true,2 FROM q6 UNION ALL SELECT id,'水の中',false,3 FROM q6 UNION ALL SELECT id,'石の下',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'2枚',false,1 FROM q7 UNION ALL SELECT id,'4枚',true,2 FROM q7 UNION ALL SELECT id,'6枚',false,3 FROM q7 UNION ALL SELECT id,'0枚',false,4 FROM q7),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'こん虫のからだは「頭・むね・はら」の3つに分かれています。' FROM q1),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'クモはあしが8本でからだが2つに分かれているので、こん虫ではありません。' FROM q3),
s5  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'チョウやカブトムシは「完全変態」：たまご→幼虫→さなぎ→成虫の順に育ちます。' FROM q5)
SELECT 'animals-basic done';

-- ===== 光と音（3年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-science' AND t.slug = 'light-sound'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','かがみで光を反射させるとき、光はどのように進みますか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','虫めがねで光を集めると、温度はどうなりますか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','音は何が振動することで伝わりますか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','糸でんわで話すとき、音はどのように伝わりますか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','かがみの枚数を増やして光を集めると、明るさはどうなりますか？',2,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'曲がって進む',false,1 FROM q1 UNION ALL SELECT id,'まっすぐに反射する',true,2 FROM q1 UNION ALL SELECT id,'消えてしまう',false,3 FROM q1 UNION ALL SELECT id,'散らばる',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'温度が下がる',false,1 FROM q2 UNION ALL SELECT id,'温度が上がる',true,2 FROM q2 UNION ALL SELECT id,'変わらない',false,3 FROM q2 UNION ALL SELECT id,'すぐ消える',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'光',false,1 FROM q3 UNION ALL SELECT id,'空気（ものの振動）',true,2 FROM q3 UNION ALL SELECT id,'水',false,3 FROM q3 UNION ALL SELECT id,'熱',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'電気で伝わる',false,1 FROM q4 UNION ALL SELECT id,'糸の振動として伝わる',true,2 FROM q4 UNION ALL SELECT id,'空気を通じて伝わる',false,3 FROM q4 UNION ALL SELECT id,'光として伝わる',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'明るさは変わらない',false,1 FROM q5 UNION ALL SELECT id,'明るくなる（温度も上がる）',true,2 FROM q5 UNION ALL SELECT id,'暗くなる',false,3 FROM q5 UNION ALL SELECT id,'明るさは下がるが温度は上がる',false,4 FROM q5),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'太鼓をたたくと皮が振動し、その振動が空気を通じて耳に届きます。' FROM q3)
SELECT 'light-sound done';

-- ===== 磁石のふしぎ（3年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-science' AND t.slug = 'magnets'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','磁石に引きつけられる材料はどれですか？',2,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','磁石のN極とS極を近づけるとどうなりますか？',2,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','磁石のN極とN極を近づけるとどうなりますか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','磁石のN極が指すのはどの方向ですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','鉄くぎを磁石でなぞると、くぎはどうなりますか？',2,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'木',false,1 FROM q1 UNION ALL SELECT id,'鉄',true,2 FROM q1 UNION ALL SELECT id,'プラスチック',false,3 FROM q1 UNION ALL SELECT id,'アルミ',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'反発する',false,1 FROM q2 UNION ALL SELECT id,'引き合う',true,2 FROM q2 UNION ALL SELECT id,'何も起こらない',false,3 FROM q2 UNION ALL SELECT id,'壊れる',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'引き合う',false,1 FROM q3 UNION ALL SELECT id,'反発する（遠ざかる）',true,2 FROM q3 UNION ALL SELECT id,'何も起こらない',false,3 FROM q3 UNION ALL SELECT id,'合体する',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'南',false,1 FROM q4 UNION ALL SELECT id,'北',true,2 FROM q4 UNION ALL SELECT id,'東',false,3 FROM q4 UNION ALL SELECT id,'西',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'熱くなる',false,1 FROM q5 UNION ALL SELECT id,'磁石の性質をもつようになる',true,2 FROM q5 UNION ALL SELECT id,'何も変わらない',false,3 FROM q5 UNION ALL SELECT id,'壊れる',false,4 FROM q5),
s2  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'異なる極（N極とS極）は引き合い、同じ極（N極とN極）は反発します。' FROM q2)
SELECT 'magnets done';

-- ===== 電気のはたらき（4年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-science' AND t.slug = 'electricity-basic'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','電流の流れる道すじをどのつなぎ方にすると、1つが切れても他のが光りますか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','乾電池2本を直列につなぐと電気の力はどうなりますか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','かん電池の＋極は赤色・－極は何色で表しますか？',2,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','電流が流れる回路として正しいものはどれですか？',2,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','電流計で電流を測るとき、どのようにつなぎますか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','並列つなぎの豆電球は直列つなぎと比べてどうですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'直列つなぎ',false,1 FROM q1 UNION ALL SELECT id,'並列つなぎ',true,2 FROM q1 UNION ALL SELECT id,'どちらでも同じ',false,3 FROM q1 UNION ALL SELECT id,'かんけいない',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'変わらない',false,1 FROM q2 UNION ALL SELECT id,'強くなる（2倍）',true,2 FROM q2 UNION ALL SELECT id,'弱くなる（半分）',false,3 FROM q2 UNION ALL SELECT id,'なくなる',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'青色',false,1 FROM q3 UNION ALL SELECT id,'黒色',false,2 FROM q3 UNION ALL SELECT id,'白色',false,3 FROM q3 UNION ALL SELECT id,'青色',true,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'とじた輪の形',true,1 FROM q4 UNION ALL SELECT id,'直線の形',false,2 FROM q4 UNION ALL SELECT id,'枝分かれした形（片方だけ）',false,3 FROM q4 UNION ALL SELECT id,'ばらばらの形',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'豆電球と並列につなぐ',false,1 FROM q5 UNION ALL SELECT id,'豆電球と直列（回路に直接）につなぐ',true,2 FROM q5 UNION ALL SELECT id,'どちらでもよい',false,3 FROM q5 UNION ALL SELECT id,'電池に直接つなぐ',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'暗くなる',false,1 FROM q6 UNION ALL SELECT id,'同じ明るさ（それぞれ独立）',true,2 FROM q6 UNION ALL SELECT id,'明るくなる',false,3 FROM q6 UNION ALL SELECT id,'つかなくなる',false,4 FROM q6),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'並列つなぎでは各豆電球に個別の電流路があるため、1つ切れても他の豆電球は光り続けます。' FROM q1)
SELECT 'electricity-basic done';

-- ===== もののとけ方（5年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-science' AND t.slug = 'dissolving'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','食塩が水に溶けた液を何といいますか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','水に溶ける量を増やすにはどうすればよいですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','食塩水のこさは場所によってちがいますか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','溶けたものを取り出すために水を蒸発させる方法を何といいますか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','ミョウバンをたくさん溶かした熱い水を冷やすとどうなりますか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','水50mLと食塩3gを混ぜた食塩水の重さは何gですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'食塩液',false,1 FROM q1 UNION ALL SELECT id,'食塩水（水溶液）',true,2 FROM q1 UNION ALL SELECT id,'塩化物',false,3 FROM q1 UNION ALL SELECT id,'塩水',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'水を少なくする',false,1 FROM q2 UNION ALL SELECT id,'水温を上げるか、水の量を増やす',true,2 FROM q2 UNION ALL SELECT id,'水を冷やす',false,3 FROM q2 UNION ALL SELECT id,'かき混ぜない',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'場所によって違う',false,1 FROM q3 UNION ALL SELECT id,'どこも同じ（均一）',true,2 FROM q3 UNION ALL SELECT id,'底が濃い',false,3 FROM q3 UNION ALL SELECT id,'表面が濃い',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'ろ過',false,1 FROM q4 UNION ALL SELECT id,'蒸発（蒸留）',true,2 FROM q4 UNION ALL SELECT id,'冷却',false,3 FROM q4 UNION ALL SELECT id,'圧縮',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'全部なくなる',false,1 FROM q5 UNION ALL SELECT id,'結晶が出てくる',true,2 FROM q5 UNION ALL SELECT id,'変化しない',false,3 FROM q5 UNION ALL SELECT id,'水が増える',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'47g',false,1 FROM q6 UNION ALL SELECT id,'53g',true,2 FROM q6 UNION ALL SELECT id,'50g',false,3 FROM q6 UNION ALL SELECT id,'56g',false,4 FROM q6),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'溶質は水全体に均一に広がるので、どの部分でも濃さは同じです。' FROM q3),
s6  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'50mLの水は50g（水1mL≒1g）。50g＋3g＝53gです。' FROM q6)
SELECT 'dissolving done';

-- ===== 植物の働き・光合成（6年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-science' AND t.slug = 'plants-photosynthesis'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','植物が光を使って養分（でんぷん）をつくるはたらきを何といいますか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','光合成に必要なものはどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','光合成で作られるものはどれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','でんぷんの確認にはどのような液を使いますか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','植物が二酸化炭素を取り入れ、酸素を出す気孔はどこにありますか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','光合成によって放出される気体はどれですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'呼吸',false,1 FROM q1 UNION ALL SELECT id,'光合成',true,2 FROM q1 UNION ALL SELECT id,'蒸散',false,3 FROM q1 UNION ALL SELECT id,'消化',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'水のみ',false,1 FROM q2 UNION ALL SELECT id,'光・水・二酸化炭素',true,2 FROM q2 UNION ALL SELECT id,'酸素のみ',false,3 FROM q2 UNION ALL SELECT id,'窒素のみ',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'二酸化炭素',false,1 FROM q3 UNION ALL SELECT id,'でんぷん（糖）と酸素',true,2 FROM q3 UNION ALL SELECT id,'水',false,3 FROM q3 UNION ALL SELECT id,'窒素',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'リトマス液',false,1 FROM q4 UNION ALL SELECT id,'ヨウ素液',true,2 FROM q4 UNION ALL SELECT id,'ベネジクト液',false,3 FROM q4 UNION ALL SELECT id,'食塩水',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'根',false,1 FROM q5 UNION ALL SELECT id,'葉の裏（気孔）',true,2 FROM q5 UNION ALL SELECT id,'花びら',false,3 FROM q5 UNION ALL SELECT id,'茎',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'二酸化炭素',false,1 FROM q6 UNION ALL SELECT id,'酸素',true,2 FROM q6 UNION ALL SELECT id,'窒素',false,3 FROM q6 UNION ALL SELECT id,'水蒸気',false,4 FROM q6),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'光合成：光＋二酸化炭素＋水→でんぷん（糖）＋酸素。植物が光のエネルギーで養分を作るはたらきです。' FROM q1),
s4  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'ヨウ素液はでんぷんに触れると青紫色に変わります。' FROM q4)
SELECT 'plants-photosynthesis done';

-- ===== 月と太陽（6年） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'elem-science' AND t.slug = 'earth-moon'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','月は自ら光を出していますか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','月の形が変わって見える理由は何ですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','満月は約何日ごとに見られますか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','太陽の黒い斑点を何といいますか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','月が地球の周りを1周するのに約何日かかりますか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','太陽が月に隠れる現象を何といいますか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'出している',false,1 FROM q1 UNION ALL SELECT id,'出していない（太陽の光を反射している）',true,2 FROM q1 UNION ALL SELECT id,'光らない',false,3 FROM q1 UNION ALL SELECT id,'熱を出している',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'月の形が変わるから',false,1 FROM q2 UNION ALL SELECT id,'月・地球・太陽の位置が変わり、見える部分が変わるから',true,2 FROM q2 UNION ALL SELECT id,'月が光ったり消えたりするから',false,3 FROM q2 UNION ALL SELECT id,'雲がかかるから',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'7日ごと',false,1 FROM q3 UNION ALL SELECT id,'約30日（約1か月）ごと',true,2 FROM q3 UNION ALL SELECT id,'365日ごと',false,3 FROM q3 UNION ALL SELECT id,'3日ごと',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'太陽斑',false,1 FROM q4 UNION ALL SELECT id,'黒点',true,2 FROM q4 UNION ALL SELECT id,'日食',false,3 FROM q4 UNION ALL SELECT id,'陰',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'7日',false,1 FROM q5 UNION ALL SELECT id,'約30日',true,2 FROM q5 UNION ALL SELECT id,'365日',false,3 FROM q5 UNION ALL SELECT id,'24時間',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'月食',false,1 FROM q6 UNION ALL SELECT id,'日食',true,2 FROM q6 UNION ALL SELECT id,'皆既食',false,3 FROM q6 UNION ALL SELECT id,'金環食',false,4 FROM q6),
s2  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'月は太陽の光を反射しており、地球から見える月の光の当たる部分の形が変化して見えます。' FROM q2)
SELECT 'earth-moon done';
