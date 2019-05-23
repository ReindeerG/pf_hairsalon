package hairsalon.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.HairorderDto;

@Repository("hairorderDao")
public class HairorderDao_Oracle implements HairorderDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int insert_member(HairorderDto hairorderDto) {
		return sqlSession.insert("db_hairorder.insert_member", hairorderDto);
	}
	
	public int insert_nonmember(HairorderDto hairorderDto) {
		return sqlSession.insert("db_hairorder.insert_nonmember", hairorderDto);
	}
	
	public List<HairorderDto> getAllList() {
		return sqlSession.selectList("db_hairorder.alllist");
	}
	
	public int countSearch(HairorderDto hairorderDto) {
		if(hairorderDto.getSearch().equals("whatday")) return sqlSession.selectOne("db_hairorder.count_search_date",hairorderDto);
		if(hairorderDto.getSearch().equals("designer")) return sqlSession.selectOne("db_hairorder.count_search_designer",hairorderDto);
		if(hairorderDto.getSearch().equals("design")) return sqlSession.selectOne("db_hairorder.count_search_design",hairorderDto);
		if(hairorderDto.getSearch().equals("customer")) return sqlSession.selectOne("db_hairorder.count_search_customer",hairorderDto);
		return sqlSession.selectOne("db_hairorder.count_search", hairorderDto);
	}
	
	public List<HairorderDto> getSearchList(int start, int count, HairorderDto hairorderDto) {
		if(hairorderDto.getSearch().equals("no")) {
			return sqlSession.selectList("db_hairorder.list_one",hairorderDto);
		}
		hairorderDto.setListstart(start);
		hairorderDto.setListcount(count);
		if(hairorderDto.getSearch().equals("whatday")) return sqlSession.selectList("db_hairorder.list_search_date",hairorderDto);
		if(hairorderDto.getSearch().equals("designer")) return sqlSession.selectList("db_hairorder.list_search_designer",hairorderDto);
		if(hairorderDto.getSearch().equals("design")) return sqlSession.selectList("db_hairorder.list_search_design",hairorderDto);
		if(hairorderDto.getSearch().equals("customer")) return sqlSession.selectList("db_hairorder.list_search_customer",hairorderDto);
		return sqlSession.selectList("db_hairorder.list_search",hairorderDto);
	}
}
