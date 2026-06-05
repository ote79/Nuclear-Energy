package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("course_chapter")
public class CourseChapter {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private Long courseId;
    private String title;
    private Integer sortOrder;
    private String content;
}
