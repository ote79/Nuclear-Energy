package org.nuclearEnergy.backend.controller;


import jakarta.validation.Valid;
import org.nuclearEnergy.backend.dto.CourseProgressDTO;
import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.service.CourseService;
import org.nuclearEnergy.backend.vo.CourseDetailVO;
import org.nuclearEnergy.backend.vo.CourseListItemVO;
import org.nuclearEnergy.backend.vo.CourseRecordVO;
import org.nuclearEnergy.backend.vo.PageResultVO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
    public Result<PageResultVO<CourseListItemVO>> getPublishedCourseList(@RequestParam(defaultValue = "9") Integer pageSize,
                                                                         @RequestParam(defaultValue = "1") Integer page,
                                                                         @RequestParam(required = false) String keyword){


        Integer offset = (page-1) * pageSize;

        return Result.success(PageResultVO.of(courseService.getPublishedCourseList(keyword,offset,pageSize), courseService.getPublishedCourseCount(keyword)));
    }

    @GetMapping("/{id}")
    public Result<CourseDetailVO> getPublishedCourseDetail(@PathVariable Long id) {
        return Result.success(courseService.getPublishedCourseDetail(id));
    }

    @PostMapping("/progress")
    public Result<String> submitProgress(@Valid @RequestBody CourseProgressDTO courseProgressDTO) {
        courseService.submitProgress(courseProgressDTO);
        return Result.success("保存成功");
    }

    @GetMapping("/records")
    public Result<PageResultVO<CourseRecordVO>> getMyRecords(@RequestParam(defaultValue = "1") Integer page,
                                                             @RequestParam(defaultValue = "10") Integer pageSize) {
        return Result.success(courseService.getMyRecords(page, pageSize));
    }

}
