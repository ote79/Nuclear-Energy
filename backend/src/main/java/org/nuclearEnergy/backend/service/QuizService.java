package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.dto.QuizSubmitDTO;
import org.nuclearEnergy.backend.dto.RemoveWrongQuestionsDTO;
import org.nuclearEnergy.backend.vo.PageResultVO;
import org.nuclearEnergy.backend.vo.QuizDetailVO;
import org.nuclearEnergy.backend.vo.QuizListItemVO;
import org.nuclearEnergy.backend.vo.QuizRecordVO;
import org.nuclearEnergy.backend.vo.QuizSubmitResultVO;
import org.nuclearEnergy.backend.vo.WrongQuestionVO;

public interface QuizService {

    PageResultVO<QuizListItemVO> getQuizList(Integer page, Integer pageSize);

    QuizDetailVO getQuizDetail(Long id);

    QuizSubmitResultVO submitQuiz(QuizSubmitDTO quizSubmitDTO);

    PageResultVO<QuizRecordVO> getMyRecords(Integer page, Integer pageSize);

    PageResultVO<WrongQuestionVO> getWrongQuestions(Integer page, Integer pageSize);

    void removeWrongQuestions(RemoveWrongQuestionsDTO removeWrongQuestionsDTO);

    void clearWrongQuestions();
}
