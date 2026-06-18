package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.QuizRecord;
import org.nuclearEnergy.backend.vo.QuizRecordVO;

import java.util.List;

@Mapper
public interface QuizRecordMapper extends BaseMapper<QuizRecord> {

    @Select("""
            select max(score)
            from quiz_record
            where user_id = #{userId}
              and quiz_id = #{quizId}
            """)
    Integer selectBestScore(@Param("userId") Long userId, @Param("quizId") Long quizId);

    @Insert("""
            insert into quiz_record(user_id, quiz_id, score, correct_count, total_count,
                                    submit_duration_seconds, create_time, update_time)
            values(#{userId}, #{quizId}, #{score}, #{correctCount}, #{totalCount},
                   #{submitDurationSeconds}, now(), now())
            """)
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertRecord(QuizRecord record);

    @Select("""
            select q.id as quizId,
                   q.title as quizTitle,
                   r.score as score,
                   r.correct_count as correctCount,
                   r.total_count as totalCount,
                   date_format(r.create_time, '%Y-%m-%d %H:%i') as createdAt
            from quiz_record r
            join quiz q on q.id = r.quiz_id
            where r.user_id = #{userId}
            order by r.create_time desc
            limit #{offset}, #{pageSize}
            """)
    List<QuizRecordVO> selectUserQuizRecords(@Param("userId") Long userId,
                                             @Param("offset") Integer offset,
                                             @Param("pageSize") Integer pageSize);

    @Select("""
            select count(*)
            from quiz_record
            where user_id = #{userId}
            """)
    Long countUserQuizRecords(@Param("userId") Long userId);
}
