-- 問題を全入れ替えできるよう、user_answers/user_favorites の FK を CASCADE に変更

ALTER TABLE "user_answers" DROP CONSTRAINT "user_answers_questionId_fkey";
ALTER TABLE "user_answers" ADD CONSTRAINT "user_answers_questionId_fkey"
  FOREIGN KEY ("questionId") REFERENCES "questions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "user_favorites" DROP CONSTRAINT "user_favorites_questionId_fkey";
ALTER TABLE "user_favorites" ADD CONSTRAINT "user_favorites_questionId_fkey"
  FOREIGN KEY ("questionId") REFERENCES "questions"("id") ON DELETE CASCADE ON UPDATE CASCADE;
