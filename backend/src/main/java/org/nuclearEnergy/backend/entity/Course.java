package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName(value = "course")
public class Course {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private String title;

    private String description;

    private String coverUrl;

    private Integer chapterCount;

    private String duration;

    private Integer status;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

}
