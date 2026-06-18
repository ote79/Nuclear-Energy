package org.nuclearEnergy.backend.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface StatsMapper {

    @Select("""
            select coalesce(sum(study_minutes), 0)
            from course_study_record
            where user_id = #{userId}
            """)
    Integer sumCourseStudyMinutes(@Param("userId") Long userId);

    @Select("""
            select count(*)
            from course_study_record
            where user_id = #{userId}
              and progress >= 100
            """)
    Integer countCompletedCourses(@Param("userId") Long userId);

    @Select("""
            select title, type, progress, updatedAt
            from (
                select c.title as title,
                       'course' as type,
                       r.progress as progress,
                       date_format(r.last_study_time, '%Y-%m-%d %H:%i') as updatedAt,
                       r.last_study_time as sortTime
                from course_study_record r
                join course c on c.id = r.course_id
                where r.user_id = #{userId}
                union all
                select a.title as title,
                       'knowledge' as type,
                       r.progress as progress,
                       date_format(r.last_study_time, '%Y-%m-%d %H:%i') as updatedAt,
                       r.last_study_time as sortTime
                from knowledge_study_record r
                join knowledge_article a on a.id = r.article_id
                where r.user_id = #{userId}
            ) t
            order by sortTime desc
            limit 8
            """)
    List<Map<String, Object>> selectRecentLearningRecords(@Param("userId") Long userId);

    @Select("""
            select date_format(last_study_time, '%m-%d') as label,
                   coalesce(sum(study_minutes), 0) as value
            from course_study_record
            where user_id = #{userId}
              and last_study_time is not null
              and last_study_time >= date_sub(curdate(), interval 6 day)
            group by date_format(last_study_time, '%m-%d')
            order by min(last_study_time)
            """)
    List<Map<String, Object>> selectLearningChart(@Param("userId") Long userId);

    @Select("""
            select count(*)
            from quiz_record
            where user_id = #{userId}
            """)
    Integer countQuizAttempts(@Param("userId") Long userId);

    @Select("""
            select coalesce(round(avg(score)), 0)
            from quiz_record
            where user_id = #{userId}
            """)
    Integer avgQuizScore(@Param("userId") Long userId);

    @Select("""
            select concat('第', row_number() over(order by create_time asc), '次') as label,
                   score as value
            from quiz_record
            where user_id = #{userId}
            order by create_time asc
            """)
    List<Map<String, Object>> selectQuizChart(@Param("userId") Long userId);

    @Select("select count(*) from sys_user")
    Integer countUsers();

    @Select("select count(*) from course where status = 1")
    Integer countCourses();

    @Select("select count(*) from knowledge_article where status = 1")
    Integer countArticles();

    @Select("select count(*) from quiz where status = 1")
    Integer countQuizzes();
}
