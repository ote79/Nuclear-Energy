package org.nuclearEnergy.backend.controller;

import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.entity.Course;
import org.nuclearEnergy.backend.entity.CourseChapter;
import org.nuclearEnergy.backend.entity.ExamQuestion;
import org.nuclearEnergy.backend.entity.PracticeQuestion;
import org.nuclearEnergy.backend.service.CourseService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/course")
public class CourseController {

    private final CourseService courseService;

    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping("/list")
    public Result<List<Course>> getCourses(@RequestParam(required = false) String category) {
        return Result.success(courseService.getAllCourses(category));
    }

    @GetMapping("/{id}")
    public Result<Map<String, Object>> getCourseDetail(@PathVariable Long id) {
        Course course = courseService.getCourseById(id);
        List<CourseChapter> chapters = courseService.getChaptersByCourseId(id);
        Map<String, Object> data = new java.util.HashMap<>();
        data.put("course", course);
        data.put("chapters", chapters);
        return Result.success(data);
    }

    @GetMapping("/{id}/chapters")
    public Result<List<CourseChapter>> getChapters(@PathVariable Long id) {
        return Result.success(courseService.getChaptersByCourseId(id));
    }

    @PostMapping("/{courseId}/chapter/{chapterId}/complete")
    public Result<String> completeChapter(@PathVariable Long courseId, @PathVariable Long chapterId) {
        courseService.markChapterComplete(courseId, chapterId);
        return Result.success("标记完成");
    }

    @GetMapping("/progress")
    public Result<Map<String, Object>> getProgress() {
        return Result.success(courseService.getUserProgress());
    }

    @GetMapping("/practice/questions")
    public Result<List<PracticeQuestion>> getPracticeQuestions(
            @RequestParam(required = false) String category) {
        return Result.success(courseService.getPracticeQuestions(category));
    }

    @GetMapping("/exam/questions")
    public Result<List<ExamQuestion>> getExamQuestions() {
        return Result.success(courseService.getExamQuestions());
    }
}
