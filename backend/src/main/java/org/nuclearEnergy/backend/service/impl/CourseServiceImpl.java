package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.dto.CourseProgressDTO;
import org.nuclearEnergy.backend.entity.CourseChapter;
import org.nuclearEnergy.backend.entity.Course;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.CourseChapterMapper;
import org.nuclearEnergy.backend.mapper.CourseChapterProgressMapper;
import org.nuclearEnergy.backend.mapper.CourseMapper;
import org.nuclearEnergy.backend.mapper.CourseStudyRecordMapper;
import org.nuclearEnergy.backend.service.CourseService;
import org.nuclearEnergy.backend.utils.SecurityUtils;
import org.nuclearEnergy.backend.vo.CourseChapterVO;
import org.nuclearEnergy.backend.vo.CourseDetailVO;
import org.nuclearEnergy.backend.vo.CourseListItemVO;
import org.nuclearEnergy.backend.vo.CourseRecordVO;
import org.nuclearEnergy.backend.vo.PageResultVO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class CourseServiceImpl implements CourseService {

    private final CourseMapper courseMapper;
    private final CourseChapterMapper courseChapterMapper;
    private final CourseStudyRecordMapper courseStudyRecordMapper;
    private final CourseChapterProgressMapper courseChapterProgressMapper;

    public CourseServiceImpl(CourseMapper courseMapper,
                             CourseChapterMapper courseChapterMapper,
                             CourseStudyRecordMapper courseStudyRecordMapper,
                             CourseChapterProgressMapper courseChapterProgressMapper){
        this.courseMapper = courseMapper;
        this.courseChapterMapper = courseChapterMapper;
        this.courseStudyRecordMapper = courseStudyRecordMapper;
        this.courseChapterProgressMapper = courseChapterProgressMapper;
    }

    @Override
    public List<CourseListItemVO> getPublishedCourseList(String keyword, Integer offset, Integer pageSize) {
        List<Course> courses = courseMapper.getPublishedCourseList(keyword, offset, pageSize);
        List<CourseListItemVO> vos = new ArrayList<>();
        Long userId = SecurityUtils.getCurrentUserIdOrNull();
        for (Course course : courses){
            CourseListItemVO vo = new CourseListItemVO();
            vo.setId(course.getId());
            vo.setDescription(course.getDescription());
            vo.setTitle(course.getTitle());
            vo.setProgress(0);
            if (userId != null) {
                Integer progress = courseStudyRecordMapper.selectProgress(userId, course.getId());
                if (progress != null) {
                    vo.setProgress(progress);
                }
            }
            vo.setDuration(course.getDuration());
            vo.setChapterCount(course.getChapterCount());
            vos.add(vo);
        }
        return vos;
    }

    @Override
    public Long getPublishedCourseCount(String keyword) {
        return courseMapper.getPublishedCourseCount(keyword);
    }

    @Override
    public CourseDetailVO getPublishedCourseDetail(Long id) {
        Course course = courseMapper.getPublishedCourseById(id);
        if (course == null) {
            throw new BusinessException(404, "课程不存在");
        }

        Long userId = SecurityUtils.getCurrentUserIdOrNull();
        Set<Long> completedChapterIds = new HashSet<>();
        if (userId != null) {
            completedChapterIds.addAll(courseChapterProgressMapper.selectCompletedChapterIds(userId, id));
        }

        List<CourseChapter> chapters = courseChapterMapper.selectPublishedChaptersByCourseId(id);
        List<CourseChapterVO> chapterVOList = new ArrayList<>();
        for (CourseChapter chapter : chapters) {
            CourseChapterVO chapterVO = new CourseChapterVO();
            chapterVO.setId(chapter.getId());
            chapterVO.setTitle(chapter.getTitle());
            chapterVO.setContent(chapter.getContent());
            chapterVO.setCompleted(completedChapterIds.contains(chapter.getId()));
            chapterVOList.add(chapterVO);
        }

        CourseDetailVO vo = new CourseDetailVO();
        vo.setId(course.getId());
        vo.setTitle(course.getTitle());
        vo.setDescription(course.getDescription());
        vo.setChapterCount(course.getChapterCount());
        vo.setDuration(course.getDuration());
        vo.setChapters(chapterVOList);
        return vo;
    }

    @Override
    public void submitProgress(CourseProgressDTO courseProgressDTO) {
        Long userId = SecurityUtils.requireCurrentUserId();
        Course course = courseMapper.getPublishedCourseById(courseProgressDTO.getCourseId());
        if (course == null) {
            throw new BusinessException(404, "课程不存在");
        }

        Long chapterId = courseProgressDTO.getChapterId();
        if (chapterId != null) {
            CourseChapter chapter = courseChapterMapper.selectById(chapterId);
            if (chapter == null || !course.getId().equals(chapter.getCourseId())) {
                throw new BusinessException(400, "章节不存在或不属于该课程");
            }
            int completed = courseProgressDTO.getProgress() >= 100 ? 1 : 0;
            courseChapterProgressMapper.saveChapterProgress(
                    userId,
                    courseProgressDTO.getCourseId(),
                    chapterId,
                    courseProgressDTO.getProgress(),
                    completed,
                    5
            );
        }

        Integer completedChapterCount = courseChapterProgressMapper.countCompletedChapters(userId, courseProgressDTO.getCourseId());
        if (completedChapterCount == null) {
            completedChapterCount = 0;
        }

        courseStudyRecordMapper.saveProgress(
                userId,
                courseProgressDTO.getCourseId(),
                chapterId,
                courseProgressDTO.getProgress(),
                completedChapterCount,
                5
        );
    }

    @Override
    public PageResultVO<CourseRecordVO> getMyRecords(Integer page, Integer pageSize) {
        Long userId = SecurityUtils.requireCurrentUserId();
        Integer offset = (page - 1) * pageSize;
        List<CourseRecordVO> list = courseStudyRecordMapper.selectUserCourseRecords(userId, offset, pageSize);
        Long total = courseStudyRecordMapper.countUserCourseRecords(userId);
        return PageResultVO.of(list, total);
    }

}
