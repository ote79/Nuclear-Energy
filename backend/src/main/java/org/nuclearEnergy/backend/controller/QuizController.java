package org.nuclearEnergy.backend.controller;

import jakarta.validation.Valid;
import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.dto.QuizSubmitDTO;
import org.nuclearEnergy.backend.dto.RemoveWrongQuestionsDTO;
import org.nuclearEnergy.backend.service.QuizService;
import org.nuclearEnergy.backend.vo.PageResultVO;
import org.nuclearEnergy.backend.vo.QuizDetailVO;
import org.nuclearEnergy.backend.vo.QuizListItemVO;
import org.nuclearEnergy.backend.vo.QuizRecordVO;
import org.nuclearEnergy.backend.vo.QuizSubmitResultVO;
import org.nuclearEnergy.backend.vo.WrongQuestionVO;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/quiz")
public class QuizController {

    private final QuizService quizService;

    public QuizController(QuizService quizService) {
        this.quizService = quizService;
    }

    @GetMapping("/list")
    public Result<Object> getQuizList(@RequestParam(required = false) Long id,
                                      @RequestParam(defaultValue = "1") Integer page,
                                      @RequestParam(defaultValue = "9") Integer pageSize) {
        if (id != null) {
            QuizDetailVO detail = quizService.getQuizDetail(id);
            return Result.success(detail);
        }

        PageResultVO<QuizListItemVO> pageResult = quizService.getQuizList(page, pageSize);
        return Result.success(pageResult);
    }

    @PostMapping("/submit")
    public Result<QuizSubmitResultVO> submitQuiz(@Valid @RequestBody QuizSubmitDTO quizSubmitDTO) {
        return Result.success(quizService.submitQuiz(quizSubmitDTO));
    }

    @GetMapping("/records")
    public Result<PageResultVO<QuizRecordVO>> getMyRecords(@RequestParam(defaultValue = "1") Integer page,
                                                           @RequestParam(defaultValue = "10") Integer pageSize) {
        return Result.success(quizService.getMyRecords(page, pageSize));
    }

    @GetMapping("/wrong-questions")
    public Result<PageResultVO<WrongQuestionVO>> getWrongQuestions(@RequestParam(defaultValue = "1") Integer page,
                                                                   @RequestParam(defaultValue = "10") Integer pageSize) {
        return Result.success(quizService.getWrongQuestions(page, pageSize));
    }

    @PostMapping("/wrong-questions/remove")
    public Result<String> removeWrongQuestions(@Valid @RequestBody RemoveWrongQuestionsDTO removeWrongQuestionsDTO) {
        quizService.removeWrongQuestions(removeWrongQuestionsDTO);
        return Result.success("移除成功");
    }

    @DeleteMapping("/wrong-questions")
    public Result<String> clearWrongQuestions() {
        quizService.clearWrongQuestions();
        return Result.success("清空成功");
    }
}
