package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("quiz_record")
public class QuizRecord {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long userId;

    private Long quizId;

    private Integer score;

    private Integer correctCount;

    private Integer totalCount;

    private Integer submitDurationSeconds;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
