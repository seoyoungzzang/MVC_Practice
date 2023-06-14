package service;

import dao.GongjiDao;
import dao.GongjiDaoImpl;
import dto.Pagination;

public class GongjiServiceImpl implements GongjiService {

	@Override
	public Pagination getPagination(int page, int countPerPage) {
		Pagination pagination = new Pagination(); // Pagination의 클래스 객체 생성
		GongjiDao gongjiDao = new GongjiDaoImpl(); // StudentScoreDaoImpl 객체 생성
		
		double calc; // 계산된 값 담을 변수
		int nn = 0; // nn 값 담을 변수
		
		calc = (double)gongjiDao.count() / countPerPage; // double로 총 항목 개수를 페이지당 항목 개수로 나눈 값 계산
		if (calc > gongjiDao.count() / countPerPage) { // double값이 int값 계산 결과보다 클 경우
			nn = gongjiDao.count() / countPerPage + 1; // nn 페이지수에 1 추가
		}
		else nn = gongjiDao.count() / countPerPage; // nn 페이지수에 1 추가
		
		if (page < 1) { // 현재 페이지수가 1보다 적을 경우
			page = 1; // 페이지수를 1로 세팅
		}
		if (page > nn) page = nn; // page가 최대 페이지수보다 클 경우 page 값을 nn으로 설정
		
		pagination.setC(page); // 그 외에는 인자로 받은 값을 현재 페이지로 설정
		
		// s (현재 뜨는 페이지 번호 중 첫 번호)
		if (page < 1) pagination.setS(1); // 페이지가 1보다 적으면 1로 설정
		else { // 그 외에는
			int s = ((page - 1)/10)*10 + 1; // 현재 페이지 계산
			pagination.setS(s); // 계산된 페이지 setting
		}
		// e (현재 뜨는 페이지 번호 중 마지막 번호)
		if (page < 1) pagination.setE(10); // 페이지가 1보다 적으면 10으로 설정
		else { // 그 외에는
			int e = ((page - 1)/10)*10 + 10; // e 값 계산
			
			if (e > nn) e = nn; // e 값이 최대 페이지보다 클 경우 최대 페이지수로 설정
			
			pagination.setE(e); // 계산된 페이지 setting
		}
		
		// p (-10페이지)
		if (page <= 10) pagination.setP(-1); // page가 10보다 적거나 같을 경우 p 값을 -1로 설정
		else { // 그 외에는
			int p = ((page - 1)/10)*10 - 9; // p 값 계산
			if (p < 1) p = 1; // p가 1보다 적을 경우 1로 설정
			pagination.setP(p); // 계산된 페이지 setting
		}
		
		// pp (맨 첫 페이지)
		if (page <= 10) pagination.setPp(-1); // 페이지수가 10 이하일 경우 pp를 안 보이도록 처리
		else { // 그 외에는
			pagination.setPp(1); // 계산된 페이지 setting
		}
		
		// n (+10페이지)
		int n = ((page - 1)/10)*10 + 11; // n의 값 계산
		pagination.setN(n); // n의 값 세팅
		
		if (page >= ((nn - 1)/10)*10 + 1) { // 마지막 페이지 그룹에 해당하면
			pagination.setN(-1); // 안 보이도록 처리
		}
		
		
		// nn (맨 마지막 페이지)
		
		pagination.setNn(nn); // 마지막 페이지 번호로 nn 설정
		if (page >= ((nn - 1)/10)*10 + 1) { // 마지막 페이지 그룹에 해당하면
			pagination.setNn(-1); // 안 보이도록 처리
		}
		
		return pagination; // 각각의 값이 설정된 pagination 리턴
	}

}
