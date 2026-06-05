package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("user_course_progress")
public class UserCourseProgress {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private Long userId;
    private Long courseId;
    private Long chapterId;
    private Integer completed;
    private LocalDateTime updateTime;
}
