package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import domain.Gongji;

public class GongjiDaoImpl implements GongjiDao {

	@Override
	public int count() { // 전체 데이터 수 세기
		int count = 0; // 전체 데이터 수 세는 count 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select count(*) from gongji2"); // 데이터베이스로부터 검색한 결과 처리, 테이블 전체 조회

			while (rset.next()) { // rset 돌면서 count 세기
				count = rset.getInt(1); // rset의 첫번째 열의 값을 count에 저장, 조회된 레코드의 수를 count에 할당
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace(); // 에러 프린트
		}
		return count; // count 리턴
	}
	
	@Override
	public List<Gongji> selectList(int page, int countPerPage) { // 전체 데이터 조회 
	    List<Gongji> gongjis = new ArrayList<>(); // 데이터 담을 list 객세 생성
	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
	        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
	        Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행
 
	        String selectSql = "SELECT * FROM gongji2 ORDER BY rootid DESC, recnt ASC LIMIT " + ((page - 1) * countPerPage) + ", " + countPerPage; // 쿼리문 작성
	        ResultSet rset = stmt.executeQuery(selectSql); // 쿼리문 실행 후 rset에 저장

	        while (rset.next()) { // rset 루프
	            Gongji gongji = new Gongji(); // gongji 객체 생성
	            
	            gongji.setId(rset.getInt(1)); // 해당 객체에 읽어온 기호 번호 설정
	            gongji.setTitle(rset.getString(2)); // 해당 객체에 읽어온 기호 번호 설정
	            gongji.setDate(rset.getString(3)); // 해당 객체에 읽어온 기호 번호 설정
	            gongji.setContent(rset.getString(4)); // 해당 객체에 읽어온 기호 번호 설정
	            gongji.setRootid(rset.getInt(5));
	            gongji.setRelevel(rset.getInt(6));
	            gongji.setRecnt(rset.getInt(7));
	            gongji.setViewcnt(rset.getInt(8));

	            gongjis.add(gongji); // gongji 객체를 리스트에 추가
	        }

	        rset.close();  // 객체 닫고 반환하여 자원 소모 방지
	        stmt.close();  // 객체 닫고 반환하여 자원 소모 방지
	        conn.close();  // 객체 닫고 반환하여 자원 소모 방지
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	    return gongjis; // gongjis 리턴
	}


	@Override
	public int insertGongji(Gongji gongji) { //데이터 삽입
		int id = 0; // 변수 선언 및 초기화
	      
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행
			 
			stmt.executeUpdate("UPDATE gongji2 SET recnt = recnt + 1 WHERE rootid = " + gongji.getRootid() + " AND relevel < " + gongji.getRelevel() + ";");

			 
			stmt.execute("INSERT INTO gongji2 (title, date, content, rootid, relevel, recnt, viewcnt) "
		            + "VALUES ('" + gongji.getTitle() + "', date(now()), '" + gongji.getContent() + "', "
		            + gongji.getRootid() + ", " + gongji.getRelevel() + ", " + gongji.getRecnt() + ", 0)"); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("select max(id) from gongji2;"); // 쿼리문 실행 후 rset에 저장

			if (rset.next()) { // rset 루프
				id = rset.getInt(1); // 첫번째 열 값 id에 저장
			}

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id; // id 리턴
	}

	@Override
	public int updateGongji(Gongji gongji) { // 데이터 수정
	      try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
				Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
				Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

	         // SQL 쿼리문을 실행하기 위해 executeUpdate 메서드를 호출합니다.
	         // 현재시간을 사용하려면 NOW() 함수를 사용
	         String updateQuery = "UPDATE gongji2 SET " + "title = '" + gongji.getTitle() + "', " + "date = NOW(), "
	               + "content = '" + gongji.getContent() + "',"+ "rootid = " + gongji.getRootid() + " ,"+ "relevel = " + gongji.getRelevel() + ", "
	               + "recnt = " + gongji.getRecnt() + " "+ "WHERE id = " + gongji.getId(); // 쿼리문 작성하여 저장

	         stmt.executeUpdate(updateQuery); // 쿼리문 실행

	         System.out.println("update 성공");

	         stmt.close();// 사용한 Statement 객체 닫기
	         conn.close();// 사용한 Connection 객체 닫기

	      } catch (Exception e) {// 오류가 발생하면
	         e.printStackTrace();// 오류를 출력
	         return -1;
	      }
	      return 1;// 업데이트된 객체를 반환
	   }

	 @Override
	   public int deleteOneGongji(int id) {
	      try { // 오류를 방지하기 위한 try문 시작
				Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
				Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
				Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행
	         
				ResultSet rset = stmt.executeQuery("select recnt from gongji2 where id = "+id+";"); // 후보 테이블의 모든 값 읽어옴
				
				int recnt = 0; // 댓글 표시 순서 담는 변수
				
				while (rset.next()) { // 읽어올 값이 남아있는 한 루프 반복
					recnt = rset.getInt(1); // 댓글 표시 순서 받아옴
				}
				// 해당 id의 댓글 수준 가져옴
				ResultSet rset2 = stmt.executeQuery("select rootid from gongji2 where id = "+id+";");
				int rootid = 0; // 댓글 수준 담는 변수
				
				while (rset2.next()) { // 읽어올 값이 남아있는 한 루프 반복
					rootid = rset2.getInt(1); // 댓글 순서 받아옴
				}
				
				// 삭제하려는 글의 레벨 찾기
				ResultSet rset3 = stmt.executeQuery("select relevel from gongji2 where id = "+id+";");
				int relevel = 0; // 게시글 레벨 넣을 변수
				
				while (rset3.next()) { // 읽어올 값이 남아있는 한 루프 반복
					relevel = rset3.getInt(1); // 게시글 레벨 받아옴
				}
				
				// 삭제하려는 글과 같거나 작은 레벨에 있으면서, rootid가 같고 recnt가 큰 글의 최소 recnt 값 찾기
				ResultSet rset4 = stmt.executeQuery("select min(recnt) from gongji2 where rootid = "+rootid+" and recnt >"+recnt+" and relevel <="+relevel+";");
				int nextRecnt = 0; // 다음 recnt 값 담을 변수
				
				while (rset4.next()) { // 읽어올 값이 남아있는 한 루프 반복
					nextRecnt = rset4.getInt(1); // 다음 recnt 받아옴
				}
				
				int count = nextRecnt - recnt; // recnt들 사이 count 계산
				
				Statement stmt2 = conn.createStatement(); // 새로 Statement 만들기
				
				if (nextRecnt != 0) { // 다음 recnt가 0이 아닐 경우
					stmt2.execute("delete from gongji2 where rootid="+rootid+" and recnt >="+recnt+" and recnt<"+nextRecnt+";"); // 삭제하려는 글에 달린 모든 댓글 삭제	
					stmt2.execute("update gongji2 set recnt= recnt - "+count+" where recnt >= "+nextRecnt+" and rootid = "+rootid+";");
				} else { // 그 외에는
					// 삭제하려는 글 이후의 모든 댓글 삭제
					stmt2.execute("delete from gongji2 where rootid="+rootid+" and recnt >="+recnt+";");
					stmt2.execute("UPDATE gongji2 SET recnt = 0, relevel = 0 WHERE id = " + id); // 원글의 recnt와 relevel을 초기화
				}
				// 삭제된 글 개수만큼 뒤에 있던 댓글들 recnt 감소


				conn.close(); // Connection 닫기
				stmt.close(); // Statement 닫기
			} catch (Exception e) { // 오류를 잡았을 경우
				e.printStackTrace(); // 오류 내용 프린트
				return -1; // null 리턴
			}
			return 1; // 1 리턴
	   }

	@Override
	public Gongji selectOne(int id) { // 선택 데이터 조회
		Gongji gongji = new Gongji(); // 객체 생성
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행
			
			ResultSet rset = stmt.executeQuery("select * from gongji2 where id=" + id); // 쿼리문 실행 후 rset에 저장

			while (rset.next()) { // rset 루프
	            gongji.setId(rset.getInt(1)); // 해당 객체에 읽어온 기호 번호 설정
	            gongji.setTitle(rset.getString(2)); // 해당 객체에 읽어온 기호 번호 설정
	            gongji.setDate(rset.getString(3)); // 해당 객체에 읽어온 기호 번호 설정
	            gongji.setContent(rset.getString(4)); // 해당 객체에 읽어온 기호 번호 설정
	            gongji.setRootid(rset.getInt(5));
	            gongji.setRelevel(rset.getInt(6));
	            gongji.setRecnt(rset.getInt(7));
	            gongji.setViewcnt(rset.getInt(8));
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return gongji; // gongji 리턴
	}

	@Override
	public int currentPage(int id, int countPerPage) { // 현재 페이지 구하기
		int cnt = 0; // 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from gongji2 order by id desc;"); // 학번 기준 정렬하여 전체 조회

			while (rset.next()) { // rset 돌면서 루프
				cnt++; // cnt 1씩 증가
				if (id == rset.getInt(1)) { // 조회한 학번이랑 학번이 같으면
					break; // 루프 종료
				}
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace(); // 에러 프린트
			return -1; // -1 리턴
		}
		int currentpage = cnt % countPerPage == 0 ? (cnt / countPerPage) : (cnt / countPerPage) + 1; // 현재 페이지 구하는 공식
		return currentpage; // 현재 페이지 리턴
	}

	@Override
	public int makeData() { // 테이블 생성 및 값 대입
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행
			
			stmt.executeUpdate("CREATE TABLE gongji2 ("
					+ "id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, "
	                   + "title VARCHAR(70), " 
					+ "date DATE, " 
	                   + "content TEXT, "
	                   + "rootid INT, " + "relevel INT, " + "recnt INT, " + "viewcnt INT) "
	                   + "DEFAULT CHARSET=utf8;"); // 테이블 생성 쿼리 실행

			for (int i = 1; i <= 125; i++) { // 125개 데이터 생성
				String title = "title " + i; // 제목 데이터
				java.sql.Date date = java.sql.Date.valueOf("2023-06-01"); // 날짜 데이터
				String content = "안녕하세요 " + i; // 내용 데이터 
				int rootid = i; // 원글번호 데이터 
				int relevel=0; // 댓글수준
				int recnt=0; // 댓글 내 글 표시 순서
				int viewcnt=0; // 조회수

				
				String insertQuery = "INSERT INTO gongji2 (title, date, content, rootid, relevel, recnt, viewcnt) VALUES ('"
	                    + title + "', '" + date + "', '" + content + "', " + rootid + ", "
	                    + relevel + ", " + recnt + ", " + viewcnt + ")"; // 데이터 삽입 쿼리문 저장

				stmt.executeUpdate(insertQuery); // 쿼리문 실행
			}
			// 테이블 생성하면 문구 출력하기
			System.out.println("테이블 만들기 OK");

			stmt.close(); // Statement 객체를 닫습니다.
			conn.close(); // Connection 객체를 닫습니다.
		} catch (Exception e) {
			e.printStackTrace();
			return -1; // -1 리턴
		}
		return 1;// 오류메시지를 반환
	}
	
	   @Override
	   public int addViewCnt(int id) {
	      try { // 오류를 방지하기 위한 try문 시작
				Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
				Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
				Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행
	         
	         stmt.execute("update gongji2 set viewcnt= viewcnt + 1 where id="+id+";"); // gongji2 테이블의 모든 값 읽어옴
	         
	         conn.close(); // Connection 닫기
	         stmt.close(); // Statement 닫기
	      } catch (Exception e) { // 오류를 잡았을 경우
	         e.printStackTrace(); // 오류 내용 프린트
	         return -1; // null 리턴
	      }
	      return 1;
	   }

	   @Override
	   public int getRecnt(int rootid, int relevel, int recnt) {
		      try { // 오류를 방지하기 위한 try문
					Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
					Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
					Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

		         ResultSet rset = stmt // 해당 페이지에 나오는 모든 학생들의 정보를 가져오는 명령어 실행
		               .executeQuery("select min(recnt) from gongji2 where rootid="+rootid+" and relevel<="+relevel+" and recnt > "+recnt+";");

		         while (rset.next()) { // 읽어올 값이 있는 한 루프 반복
		            recnt = rset.getInt(1);
		         }
		         
		         Statement stmt2 = conn.createStatement();
		         
		         if (recnt == 0) {
		            ResultSet rset2 = stmt2.executeQuery("select max(recnt)+1 from gongji2 where rootid="+rootid+";");
		            while(rset2.next()) {
		               recnt = rset2.getInt(1);
		            }
		         }

		         conn.close(); // Connection 닫기
		         stmt.close(); // Statement 닫기
		         rset.close(); // ResultSet 닫기
		      } catch (Exception e) { // 오류를 잡았을 경우
		         e.printStackTrace(); // 오류 내용 프린트
		         return -1; // null값 리턴
		      }
		      return recnt;
		   }
	   
	}
