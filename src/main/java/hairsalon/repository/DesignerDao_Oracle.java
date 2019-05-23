package hairsalon.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignDto;
import hairsalon.entity.DesignerDto;

@Repository("designerDao")
public class DesignerDao_Oracle implements DesignerDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int nextval() {
		return sqlSession.selectOne("db_designer.nextval");
	}
	
	public int insert(DesignerDto designerDto) {
		return sqlSession.insert("db_designer.insert", designerDto);
	}

	public List<DesignerDto> getAllList() {
		return sqlSession.selectList("db_designer.alllist");
	}
	
	public List<DesignerDto> getSearchList(DesignerDto designerDto) {
		return sqlSession.selectList("db_designer.list_search",designerDto);
	}
	
	public List<DesignerDto> getOnList() {
		return sqlSession.selectList("db_designer.onlist");
	}
	
	public DesignerDto getOne(int no) {
		return sqlSession.selectOne("db_designer.getone",no);
	}
	
	public int modify(DesignerDto designerDto) {
		return sqlSession.update("db_designer.modify", designerDto);
	}
	
	public int picChange(DesignerDto designerDto) {
		return sqlSession.update("db_designer.picchange", designerDto);
	}
	
	public int delete(int no) {
		return sqlSession.delete("db_designer.delete", no);
	}
	
	public int designcount(int no) {
		return sqlSession.update("db_designer.designcount",no);
	}
	
	public int toVacation(int no) {
		return sqlSession.update("db_designer.tovacation", no);
	}
	
	public int toWorkAll() {
		return sqlSession.update("db_designer.toworkall");
	}
	
	public int restore() {
		sqlSession.update("db_designer.restore1");
		return sqlSession.update("db_designer.restore2");
	}
}