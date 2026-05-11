package org.nuclearEnergy.backend.controller;

import jakarta.validation.Valid;
import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.dto.LoginDTO;
import org.nuclearEnergy.backend.dto.RegisterDTO;
import org.nuclearEnergy.backend.service.AuthService;
import org.nuclearEnergy.backend.vo.LoginVO;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;

    // 使用构造器注入，依赖更明确，也方便测试
    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public Result<LoginVO> login(@Valid @RequestBody LoginDTO loginDTO) {
        LoginVO loginVO = authService.login(loginDTO);
        return Result.success(loginVO);
    }

    @PostMapping("/register")
    public Result<String> register(@Valid @RequestBody RegisterDTO registerDTO){
        authService.register(registerDTO);
        return Result.success("注册成功");
    }

}
