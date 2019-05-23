package hairsalon.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.UploadimageDto;

@Repository("uploadimageDao")
public class UploadimageDao_Oracle implements UploadimageDao {
	@Autowired
	private SqlSession sqlSession;
	
	public List<String> listBoardno(int no) {
		return sqlSession.selectList("db_uploadimage.listboardno", no);
	}
	
	public List<String> precheckSelect(UploadimageDto uploadimageDto) {
		return sqlSession.selectList("db_uploadimage.precheck_select", uploadimageDto);
	}
	
	public int precheckDelete(UploadimageDto uploadimageDto) {
		return sqlSession.delete("db_uploadimage.precheck_delete", uploadimageDto);
	}
	
	public int insert(UploadimageDto uploadimageDto) {
		return sqlSession.insert("db_uploadimage.insert", uploadimageDto);
	}
	public UploadimageDto getOne(int no) {
		return sqlSession.selectOne("db_uploadimage.getone",no);
	}
	
	public int delete(int no) {
		return sqlSession.delete("db_uploadimage.delete", no);
	}
	
	public int delete_path(String file_path) {
		return sqlSession.delete("db_uploadimage.delete_path", file_path);
	}
	
	public int delete_board(int board_no) {
		return sqlSession.delete("db_uploadimage.delete_board", board_no);
	}
}