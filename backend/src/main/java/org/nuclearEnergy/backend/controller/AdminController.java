package org.nuclearEnergy.backend.controller;

import jakarta.validation.Valid;
import org.nuclearEnergy.backend.common.Result;
import org.nuclearEnergy.backend.dto.UpdateUserStatusDTO;
import org.nuclearEnergy.backend.service.AdminService;
import org.nuclearEnergy.backend.vo.UserListItemVO;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    public AdminController(AdminService adminService){

        this.adminService = adminService;

    }

    @GetMapping("/hello")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<String> hello(){
        return Result.success("管理员接口验权成功");
    }


    @GetMapping("/users")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<List<UserListItemVO>> getUsers(){
        return Result.success(adminService.getAllUsers());
    }

    @PutMapping("/users/{userId}/status")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<String> updateUserStatus(@PathVariable Long userId,
                                           @Valid @RequestBody UpdateUserStatusDTO updateUserStatusDTO){
        adminService.updateUserStatus(userId,updateUserStatusDTO);
        return Result.success("用户更新成功");
    }
}
