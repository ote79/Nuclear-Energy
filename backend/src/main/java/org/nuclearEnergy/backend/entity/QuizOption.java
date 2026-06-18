package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("quiz_option")
public class QuizOption {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long questionId;

    private String optionKey;

    private String optionText;

    private Integer sort;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
