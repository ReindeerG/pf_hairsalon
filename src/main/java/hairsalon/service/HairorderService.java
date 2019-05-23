package hairsalon.service;

import java.util.List;

import org.springframework.stereotype.Service;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.HairorderDto;

@Service("hairorderService")
public interface HairorderService {
	int regist(HairorderDto hairorderDto);
	List<HairorderDto> getAllList();
	List<HairorderDto> getSearchList(int no, HairorderDto hairorderDto);
	int getTotalPagenation(HairorderDto hairorderDto);
	int getMinPagenation(int no);
	int getMaxPagenation(int no, HairorderDto hairorderDto);
	int getPrevPagenation(int no);
	int getNextPagenation(int no, HairorderDto hairorderDto);
}