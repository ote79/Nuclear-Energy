package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
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
    List<Course> getPublishedCourseList(String keyword, Integer offset, Integer pageSize);

    @Select("""
            select count(*)
            from course
            where status = 1
              and (#{keyword} is null
                   or #{keyword} = ''
                   or title like concat('%', #{keyword}, '%')
                   or description like concat('%', #{keyword}, '%'))
            """)
    Long getPublishedCourseCount(String keyword);

}
