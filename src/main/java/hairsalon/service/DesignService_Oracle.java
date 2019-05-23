package hairsalon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignDto;
import hairsalon.repository.DesignDao;

@Service("designService")
public class DesignService_Oracle implements DesignService {
	@Autowired
	private DesignDao designDao;
	

	public int regist(DesignDto designDto) {
		return designDao.insert(designDto);
	}
	
	public List<DesignDto> getAllList() {
		List<DesignDto> list = designDao.getAllList();
		return this.setTime(list);
	}
	
	public List<DesignDto> getSearchList(DesignDto designDto) {
		List<DesignDto> list = designDao.getSearchList(designDto);
		return this.setTime(list);
	}
	
	public List<DesignDto> getOnList() {
		List<DesignDto> list = designDao.getOnList();
		return this.setTime(list);
	}
	
	public List<DesignDto> getListForPage() {
		List<DesignDto> list = designDao.getListForPage();
		return this.setTime(list);
	}
	
	private List<DesignDto> setTime(List<DesignDto> list) {
		for(DesignDto designDto : list) {
			designDto.setMaxtime_hour(designDto.getMaxtime()/60);
			designDto.setMaxtime_min(designDto.getMaxtime()%60);
		}
		return list;
	}
	
	public DesignDto getOne(int no) {
		DesignDto designDto = designDao.getOne(no);
		designDto.setMaxtime_hour(designDto.getMaxtime()/60);
		designDto.setMaxtime_min(designDto.getMaxtime()%60);
		return designDto;
	}
	
	public int delete(int no) {
		return designDao.delete(no);
	}
	
	public int modify(DesignDto designDto) {
		return designDao.modify(designDto);
	}
	
	public int restore() {
		return designDao.restore();
	}
}
