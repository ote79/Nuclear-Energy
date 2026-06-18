package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.CourseStudyRecord;
import org.nuclearEnergy.backend.vo.CourseRecordVO;

import java.util.List;

@Mapper
public interface CourseStudyRecordMapper extends BaseMapper<CourseStudyRecord> {

    @Select("""
            select progress
            from course_study_record
            where user_id = #{userId}
              and course_id = #{courseId}
            """)
    Integer selectProgress(@Param("userId") Long userId, @Param("courseId") Long courseId);

    @Insert("""
            insert into course_study_record(user_id, course_id, progress, current_chapter_id,
                                            completed_chapter_count, study_minutes, last_study_time,
                                            create_time, update_time)
            values(#{userId}, #{courseId}, #{progress}, #{chapterId},
                   #{completedChapterCount}, #{studyMinutes}, now(), now(), now())
            on duplicate key update
                progress = greatest(progress, values(progress)),
                current_chapter_id = values(current_chapter_id),
                completed_chapter_count = values(completed_chapter_count),
                study_minutes = study_minutes + values(study_minutes),
                last_study_time = now(),
                update_time = now()
            """)
    int saveProgress(@Param("userId") Long userId,
                     @Param("courseId") Long courseId,
                     @Param("chapterId") Long chapterId,
                     @Param("progress") Integer progress,
                     @Param("completedChapterCount") Integer completedChapterCount,
                     @Param("studyMinutes") Integer studyMinutes);

    @Select("""
            select c.id as courseId,
                   c.title as title,
                   r.progress as progress,
                   date_format(r.last_study_time, '%Y-%m-%d %H:%i') as updatedAt
            from course_study_record r
            join course c on c.id = r.course_id
            where r.user_id = #{userId}
            order by r.last_study_time desc
            limit #{offset}, #{pageSize}
            """)
    List<CourseRecordVO> selectUserCourseRecords(@Param("userId") Long userId,
                                                 @Param("offset") Integer offset,
                                                 @Param("pageSize") Integer pageSize);

    @Select("""
            select count(*)
            from course_study_record
            where user_id = #{userId}
            """)
    Long countUserCourseRecords(@Param("userId") Long userId);
}
