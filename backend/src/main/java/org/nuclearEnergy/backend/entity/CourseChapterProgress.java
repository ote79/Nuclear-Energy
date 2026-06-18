package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("course_chapter_progress")
public class CourseChapterProgress {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long userId;

    private Long courseId;

    private Long chapterId;

    private Integer progress;

    private Integer completed;

    private Integer studyMinutes;

    private LocalDateTime lastStudyTime;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
