package hairsalon.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DesignerDto {
	private int no;
	private String name;
	private String gender;
	private String phone;
	private String email;
	private Date birth;
	private String birth_str;
	private int grade;
	private String grade_str;
	private Date signindate;
	private String signindate_str;
	private String picture;
	private String offdays;
	private int isvacation;
	private long designcount;
	private int isonoff;
	/**
	 * 검색 및 정렬
	 */
	private String sort;
	private String search;
	private String keyword;
}
