package dao;

import java.util.List;

import domain.Gongji;

public interface GongjiDao {

	public int count(); // 전체 데이터 수 계산하는 메소드

	List<Gongji> selectAll(int page, int countPerPage); // 공지 모두 조회하여 리스트 저장

	int insertGongji(Gongji gongji); // 테이블에 데이터 삽입
	
	int updateGongji(Gongji gongji); // 데이터 수정
	
	int deleteOneGongji(int id); // 데이터 삭제
	
	Gongji selectOne(int id); // 조건 데이터 조회
	
	int currentPage(int id, int countPerPage); // 현재 페이지 구하는 메소드
	
	int makeData(); // 테이블 생성 및 데이터 입력
}




