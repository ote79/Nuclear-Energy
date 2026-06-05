package org.nuclearEnergy.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.nuclearEnergy.backend.entity.RadiationRecord;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.RadiationRecordMapper;
import org.nuclearEnergy.backend.service.RadiationRecordService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class RadiationRecordServiceImpl implements RadiationRecordService {

    private final RadiationRecordMapper recordMapper;

    public RadiationRecordServiceImpl(RadiationRecordMapper recordMapper) {
        this.recordMapper = recordMapper;
    }

    private Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication.getPrincipal() == null) {
            throw new BusinessException(401, "用户未登录");
        }
        return Long.parseLong(authentication.getPrincipal().toString());
    }

    @Override
    public List<RadiationRecord> getUserRecords() {
        Long userId = getCurrentUserId();
        LambdaQueryWrapper<RadiationRecord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RadiationRecord::getUserId, userId).orderByDesc(RadiationRecord::getCreateTime);
        return recordMapper.selectList(wrapper);
    }

    @Override
    public RadiationRecord addRecord(RadiationRecord record) {
        Long userId = getCurrentUserId();
        record.setUserId(userId);
        record.setCreateTime(LocalDateTime.now());
        recordMapper.insert(record);
        return record;
    }

    @Override
    public void deleteRecord(Long id) {
        Long userId = getCurrentUserId();
        LambdaQueryWrapper<RadiationRecord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RadiationRecord::getId, id).eq(RadiationRecord::getUserId, userId);
        RadiationRecord record = recordMapper.selectOne(wrapper);
        if (record == null) {
            throw new BusinessException(404, "记录不存在");
        }
        recordMapper.deleteById(id);
    }

    @Override
    public Map<String, Object> getDoseStats() {
        Long userId = getCurrentUserId();
        List<RadiationRecord> records = getUserRecords();

        int currentYear = LocalDateTime.now().getYear();
        double currentYearDose = 0;
        double last30DaysDose = 0;
        LocalDateTime thirtyDaysAgo = LocalDateTime.now().minusDays(30);

        for (RadiationRecord r : records) {
            if (r.getCreateTime() != null && r.getCreateTime().getYear() == currentYear) {
                currentYearDose += r.getDose() != null ? r.getDose() : 0;
            }
            if (r.getCreateTime() != null && r.getCreateTime().isAfter(thirtyDaysAgo)) {
                last30DaysDose += r.getDose() != null ? r.getDose() : 0;
            }
        }

        Map<String, Object> stats = new HashMap<>();
        stats.put("currentYearDose", currentYearDose);
        stats.put("last30DaysDose", last30DaysDose);
        stats.put("totalRecords", records.size());
        stats.put("backgroundAnnualDose", 2.4);
        stats.put("publicAnnualLimit", 1.0);
        return stats;
    }

    @Override
    public Map<Integer, Double> getMonthlyStats() {
        Long userId = getCurrentUserId();
        List<RadiationRecord> records = getUserRecords();

        Map<Integer, Double> monthlyStats = new LinkedHashMap<>();
        for (int i = 1; i <= 12; i++) {
            monthlyStats.put(i, 0.0);
        }

        int currentYear = LocalDateTime.now().getYear();
        for (RadiationRecord r : records) {
            if (r.getCreateTime() != null && r.getCreateTime().getYear() == currentYear) {
                int month = r.getCreateTime().getMonthValue();
                monthlyStats.merge(month, r.getDose() != null ? r.getDose() : 0, Double::sum);
            }
        }
        return monthlyStats;
    }
}
