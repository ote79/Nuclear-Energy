package org.nuclearEnergy.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("nuclear_facility")
public class NuclearFacility {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private String name;

    private String facilityType;

    private BigDecimal lat;

    private BigDecimal lng;

    private String status;

    private String summary;

    private String detail;

    private String mapUrl;

    private String newsUrl;

    private String gradient;

    private BigDecimal mapX;

    private BigDecimal mapY;

    private Integer sort;

    private Integer enabled;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
