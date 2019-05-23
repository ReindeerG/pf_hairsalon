package hairsalon.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.QnaDto;

@Repository("QnaDao")
public class QnaDao_Oracle implements QnaDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int question_new(QnaDto qnaDto) {
		return sqlSession.insert("db_qna.question_new", qnaDto);
	}
	
	public int question_mod(QnaDto qnaDto) {
		return sqlSession.update("db_qna.question_mod", qnaDto);
	}
	
	public int answer(QnaDto qnaDto) {
		return sqlSession.update("db_qna.answer", qnaDto);
	}
	
	public boolean isNotAnswered(QnaDto qnaDto) {
		int result = sqlSession.selectOne("db_qna.isnotanswered", qnaDto);
		return (result==1);
	}

	public List<QnaDto> getListNew() {
		return sqlSession.selectList("db_qna.list_new");
	}
	
	public List<QnaDto> getListAnswered() {
		return sqlSession.selectList("db_qna.list_answered");
	}
	
	public List<QnaDto> getListNewSome(int start, int count) {
		Map<String, Object> param = Map.of("start",start,"count",count);
		return sqlSession.selectList("db_qna.list_new_somepage",param);
	}
	
	public List<QnaDto> getListAnsweredSome(int start, int count) {
		Map<String, Object> param = Map.of("start",start,"count",count);
		return sqlSession.selectList("db_qna.list_answered_somepage",param);
	}
	
	public int countSearch(QnaDto qnaDto) {
		return sqlSession.selectOne("db_qna.count_search", qnaDto);
	}
	
	public int countForCustomer(QnaDto qnaDto) {
		return sqlSession.selectOne("db_qna.count_forcustomer", qnaDto);
	}
	
	public int countCustomer(QnaDto qnaDto) {
		return sqlSession.selectOne("db_qna.count_customer", qnaDto);
	}
	
	public int countCustomerName(QnaDto qnaDto) {
		return sqlSession.selectOne("db_qna.count_customername", qnaDto);
	}
	
	public List<QnaDto> getSearchList(int start, int count, QnaDto qnaDto) {
		if(qnaDto.getSearch().equals("no")) {
			return sqlSession.selectList("db_qna.list_one",qnaDto);
		}
		qnaDto.setListstart(start);
		qnaDto.setListcount(count);
		if(qnaDto.getSearch().equals("customer")) {
			return sqlSession.selectList("db_qna.list_customer",qnaDto);
		} else if(qnaDto.getSearch().equals("customer_name")) {
			return sqlSession.selectList("db_qna.list_customername",qnaDto);
		}
		return sqlSession.selectList("db_qna.list_search",qnaDto);
	}
	
	public List<QnaDto> getSearchListForCustomer(int start, int count, QnaDto qnaDto) {
		qnaDto.setListstart(start);
		qnaDto.setListcount(count);
		return sqlSession.selectList("db_qna.list_forcustomer",qnaDto);
	}
	
	public QnaDto getOne(int no) {
		return sqlSession.selectOne("db_qna.getone",no);
	}
	
	public int countNew() {
		return sqlSession.selectOne("db_qna.count_new");
	}
	
	public int countAnswered() {
		return sqlSession.selectOne("db_qna.count_answered");
	}
	
	public int countAll() {
		return sqlSession.selectOne("db_qna.count_all");
	}
}