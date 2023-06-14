package service;

import dto.Pagination;

public interface GongjiService {
	Pagination getPagination(int page, int countPerPage);
}
