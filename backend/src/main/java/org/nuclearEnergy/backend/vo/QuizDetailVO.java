package org.nuclearEnergy.backend.vo;

import lombok.Data;

import java.util.List;

@Data
public class QuizDetailVO {

    private Long id;

    private String title;

    private String description;

    private Integer timeLimit;

    private List<QuizQuestionVO> questions;
}
