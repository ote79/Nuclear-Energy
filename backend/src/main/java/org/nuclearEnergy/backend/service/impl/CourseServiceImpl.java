package org.nuclearEnergy.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.nuclearEnergy.backend.entity.*;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.*;
import org.nuclearEnergy.backend.service.CourseService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class CourseServiceImpl implements CourseService {

    private final CourseMapper courseMapper;
    private final CourseChapterMapper chapterMapper;
    private final UserCourseProgressMapper progressMapper;
    private final PracticeQuestionMapper practiceQuestionMapper;
    private final ExamQuestionMapper examQuestionMapper;

    public CourseServiceImpl(CourseMapper courseMapper, CourseChapterMapper chapterMapper,
                             UserCourseProgressMapper progressMapper,
                             PracticeQuestionMapper practiceQuestionMapper,
                             ExamQuestionMapper examQuestionMapper) {
        this.courseMapper = courseMapper;
        this.chapterMapper = chapterMapper;
        this.progressMapper = progressMapper;
        this.practiceQuestionMapper = practiceQuestionMapper;
        this.examQuestionMapper = examQuestionMapper;
    }

    private Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication.getPrincipal() == null) {
            throw new BusinessException(401, "用户未登录");
        }
        return Long.parseLong(authentication.getPrincipal().toString());
    }

    @Override
    public List<Course> getAllCourses(String category) {
        LambdaQueryWrapper<Course> wrapper = new LambdaQueryWrapper<>();
        if (category != null && !category.isEmpty() && !"all".equals(category)) {
            wrapper.eq(Course::getCategory, category);
        }
        wrapper.eq(Course::getStatus, 1);
        return courseMapper.selectList(wrapper);
    }

    @Override
    public Course getCourseById(Long id) {
        return courseMapper.selectById(id);
    }

    @Override
    public List<CourseChapter> getChaptersByCourseId(Long courseId) {
        LambdaQueryWrapper<CourseChapter> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseChapter::getCourseId, courseId).orderByAsc(CourseChapter::getSortOrder);
        return chapterMapper.selectList(wrapper);
    }

    @Override
    @Transactional
    public void markChapterComplete(Long courseId, Long chapterId) {
        Long userId = getCurrentUserId();
        LambdaQueryWrapper<UserCourseProgress> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCourseProgress::getUserId, userId)
               .eq(UserCourseProgress::getCourseId, courseId)
               .eq(UserCourseProgress::getChapterId, chapterId);
        UserCourseProgress progress = progressMapper.selectOne(wrapper);
        if (progress == null) {
            progress = new UserCourseProgress();
            progress.setUserId(userId);
            progress.setCourseId(courseId);
            progress.setChapterId(chapterId);
            progress.setCompleted(1);
            progress.setUpdateTime(LocalDateTime.now());
            progressMapper.insert(progress);
        } else {
            progress.setCompleted(1);
            progress.setUpdateTime(LocalDateTime.now());
            progressMapper.updateById(progress);
        }
    }

    @Override
    public Map<String, Object> getUserProgress() {
        Long userId = getCurrentUserId();
        LambdaQueryWrapper<UserCourseProgress> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCourseProgress::getUserId, userId);
        List<UserCourseProgress> progressList = progressMapper.selectList(wrapper);

        Map<Long, Set<Long>> progressMap = new HashMap<>();
        for (UserCourseProgress p : progressList) {
            if (p.getCompleted() == 1) {
                progressMap.computeIfAbsent(p.getCourseId(), k -> new HashSet<>()).add(p.getChapterId());
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put("progressMap", progressMap);
        return result;
    }

    @Override
    public List<PracticeQuestion> getPracticeQuestions(String category) {
        LambdaQueryWrapper<PracticeQuestion> wrapper = new LambdaQueryWrapper<>();
        if (category != null && !category.isEmpty()) {
            wrapper.eq(PracticeQuestion::getCategory, category);
        }
        return practiceQuestionMapper.selectList(wrapper);
    }

    @Override
    public List<ExamQuestion> getExamQuestions() {
        return examQuestionMapper.selectList(null);
    }
}
