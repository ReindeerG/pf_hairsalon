package hairsalon.repository;

import hairsalon.entity.AdminDto;

public interface AdminDao {
	AdminDto login(AdminDto adminDto);
	int insert(AdminDto adminDto);
}
