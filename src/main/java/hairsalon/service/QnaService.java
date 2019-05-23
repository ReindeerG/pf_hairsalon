package hairsalon.service;

import java.util.List;

import hairsalon.entity.QnaDto;

public interface QnaService {
	int question_new(QnaDto qnaDto);
	int question_mod(QnaDto qnaDto);
	int answer(QnaDto qnaDto);
	boolean isNotAnswered(QnaDto qnaDto);
	List<QnaDto> getListNew();
	List<QnaDto> getListAnswered();
	List<QnaDto> getListNewSome(int start, int count);
	List<QnaDto> getListAnsweredSome(int start, int count);
	QnaDto getOne(int no);
	int countNew();
	int countAnswered();
	int countAll();
	List<QnaDto> getListPagenated(int no);
	int getTotalPagenation();
	int getMinPagenation(int no);
	int getMaxPagenation(int no);
	int getPrevPagenation(int no);
	int getNextPagenation(int no);
	int getTotalPagenation(QnaDto qnaDto);
	int getMaxPagenation(int no, QnaDto qnaDto);
	int getNextPagenation(int no, QnaDto qnaDto);
	List<QnaDto> getSearchList(int no, QnaDto qnaDto);
	int getTotalPagenationForCustomer(QnaDto qnaDto);
	int getMaxPagenationForCustomer(int no, QnaDto qnaDto);
	int getNextPagenationForCustomer(int no, QnaDto qnaDto);
	List<QnaDto> getSearchListForCustomer(int no, QnaDto qnaDto);
}