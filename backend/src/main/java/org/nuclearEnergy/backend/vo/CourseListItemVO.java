package org.nuclearEnergy.backend.vo;

import lombok.Data;

@Data
public class CourseListItemVO {

    private Long id;

    private String title;

    private String description;

    private Integer chapterCount;

    private String duration;

    private Integer progress;
}