package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.KnowledgeCategory;

import java.util.List;

@Mapper
public interface KnowledgeCategoryMapper extends BaseMapper<KnowledgeCategory> {
    @Select("select * from knowledge_category where status = 1 order by sort,id")
    List<KnowledgeCategory> getEnableCategory();

    @Select("select name from knowledge_category where id = #{id}")
    String getCategoryNameById(Long id);
}
