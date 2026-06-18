package org.nuclearEnergy.backend.vo;

import lombok.Data;

import java.util.List;

@Data
public class CourseDetailVO {

    private Long id;

    private String title;

    private String description;

    private Integer chapterCount;

    private String duration;

    private List<CourseChapterVO> chapters;
}