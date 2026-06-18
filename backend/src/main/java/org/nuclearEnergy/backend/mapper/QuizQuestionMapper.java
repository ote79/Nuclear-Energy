package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.QuizQuestion;

import java.util.List;

@Mapper
public interface QuizQuestionMapper extends BaseMapper<QuizQuestion> {

    @Select("""
            select *
            from quiz_question
            where quiz_id = #{quizId}
              and status = 1
            order by sort asc, id asc
            """)
    List<QuizQuestion> selectByQuizId(@Param("quizId") Long quizId);
}
