package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.nuclearEnergy.backend.entity.SysUserRole;

@Mapper
public interface SysUserRoleMapper extends BaseMapper<SysUserRole> {

    @Delete("delete from sys_user_role where user_id = #{userId}")
    int deleteAllRoleByUserId(Long userId);

    @Insert("insert into sys_user_role (user_id, role_id) values (#{userId},#{roleId})")
    int insertRoleIdByUserId(Long userId,Long roleId);
}
