package org.nuclearEnergy.backend.vo;

import lombok.Data;

import java.util.List;

@Data
public class QuizQuestionVO {

    private Long id;

    private String title;

    private String type;

    private List<QuizOptionVO> options;

    private String answer;

    private String explanation;
}
