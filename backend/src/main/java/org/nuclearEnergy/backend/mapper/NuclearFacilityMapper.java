package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.NuclearFacility;

import java.util.List;

@Mapper
public interface NuclearFacilityMapper extends BaseMapper<NuclearFacility> {

    @Select("""
            select *
            from nuclear_facility
            where enabled = 1
            order by sort asc, id asc
            """)
    List<NuclearFacility> selectEnabledFacilities();
}
