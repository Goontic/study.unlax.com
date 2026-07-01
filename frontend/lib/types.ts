export type QuestionType = "multiple_choice" | "text_input" | "fill_blank" | "ordering";
export type SchoolLevel = "elementary" | "middle" | "exam_prep";
export type Genre = "school_education" | "certification";

export interface Subject {
  id: number;
  slug: string;
  name: string;
  icon: string;
  displayOrder: number;
  genre: Genre;
  schoolLevel: SchoolLevel;
}

export interface Topic {
  id: number;
  subjectId: number;
  slug: string;
  name: string;
  gradeLevel: number;
  displayOrder: number;
}

export interface SubjectWithTopics extends Subject {
  topics: Topic[];
}

export interface AdminUser {
  id: number;
  email: string;
  displayName: string;
  createdAt: string;
  updatedAt: string;
}

export interface QuestionChoice {
  id: number;
  body: string;
  isCorrect: boolean;
  displayOrder: number;
}

export interface QuestionBlankAnswer {
  id: number;
  blankIndex: number;
  correctAnswer: string;
}

export interface QuestionOrderItem {
  id: number;
  body: string;
  correctPosition: number;
}

export interface QuestionStep {
  id: number;
  stepNumber: number;
  body: string;
}

export interface Question {
  id: number;
  topicId: number;
  type: QuestionType;
  body: string;
  difficulty: number;
  displayOrder: number;
  choices?: QuestionChoice[];
  blankAnswers?: QuestionBlankAnswer[];
  orderItems?: QuestionOrderItem[];
  steps?: QuestionStep[];
}
