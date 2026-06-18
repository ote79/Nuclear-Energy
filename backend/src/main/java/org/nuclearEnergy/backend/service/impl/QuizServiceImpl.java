package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.dto.QuizAnswerDTO;
import org.nuclearEnergy.backend.dto.QuizSubmitDTO;
import org.nuclearEnergy.backend.dto.RemoveWrongQuestionsDTO;
import org.nuclearEnergy.backend.entity.Quiz;
import org.nuclearEnergy.backend.entity.QuizAnswerRecord;
import org.nuclearEnergy.backend.entity.QuizOption;
import org.nuclearEnergy.backend.entity.QuizQuestion;
import org.nuclearEnergy.backend.entity.QuizRecord;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.QuizAnswerRecordMapper;
import org.nuclearEnergy.backend.mapper.QuizMapper;
import org.nuclearEnergy.backend.mapper.QuizOptionMapper;
import org.nuclearEnergy.backend.mapper.QuizQuestionMapper;
import org.nuclearEnergy.backend.mapper.QuizRecordMapper;
import org.nuclearEnergy.backend.service.QuizService;
import org.nuclearEnergy.backend.utils.SecurityUtils;
import org.nuclearEnergy.backend.vo.PageResultVO;
import org.nuclearEnergy.backend.vo.QuizDetailVO;
import org.nuclearEnergy.backend.vo.QuizListItemVO;
import org.nuclearEnergy.backend.vo.QuizOptionVO;
import org.nuclearEnergy.backend.vo.QuizQuestionVO;
import org.nuclearEnergy.backend.vo.QuizRecordVO;
import org.nuclearEnergy.backend.vo.QuizSubmitResultVO;
import org.nuclearEnergy.backend.vo.WrongQuestionVO;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class QuizServiceImpl implements QuizService {

    private final QuizMapper quizMapper;
    private final QuizQuestionMapper quizQuestionMapper;
    private final QuizOptionMapper quizOptionMapper;
    private final QuizRecordMapper quizRecordMapper;
    private final QuizAnswerRecordMapper quizAnswerRecordMapper;

    public QuizServiceImpl(QuizMapper quizMapper,
                           QuizQuestionMapper quizQuestionMapper,
                           QuizOptionMapper quizOptionMapper,
                           QuizRecordMapper quizRecordMapper,
                           QuizAnswerRecordMapper quizAnswerRecordMapper) {
        this.quizMapper = quizMapper;
        this.quizQuestionMapper = quizQuestionMapper;
        this.quizOptionMapper = quizOptionMapper;
        this.quizRecordMapper = quizRecordMapper;
        this.quizAnswerRecordMapper = quizAnswerRecordMapper;
    }

    @Override
    public PageResultVO<QuizListItemVO> getQuizList(Integer page, Integer pageSize) {
        Integer offset = (page - 1) * pageSize;
        List<Quiz> quizzes = quizMapper.selectPublishedQuizList(offset, pageSize);
        Long total = quizMapper.countPublishedQuiz();
        Long userId = SecurityUtils.getCurrentUserIdOrNull();

        List<QuizListItemVO> list = new ArrayList<>();
        for (Quiz quiz : quizzes) {
            QuizListItemVO vo = new QuizListItemVO();
            vo.setId(quiz.getId());
            vo.setTitle(quiz.getTitle());
            vo.setDescription(quiz.getDescription());
            vo.setQuestionCount(quiz.getQuestionCount());
            vo.setTimeLimit(quiz.getTimeLimit());
            if (userId != null) {
                vo.setBestScore(quizRecordMapper.selectBestScore(userId, quiz.getId()));
            }
            list.add(vo);
        }
        return PageResultVO.of(list, total);
    }

    @Override
    public QuizDetailVO getQuizDetail(Long id) {
        Quiz quiz = quizMapper.selectPublishedQuizById(id);
        if (quiz == null) {
            throw new BusinessException(404, "测验不存在");
        }

        List<QuizQuestion> questions = quizQuestionMapper.selectByQuizId(id);
        List<QuizQuestionVO> questionVOList = new ArrayList<>();
        for (QuizQuestion question : questions) {
            QuizQuestionVO questionVO = new QuizQuestionVO();
            questionVO.setId(question.getId());
            questionVO.setTitle(question.getTitle());
            questionVO.setType(question.getQuestionType());
            questionVO.setAnswer(question.getAnswer());
            questionVO.setExplanation(question.getExplanation());

            List<QuizOptionVO> optionVOList = new ArrayList<>();
            for (QuizOption option : quizOptionMapper.selectByQuestionId(question.getId())) {
                QuizOptionVO optionVO = new QuizOptionVO();
                optionVO.setKey(option.getOptionKey());
                optionVO.setText(option.getOptionText());
                optionVOList.add(optionVO);
            }
            questionVO.setOptions(optionVOList);
            questionVOList.add(questionVO);
        }

        QuizDetailVO vo = new QuizDetailVO();
        vo.setId(quiz.getId());
        vo.setTitle(quiz.getTitle());
        vo.setDescription(quiz.getDescription());
        vo.setTimeLimit(quiz.getTimeLimit());
        vo.setQuestions(questionVOList);
        return vo;
    }

    @Override
    public QuizSubmitResultVO submitQuiz(QuizSubmitDTO quizSubmitDTO) {
        Long userId = SecurityUtils.requireCurrentUserId();
        QuizDetailVO quiz = getQuizDetail(quizSubmitDTO.getQuizId());
        if (quiz.getQuestions() == null || quiz.getQuestions().isEmpty()) {
            throw new BusinessException(400, "测验暂无题目");
        }

        Map<Long, String> answerMap = new HashMap<>();
        for (QuizAnswerDTO answerDTO : quizSubmitDTO.getAnswers()) {
            answerMap.put(answerDTO.getQuestionId(), normalizeAnswer(answerDTO.getAnswer()));
        }

        int correctCount = 0;
        List<Long> wrongQuestionIds = new ArrayList<>();
        List<QuizAnswerRecord> answerRecords = new ArrayList<>();

        for (QuizQuestionVO question : quiz.getQuestions()) {
            String userAnswer = answerMap.get(question.getId());
            if (userAnswer == null) {
                throw new BusinessException(400, "还有题目未作答");
            }

            String correctAnswer = normalizeAnswer(question.getAnswer());
            boolean isCorrect = correctAnswer.equals(userAnswer);
            if (isCorrect) {
                correctCount++;
            } else {
                wrongQuestionIds.add(question.getId());
            }

            QuizAnswerRecord answerRecord = new QuizAnswerRecord();
            answerRecord.setQuestionId(question.getId());
            answerRecord.setUserAnswer(userAnswer);
            answerRecord.setCorrectAnswer(correctAnswer);
            answerRecord.setIsCorrect(isCorrect ? 1 : 0);
            answerRecord.setCreateTime(LocalDateTime.now());
            answerRecords.add(answerRecord);
        }

        int totalCount = quiz.getQuestions().size();
        int score = Math.round(correctCount * 100.0f / totalCount);

        QuizRecord quizRecord = new QuizRecord();
        quizRecord.setUserId(userId);
        quizRecord.setQuizId(quizSubmitDTO.getQuizId());
        quizRecord.setScore(score);
        quizRecord.setCorrectCount(correctCount);
        quizRecord.setTotalCount(totalCount);
        quizRecord.setSubmitDurationSeconds(0);
        quizRecordMapper.insertRecord(quizRecord);

        for (QuizAnswerRecord answerRecord : answerRecords) {
            answerRecord.setQuizRecordId(quizRecord.getId());
            quizAnswerRecordMapper.insert(answerRecord);
        }

        QuizSubmitResultVO vo = new QuizSubmitResultVO();
        vo.setScore(score);
        vo.setCorrectCount(correctCount);
        vo.setTotalCount(totalCount);
        vo.setWrongQuestionIds(wrongQuestionIds);
        return vo;
    }

    @Override
    public PageResultVO<QuizRecordVO> getMyRecords(Integer page, Integer pageSize) {
        Long userId = SecurityUtils.requireCurrentUserId();
        Integer offset = (page - 1) * pageSize;
        List<QuizRecordVO> list = quizRecordMapper.selectUserQuizRecords(userId, offset, pageSize);
        Long total = quizRecordMapper.countUserQuizRecords(userId);
        return PageResultVO.of(list, total);
    }

    @Override
    public PageResultVO<WrongQuestionVO> getWrongQuestions(Integer page, Integer pageSize) {
        Long userId = SecurityUtils.requireCurrentUserId();
        Integer offset = (page - 1) * pageSize;
        List<WrongQuestionVO> list = quizAnswerRecordMapper.selectWrongQuestions(userId, offset, pageSize);
        for (WrongQuestionVO wrongQuestionVO : list) {
            List<QuizOptionVO> optionVOList = new ArrayList<>();
            for (QuizOption option : quizOptionMapper.selectByQuestionId(wrongQuestionVO.getId())) {
                QuizOptionVO optionVO = new QuizOptionVO();
                optionVO.setKey(option.getOptionKey());
                optionVO.setText(option.getOptionText());
                optionVOList.add(optionVO);
            }
            wrongQuestionVO.setOptions(optionVOList);
        }
        Long total = quizAnswerRecordMapper.countWrongQuestions(userId);
        return PageResultVO.of(list, total);
    }

    @Override
    public void removeWrongQuestions(RemoveWrongQuestionsDTO removeWrongQuestionsDTO) {
        Long userId = SecurityUtils.requireCurrentUserId();
        for (Long questionId : removeWrongQuestionsDTO.getQuestionIds()) {
            quizAnswerRecordMapper.markOneWrongQuestionCorrect(userId, questionId);
        }
    }

    @Override
    public void clearWrongQuestions() {
        Long userId = SecurityUtils.requireCurrentUserId();
        quizAnswerRecordMapper.clearWrongQuestions(userId);
    }

    private String normalizeAnswer(String answer) {
        if (answer == null) {
            return "";
        }
        String[] items = answer.split(",");
        List<String> list = new ArrayList<>();
        for (String item : items) {
            String value = item.trim();
            if (!value.isEmpty()) {
                list.add(value);
            }
        }
        Collections.sort(list);
        return String.join(",", list);
    }
}
