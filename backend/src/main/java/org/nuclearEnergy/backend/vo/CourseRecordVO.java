package org.nuclearEnergy.backend.vo;

import lombok.Data;

@Data
public class CourseRecordVO {

    private Long courseId;

    private String title;

    private Integer progress;

    private String updatedAt;
}
