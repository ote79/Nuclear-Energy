package org.nuclearEnergy.backend.controller;

import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.service.StatsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/stats")
public class StatsController {

    private final StatsService statsService;

    public StatsController(StatsService statsService) {
        this.statsService = statsService;
    }

    @GetMapping("/learning")
    public Result<Map<String, Object>> getLearningStats() {
        return Result.success(statsService.getLearningStats());
    }

    @GetMapping("/quiz")
    public Result<Map<String, Object>> getQuizStats() {
        return Result.success(statsService.getQuizStats());
    }

    @GetMapping("/platform")
    public Result<Map<String, Object>> getPlatformStats() {
        return Result.success(statsService.getPlatformStats());
    }
}
