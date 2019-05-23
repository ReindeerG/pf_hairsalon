package hairsalon.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.VacationDto;

@Repository("vacationDao")
public class VacationDao_Oracle implements VacationDao {
	@Autowired
	private SqlSession sqlSession;

	public int insert(VacationDto vacationDto) {
		return sqlSession.insert("db_vacation.insert", vacationDto);
	}

	public List<VacationDto> getAllList(int designer) {
		return sqlSession.selectList("db_vacation.alllist", designer);
	}
	
	public List<Integer> getTodays() {
		return sqlSession.selectList("db_vacation.todays");
	}

	public VacationDto getOne(int no) {
		return sqlSession.selectOne("db_vacation.getone", no);
	}

	public int isExist(VacationDto vacationDto) {
		return sqlSession.selectOne("db_vacation.isexist", vacationDto);
	}
	
	public int isVacation(VacationDto vacationDto) {
		return sqlSession.selectOne("db_vacation.isvacation", vacationDto);
	}

	public int modify(VacationDto vacationDto) {
		return sqlSession.update("db_vacation.modify", vacationDto);
	}

	public int delete(int no) {
		return sqlSession.delete("db_vacation.delete", no);
	}
	
	public int dayover() {
		return sqlSession.delete("db_vacation.dayover");
	}
}