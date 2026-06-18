package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.mapper.StatsMapper;
import org.nuclearEnergy.backend.service.StatsService;
import org.nuclearEnergy.backend.utils.SecurityUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StatsServiceImpl implements StatsService {

    private final StatsMapper statsMapper;

    public StatsServiceImpl(StatsMapper statsMapper) {
        this.statsMapper = statsMapper;
    }

    @Override
    public Map<String, Object> getLearningStats() {
        Long userId = SecurityUtils.requireCurrentUserId();
        Integer studyMinutes = statsMapper.sumCourseStudyMinutes(userId);
        Integer completedCourses = statsMapper.countCompletedCourses(userId);

        Map<String, Object> cards = new HashMap<>();
        cards.put("totalHours", Math.round((studyMinutes == null ? 0 : studyMinutes) / 60.0));
        cards.put("completedCourses", completedCourses == null ? 0 : completedCourses);

        Map<String, Object> result = new HashMap<>();
        result.put("cards", cards);
        result.put("records", statsMapper.selectRecentLearningRecords(userId));
        result.put("chart", buildChart(statsMapper.selectLearningChart(userId)));
        return result;
    }

    @Override
    public Map<String, Object> getQuizStats() {
        Long userId = SecurityUtils.requireCurrentUserId();
        Integer totalAttempts = statsMapper.countQuizAttempts(userId);
        Integer avgScore = statsMapper.avgQuizScore(userId);

        Map<String, Object> cards = new HashMap<>();
        cards.put("totalAttempts", totalAttempts == null ? 0 : totalAttempts);
        cards.put("avgScore", avgScore == null ? 0 : avgScore);

        Map<String, Object> result = new HashMap<>();
        result.put("cards", cards);
        result.put("chart", buildChart(statsMapper.selectQuizChart(userId)));
        return result;
    }

    @Override
    public Map<String, Object> getPlatformStats() {
        Map<String, Object> result = new HashMap<>();
        result.put("userCount", statsMapper.countUsers());
        result.put("courseCount", statsMapper.countCourses());
        result.put("articleCount", statsMapper.countArticles());
        result.put("quizCount", statsMapper.countQuizzes());
        return result;
    }

    private Map<String, Object> buildChart(List<Map<String, Object>> rows) {
        List<String> labels = new ArrayList<>();
        List<Object> values = new ArrayList<>();
        for (Map<String, Object> row : rows) {
            labels.add(String.valueOf(row.get("label")));
            values.add(row.get("value"));
        }

        Map<String, Object> chart = new HashMap<>();
        chart.put("labels", labels);
        chart.put("values", values);
        return chart;
    }
}
