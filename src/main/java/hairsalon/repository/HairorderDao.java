package hairsalon.repository;

import java.util.List;

import hairsalon.entity.HairorderDto;

public interface HairorderDao {
	int insert_member(HairorderDto hairorderDto);
	int insert_nonmember(HairorderDto hairorderDto);
	List<HairorderDto> getAllList();
	int countSearch(HairorderDto hairorderDto);
	List<HairorderDto> getSearchList(int start, int count, HairorderDto hairorderDto);
}