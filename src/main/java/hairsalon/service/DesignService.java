package hairsalon.service;

import java.util.List;

import hairsalon.entity.DesignDto;

public interface DesignService {
	int regist(DesignDto designDto);
	List<DesignDto> getAllList();
	List<DesignDto> getSearchList(DesignDto designDto);
	List<DesignDto> getOnList();
	List<DesignDto> getListForPage();
	DesignDto getOne(int no);
	int delete(int no);
	int modify(DesignDto designDto);
	int restore();
}