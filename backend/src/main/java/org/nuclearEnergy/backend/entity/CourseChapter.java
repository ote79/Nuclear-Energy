package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName(value = "course_chapter")
public class CourseChapter {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long courseId;

    private String title;

    private String content;

    private Integer sort;

    private Integer status;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

}
