package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.dto.UpdateUserStatusDTO;
import org.nuclearEnergy.backend.vo.UserListItemVO;

import java.util.List;

public interface AdminService {

    List<UserListItemVO> getAllUsers();

    void updateUserStatus(Long userId, UpdateUserStatusDTO updateUserStatusDTO);
}
