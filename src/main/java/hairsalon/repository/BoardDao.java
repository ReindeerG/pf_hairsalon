package hairsalon.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import hairsalon.entity.BoardDto;

public interface BoardDao{
	int insert(BoardDto boardDto);
	int nextval();
	int isexist(int no);
	List<BoardDto> getAllList();
	int countAll();
	int countSearch(BoardDto boardDto);
	List<BoardDto> getSomeList(int start, int count);
	List<BoardDto> getSearchList(int start, int count, BoardDto boardDto);
	BoardDto getOne(int no);
	int delete(int no);
	int modify(BoardDto boardDto);
	int delAttach(BoardDto boardDto);
	int viewCountUp(int no);
}