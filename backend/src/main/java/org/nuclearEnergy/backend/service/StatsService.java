package org.nuclearEnergy.backend.service;

import java.util.Map;

public interface StatsService {

    Map<String, Object> getLearningStats();

    Map<String, Object> getQuizStats();

    Map<String, Object> getPlatformStats();
}
