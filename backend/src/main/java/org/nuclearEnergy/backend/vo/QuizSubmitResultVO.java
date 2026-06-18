package org.nuclearEnergy.backend.vo;

import lombok.Data;

import java.util.List;

@Data
public class QuizSubmitResultVO {

    private Integer score;

    private Integer correctCount;

    private Integer totalCount;

    private List<Long> wrongQuestionIds;
}
