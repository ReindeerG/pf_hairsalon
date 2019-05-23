package hairsalon.repository;

import java.util.List;

import hairsalon.entity.VacationDto;

public interface VacationDao {
	int insert(VacationDto vacationDto);
	List<VacationDto> getAllList(int designer);
	List<Integer> getTodays();
	VacationDto getOne(int no);
	int isExist(VacationDto vacationDto);
	int isVacation(VacationDto vacationDto);
	int modify(VacationDto vacationDto);
	int delete(int no);
	int dayover();
}
