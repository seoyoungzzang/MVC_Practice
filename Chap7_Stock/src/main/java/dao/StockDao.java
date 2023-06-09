package dao;

import java.util.List;

import domain.Stock;

public interface StockDao {
	
	int makeData();

	public int count();
	
	List<Stock> selectAll(int page, int countPerPage);

	int insertProduct(Stock stock);
	
	int updateStock(Stock stock);
	
	int deleteProduct(int id);
	
	Stock selectOne(int id);
	
	int currentPage(int id, int countPerPage); // 현재 페이지 구하는 메소드

}
