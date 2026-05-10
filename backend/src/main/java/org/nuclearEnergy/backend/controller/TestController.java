package org.nuclearEnergy.backend.controller;


import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.entity.SysUser;
import org.nuclearEnergy.backend.exception.BusinessException;
import org.nuclearEnergy.backend.mapper.SysUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class TestController {

    @Autowired
    SysUserMapper userMapper;

    @GetMapping("/hello")
    public Result<String> hello(){
        return Result.success("后端相应成功");
    }

    @GetMapping("/error")
    public Result<String> error(){
        int n = 10 / 0;
        return Result.success("cheng!");
    }

    @GetMapping("/testError")
    public Result<String> businessError() {
        throw new BusinessException(400, "这是一个业务异常测试");
    }

    @GetMapping("/user")
    public Result<SysUser> getUser() {
        SysUser sysUser = userMapper.selectById(1L);
        return Result.success(sysUser);
    }


}
