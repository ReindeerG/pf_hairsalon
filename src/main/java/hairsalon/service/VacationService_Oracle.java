package hairsalon.service;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hairsalon.entity.VacationDto;
import hairsalon.repository.VacationDao;

@Service("vacationService")
public class VacationService_Oracle implements VacationService {
	@Autowired
	private VacationDao vacationDao;
	
	@Autowired
	private DesignerService designerService;
	
	private VacationDto setString(VacationDto vacationDto) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		vacationDto.setVac_str(format.format(vacationDto.getVac()));
		return vacationDto;
	}
	
	private List<VacationDto> setString(List<VacationDto> list) {
		for(VacationDto vacationDto : list) {
			vacationDto = this.setString(vacationDto);
		}
		return list;
	}
	
	private List<Integer> getTodays() {
		return vacationDao.getTodays();
	}
	
	public void setVacations() {
		designerService.toWorkAll();
		List<Integer> list = this.getTodays();
		for(Integer designer : list) {
			designerService.toVacation(designer);
		}
	}

	public int insert(VacationDto vacationDto) {
		int result = vacationDao.insert(vacationDto);
		if(result==1) this.setVacations();
		return result;
	}

	public List<VacationDto> getAllList(int designer) {
		List<VacationDto> list = vacationDao.getAllList(designer);
		return this.setString(list);
	}

	public VacationDto getOne(int no) {
		VacationDto vacationDto = vacationDao.getOne(no);
		return this.setString(vacationDto);
	}

	public int isExist(int no, int designer, String vac_str) {
		VacationDto vacationDto = VacationDto.builder().no(no).designer(designer).vac_str(vac_str).build();
		return vacationDao.isExist(vacationDto);
	}
	
	public int isVacation(int designer, String vac_str) {
		VacationDto vacationDto = VacationDto.builder().designer(designer).vac_str(vac_str).build();
		return vacationDao.isVacation(vacationDto);
	}

	public int modify(VacationDto vacationDto) {
		int result = vacationDao.modify(vacationDto);
		if(result==1) this.setVacations();
		return result;
	}

	public int delete(int no) {
		int result = vacationDao.delete(no);
		if(result==1) this.setVacations();
		return result;
	}
	
	public int dayover() {
		return vacationDao.dayover();
	}
}