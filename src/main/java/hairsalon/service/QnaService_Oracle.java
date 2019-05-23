package hairsalon.service;

import java.text.SimpleDateFormat;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.QnaDto;
import hairsalon.repository.DesignerDao;
import hairsalon.repository.QnaDao;

@Service("qnaService")
@PropertySource({"classpath:/properties/page.properties"})
public class QnaService_Oracle implements QnaService {
	@Autowired
	private QnaDao qnaDao;
	
	@Autowired
	private Environment env;
	
	@Autowired
	private CustomerService customerService;

	private List<QnaDto> setString(List<QnaDto> list) {
		for(QnaDto qnaDto : list) {
			qnaDto = this.setString(qnaDto);
		}
		return list;
	}
	
	private QnaDto setString(QnaDto qnaDto) {
		if(qnaDto.getQuestion().length()>20) qnaDto.setTitle(qnaDto.getQuestion().substring(0,20)+"...");
		else qnaDto.setTitle(qnaDto.getQuestion());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		qnaDto.setTime_q_str(format.format(qnaDto.getTime_q()));
		if(qnaDto.getTime_a()!=null) {
			qnaDto.setTime_a_str(format.format(qnaDto.getTime_a()));
		}
		CustomerDto customerDto = customerService.getOne(qnaDto.getCustomer());
		qnaDto.setCustomer_name(customerDto.getName());
		qnaDto.setCustomer_gender(customerDto.getGender());
		// qnaDto.setCustomer_phone(customerDto.getPhone());
		// qnaDto.setCustomer_birth(customerDto.getBirth_str());
		return qnaDto;
	}
	
	public int question_new(QnaDto qnaDto) {
		return qnaDao.question_new(qnaDto);
	}
	
	public int question_mod(QnaDto qnaDto) {
		return qnaDao.question_mod(qnaDto);
	}
	
	public int answer(QnaDto qnaDto) {
		qnaDto.setAnswer(qnaDto.getAnswer().trim());
		return qnaDao.answer(qnaDto);
	}
	
	public boolean isNotAnswered(QnaDto qnaDto) {
		return qnaDao.isNotAnswered(qnaDto);
	}

	public List<QnaDto> getListNew() {
		List<QnaDto> list = qnaDao.getListNew();
		return this.setString(list);
	}
	
	public List<QnaDto> getListAnswered() {
		List<QnaDto> list = qnaDao.getListAnswered();
		return this.setString(list);
	}
	
	public List<QnaDto> getListNewSome(int start, int count) {
		List<QnaDto> list = qnaDao.getListNewSome(start, count);
		return this.setString(list);
	}
	
	public List<QnaDto> getListAnsweredSome(int start, int count) {
		List<QnaDto> list = qnaDao.getListAnsweredSome(start, count);
		return this.setString(list);
	}
	
	public QnaDto getOne(int no) {
		QnaDto qnaDto = qnaDao.getOne(no);
		return this.setString(qnaDto);
	}
	
	public int countNew() {
		return qnaDao.countNew();
	}
	
	public int countAnswered() {
		return qnaDao.countAnswered();
	}
	
	public int countAll() {
		return qnaDao.countAll();
	}
	
	public int getTotalPagenation() {
		int total = this.countAll();
		int perview = Integer.parseInt(env.getProperty("view.qna"));
		int pagenation = total/perview;
		if(total%perview!=0) pagenation++;
		if(pagenation==0) pagenation=1;
		return pagenation;
	}
	
	public int getMinPagenation(int no) {
		int perpage = Integer.parseInt(env.getProperty("pages.qna"));
		if(no%perpage==0) {
			return ((no/perpage-1)*perpage+1);
		} else return ((no/perpage)*perpage+1);
	}
	
	public int getMaxPagenation(int no) {
		int perpage = Integer.parseInt(env.getProperty("pages.qna"));
		int result = 0;
		if(no%perpage==0) {
			result = no;
		} else result = (no/perpage+1)*perpage;
		if(result<this.getTotalPagenation()) return result;
		else return this.getTotalPagenation();
	}
	
	public int getPrevPagenation(int no) {
		if(no==1) return 0;
		else return this.getMinPagenation(no)-1;
	}
	
	public int getNextPagenation(int no) {
		if(this.getMaxPagenation(no)==this.getTotalPagenation()) return 0;
		else return this.getMaxPagenation(no)+1;
	}
	
	public List<QnaDto> getListPagenated(int no) {
		int perview = Integer.parseInt(env.getProperty("view.qna"));
		int countnew = this.countNew();
		int countanswered = this.countAnswered();
		int total = countnew + countanswered;
		if(total<=perview) {
			List<QnaDto> listnew = this.getListNew();
			List<QnaDto> listanswered = this.getListAnswered();
			listnew.addAll(getListAnswered());
			return listnew;
		} else {
			if(countnew>0) {
				if(countnew<no*perview) {
					int gap = no*perview - countnew;
					if(gap<perview) {		//섞임
						int viewnew = perview - gap;
						int viewanswered = perview - viewnew;
						List<QnaDto> listnew = this.getListNewSome((no-1)*perview+1, viewnew);
						List<QnaDto> listanswered = this.getListAnsweredSome(1, viewanswered);
						listnew.addAll(listanswered);
						return listnew;
					} else {	// 순수답변만
						int trash1 = gap/perview;
						int trash2 = gap%perview;
						List<QnaDto> listanswered;
						if(trash1>0) {
							listanswered = this.getListAnsweredSome((trash1-1)*perview+trash2+1, perview);
						} else {
							listanswered = this.getListAnsweredSome(trash2+1, perview);
						}
						return listanswered;
					}
				} else {
					return this.getListNewSome((no-1)*perview+1, perview);
				}
			} else {
				return this.getListAnsweredSome((no-1)*perview+1, perview);
			}
		}
	}
	
	public int getTotalPagenation(QnaDto qnaDto) {
		int total;
		if(qnaDto.getSearch().equals("no")) {
			total=1;
		} else if(qnaDto.getSearch().equals("customer_no")) {
			total = qnaDao.countCustomer(qnaDto);
		} 
		else if(qnaDto.getSearch().equals("customer_name")) {
			total = qnaDao.countCustomerName(qnaDto);
		}
		else {
			total = qnaDao.countSearch(qnaDto);
		}
		int perview = Integer.parseInt(env.getProperty("view.qna"));
		int pagenation = total/perview;
		if(total%perview!=0) pagenation++;
		if(pagenation==0) pagenation=1;
		return pagenation;
	}
	
	public int getMaxPagenation(int no, QnaDto qnaDto) {
		int perpage = Integer.parseInt(env.getProperty("pages.qna"));
		int result = 0;
		if(no%perpage==0) {
			result = no;
		} else result = (no/perpage+1)*perpage;
		if(result<this.getTotalPagenation(qnaDto)) return result;
		else return this.getTotalPagenation(qnaDto);
	}
	
	public int getNextPagenation(int no, QnaDto qnaDto) {
		if(this.getMaxPagenation(no, qnaDto)==this.getTotalPagenation(qnaDto)) return 0;
		else return this.getMaxPagenation(no, qnaDto)+1;
	}
	
	public List<QnaDto> getSearchList(int no, QnaDto qnaDto) {
		int perview = Integer.parseInt(env.getProperty("view.qna"));
		if(qnaDto.getSearch().equals("customer_no")) {
			qnaDto.setSearch("customer");
		}
		List<QnaDto> list = qnaDao.getSearchList((no-1)*perview+1, perview, qnaDto);
		return this.setString(list);
	}
	
	public int getTotalPagenationForCustomer(QnaDto qnaDto) {
		int total = qnaDao.countForCustomer(qnaDto);
		int perview = Integer.parseInt(env.getProperty("view.qna"));
		int pagenation = total/perview;
		if(total%perview!=0) pagenation++;
		if(pagenation==0) pagenation=1;
		return pagenation;
	}
	
	public int getMaxPagenationForCustomer(int no, QnaDto qnaDto) {
		int perpage = Integer.parseInt(env.getProperty("pages.qna"));
		int result = 0;
		if(no%perpage==0) {
			result = no;
		} else result = (no/perpage+1)*perpage;
		if(result<this.getTotalPagenationForCustomer(qnaDto)) return result;
		else return this.getTotalPagenationForCustomer(qnaDto);
	}
	
	public int getNextPagenationForCustomer(int no, QnaDto qnaDto) {
		if(this.getMaxPagenationForCustomer(no, qnaDto)==this.getTotalPagenationForCustomer(qnaDto)) return 0;
		else return this.getMaxPagenationForCustomer(no, qnaDto)+1;
	}
	
	public List<QnaDto> getSearchListForCustomer(int no, QnaDto qnaDto) {
		int perview = Integer.parseInt(env.getProperty("view.qna"));
		List<QnaDto> list = qnaDao.getSearchListForCustomer((no-1)*perview+1, perview, qnaDto);
		return this.setString(list);
	}
}