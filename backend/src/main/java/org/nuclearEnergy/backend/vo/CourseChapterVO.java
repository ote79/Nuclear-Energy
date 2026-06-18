package org.nuclearEnergy.backend.vo;

import lombok.Data;

@Data
public class CourseChapterVO {

    private Long id;

    private String title;

    private String content;

    private Boolean completed;
}
