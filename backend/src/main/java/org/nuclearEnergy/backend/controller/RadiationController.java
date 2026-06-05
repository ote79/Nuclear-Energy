package org.nuclearEnergy.backend.controller;

import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.entity.RadiationRecord;
import org.nuclearEnergy.backend.service.RadiationRecordService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/radiation")
public class RadiationController {

    private final RadiationRecordService radiationRecordService;

    public RadiationController(RadiationRecordService radiationRecordService) {
        this.radiationRecordService = radiationRecordService;
    }

    @GetMapping("/records")
    public Result<List<RadiationRecord>> getRecords() {
        return Result.success(radiationRecordService.getUserRecords());
    }

    @PostMapping("/records")
    public Result<RadiationRecord> addRecord(@RequestBody RadiationRecord record) {
        return Result.success(radiationRecordService.addRecord(record));
    }

    @DeleteMapping("/records/{id}")
    public Result<String> deleteRecord(@PathVariable Long id) {
        radiationRecordService.deleteRecord(id);
        return Result.success("删除成功");
    }

    @GetMapping("/stats")
    public Result<Map<String, Object>> getStats() {
        return Result.success(radiationRecordService.getDoseStats());
    }

    @GetMapping("/monthly-stats")
    public Result<Map<Integer, Double>> getMonthlyStats() {
        return Result.success(radiationRecordService.getMonthlyStats());
    }
}
