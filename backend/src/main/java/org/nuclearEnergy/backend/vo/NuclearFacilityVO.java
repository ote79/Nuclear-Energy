package org.nuclearEnergy.backend.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class NuclearFacilityVO {

    private Long id;

    private String name;

    private String type;

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
}
