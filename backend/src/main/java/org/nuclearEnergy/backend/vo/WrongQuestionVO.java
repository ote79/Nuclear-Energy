package org.nuclearEnergy.backend.vo;

import lombok.Data;

import java.util.List;

@Data
public class WrongQuestionVO {

    private Long id;

    private Long quizId;

    private String quizTitle;

    private String title;

    private String type;

    private List<QuizOptionVO> options;

    private String answer;

    private String explanation;

    private String lastUserAnswer;

    private Integer wrongCount;

    private String lastWrongAt;
}
