package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.Course;

import java.util.List;

@Mapper
public interface CourseMapper extends BaseMapper<Course> {

    @Select("""
            select *
            from course
            where status = 1
              and (#{keyword} is null
                   or #{keyword} = ''
                   or title like concat('%', #{keyword}, '%')
                   or description like concat('%', #{keyword}, '%'))
            order by create_time desc
            limit #{offset}, #{pageSize}
            """)
    List<Course> getPublishedCourseList(@Param("keyword") String keyword,
                                        @Param("offset") Integer offset,
                                        @Param("pageSize") Integer pageSize);

    @Select("""
            select count(*)
            from course
            where status = 1
              and (#{keyword} is null
                   or #{keyword} = ''
                   or title like concat('%', #{keyword}, '%')
                   or description like concat('%', #{keyword}, '%'))
            """)
    Long getPublishedCourseCount(@Param("keyword") String keyword);

    @Select("""
            select *
            from course
            where id = #{id}
              and status = 1
            """)
    Course getPublishedCourseById(@Param("id") Long id);

}
