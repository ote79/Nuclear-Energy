package org.nuclearEnergy.backend.service.impl;

import org.nuclearEnergy.backend.entity.Banner;
import org.nuclearEnergy.backend.entity.NuclearFacility;
import org.nuclearEnergy.backend.mapper.BannerMapper;
import org.nuclearEnergy.backend.mapper.NuclearFacilityMapper;
import org.nuclearEnergy.backend.service.HomeService;
import org.nuclearEnergy.backend.vo.BannerVO;
import org.nuclearEnergy.backend.vo.NuclearFacilityVO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HomeServiceImpl implements HomeService {

    private final BannerMapper bannerMapper;
    private final NuclearFacilityMapper nuclearFacilityMapper;

    public HomeServiceImpl(BannerMapper bannerMapper, NuclearFacilityMapper nuclearFacilityMapper) {
        this.bannerMapper = bannerMapper;
        this.nuclearFacilityMapper = nuclearFacilityMapper;
    }

    @Override
    public List<BannerVO> getBanners() {
        List<BannerVO> list = new ArrayList<>();
        for (Banner banner : bannerMapper.selectEnabledBanners()) {
            BannerVO vo = new BannerVO();
            vo.setId(banner.getId());
            vo.setTitle(banner.getTitle());
            vo.setImageUrl(banner.getImageUrl());
            vo.setLinkUrl(banner.getLinkUrl());
            vo.setSort(banner.getSort());
            list.add(vo);
        }
        return list;
    }

    @Override
    public List<NuclearFacilityVO> getFacilities() {
        List<NuclearFacilityVO> list = new ArrayList<>();
        for (NuclearFacility facility : nuclearFacilityMapper.selectEnabledFacilities()) {
            NuclearFacilityVO vo = new NuclearFacilityVO();
            vo.setId(facility.getId());
            vo.setName(facility.getName());
            vo.setType(facility.getFacilityType());
            vo.setLat(facility.getLat());
            vo.setLng(facility.getLng());
            vo.setStatus(facility.getStatus());
            vo.setSummary(facility.getSummary());
            vo.setDetail(facility.getDetail());
            vo.setMapUrl(facility.getMapUrl());
            vo.setNewsUrl(facility.getNewsUrl());
            vo.setGradient(facility.getGradient());
            vo.setMapX(facility.getMapX());
            vo.setMapY(facility.getMapY());
            list.add(vo);
        }
        return list;
    }
}
