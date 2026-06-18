package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.dto.UpdateUserRolesDTO;
import org.nuclearEnergy.backend.dto.UpdateUserStatusDTO;
import org.nuclearEnergy.backend.vo.RoleItemVO;
import org.nuclearEnergy.backend.vo.UserListItemVO;

import java.util.List;

public interface AdminService {

    List<UserListItemVO> getAllUsers();

    List<RoleItemVO> getRolesByUserId(long userId);

    int updateUserRoles(Long userId, UpdateUserRolesDTO updateUserRolesDTO);

    void updateUserStatus(Long userId, UpdateUserStatusDTO updateUserStatusDTO);
}
