package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.Quiz;

import java.util.List;

@Mapper
public interface QuizMapper extends BaseMapper<Quiz> {

    @Select("""
            select *
            from quiz
            where status = 1
            order by create_time desc, id desc
            limit #{offset}, #{pageSize}
            """)
    List<Quiz> selectPublishedQuizList(@Param("offset") Integer offset, @Param("pageSize") Integer pageSize);

    @Select("""
            select count(*)
            from quiz
            where status = 1
            """)
    Long countPublishedQuiz();

    @Select("""
            select *
            from quiz
            where id = #{id}
              and status = 1
            """)
    Quiz selectPublishedQuizById(@Param("id") Long id);
}
