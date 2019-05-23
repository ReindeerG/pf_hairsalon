package hairsalon.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.AdminDto;
import hairsalon.entity.CustomerDto;

@Repository("adminDao")
public class AdminDao_Oracle implements AdminDao {
	@Autowired
	private SqlSession sqlSession;
	
	public AdminDto login(AdminDto adminDto) {
		return sqlSession.selectOne("db_admin.login", adminDto);
	}

	public int insert(AdminDto adminDto) {
		return sqlSession.insert("db_admin.insert", adminDto);
	}
}
