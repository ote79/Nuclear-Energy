package org.nuclearEnergy.backend.controller;

import jakarta.validation.constraints.NotNull;
import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.service.HomeService;
import org.nuclearEnergy.backend.service.UploadService;
import org.nuclearEnergy.backend.vo.BannerVO;
import org.nuclearEnergy.backend.vo.NuclearFacilityVO;
import org.nuclearEnergy.backend.vo.UploadVO;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Validated
@RestController
public class HomeController {

    private final HomeService homeService;
    private final UploadService uploadService;

    public HomeController(HomeService homeService, UploadService uploadService) {
        this.homeService = homeService;
        this.uploadService = uploadService;
    }

    @GetMapping("/banners")
    public Result<List<BannerVO>> getBanners() {
        return Result.success(homeService.getBanners());
    }

    @GetMapping("/facilities")
    public Result<List<NuclearFacilityVO>> getFacilities() {
        return Result.success(homeService.getFacilities());
    }

    @PostMapping("/upload")
    public Result<UploadVO> upload(@NotNull(message = "上传文件不能为空") @RequestParam("file") MultipartFile file) {
        return Result.success(uploadService.upload(file));
    }
}
