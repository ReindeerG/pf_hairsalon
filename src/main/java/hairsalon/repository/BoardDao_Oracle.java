package hairsalon.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.BoardDto;

@Repository("boardDao")
public class BoardDao_Oracle implements BoardDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int nextval() {
		return sqlSession.selectOne("db_board.nextval");
	}
	
	public int isexist(int no) {
		return sqlSession.selectOne("db_board.isexist", no);
	}
	
	public int insert(BoardDto boardDto) {
		return sqlSession.insert("db_board.insert", boardDto);
	}

	public List<BoardDto> getAllList() {
		return sqlSession.selectList("db_board.alllist");
	}
	
	public int countAll() {
		return sqlSession.selectOne("db_board.count_all");
	}
	
	public int countSearch(BoardDto boardDto) {
		return sqlSession.selectOne("db_board.count_search", boardDto);
	}
	
	public List<BoardDto> getSomeList(int start, int count) {
		Map<String, Object> param = Map.of("start",start,"count",count);
		return sqlSession.selectList("db_board.somelist",param);
	}
	
	public List<BoardDto> getSearchList(int start, int count, BoardDto boardDto) {
		if(boardDto.getSearch().equals("no")) {
			int intno;
			try {
				intno = Integer.parseInt(boardDto.getKeyword());
				boardDto.setNo(intno);
				return sqlSession.selectList("db_board.list_one",boardDto);
			} catch(Exception e) {
				return null;
			}
		}
		boardDto.setListstart(start);
		boardDto.setListcount(count);
		return sqlSession.selectList("db_board.list_search",boardDto);
	}

	public BoardDto getOne(int no) {
		return sqlSession.selectOne("db_board.getone",no);
	}
	
	public int delete(int no) {
		return sqlSession.delete("db_board.delete",no);
	}
	
	public int modify(BoardDto boardDto) {
		return sqlSession.update("db_board.modify",boardDto);
	}
	
	public int delAttach(BoardDto boardDto) {
		return sqlSession.update("db_board.del_attach",boardDto);
	}
	
	public int viewCountUp(int no) {
		return sqlSession.update("db_board.viewcountup",no);
	}
}