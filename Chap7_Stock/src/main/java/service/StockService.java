package service;

import dto.Pagination;

public interface StockService {
	Pagination getPagination(int page, int countPerPage); // 페이지네이션 함수
}
