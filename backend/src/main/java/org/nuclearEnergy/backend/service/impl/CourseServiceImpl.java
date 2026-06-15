package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.entity.Course;
import org.nuclearEnergy.backend.mapper.CourseMapper;
import org.nuclearEnergy.backend.service.CourseService;
import org.nuclearEnergy.backend.vo.CourseListItemVO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {

    private final CourseMapper courseMapper;

    public CourseServiceImpl(CourseMapper courseMapper){
        this.courseMapper = courseMapper;
    }

    @Override
    public List<CourseListItemVO> getPublishedCourseList(String keyword, Integer offset, Integer pageSize) {
        List<Course> courses = courseMapper.getPublishedCourseList(keyword, offset, pageSize);
        List<CourseListItemVO> vos = new ArrayList<>();
        for (Course course : courses){
            CourseListItemVO vo = new CourseListItemVO();
            vo.setId(course.getId());
            vo.setDescription(course.getDescription());
            vo.setTitle(course.getTitle());
            vo.setProgress(0);
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

}
