package kr.ac.kopo.ctc.kopo34.service;

import kr.ac.kopo.ctc.kopo34.dao.StudentScoreDaoImpl;
import kr.ac.kopo.ctc.kopo34.dto.Pagination;

public class StudentScoreServiceImpl implements StudentScoreService {

	@Override
	public Pagination getPagination(int page, int countPerPage) {

		Pagination pagination = new Pagination(); // 페이지네이션 객체 생성

		StudentScoreDaoImpl count = new StudentScoreDaoImpl(); // StudentScoreDaoImpl 객체 생성하여 전체 레코드 수 가져옴
		int totalCnt = count.count(); // 전체 레코드 수 저장

		int nn = 0; // 마지막 페이지 
		if (totalCnt % countPerPage == 0) { // 나눠떨어지면
			nn = totalCnt / countPerPage; // 몫
		} else { // 아니면
			nn = totalCnt / countPerPage + 1; // +1
		}

		int c = 0; // 현재 페이지
		if (page < 1) { // 1보다 작으면
			page = 1; // 1
			c = page; // 페이지는 1
		} else { // 아니면
			c = page; // 페이지는 현재 페이지
		}

		int s = 0; // 시작 페이지
		s = ((page - 1) / 10) * 10 + 1; // 시작 페이지 계산

		int e = 0; // 끝 페이지
		if (c >= (nn - 1) / 10 * 10 + 1) { // 현재 페이지 보다 크거나 같으면
			e = nn; // 마지막 페이지
		} else { // 아니면
			e = s + 9; // 시작 페이지 +9
		}

		int p = 0; // 이전 페이지
		if (c <= 10) { // 현재 페이지가 10보다 같거나 작으면
			p = -1; // 이전 페이지 없음
		} else { // 아니면
			p = (s - 1) / 10 * 10 - 9; // 이전 페이지
		}

		if (c <= 10) { // 현재 페이지가 10보다 같거나 작으면
			pagination.setPp(-1); // 이전 페이지 그룹 없음
		} else { // 아니면
			pagination.setPp(1); // 이전 페이지 그룹 있음
		}

		int n = 0; // 다음 페이지
		if (c >= (nn - 1) / 10 * 10 + 1) { // 현재 페이지 보다 크거나 같으면
			n = -1; // 다음 페이지 없음
		} else { // 아니면
			n = (s - 1) / 10 * 10 + 11; // 다음 페이지
		}

		if (c >= (nn - 1) / 10 * 10 + 1) { // 현재 페이지 보다 크거나 같으면
			pagination.setNn(-1); // 다음 페이지 그룹 없음
		} else { // 아니면
			pagination.setNn(nn); // 다음 페이지 그룹 있음
		}

		pagination.setC(c); // 현재 페이지
		pagination.setS(s); // 시작 페이지
		pagination.setE(e); // 끝 페이지
		pagination.setP(p); // 이전 페이지
		pagination.setN(n); // 다음 페이지

		return pagination; // 페이지네이션 리턴
	}

}
