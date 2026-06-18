package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("upload_file")
public class UploadFile {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String bizType;

    private String originalName;

    private String storedName;

    private String filePath;

    private String fileUrl;

    private Long fileSize;

    private String contentType;

    private LocalDateTime createTime;
}
