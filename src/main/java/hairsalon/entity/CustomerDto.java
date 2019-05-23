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
public class CustomerDto {
	private int no;
	private String email;
	private String pw;
	private String name;
	private String gender;
	private String phone;
	private Date birth;
	private String birth_str;
	private Date reg;
	private String reg_str;
	private long mileage;
	private int designer;
	private String designer_str;
	private int isonoff;
	private int visitcount;
	private Date latestdate;
	private String latestdate_str;
	private Date deletedate;
	private String deletedate_str;
	private int confirmed;
	private String confirmcode;
	/**
	 * 검색 및 정렬
	 */
	private String sort;
	private String search;
	private String keyword;
	private int liststart;
	private int listcount;
}
