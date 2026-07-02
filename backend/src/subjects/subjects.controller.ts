import { Controller, Get, Param, NotFoundException } from "@nestjs/common";
import { SubjectsService } from "./subjects.service";

@Controller("subjects")
export class SubjectsController {
  constructor(private readonly subjectsService: SubjectsService) {}

  @Get()
  findAll() {
    return this.subjectsService.findAll();
  }

  @Get("by-grade/:level")
  getByGrade(@Param("level") level: string) {
    return this.subjectsService.getByGrade(Number(level));
  }

  @Get("elementary/by-grade/:level")
  getByGradeElementary(@Param("level") level: string) {
    return this.subjectsService.getByGradeElementary(Number(level));
  }

  @Get("exam-prep")
  getExamPrepSubjects() {
    return this.subjectsService.getExamPrepSubjects();
  }

  @Get("certification")
  getCertificationSubjects() {
    return this.subjectsService.getCertificationSubjects();
  }

  @Get("sitemap-entries")
  getSitemapEntries() {
    return this.subjectsService.getSitemapEntries();
  }

  @Get(":slug")
  async findOne(@Param("slug") slug: string) {
    const subject = await this.subjectsService.findOne(slug);
    if (!subject) throw new NotFoundException();
    return subject;
  }

  @Get(":slug/topics")
  getTopics(@Param("slug") slug: string) {
    return this.subjectsService.getTopics(slug);
  }

  @Get(":subjectSlug/topics/:topicSlug")
  async getTopic(
    @Param("subjectSlug") subjectSlug: string,
    @Param("topicSlug") topicSlug: string,
  ) {
    const topic = await this.subjectsService.findTopic(subjectSlug, topicSlug);
    if (!topic) throw new NotFoundException();
    return topic;
  }

  @Get(":subjectSlug/topics/:topicSlug/questions")
  getQuestions(
    @Param("subjectSlug") subjectSlug: string,
    @Param("topicSlug") topicSlug: string,
  ) {
    return this.subjectsService.getQuestions(subjectSlug, topicSlug);
  }
}
