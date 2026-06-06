package org.nuclearEnergy.backend.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class KnowledgeArticleDetailVO {
    private Long id;

    private String title;

    private String categoryName;

    private LocalDateTime createdAt;

    private String content;
}
