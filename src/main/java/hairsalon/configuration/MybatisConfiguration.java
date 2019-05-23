package hairsalon.configuration;

import java.io.IOException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/*
 * 마이바티스 설정 파일
 * [1] SqlSessionFactoryBean				myBatis의 모든 설정들을 생성하는 bean
 * [2] SqlSessionTemplate					mybatis를 실제로 사용할 때 쓰는 도구
 */
@Configuration
public class MybatisConfiguration {

		@Bean
		public SqlSessionFactoryBean sqlSessionFactory(DataSource dbcpSource, ApplicationContext context) throws IOException {
			SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
			// [1] DS연결방식은 어떻게 됩니까;
			factory.setDataSource(dbcpSource);
			// [2]  mybatis 운영 설정은 어느 파일에서 합니까?
			factory.setConfigLocation(context.getResource("classpath:/mybatis/mybatis-config.xml"));
			// [3] 어느 파일에 SQL 명령이 있습니까?
			factory.setMapperLocations(context.getResources("classpath:/mybatis/mapper/*-mapper.xml"));
			return factory;
		}
		
		@Bean
		public SqlSessionTemplate sqlSession(SqlSessionFactory sqlSessionFactory) {
			SqlSessionTemplate template= new SqlSessionTemplate(sqlSessionFactory);
			return template;
		}
}
