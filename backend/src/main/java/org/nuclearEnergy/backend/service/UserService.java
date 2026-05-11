package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.dto.UpdatePasswordDTO;
import org.nuclearEnergy.backend.dto.UpdateUserProfileDTO;
import org.nuclearEnergy.backend.vo.UserInfoVO;

public interface UserService {
    UserInfoVO getCurrentUser();

    void updateProfile(UpdateUserProfileDTO updateUserProfileDTO);

    void updatePassword(UpdatePasswordDTO updatePasswordDTO);
}
