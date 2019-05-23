package hairsalon.entity;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UploadimageDto {
	private int no;
	private int board_no;
	private String file_type;
	private String file_name;
	private String file_path;
	private long file_size;
	private List<String> prechecklist;
}
