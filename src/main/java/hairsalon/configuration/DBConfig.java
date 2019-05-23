package hairsalon.configuration;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

/*
 * 설정 파일은 @Configuration으로 등록한다
 * - 반드시 Component-scan이 작동해야 한다.
 */

@Configuration
@PropertySource({"classpath:/properties/db.properties"})
public class DBConfig {
	/*
	 * Bean을 등록하려면 @Bean을 사용한다
	 */
	
	@Autowired
	private Environment env;	// 모든 property 값을 map 형태로 가지는 객체
	
	// public 결과물자료형 id(설정할 데이터)
	
	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(env.getProperty("jdbc.driver"));
		dataSource.setUrl(env.getProperty("jdbc.url"));
		dataSource.setUsername(env.getProperty("jdbc.username"));
		dataSource.setPassword(env.getProperty("jdbc.password"));
		return dataSource;
	}
	
	@Bean
	public DataSource dbcpSource() {
		BasicDataSource dbcpSource = new BasicDataSource();
		dbcpSource.setDriverClassName(env.getProperty("jdbc.driver"));
		dbcpSource.setUrl(env.getProperty("jdbc.url"));
		dbcpSource.setUsername(env.getProperty("jdbc.username"));
		dbcpSource.setPassword(env.getProperty("jdbc.password"));
		dbcpSource.setMaxTotal(Integer.parseInt(env.getProperty("jdbc.max-total")));
		dbcpSource.setMaxIdle(Integer.parseInt(env.getProperty("jdbc.max-idle")));
		dbcpSource.setMaxWaitMillis(Long.parseLong(env.getProperty("jdbc.max-wait")));
		return dbcpSource;
	}
	
	@Bean
	public JdbcTemplate jdbcTemplate(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate();
		jdbcTemplate.setDataSource(dataSource);
		return jdbcTemplate;
	}
	
}
