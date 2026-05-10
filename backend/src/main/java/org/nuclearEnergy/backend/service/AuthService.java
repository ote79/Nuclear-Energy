package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.dto.LoginDTO;
import org.nuclearEnergy.backend.vo.LoginVO;

public interface AuthService {
    LoginVO login(LoginDTO loginDTO);
}
