package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.KnowledgeArticle;
import org.nuclearEnergy.backend.vo.KnowledgeArticleListItemVO;

import java.util.List;

@Mapper
public interface KnowledgeArticleMapper extends BaseMapper<KnowledgeArticle> {
    @Select("select * from knowledge_article where id = #{id} and status = 1")
    KnowledgeArticle getPublishedArticleById(Long id);

    @Select("""
                    select
                        ka.id,
                        ka.title,
                        ka.summary,
                        kc.name as categoryName,
                        ka.create_time as createdAt
                    from knowledge_article ka
                    left join knowledge_category kc
                    on ka.category_id = kc.id
                    where ka.status = 1
                        and (#{categoryId} is null or ka.category_id = #{categoryId})
                        and (#{keyword} is null or #{keyword} = '' or ka.title like concat('%',#{keyword},'%') or ka.summary like concat('%', #{keyword}, '%'))
                    order by ka.create_time desc
                    limit #{offset},#{pageSize}
            """)
    List<KnowledgeArticleListItemVO> getPublishedArticleList(Long categoryId,
                                                             String keyword,
                                                             Integer offset,
                                                             Integer pageSize);

    @Select("select count(*) from knowledge_article")
    Long getAllArticleCounts();

    @Select("""
            select count(*)
            from knowledge_article ka
            where ka.status = 1
                and (#{categoryId} is null or ka.category_id = #{categoryId})
                and (#{keyword} is null or #{keyword} = '' or ka.title like concat('%',#{keyword},'%') or ka.summary like concat('%', #{keyword}, '%'))
        """)
    Long getPublishedArticleCount(Long categoryId, String keyword);
}
