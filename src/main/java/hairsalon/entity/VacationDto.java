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
public class VacationDto {
	private int no;
	private int designer;
	private Date vac;
	private String vac_str;
	private String memo;
}
