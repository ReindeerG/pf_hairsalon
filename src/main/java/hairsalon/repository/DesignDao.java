package hairsalon.repository;

import java.util.List;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignDto;
import hairsalon.entity.DesignerDto;

public interface DesignDao {
	int insert(DesignDto designDto);
	List<DesignDto> getAllList();
	List<DesignDto> getSearchList(DesignDto designDto);
	List<DesignDto> getOnList();
	List<DesignDto> getListForPage();
	DesignDto getOne(int no);
	int delete(int no);
	int modify(DesignDto designDto);
	int restore();
}
