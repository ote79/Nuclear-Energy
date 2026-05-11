package org.nuclearEnergy.backend.controller;

import org.nuclearEnergy.backend.common.Result;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin")
public class AdminController {

    @GetMapping("/hello")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<String> hello(){
        return Result.success("管理员接口验权成功");
    }

}
