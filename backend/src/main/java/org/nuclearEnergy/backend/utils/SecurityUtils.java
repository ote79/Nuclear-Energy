package org.nuclearEnergy.backend.utils;

import org.nuclearEnergy.backend.exception.BusinessException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class SecurityUtils {

    private SecurityUtils() {
    }

    public static Long getCurrentUserIdOrNull() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication.getPrincipal() == null) {
            return null;
        }

        try {
            return Long.parseLong(authentication.getPrincipal().toString());
        } catch (Exception e) {
            return null;
        }
    }

    public static Long requireCurrentUserId() {
        Long userId = getCurrentUserIdOrNull();
        if (userId == null) {
            throw new BusinessException(401, "用户未登录");
        }
        return userId;
    }
}
