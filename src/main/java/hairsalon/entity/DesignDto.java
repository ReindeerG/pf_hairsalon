package hairsalon.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DesignDto {
	private int no;
	private String type;
	private String name;
	private long price;
	private int maxtime;
	private int maxtime_hour;
	private int maxtime_min;
	private int isonoff;
	private String memo;
	/**
	 * 검색 및 정렬
	 */
	private String sort;
	private String search;
	private String keyword;
}
