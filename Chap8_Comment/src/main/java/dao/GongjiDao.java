package dao;

import java.util.List;

import domain.Gongji;

public interface GongjiDao {

	int makeData(); // 테스트용 데이터셋을 테이블에 삽입하는 메소드

	List<Gongji> selectAllGongji(); // 모든 공지 객체들을 불러와 리스트로 묶어 리턴

	Gongji selectOneGongji(int id); // id를 기반으로 공지 하나의 정보를 불러옴

	int deleteOneGongji(int id); // id를 기반으로 공지 하나를 삭제함

	int updateGongji(Gongji gongji); // 인자로 받은 공지 정보로 기존 공지를 수정

	int insertGongji(Gongji gongji); // 인자로 받은 공지 정보를 DB에 추가

	int count(); // 총 공지 개수 세어 리턴

	List<Gongji> selectAll(int pageNum, int countPerPage); // 해당 페이지에 보여지는 공지들을 리스트로 묶어 리턴

	int getPageById(int id, int countPerPage); // 해당 id의 공지가 몇 번째 페이지에 존재하는지 리턴

	int addViewCnt(int id); // 게시글의 조회수를 1 늘려줌

	int getRecnt(int rootid, int relevel, int recnt); // 모체의 rootid, relevel, recnt를 기반으로 새로운 댓글의 recnt를 계산해 리턴

	int getNewId(); // 새로운 게시글이 배정받은 아이디 값을 리턴

}
