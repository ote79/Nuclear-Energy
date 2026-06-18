package org.nuclearEnergy.backend.vo;

import lombok.Data;

@Data
public class BannerVO {

    private Long id;

    private String title;

    private String imageUrl;

    private String linkUrl;

    private Integer sort;
}
