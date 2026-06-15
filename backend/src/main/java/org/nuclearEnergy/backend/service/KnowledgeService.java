package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.vo.KnowledgeArticleDetailVO;
import org.nuclearEnergy.backend.vo.KnowledgeArticleListItemVO;
import org.nuclearEnergy.backend.vo.KnowledgeCategoryVO;

import java.util.List;

public interface KnowledgeService {

    List<KnowledgeCategoryVO> getCategories();

    KnowledgeArticleDetailVO getPublishedArticleById(Long id);

    List<KnowledgeArticleListItemVO> getKnowledgeArticleListItem(Long categoryId,
                                                           String keyword,
                                                           Integer offset,
                                                           Integer pageSize);
    Long getAllArticleCounts();

    Long getPublishedArticleCount(Long categoryId, String keyword);
}
