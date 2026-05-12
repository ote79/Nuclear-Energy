package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.entity.SysRole;
import org.nuclearEnergy.backend.vo.UserListItemVO;

import java.util.List;


@Mapper
public interface SysRoleMapper extends BaseMapper<SysRole> {

    @Select("select * from sys_role where role_name = #{roleName}")
    SysRole selectRoleByName(String roleName);

    @Select("select * from sys_role where role_code = #{code}")
    SysRole selectRoleByCode(String code);

    @Select("select role_code from sys_role sr left join sys_user_role sur on sr.id = sur.role_id where sur.user_id = #{userId}")
    List<String> selectAllRolesByUserId(long userId);

    @Select("select role_code,role_name,su.id userId,su.phone,su.username,su.nickname,su.email,su.status from sys_role sr left join sys_user_role sur on sr.id = sur.role_id left join sys_user su on sur.user_id = su.id")
    List<UserListItemVO> selectAllUsers();
}
