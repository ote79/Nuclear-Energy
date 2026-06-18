package org.nuclearEnergy.backend.service;

import org.nuclearEnergy.backend.vo.BannerVO;
import org.nuclearEnergy.backend.vo.NuclearFacilityVO;

import java.util.List;

public interface HomeService {

    List<BannerVO> getBanners();

    List<NuclearFacilityVO> getFacilities();
}
