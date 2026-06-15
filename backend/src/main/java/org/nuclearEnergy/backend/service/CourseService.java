package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.vo.CourseListItemVO;

import java.util.List;

public interface CourseService {
    List<CourseListItemVO> getPublishedCourseList(String keyword, Integer offset, Integer pageSize);

    Long getPublishedCourseCount(String keyword);
}
