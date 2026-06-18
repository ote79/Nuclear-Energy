package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.entity.UploadFile;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.UploadFileMapper;
import org.nuclearEnergy.backend.service.UploadService;
import org.nuclearEnergy.backend.utils.SecurityUtils;
import org.nuclearEnergy.backend.vo.UploadVO;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class UploadServiceImpl implements UploadService {

    private final UploadFileMapper uploadFileMapper;

    public UploadServiceImpl(UploadFileMapper uploadFileMapper) {
        this.uploadFileMapper = uploadFileMapper;
    }

    @Override
    public UploadVO upload(MultipartFile file) {
        Long userId = SecurityUtils.requireCurrentUserId();
        if (file == null || file.isEmpty()) {
            throw new BusinessException(400, "上传文件不能为空");
        }

        String originalName = file.getOriginalFilename();
        String suffix = "";
        if (originalName != null && originalName.lastIndexOf(".") >= 0) {
            suffix = originalName.substring(originalName.lastIndexOf("."));
        }
        String storedName = UUID.randomUUID() + suffix;
        Path uploadDir = Path.of("uploads", "avatar");
        Path targetPath = uploadDir.resolve(storedName);

        try {
            Files.createDirectories(uploadDir);
            file.transferTo(targetPath);
        } catch (IOException e) {
            throw new BusinessException(500, "文件保存失败");
        }

        String url = "/uploads/avatar/" + storedName;
        UploadFile uploadFile = new UploadFile();
        uploadFile.setUserId(userId);
        uploadFile.setBizType("avatar");
        uploadFile.setOriginalName(originalName);
        uploadFile.setStoredName(storedName);
        uploadFile.setFilePath(targetPath.toAbsolutePath().toString());
        uploadFile.setFileUrl(url);
        uploadFile.setFileSize(file.getSize());
        uploadFile.setContentType(file.getContentType());
        uploadFile.setCreateTime(LocalDateTime.now());
        uploadFileMapper.insert(uploadFile);

        UploadVO vo = new UploadVO();
        vo.setUrl(url);
        return vo;
    }
}
