package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.dto.UpdateUserStatusDTO;
import org.nuclearEnergy.backend.entity.SysUser;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.SysRoleMapper;
import org.nuclearEnergy.backend.mapper.SysUserMapper;
import org.nuclearEnergy.backend.service.AdminService;
import org.nuclearEnergy.backend.vo.UserListItemVO;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;

@Service
public class AdminServiceImpl implements AdminService {

    private final SysRoleMapper sysRoleMapper;
    private final SysUserMapper sysUserMapper;

    public AdminServiceImpl(SysRoleMapper sysRoleMapper, SysUserMapper sysUserMapper) {
        this.sysRoleMapper = sysRoleMapper;
        this.sysUserMapper = sysUserMapper;
    }

    @Override
    public List<UserListItemVO> getAllUsers() {

        return sysRoleMapper.selectAllUsers();
    }

    @Override
    @Transactional
    public void updateUserStatus(Long userId, UpdateUserStatusDTO updateUserStatusDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        SysUser user = sysUserMapper.selectUserByUserId(userId);

        if (user == null) {
            throw new BusinessException("用户不存在！！！");
        }

        if (updateUserStatusDTO.getStatus() != 0 && updateUserStatusDTO.getStatus() != 1){
            throw new BusinessException("传参错误，请检查是否为0或1!");
        }

        if ((user.getId() == Long.parseLong(Objects.requireNonNull(authentication.getPrincipal()).toString()))
            && (updateUserStatusDTO.getStatus() == 0)) {
            throw new BusinessException("小逼崽子我就知道你会禁自己账号");
        }

        if (user.getStatus() != 1 && user.getStatus() != 0) {
            throw new BusinessException("状态码是" + user.getStatus() + "，不能在这里修改");
        }

        user.setStatus(updateUserStatusDTO.getStatus());

        int count = sysUserMapper.updateById(user);

        if (count != 1) {
            throw new BusinessException("未知错误！！！");
        }
    }
}
