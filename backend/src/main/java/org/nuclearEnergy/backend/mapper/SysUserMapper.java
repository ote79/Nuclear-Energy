package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.dto.UpdateUserStatusDTO;
import org.nuclearEnergy.backend.entity.SysUser;


@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {

    @Select("select * from sys_user where username = #{username}")
    SysUser selectByUsername(String username);


    @Select("select * from sys_user where id = #{userId}")
    SysUser selectUserByUserId(long userId);
}
