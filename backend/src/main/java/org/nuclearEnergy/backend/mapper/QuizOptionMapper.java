package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.QuizOption;

import java.util.List;

@Mapper
public interface QuizOptionMapper extends BaseMapper<QuizOption> {

    @Select("""
            select *
            from quiz_option
            where question_id = #{questionId}
            order by sort asc, id asc
            """)
    List<QuizOption> selectByQuestionId(@Param("questionId") Long questionId);
}
