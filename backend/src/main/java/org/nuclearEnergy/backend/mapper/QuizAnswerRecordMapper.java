package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.nuclearEnergy.backend.entity.QuizAnswerRecord;
import org.nuclearEnergy.backend.vo.WrongQuestionVO;

import java.util.List;

@Mapper
public interface QuizAnswerRecordMapper extends BaseMapper<QuizAnswerRecord> {

    @Select("""
            select qq.id as id,
                   q.id as quizId,
                   q.title as quizTitle,
                   qq.title as title,
                   qq.question_type as type,
                   qq.answer as answer,
                   qq.explanation as explanation,
                   latest.user_answer as lastUserAnswer,
                   wrong_stats.wrongCount as wrongCount,
                   date_format(latest.create_time, '%Y-%m-%d %H:%i') as lastWrongAt
            from (
                select qar.question_id as questionId,
                       count(*) as wrongCount,
                       max(qar.id) as latestId
                from quiz_answer_record qar
                join quiz_record qr on qr.id = qar.quiz_record_id
                where qr.user_id = #{userId}
                  and qar.is_correct = 0
                group by qar.question_id
                order by max(qar.create_time) desc
                limit #{offset}, #{pageSize}
            ) wrong_stats
            join quiz_answer_record latest on latest.id = wrong_stats.latestId
            join quiz_question qq on qq.id = wrong_stats.questionId
            join quiz q on q.id = qq.quiz_id
            order by latest.create_time desc
            """)
    List<WrongQuestionVO> selectWrongQuestions(@Param("userId") Long userId,
                                               @Param("offset") Integer offset,
                                               @Param("pageSize") Integer pageSize);

    @Select("""
            select count(*)
            from (
                select qar.question_id
                from quiz_answer_record qar
                join quiz_record qr on qr.id = qar.quiz_record_id
                where qr.user_id = #{userId}
                  and qar.is_correct = 0
                group by qar.question_id
            ) t
            """)
    Long countWrongQuestions(@Param("userId") Long userId);

    @Update("""
            update quiz_answer_record qar
            join quiz_record qr on qr.id = qar.quiz_record_id
            set qar.is_correct = 1
            where qr.user_id = #{userId}
              and qar.question_id = #{questionId}
            """)
    int markOneWrongQuestionCorrect(@Param("userId") Long userId,
                                    @Param("questionId") Long questionId);

    @Update("""
            update quiz_answer_record qar
            join quiz_record qr on qr.id = qar.quiz_record_id
            set qar.is_correct = 1
            where qr.user_id = #{userId}
              and qar.is_correct = 0
            """)
    int clearWrongQuestions(@Param("userId") Long userId);
}
