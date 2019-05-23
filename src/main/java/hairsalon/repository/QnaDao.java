package hairsalon.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.QnaDto;

public interface QnaDao {
	int question_new(QnaDto qnaDto);
	int question_mod(QnaDto qnaDto);
	int answer(QnaDto qnaDto);
	boolean isNotAnswered(QnaDto qnaDto);
	List<QnaDto> getListNew();
	List<QnaDto> getListAnswered();
	List<QnaDto> getListNewSome(int start, int count);
	List<QnaDto> getListAnsweredSome(int start, int count);
	int countSearch(QnaDto qnaDto);
	int countForCustomer(QnaDto qnaDto);
	int countCustomer(QnaDto qnaDto);
	int countCustomerName(QnaDto qnaDto);
	List<QnaDto> getSearchList(int start, int count, QnaDto qnaDto);
	List<QnaDto> getSearchListForCustomer(int start, int count, QnaDto qnaDto);
	QnaDto getOne(int no);
	int countNew();
	int countAnswered();
	int countAll();
}