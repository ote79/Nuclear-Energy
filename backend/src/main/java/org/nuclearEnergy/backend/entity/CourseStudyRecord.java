package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("course_study_record")
public class CourseStudyRecord {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long userId;

    private Long courseId;

    private Integer progress;

    private Long currentChapterId;

    private Integer completedChapterCount;

    private Integer studyMinutes;

    private LocalDateTime lastStudyTime;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
