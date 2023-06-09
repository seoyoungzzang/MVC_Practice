package service;

import dto.Pagination;

public interface StockService {
	Pagination getPagination(int page, int countPerPage);
}
