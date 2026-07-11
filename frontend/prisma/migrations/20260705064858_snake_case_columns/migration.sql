-- RenameColumn: admin_users
ALTER TABLE "admin_users" RENAME COLUMN "createdAt" TO "created_at";
ALTER TABLE "admin_users" RENAME COLUMN "displayName" TO "display_name";
ALTER TABLE "admin_users" RENAME COLUMN "passwordHash" TO "password_hash";
ALTER TABLE "admin_users" RENAME COLUMN "updatedAt" TO "updated_at";

-- RenameColumn: password_reset_tokens
ALTER TABLE "password_reset_tokens" RENAME COLUMN "createdAt" TO "created_at";
ALTER TABLE "password_reset_tokens" RENAME COLUMN "expiresAt" TO "expires_at";
ALTER TABLE "password_reset_tokens" RENAME COLUMN "usedAt" TO "used_at";
ALTER TABLE "password_reset_tokens" RENAME COLUMN "userId" TO "user_id";

-- RenameColumn: question_blank_answers
ALTER TABLE "question_blank_answers" RENAME COLUMN "blankIndex" TO "blank_index";
ALTER TABLE "question_blank_answers" RENAME COLUMN "correctAnswer" TO "correct_answer";
ALTER TABLE "question_blank_answers" RENAME COLUMN "questionId" TO "question_id";

-- RenameColumn: question_choices
ALTER TABLE "question_choices" RENAME COLUMN "displayOrder" TO "display_order";
ALTER TABLE "question_choices" RENAME COLUMN "isCorrect" TO "is_correct";
ALTER TABLE "question_choices" RENAME COLUMN "questionId" TO "question_id";

-- RenameColumn: question_order_items
ALTER TABLE "question_order_items" RENAME COLUMN "correctPosition" TO "correct_position";
ALTER TABLE "question_order_items" RENAME COLUMN "questionId" TO "question_id";

-- RenameColumn: question_steps
ALTER TABLE "question_steps" RENAME COLUMN "questionId" TO "question_id";
ALTER TABLE "question_steps" RENAME COLUMN "stepNumber" TO "step_number";

-- RenameColumn: questions
ALTER TABLE "questions" RENAME COLUMN "createdAt" TO "created_at";
ALTER TABLE "questions" RENAME COLUMN "displayOrder" TO "display_order";
ALTER TABLE "questions" RENAME COLUMN "topicId" TO "topic_id";

-- RenameColumn: subjects
ALTER TABLE "subjects" RENAME COLUMN "displayOrder" TO "display_order";
ALTER TABLE "subjects" RENAME COLUMN "schoolLevel" TO "school_level";

-- RenameColumn: topics
ALTER TABLE "topics" RENAME COLUMN "displayOrder" TO "display_order";
ALTER TABLE "topics" RENAME COLUMN "gradeLevel" TO "grade_level";
ALTER TABLE "topics" RENAME COLUMN "subjectId" TO "subject_id";

-- RenameColumn: user_answers
ALTER TABLE "user_answers" RENAME COLUMN "answeredAt" TO "answered_at";
ALTER TABLE "user_answers" RENAME COLUMN "isCorrect" TO "is_correct";
ALTER TABLE "user_answers" RENAME COLUMN "questionId" TO "question_id";
ALTER TABLE "user_answers" RENAME COLUMN "userId" TO "user_id";

-- RenameColumn: user_favorites
ALTER TABLE "user_favorites" RENAME COLUMN "createdAt" TO "created_at";
ALTER TABLE "user_favorites" RENAME COLUMN "questionId" TO "question_id";
ALTER TABLE "user_favorites" RENAME COLUMN "userId" TO "user_id";

-- RenameColumn: users
ALTER TABLE "users" RENAME COLUMN "createdAt" TO "created_at";
ALTER TABLE "users" RENAME COLUMN "displayName" TO "display_name";
ALTER TABLE "users" RENAME COLUMN "passwordHash" TO "password_hash";
ALTER TABLE "users" RENAME COLUMN "updatedAt" TO "updated_at";

-- RenameForeignKey
ALTER TABLE "password_reset_tokens" RENAME CONSTRAINT "password_reset_tokens_userId_fkey" TO "password_reset_tokens_user_id_fkey";
ALTER TABLE "question_blank_answers" RENAME CONSTRAINT "question_blank_answers_questionId_fkey" TO "question_blank_answers_question_id_fkey";
ALTER TABLE "question_choices" RENAME CONSTRAINT "question_choices_questionId_fkey" TO "question_choices_question_id_fkey";
ALTER TABLE "question_order_items" RENAME CONSTRAINT "question_order_items_questionId_fkey" TO "question_order_items_question_id_fkey";
ALTER TABLE "question_steps" RENAME CONSTRAINT "question_steps_questionId_fkey" TO "question_steps_question_id_fkey";
ALTER TABLE "questions" RENAME CONSTRAINT "questions_topicId_fkey" TO "questions_topic_id_fkey";
ALTER TABLE "topics" RENAME CONSTRAINT "topics_subjectId_fkey" TO "topics_subject_id_fkey";
ALTER TABLE "user_answers" RENAME CONSTRAINT "user_answers_questionId_fkey" TO "user_answers_question_id_fkey";
ALTER TABLE "user_answers" RENAME CONSTRAINT "user_answers_userId_fkey" TO "user_answers_user_id_fkey";
ALTER TABLE "user_favorites" RENAME CONSTRAINT "user_favorites_questionId_fkey" TO "user_favorites_question_id_fkey";
ALTER TABLE "user_favorites" RENAME CONSTRAINT "user_favorites_userId_fkey" TO "user_favorites_user_id_fkey";

-- RenameIndex
ALTER INDEX "topics_subjectId_slug_key" RENAME TO "topics_subject_id_slug_key";
ALTER INDEX "user_favorites_userId_questionId_key" RENAME TO "user_favorites_user_id_question_id_key";
