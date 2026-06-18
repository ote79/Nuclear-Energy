package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.vo.UploadVO;
import org.springframework.web.multipart.MultipartFile;

public interface UploadService {

    UploadVO upload(MultipartFile file);
}
