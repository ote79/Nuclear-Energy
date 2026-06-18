package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.dto.CourseProgressDTO;
import org.nuclearEnergy.backend.vo.CourseDetailVO;
import org.nuclearEnergy.backend.vo.CourseListItemVO;
import org.nuclearEnergy.backend.vo.CourseRecordVO;
import org.nuclearEnergy.backend.vo.PageResultVO;

import java.util.List;

public interface CourseService {
    List<CourseListItemVO> getPublishedCourseList(String keyword, Integer offset, Integer pageSize);

    Long getPublishedCourseCount(String keyword);

    CourseDetailVO getPublishedCourseDetail(Long id);

    void submitProgress(CourseProgressDTO courseProgressDTO);

    PageResultVO<CourseRecordVO> getMyRecords(Integer page, Integer pageSize);
}
