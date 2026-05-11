package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.dto.UpdatePasswordDTO;
import org.nuclearEnergy.backend.dto.UpdateUserProfileDTO;
import org.nuclearEnergy.backend.entity.SysUser;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.SysRoleMapper;
import org.nuclearEnergy.backend.mapper.SysUserMapper;
import org.nuclearEnergy.backend.service.UserService;
import org.nuclearEnergy.backend.vo.UserInfoVO;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    private final SysUserMapper sysUserMapper;
    private final SysRoleMapper sysRoleMapper;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(SysUserMapper sysUserMapper,SysRoleMapper sysRoleMapper,PasswordEncoder passwordEncoder) {
        this.sysUserMapper = sysUserMapper;
        this.sysRoleMapper = sysRoleMapper;
        this.passwordEncoder = passwordEncoder;
    }

    private SysUser getCurrentLoginUser(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || authentication.getPrincipal() == null) {
            throw new BusinessException(401, "用户未登录");
        }

        // 这里先假设你后面的过滤器里放进去的是 userId
        long userId;
        try {
            userId = Long.parseLong(authentication.getPrincipal().toString());
        } catch (Exception e) {
            throw new BusinessException(401, "用户认证信息无效");
        }

        SysUser user = sysUserMapper.selectById(userId);
        if (user == null) {
            throw new BusinessException(404, "用户不存在");
        }

        return user;
    }

    @Override
    public UserInfoVO getCurrentUser() {

        SysUser user = getCurrentLoginUser();

        UserInfoVO userInfoVO = new UserInfoVO();
        userInfoVO.setId(user.getId());
        userInfoVO.setUsername(user.getUsername());
        userInfoVO.setNickname(user.getNickname());
        userInfoVO.setPhone(user.getPhone());
        userInfoVO.setEmail(user.getEmail());
        userInfoVO.setStatus(user.getStatus());

        List<String> roles = sysRoleMapper.selectAllRolesByUserId(user.getId());
        userInfoVO.setRoles(roles);
        return userInfoVO;
    }

    @Override
    public void updateProfile(UpdateUserProfileDTO updateUserProfileDTO){
        SysUser user = getCurrentLoginUser();
        user.setNickname(updateUserProfileDTO.getNickname());
        user.setPhone(updateUserProfileDTO.getPhone());
        user.setEmail(updateUserProfileDTO.getEmail());
        int count = sysUserMapper.updateById(user);

        if (count <= 0)
            throw new BusinessException("更新失败！！！请检查输入内容后重试");
    }

    @Override
    public void updatePassword(UpdatePasswordDTO updatePasswordDTO){
        SysUser user = getCurrentLoginUser();

        if (!passwordEncoder.matches(updatePasswordDTO.getOldPassword(), user.getPassword()))
            throw new BusinessException("旧密码错误！！！");
        user.setPassword(passwordEncoder.encode(updatePasswordDTO.getNewPassword()));

        int count = sysUserMapper.updateById(user);
        if (count <= 0) {
            throw new BusinessException(500, "修改密码失败");
        }
    }
}
