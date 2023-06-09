package kr.ac.kopo.ctc.kopo34.service;

import kr.ac.kopo.ctc.kopo34.dto.Pagination;

public interface StudentScoreService {
	Pagination getPagination(int page, int countPerPage); // 페이지와 페이지당 레코드 수 인자로 받아서 페이지네이션 
}
