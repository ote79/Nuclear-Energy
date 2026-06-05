package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("practice_question")
public class PracticeQuestion {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private String question;
    private String options;
    private Integer answer;
    private String explanation;
    private String category;
}
