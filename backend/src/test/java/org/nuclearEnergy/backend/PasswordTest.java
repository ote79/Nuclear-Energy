package org.nuclearEnergy.backend;

import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.nuclearEnergy.backend.mapper.SysRoleMapper;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class PasswordTest {

    @Resource
    SysRoleMapper sysRoleMapper;

    @Test
    public void passwordTest(){
        System.out.println(sysRoleMapper.selectAllUsers());
    }

}
