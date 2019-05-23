package hairsalon.service;

import java.util.List;

import hairsalon.entity.VacationDto;

public interface VacationService {
	void setVacations();
	int insert(VacationDto vacationDto);
	List<VacationDto> getAllList(int designer);
	VacationDto getOne(int no);
	int isExist(int no, int designer, String vac_str);
	int isVacation(int designer, String vac_str);
	int modify(VacationDto vacationDto);
	int delete(int no);
	int dayover();
}