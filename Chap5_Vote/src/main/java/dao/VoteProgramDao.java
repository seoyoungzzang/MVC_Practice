package dao;

import java.util.List;

import domain.VoteProgram;

public interface VoteProgramDao {
	int insertHubo(String name); // hubo테이블에 데이터 입력
	
	int CalcId(); // hubo테이블에 아이디 계산해서 저장
	
	void insertTupyo(int id, int age); // tupyo테이블에 데이터 입력

	int deleteHubo(int id); // 후보 삭제

	int countAll(); // 총 투표수 count
	
	int countVotes(int id); // 후보자별 득표수 count

	List<VoteProgram> selectAll(); // 후보 모두 조회하여 리스트 저장

	List<VoteProgram> selectOne(int id); // 후보별 연령대별 득표수 리스트 저장

}
