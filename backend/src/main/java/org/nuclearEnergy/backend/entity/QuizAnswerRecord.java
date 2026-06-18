package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("quiz_answer_record")
public class QuizAnswerRecord {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long quizRecordId;

    private Long questionId;

    private String userAnswer;

    private String correctAnswer;

    private Integer isCorrect;

    private LocalDateTime createTime;
}
