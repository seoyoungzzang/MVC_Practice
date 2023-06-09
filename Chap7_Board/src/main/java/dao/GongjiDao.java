package dao;

import java.util.List;

import domain.Gongji;

public interface GongjiDao {

	public int count(); // 전체 데이터 수 계산하는 메소드

	List<Gongji> selectAll(int page, int countPerPage);

	int insertGongji(Gongji gongji);
	
	int updateGongji(Gongji gongji);
	
	int deleteOneGongji(int id);
	
	Gongji selectOne(int id);
	
	int currentPage(int id, int countPerPage); // 현재 페이지 구하는 메소드
	
	int makeData();
}




