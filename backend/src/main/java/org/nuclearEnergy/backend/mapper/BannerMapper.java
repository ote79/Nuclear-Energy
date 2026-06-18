package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.Banner;

import java.util.List;

@Mapper
public interface BannerMapper extends BaseMapper<Banner> {

    @Select("""
            select *
            from banner
            where status = 1
            order by sort asc, id asc
            """)
    List<Banner> selectEnabledBanners();
}
