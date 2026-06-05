package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.entity.RadiationRecord;

import java.util.List;
import java.util.Map;

public interface RadiationRecordService {
    List<RadiationRecord> getUserRecords();
    RadiationRecord addRecord(RadiationRecord record);
    void deleteRecord(Long id);
    Map<String, Object> getDoseStats();
    Map<Integer, Double> getMonthlyStats();
}
