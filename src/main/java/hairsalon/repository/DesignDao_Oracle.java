package hairsalon.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignDto;
import hairsalon.entity.DesignerDto;

@Repository("designDao")
public class DesignDao_Oracle implements DesignDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int insert(DesignDto designDto) {
		return sqlSession.insert("db_design.insert", designDto);
	}

	public List<DesignDto> getAllList() {
		return sqlSession.selectList("db_design.alllist");
	}
	
	public List<DesignDto> getSearchList(DesignDto designDto) {
		return sqlSession.selectList("db_design.list_search",designDto);
	}
	
	public List<DesignDto> getOnList() {
		return sqlSession.selectList("db_design.onlist");
	}
	
	public List<DesignDto> getListForPage() {
		return sqlSession.selectList("db_design.listforpage");
	}

	public DesignDto getOne(int no) {
		return sqlSession.selectOne("db_design.getone",no);
	}
	
	public int delete(int no) {
		return sqlSession.delete("db_design.delete",no);
	}
	
	public int modify(DesignDto designDto) {
		return sqlSession.update("db_design.modify",designDto);
	}
	
	public int restore() {
		return sqlSession.update("db_design.restore");
	}
}