package org.nuclearEnergy.backend.vo;

import lombok.Data;

@Data
public class QuizRecordVO {

    private Long quizId;

    private String quizTitle;

    private Integer score;

    private Integer correctCount;

    private Integer totalCount;

    private String createdAt;
}
