package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.entity.Course;
import org.nuclearEnergy.backend.entity.CourseChapter;
import org.nuclearEnergy.backend.entity.PracticeQuestion;
import org.nuclearEnergy.backend.entity.ExamQuestion;

import java.util.List;
import java.util.Map;

public interface CourseService {
    List<Course> getAllCourses(String category);
    Course getCourseById(Long id);
    List<CourseChapter> getChaptersByCourseId(Long courseId);
    void markChapterComplete(Long courseId, Long chapterId);
    Map<String, Object> getUserProgress();
    List<PracticeQuestion> getPracticeQuestions(String category);
    List<ExamQuestion> getExamQuestions();
}
