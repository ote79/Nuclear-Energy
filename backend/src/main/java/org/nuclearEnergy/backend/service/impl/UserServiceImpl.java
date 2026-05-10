package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.entity.SysUser;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.SysUserMapper;
import org.nuclearEnergy.backend.service.UserService;
import org.nuclearEnergy.backend.vo.UserInfoVO;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    private final SysUserMapper sysUserMapper;

    public UserServiceImpl(SysUserMapper sysUserMapper) {
        this.sysUserMapper = sysUserMapper;
    }

    @Override
    public UserInfoVO getCurrentUser() {
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

        UserInfoVO userInfoVO = new UserInfoVO();
        userInfoVO.setId(user.getId());
        userInfoVO.setUsername(user.getUsername());
        userInfoVO.setNickname(user.getNickname());
        userInfoVO.setPhone(user.getPhone());
        userInfoVO.setEmail(user.getEmail());
        userInfoVO.setStatus(user.getStatus());

        return userInfoVO;
    }
}
