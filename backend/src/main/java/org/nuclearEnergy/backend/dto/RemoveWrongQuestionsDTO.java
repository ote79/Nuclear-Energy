package org.nuclearEnergy.backend.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.List;

@Data
public class RemoveWrongQuestionsDTO {

    @NotEmpty(message = "题目ID列表不能为空")
    private List<Long> questionIds;
}
