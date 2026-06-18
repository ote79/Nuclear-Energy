package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("quiz_question")
public class QuizQuestion {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long quizId;

    private String title;

    private String questionType;

    private String answer;

    private String explanation;

    private Integer sort;

    private Integer status;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
