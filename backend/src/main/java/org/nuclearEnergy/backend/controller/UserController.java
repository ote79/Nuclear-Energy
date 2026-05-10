package org.nuclearEnergy.backend.controller;


import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.service.UserService;
import org.nuclearEnergy.backend.vo.UserInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;

    @GetMapping("/me")
    public Result<UserInfoVO> me() {
        UserInfoVO userInfoVO = userService.getCurrentUser();
        return Result.success(userInfoVO);
    }


}
