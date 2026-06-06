package org.nuclearEnergy.backend.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class KnowledgeArticleListItemVO {
    private Long id;

    private String title;

    private String summary;

    private String categoryName;

    private LocalDateTime createdAt;
}
