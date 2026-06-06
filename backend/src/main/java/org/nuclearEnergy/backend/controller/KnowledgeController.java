package org.nuclearEnergy.backend.controller;

import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.service.KnowledgeService;
import org.nuclearEnergy.backend.vo.KnowledgeArticleDetailVO;
import org.nuclearEnergy.backend.vo.KnowledgeArticleListItemVO;
import org.nuclearEnergy.backend.vo.KnowledgeCategoryVO;
import org.nuclearEnergy.backend.vo.PageResultVO;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/knowledge")
public class KnowledgeController {

    private final KnowledgeService knowledgeService;

    public KnowledgeController(KnowledgeService knowledgeService) {
        this.knowledgeService = knowledgeService;
    }


    @GetMapping("/categories")
    public Result<List<KnowledgeCategoryVO>> getCategories() {

        return Result.success(knowledgeService.getCategories());
    }

    @GetMapping("/{id}")
    public Result<KnowledgeArticleDetailVO> getArticleById(@PathVariable Long id){
        return Result.success(knowledgeService.getPublishedArticleById(id));
    }

    @GetMapping("/list")
    public Result<PageResultVO<KnowledgeArticleListItemVO>> getArticleList(
            @RequestParam Integer pageSize,
            @RequestParam Integer page,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Long categoryId
    ) {
        Integer offset = (page - 1) * pageSize;

        Long total = knowledgeService.getPublishedArticleCount(categoryId, keyword);

        return Result.success(new PageResultVO<>(
                knowledgeService.getKnowledgeArticleListItem(categoryId, keyword, offset, pageSize),
                total
        ));
    }
}
