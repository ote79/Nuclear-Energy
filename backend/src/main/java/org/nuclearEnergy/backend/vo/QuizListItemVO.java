package org.nuclearEnergy.backend.vo;

import lombok.Data;

@Data
public class QuizListItemVO {

    private Long id;

    private String title;

    private String description;

    private Integer questionCount;

    private Integer timeLimit;

    private Integer bestScore;
}
