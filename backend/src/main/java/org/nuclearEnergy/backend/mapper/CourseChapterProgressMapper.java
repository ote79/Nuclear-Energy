package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.CourseChapterProgress;

import java.util.List;

@Mapper
public interface CourseChapterProgressMapper extends BaseMapper<CourseChapterProgress> {

    @Insert("""
            insert into course_chapter_progress(user_id, course_id, chapter_id, progress, completed,
                                                study_minutes, last_study_time, create_time, update_time)
            values(#{userId}, #{courseId}, #{chapterId}, #{progress}, #{completed},
                   #{studyMinutes}, now(), now(), now())
            on duplicate key update
                progress = greatest(progress, values(progress)),
                completed = greatest(completed, values(completed)),
                study_minutes = study_minutes + values(study_minutes),
                last_study_time = now(),
                update_time = now()
            """)
    int saveChapterProgress(@Param("userId") Long userId,
                            @Param("courseId") Long courseId,
                            @Param("chapterId") Long chapterId,
                            @Param("progress") Integer progress,
                            @Param("completed") Integer completed,
                            @Param("studyMinutes") Integer studyMinutes);

    @Select("""
            select chapter_id
            from course_chapter_progress
            where user_id = #{userId}
              and course_id = #{courseId}
              and completed = 1
            """)
    List<Long> selectCompletedChapterIds(@Param("userId") Long userId, @Param("courseId") Long courseId);

    @Select("""
            select count(*)
            from course_chapter_progress
            where user_id = #{userId}
              and course_id = #{courseId}
              and completed = 1
            """)
    Integer countCompletedChapters(@Param("userId") Long userId, @Param("courseId") Long courseId);
}
