-- 高校入試対策 国語 問題データ

-- ===== 漢字・語句 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-japanese' AND t.slug = 'exam-kanji-vocab'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「興味」の読み方はどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「知識を（かさ）ねる」の「かさ」の漢字はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「異口同音」の意味はどれですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「先手必勝」の意味はどれですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「過去の出来事を（かいこ）する」の「かいこ」の漢字はどれですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「臨機応変」の意味はどれですか？',4,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「彼は（けんきょ）な人だ」の「けんきょ」の漢字はどれですか？',3,7 FROM topic RETURNING id),
q8  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「矛盾」の意味はどれですか？',4,8 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'きょうみ',false,1 FROM q1 UNION ALL SELECT id,'こうみ',false,2 FROM q1 UNION ALL SELECT id,'きょうみ',true,3 FROM q1 UNION ALL SELECT id,'こうきょ',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'加',false,1 FROM q2 UNION ALL SELECT id,'重',true,2 FROM q2 UNION ALL SELECT id,'積',false,3 FROM q2 UNION ALL SELECT id,'倍',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'一人だけが異なる意見を言う',false,1 FROM q3 UNION ALL SELECT id,'多くの人が同じことを言う',true,2 FROM q3 UNION ALL SELECT id,'口が多いほど誤解が生まれる',false,3 FROM q3 UNION ALL SELECT id,'知識が豊富なこと',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'後から手を打てば勝てる',false,1 FROM q4 UNION ALL SELECT id,'先に手を打つ者が有利に勝てる',true,2 FROM q4 UNION ALL SELECT id,'最後まで諦めないこと',false,3 FROM q4 UNION ALL SELECT id,'勝負に備えて準備をすること',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'回顧',true,1 FROM q5 UNION ALL SELECT id,'回去',false,2 FROM q5 UNION ALL SELECT id,'回考',false,3 FROM q5 UNION ALL SELECT id,'懐古',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'状況に関係なく同じ行動をすること',false,1 FROM q6 UNION ALL SELECT id,'その場の状況に合わせて適切に対処すること',true,2 FROM q6 UNION ALL SELECT id,'何事も変化しないこと',false,3 FROM q6 UNION ALL SELECT id,'計画通りに進めること',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'謙虚',true,1 FROM q7 UNION ALL SELECT id,'賢挙',false,2 FROM q7 UNION ALL SELECT id,'建居',false,3 FROM q7 UNION ALL SELECT id,'見虚',false,4 FROM q7),
c8  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'物事が非常によくできていること',false,1 FROM q8 UNION ALL SELECT id,'前後や内容が食い違っていること',true,2 FROM q8 UNION ALL SELECT id,'困難を乗り越えること',false,3 FROM q8 UNION ALL SELECT id,'意見が一致していること',false,4 FROM q8),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'「異口」＝異なる口（多くの人）、「同音」＝同じ声。多くの人が口をそろえて同じことを言うという意味です。' FROM q3),
s8  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'「矛盾」の語源：「どんな盾も貫く矛」と「どんな矛も防ぐ盾」が同時に存在できないことから、論理的な食い違いを意味します。' FROM q8)
SELECT 'exam-kanji-vocab done';

-- ===== 現代文読解（説明文・論説文） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-japanese' AND t.slug = 'exam-modern-prose'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','論説文を読むとき、筆者の主張を見つけるのに役立つ接続語はどれですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「逆接」を表す接続語はどれですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','説明文で「具体例」を示すときに使う接続語はどれですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「換言」を示す接続語はどれですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','論説文で筆者の主張は文章のどこに多く書かれていますか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「傍線部の理由を述べよ」という問題で答えを探す場所はどこですか？',3,6 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'しかし・だが',false,1 FROM q1 UNION ALL SELECT id,'つまり・したがって・だから',true,2 FROM q1 UNION ALL SELECT id,'例えば・たとえば',false,3 FROM q1 UNION ALL SELECT id,'また・さらに',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'つまり',false,1 FROM q2 UNION ALL SELECT id,'しかし・だが・けれども',true,2 FROM q2 UNION ALL SELECT id,'また・そして',false,3 FROM q2 UNION ALL SELECT id,'したがって',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'つまり',false,1 FROM q3 UNION ALL SELECT id,'例えば・たとえば',true,2 FROM q3 UNION ALL SELECT id,'しかし',false,3 FROM q3 UNION ALL SELECT id,'したがって',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'しかし',false,1 FROM q4 UNION ALL SELECT id,'つまり・すなわち・言い換えると',true,2 FROM q4 UNION ALL SELECT id,'例えば',false,3 FROM q4 UNION ALL SELECT id,'さらに・また',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'最初の段落のみ',false,1 FROM q5 UNION ALL SELECT id,'最後の段落・まとめの部分が多い',true,2 FROM q5 UNION ALL SELECT id,'中間の段落のみ',false,3 FROM q5 UNION ALL SELECT id,'どこにも書かれていない',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'傍線部より後の部分',false,1 FROM q6 UNION ALL SELECT id,'傍線部の前（直前〜数段落前）',true,2 FROM q6 UNION ALL SELECT id,'文章全体から推測',false,3 FROM q6 UNION ALL SELECT id,'傍線部そのものから',false,4 FROM q6),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'「つまり・したがって・要するに・だから」は筆者の結論や主張をまとめる接続語です。この前後に主張があります。' FROM q1),
s5  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'論説文では序論・本論・結論の構造が多く、結論（最後の段落）に主張がまとまることが多いです。' FROM q5)
SELECT 'exam-modern-prose done';

-- ===== 文法（品詞・文の組み立て） =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-japanese' AND t.slug = 'exam-grammar-jp'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「美しい」はどの品詞ですか？',3,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「走る」はどの品詞ですか？',3,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「静かだ」はどの品詞ですか？',3,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','文の主語を示す助詞はどれですか？',3,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「彼女が急いで走った。」という文の述語はどれですか？',3,5 FROM topic RETURNING id),
q6  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','動詞の未然形につく助動詞はどれですか？（否定を表す）',4,6 FROM topic RETURNING id),
q7  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「どんなに暑くても、彼は走り続けた。」の接続助詞はどれですか？',4,7 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'名詞',false,1 FROM q1 UNION ALL SELECT id,'形容詞',true,2 FROM q1 UNION ALL SELECT id,'副詞',false,3 FROM q1 UNION ALL SELECT id,'動詞',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'名詞',false,1 FROM q2 UNION ALL SELECT id,'動詞',true,2 FROM q2 UNION ALL SELECT id,'形容詞',false,3 FROM q2 UNION ALL SELECT id,'副詞',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'形容詞',false,1 FROM q3 UNION ALL SELECT id,'形容動詞',true,2 FROM q3 UNION ALL SELECT id,'副詞',false,3 FROM q3 UNION ALL SELECT id,'名詞',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'を',false,1 FROM q4 UNION ALL SELECT id,'が・は',true,2 FROM q4 UNION ALL SELECT id,'に',false,3 FROM q4 UNION ALL SELECT id,'と',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'彼女が',false,1 FROM q5 UNION ALL SELECT id,'走った',true,2 FROM q5 UNION ALL SELECT id,'急いで',false,3 FROM q5 UNION ALL SELECT id,'彼女',false,4 FROM q5),
c6  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'た',false,1 FROM q6 UNION ALL SELECT id,'ない',true,2 FROM q6 UNION ALL SELECT id,'れる',false,3 FROM q6 UNION ALL SELECT id,'ます',false,4 FROM q6),
c7  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'て',false,1 FROM q7 UNION ALL SELECT id,'ても',true,2 FROM q7 UNION ALL SELECT id,'が',false,3 FROM q7 UNION ALL SELECT id,'から',false,4 FROM q7),
s1  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'形容詞は「〜い」という形で終わり、物の性質や状態を表す品詞です。「美しい・大きい・楽しい」など。' FROM q1),
s3  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'形容動詞は「〜だ」「〜な」という形で終わる品詞です。「静かだ・きれいだ・有名だ」など。' FROM q3)
SELECT 'exam-grammar-jp done';

-- ===== 古文読解 =====
WITH topic AS (
  SELECT t.id AS tid FROM topics t JOIN subjects s ON s.id = t."subject_id"
  WHERE s.slug = 'exam-japanese' AND t.slug = 'exam-classical-prose'
),
q1  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','古文の「あはれ」はどんな意味ですか？',4,1 FROM topic RETURNING id),
q2  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「いとうつくし」の「いと」はどんな意味ですか？',4,2 FROM topic RETURNING id),
q3  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','古文の「をかし」はどんな意味ですか？',4,3 FROM topic RETURNING id),
q4  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','「さらなり」はどんな意味ですか？',4,4 FROM topic RETURNING id),
q5  AS (INSERT INTO questions ("topic_id",type,body,difficulty,"display_order") SELECT tid,'multiple_choice','古文で「ぬ（打消の助動詞）」がつくとき、動詞はどの活用形ですか？',4,5 FROM topic RETURNING id),
c1  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'うれしい・楽しい',false,1 FROM q1 UNION ALL SELECT id,'しみじみとした趣・感動・かわいそう',true,2 FROM q1 UNION ALL SELECT id,'怒り',false,3 FROM q1 UNION ALL SELECT id,'驚き',false,4 FROM q1),
c2  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'少し',false,1 FROM q2 UNION ALL SELECT id,'たいそう・非常に',true,2 FROM q2 UNION ALL SELECT id,'美しく',false,3 FROM q2 UNION ALL SELECT id,'ちょっと',false,4 FROM q2),
c3  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'悲しい',false,1 FROM q3 UNION ALL SELECT id,'趣がある・興味深い',true,2 FROM q3 UNION ALL SELECT id,'可愛い',false,3 FROM q3 UNION ALL SELECT id,'怖い',false,4 FROM q3),
c4  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'言うまでもない・もちろんである',true,1 FROM q4 UNION ALL SELECT id,'さらに続く',false,2 FROM q4 UNION ALL SELECT id,'しばらくたつと',false,3 FROM q4 UNION ALL SELECT id,'今さら',false,4 FROM q4),
c5  AS (INSERT INTO question_choices ("question_id",body,"is_correct","display_order") SELECT id,'連用形',false,1 FROM q5 UNION ALL SELECT id,'未然形',true,2 FROM q5 UNION ALL SELECT id,'連体形',false,3 FROM q5 UNION ALL SELECT id,'終止形',false,4 FROM q5),
s2  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'古文の「いと」は「たいそう・とても・非常に」という程度を強める副詞です。「いとうつくし」＝「たいそうかわいい」。' FROM q2),
s5  AS (INSERT INTO question_steps ("question_id","step_number",body) SELECT id,1,'打消の助動詞「ず」「ぬ」は動詞の未然形につきます。「書かぬ・来ぬ」など。' FROM q5)
SELECT 'exam-classical-prose done';
