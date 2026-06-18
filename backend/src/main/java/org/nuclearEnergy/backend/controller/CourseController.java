package org.nuclearEnergy.backend.controller;


import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.service.CourseService;
import org.nuclearEnergy.backend.vo.CourseListItemVO;
import org.nuclearEnergy.backend.vo.PageResultVO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/course")
public class CourseController {

    private final CourseService courseService;

    public CourseController(CourseService completionService){
        this.courseService = completionService;
    }

    @GetMapping("/list")
    public Result<PageResultVO<CourseListItemVO>> getPublishedCourseList(@RequestParam Integer pageSize,
                                                                         @RequestParam Integer page,
                                                                         @RequestParam(required = false) String keyword){


        Integer offset = (page-1) * pageSize;

        return Result.success(PageResultVO.of(courseService.getPublishedCourseList(keyword,offset,pageSize), courseService.getPublishedCourseCount(keyword)));
    }

}
