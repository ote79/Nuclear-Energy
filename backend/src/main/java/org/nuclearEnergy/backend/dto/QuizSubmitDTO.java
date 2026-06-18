package org.nuclearEnergy.backend.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class QuizSubmitDTO {

    @NotNull(message = "测验ID不能为空")
    private Long quizId;

    @Valid
    @NotEmpty(message = "答案不能为空")
    private List<QuizAnswerDTO> answers;
}
