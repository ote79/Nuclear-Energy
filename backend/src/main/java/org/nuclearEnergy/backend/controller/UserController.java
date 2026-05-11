package org.nuclearEnergy.backend.controller;


import jakarta.validation.Valid;
import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.dto.UpdatePasswordDTO;
import org.nuclearEnergy.backend.dto.UpdateUserProfileDTO;
import org.nuclearEnergy.backend.service.UserService;
import org.nuclearEnergy.backend.vo.UserInfoVO;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/me")
    public Result<UserInfoVO> me() {
        UserInfoVO userInfoVO = userService.getCurrentUser();
        return Result.success(userInfoVO);
    }

    @PostMapping("/profile")
    public Result<String> updateProfile(@Valid @RequestBody UpdateUserProfileDTO updateUserProfileDTO){
        userService.updateProfile(updateUserProfileDTO);
        return Result.success("更新成功");
    }

    @PostMapping("/password")
    public Result<String> updatePassword(@Valid @RequestBody UpdatePasswordDTO updatePasswordDTO){
        userService.updatePassword(updatePasswordDTO);
        return Result.success("密码更改成功");
    }
}
