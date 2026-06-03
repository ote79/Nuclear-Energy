package org.nuclearEnergy.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.nuclearEnergy.backend.dto.UpdateUserStatusDTO;
import org.nuclearEnergy.backend.entity.SysUser;
import org.nuclearEnergy.backend.vo.UserListItemVO;

import java.util.List;


@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {

    @Select("select * from sys_user where username = #{username}")
    SysUser selectByUsername(String username);


    @Select("select * from sys_user where id = #{userId}")
    SysUser selectUserByUserId(long userId);

    @Select("select id as userId,username,nickname,phone,email,status from sys_user")
    List<UserListItemVO> getAllUsers();
}
