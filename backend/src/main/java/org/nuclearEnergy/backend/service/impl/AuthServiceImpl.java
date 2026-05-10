package org.nuclearEnergy.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.nuclearEnergy.backend.dto.LoginDTO;
import org.nuclearEnergy.backend.entity.SysUser;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.SysUserMapper;
import org.nuclearEnergy.backend.service.AuthService;
import org.nuclearEnergy.backend.utils.JwtUtils;
import org.nuclearEnergy.backend.vo.LoginVO;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    private final SysUserMapper sysUserMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtils jwtUtils;

    public AuthServiceImpl(SysUserMapper sysUserMapper,
                           PasswordEncoder passwordEncoder,
                           JwtUtils jwtUtils) {
        this.sysUserMapper = sysUserMapper;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtils = jwtUtils;
    }

    @Override
    public LoginVO login(LoginDTO loginDTO) {
        // 1. 按用户名查用户
        SysUser user = sysUserMapper.selectOne(
                new LambdaQueryWrapper<SysUser>()
                        .eq(SysUser::getUsername, loginDTO.getUsername())
                        .last("limit 1")
        );

        // 2. 用户不存在
        if (user == null) {
            throw new BusinessException(400, "用户名或密码错误");
        }

        // 3. 用户状态校验（假设 1=启用，0=禁用）
        if (user.getStatus() != null && user.getStatus() == 0) {
            throw new BusinessException(403, "账号已被禁用");
        }

        // 4. 校验密码（明文 vs BCrypt密文）
        if (!passwordEncoder.matches(loginDTO.getPassword(), user.getPassword())) {
            throw new BusinessException(400, "用户名或密码错误");
        }

        // 5. 生成 token 并返回
        String token = jwtUtils.generateToken(user.getId(), user.getUsername());
        LoginVO vo = new LoginVO();
        vo.setToken(token);
        return vo;
    }

}
