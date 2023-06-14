package dao;

import java.util.List;

import domain.Stock;

public interface StockDao {
	
	int makeData(); // 테이블 생성 및 데이터 입력

	public int count(); // 전체 데이터 수 계산하는 메소드
	
	List<Stock> selectAll(int page, int countPerPage); // 공지 모두 조회하여 리스트 저장

	int insertProduct(Stock stock); // 신규 상품 입력
	
	int updateStock(Stock stock); // 재고수 수정
	
	String deleteProduct(String id); // 상품 삭제
	
	Stock selectOne(String id); // 조건 데이터 조회
	
	int currentPage(String id, int countPerPage); // 현재 페이지 구하는 메소드
	
	boolean isIdExist(String id); // 중복 id 걸러내는 메소드
}
