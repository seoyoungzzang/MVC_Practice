package kr.ac.kopo.ctc.kopo34.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo34.domain.StudentScore;

public interface StudentScoreDao {

	StudentScore create(StudentScore studentScore); // studentScore 매개변수로 전달된 학생 점수 객체를 db에 추가

	StudentScore selectOne(String studentid); // id를 가진 학생 점수 검색 및 해당 학생 점수 객체 리턴

	List<StudentScore> selectAll(int page, int countPerPage); // 해당 페이지에 해당하는 학생 점수 목록 검색 및 반환

	StudentScore update(String studentid, StudentScore studentScore); // 주어진 id의 학생점수를 studentScore 매개변수로 전달된 학생 점수 객체의 내용으로 수정

	StudentScore delete(String studentid); // id를 가진 학생 점수 삭제 및 삭제된 학생 점수 객체 리턴
	
	String insertAll(int last); // 랜덤 데이터 삽입 메소드
	
	String dropTable(); // 테이블 삭제 메소드
	
	String createTable(); // 테이블 생성 메소드
	
	int currentPage(String studentid, int countPerPage); // 현재 페이지 구하는 메소드
	
	public int count(); // 전체 데이터 수 계산하는 메소드
}
