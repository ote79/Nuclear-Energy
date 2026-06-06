package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.entity.KnowledgeArticle;
import org.nuclearEnergy.backend.entity.KnowledgeCategory;
import org.nuclearEnergy.backend.mapper.KnowledgeArticleMapper;
import org.nuclearEnergy.backend.mapper.KnowledgeCategoryMapper;
import org.nuclearEnergy.backend.service.KnowledgeService;
import org.nuclearEnergy.backend.vo.KnowledgeArticleDetailVO;
import org.nuclearEnergy.backend.vo.KnowledgeArticleListItemVO;
import org.nuclearEnergy.backend.vo.KnowledgeCategoryVO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class KnowledgeServiceImpl implements KnowledgeService {

    private final KnowledgeArticleMapper knowledgeArticleMapper;
    private final KnowledgeCategoryMapper knowledgeCategoryMapper;

    public KnowledgeServiceImpl(KnowledgeCategoryMapper knowledgeCategoryMapper,
                                KnowledgeArticleMapper knowledgeArticleMapper) {
        this.knowledgeArticleMapper = knowledgeArticleMapper;
        this.knowledgeCategoryMapper = knowledgeCategoryMapper;
    }


    @Override
    public List<KnowledgeCategoryVO> getCategories() {
        List<KnowledgeCategory> categoryList = knowledgeCategoryMapper.getEnableCategory();

        List<KnowledgeCategoryVO> voList = new ArrayList<>();

        for (KnowledgeCategory category : categoryList) {
            KnowledgeCategoryVO vo = new KnowledgeCategoryVO();
            vo.setId(category.getId());
            vo.setName(category.getName());
            voList.add(vo);
        }

        return voList;
    }

    @Override
    public KnowledgeArticleDetailVO getPublishedArticleById(Long id) {

        KnowledgeArticle article = knowledgeArticleMapper.getPublishedArticleById(id);
        KnowledgeArticleDetailVO vo = new KnowledgeArticleDetailVO();

        vo.setId(article.getId());
        vo.setTitle(article.getTitle());
        vo.setCategoryName(knowledgeCategoryMapper.getCategoryNameById(article.getCategoryId()));
        vo.setCreatedAt(article.getCreateTime());
        vo.setContent(article.getContent());

        return vo;
    }

    @Override
    public List<KnowledgeArticleListItemVO> getKnowledgeArticleListItem(Long categoryId,
                                                                        String keyword,
                                                                        Integer offset,
                                                                        Integer pageSize) {


        return knowledgeArticleMapper.getPublishedArticleList(categoryId, keyword, offset, pageSize);
    }

    @Override
    public Long getAllArticleCounts() {
        return knowledgeArticleMapper.getAllArticleCounts();
    }

    @Override
    public Long getPublishedArticleCount(Long categoryId, String keyword) {
        return knowledgeArticleMapper.getPublishedArticleCount(categoryId, keyword);
    }
}
