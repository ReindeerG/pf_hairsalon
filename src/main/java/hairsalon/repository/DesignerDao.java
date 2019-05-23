package hairsalon.repository;

import java.util.List;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignerDto;

public interface DesignerDao {
	int nextval();
	int insert(DesignerDto designerDto);
	List<DesignerDto> getAllList();
	List<DesignerDto> getSearchList(DesignerDto designerDto);
	List<DesignerDto> getOnList();
	DesignerDto getOne(int no);
	int modify(DesignerDto designerDto);
	int picChange(DesignerDto designerDto);
	int delete(int no);
	int designcount(int no);
	int toVacation(int no);
	int toWorkAll();
	int restore();
}
