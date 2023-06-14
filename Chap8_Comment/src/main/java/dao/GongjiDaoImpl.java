package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import domain.Gongji;
import service.GongjiService;
import service.GongjiServiceImpl;

public class GongjiDaoImpl implements GongjiDao {

	@Override
	public int makeData() { // 테이블 생성 및 값 대입
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			stmt.executeUpdate("CREATE TABLE gongji2 (" + "id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, "
					+ "title VARCHAR(70), " + "date DATE, " + "content TEXT, " + "rootid INT, " + "relevel INT, "
					+ "recnt INT, " + "viewcnt INT) " + "DEFAULT CHARSET=utf8;"); // 테이블 생성 쿼리 실행

			for (int i = 1; i <= 125; i++) { // 125개 데이터 생성
				String title = "title " + i; // 제목 데이터
				java.sql.Date date = java.sql.Date.valueOf("2023-06-01"); // 날짜 데이터
				String content = "안녕하세요 " + i; // 내용 데이터
				int rootid = i; // 원글번호 데이터
				int relevel = 0; // 댓글수준
				int recnt = 0; // 댓글 내 글 표시 순서
				int viewcnt = 0; // 조회수

				String insertQuery = "INSERT INTO gongji2 (title, date, content, rootid, relevel, recnt, viewcnt) VALUES ('"
						+ title + "', '" + date + "', '" + content + "', " + rootid + ", " + relevel + ", " + recnt
						+ ", " + viewcnt + ")"; // 데이터 삽입 쿼리문 저장

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
	public List<Gongji> selectAllGongji() { // 모든 공지 불러와 리스트로 묶어 리턴하는 함수
		List<Gongji> selectAll = new ArrayList<Gongji>(); // 공지 리스트 생성

		try { // 오류를 방지하기 위한 try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from gongji2 order by id desc;"); // 후보 테이블의 모든 값 읽어옴

			while (rset.next()) { // 읽어올 값이 남아있는 한 루프 반복

				Gongji gongji = new Gongji(); // 후보 객체 생성

				gongji.setId(rset.getInt(1)); // 해당 객체에 읽어온 아이디 설정
				gongji.setTitle(rset.getString(2)); // 해당 객체에 읽어온 제목 설정
				gongji.setDate(rset.getString(3)); // 해당 객체에 읽어온 날짜 설정
				gongji.setContent(rset.getString(4)); // 해당 객체에 읽어온 본문 내용 설정
				gongji.setRootid(rset.getInt(5)); // 해당 객체에 읽어온 원글 아이디 설정
				gongji.setRelevel(rset.getInt(6)); // 해당 객체에 읽어온 댓글 깊이 설정
				gongji.setRecnt(rset.getInt(7)); // 해당 객체에 읽어온 댓글 표시 순서 설정
				gongji.setViewcnt(rset.getInt(8)); // 해당 객체에 읽어온 조회수 설정
				selectAll.add(gongji); // 후보 리스트에 추가
			}
			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
			rset.close(); // ResultSet 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return null; // null 리턴
		}
		return selectAll; // 리스트 리턴
	}

	@Override
	public Gongji selectOneGongji(int id) { // id를 기반으로 공지 정보 하나 불러옴
		Gongji select = new Gongji(); // 공지 객체 생성

		try { // 오류를 방지하기 위한 try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from gongji2 where id = " + id + ";"); // 후보 테이블의 모든 값 읽어옴

			while (rset.next()) { // 읽어올 값이 남아있는 한 루프 반복

				select.setId(rset.getInt(1)); // 해당 객체에 읽어온 기호 번호 설정
				select.setTitle(rset.getString(2)); // 해당 객체에 읽어온 기호 번호 설정
				select.setDate(rset.getString(3)); // 해당 객체에 읽어온 기호 번호 설정
				select.setContent(rset.getString(4)); // 해당 객체에 읽어온 기호 번호 설정
				select.setRootid(rset.getInt(5));
				select.setRelevel(rset.getInt(6));
				select.setRecnt(rset.getInt(7));
				select.setViewcnt(rset.getInt(8));
			}
			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
			rset.close(); // ResultSet 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return null; // null 리턴
		}
		return select; // 리스트 리턴
	}

	@Override
	public int deleteOneGongji(int id) { // id를 기반으로 공지를 찾아 db에서 삭제
		try { // 오류를 방지하기 위한 try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select recnt from gongji2 where id = " + id + ";"); // 후보 테이블의 모든 값 읽어옴

			int recnt = 0; // 댓글 표시 순서 담는 변수

			while (rset.next()) { // 읽어올 값이 남아있는 한 루프 반복
				recnt = rset.getInt(1); // 댓글 표시 순서 받아옴
			}
			// 해당 id의 댓글 수준 가져옴
			ResultSet rset2 = stmt.executeQuery("select rootid from gongji2 where id = " + id + ";");
			int rootid = 0; // 댓글 수준 담는 변수

			while (rset2.next()) { // 읽어올 값이 남아있는 한 루프 반복
				rootid = rset2.getInt(1); // 댓글 순서 받아옴
			}

			// 삭제하려는 글의 레벨 찾기
			ResultSet rset3 = stmt.executeQuery("select relevel from gongji2 where id = " + id + ";");
			int relevel = 0; // 게시글 레벨 넣을 변수

			while (rset3.next()) { // 읽어올 값이 남아있는 한 루프 반복
				relevel = rset3.getInt(1); // 게시글 레벨 받아옴
			}

			// 삭제하려는 글과 같거나 작은 레벨에 있으면서, rootid가 같고 recnt가 큰 글의 최소 recnt 값 찾기
			ResultSet rset4 = stmt.executeQuery("select min(recnt) from gongji2 where rootid = " + rootid
					+ " and recnt >" + recnt + " and relevel <=" + relevel + ";");
			int nextRecnt = 0; // 다음 recnt 값 담을 변수

			while (rset4.next()) { // 읽어올 값이 남아있는 한 루프 반복
				nextRecnt = rset4.getInt(1); // 다음 recnt 받아옴
			}

			int count = nextRecnt - recnt; // recnt들 사이 count 계산

			Statement stmt2 = conn.createStatement(); // 새로 Statement 만들기

			if (nextRecnt != 0) { // 다음 recnt가 0이 아닐 경우
				stmt2.execute("delete from gongji2 where rootid=" + rootid + " and recnt >=" + recnt + " and recnt<"
						+ nextRecnt + ";"); // 삭제하려는 글에 달린 모든 댓글 삭제
			} else { // 그 외에는
				// 삭제하려는 글 이후의 모든 댓글 삭제
				stmt2.execute("delete from gongji2 where rootid=" + rootid + " and recnt >=" + recnt + ";");
			}
			// 삭제된 글 개수만큼 뒤에 있던 댓글들 recnt 감소
			stmt2.execute("update gongji2 set recnt= recnt - " + count + " where recnt >= " + nextRecnt
					+ " and rootid = " + rootid + ";");

			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return -1; // null 리턴
		}
		return 1; // 1 리턴
	}

	@Override
	public int updateGongji(Gongji gongji) { // 인자로 받은 공지 정보를 기반으로 이미 존재하는 공지 수정
		int id = gongji.getId(); // 인자 객체에서 id 받아오기
		String title = gongji.getTitle(); // 인자 객체에서 공지 제목 받아오기
		String content = gongji.getContent(); // 인자 객체에서 본문 내용 받아오기
		try { // 오류를 방지하기 위한 try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			stmt.execute("update gongji2 set title='" + title + "',content='" + content + "' where id=" + id + ";"); // 데이터 업데이트 

			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return -1; // null 리턴
		}
		return 1; // 1 리턴
	}

	@Override
	public int insertGongji(Gongji gongji) { // 인자로 받은 공지 정보 DB에 추가
		int result = -1; // 결과를 담을 변수
		String title = gongji.getTitle(); // 공지사항 제목 가져오기
		String date = gongji.getDate(); // 날짜 가져오기
		String content = gongji.getContent(); // 본문 내용 가져오기
		int rootid = gongji.getRootid(); // rootid 가져오기
		int relevel = gongji.getRelevel(); // relevel 가져오기
		int recnt = gongji.getRecnt(); // recnt 가져오기
		int viewcnt = gongji.getViewcnt(); // viewcnt 가져오기

		try { // 오류를 방지하기 위한 try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행
			// 생성된 댓글 이후의 댓글들 recnt 1 추가
			stmt.execute(
					"update gongji2 set recnt= recnt + 1 where recnt >= " + recnt + " and rootid = " + rootid + ";");

			stmt.execute("insert into gongji2(title,date,content, rootid, relevel, recnt, viewcnt)" + "values('" + title
					+ "','" + date + "','" + content + "'," + rootid + "," + relevel + "," + recnt + ",0);"); // 삽입 진행

			ResultSet rset = stmt.executeQuery("select max(id) from gongji2;"); // 후보 테이블의 모든 값 읽어옴

			while (rset.next()) { // 읽어올 값이 남아있는 한 루프 반복
				result = rset.getInt(1); // 결과값 받아옴
			}

			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return -1; // null 리턴
		}
		return result; // max id 리턴
	}

	@Override
	public int count() { // 항목 개수 세어 리턴
		int count = 0; // 개수 담을 변수 생성
		try { // 오류를 방지하기 위한 try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select count(*) from gongji2;"); // 모든 값의 개수 가져옴

			while (rset.next()) { // 읽어올 값이 남아있는 한 루프 반복
				count = rset.getInt(1); // 개수 받아옴
			}

			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return -1; // null 리턴
		}
		return count; // 개수 리턴
	}

	@Override
	public List<Gongji> selectAll(int pageNum, int countPerPage) { // 특정 페이지의 공지들 정보를 리스트로 묶어 리턴
		List<Gongji> select = new ArrayList<Gongji>(); // 학생 정보 객체들이 모인 리스트 생성

		try { // 오류를 방지하기 위한 try문
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			int start = countPerPage * (pageNum - 1) + 1; // 현재 페이지수를 기준으로 시작 인덱스 계산

			ResultSet rset = stmt // 해당 페이지에 나오는 모든 학생들의 정보를 가져오는 명령어 실행
					.executeQuery("select * from gongji2 order by rootid desc, recnt asc limit " + (start - 1) + ", "
							+ countPerPage + ";");

			while (rset.next()) { // 읽어올 값이 있는 한 루프 반복

				Gongji gongji = new Gongji(); // StudentScore 객체 생성

				gongji.setId(rset.getInt(1)); // 객체에 받아온 id값 지정
				gongji.setTitle(rset.getString(2)); // 객체에 받아온 이름값 지정
				gongji.setDate(rset.getString(3)); // 객체에 받아온 학번값 지정
				gongji.setContent(rset.getString(4)); // 객체에 받아온 국어 성적값 지정
				gongji.setRootid(rset.getInt(5)); // 객체에 받아온 국어 성적값 지정
				gongji.setRelevel(rset.getInt(6)); // 객체에 받아온 국어 성적값 지정
				gongji.setRecnt(rset.getInt(7)); // 객체에 받아온 국어 성적값 지정
				gongji.setViewcnt(rset.getInt(8)); // 객체에 받아온 국어 성적값 지정

				select.add(gongji); // 해당 값 리스트에 추가
			}
			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
			rset.close(); // ResultSet 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return null; // null값 리턴
		}

		return select; // 학생 정보가 담긴 리스트 리턴
	}

	@Override
	public int getPageById(int id, int countPerPage) { // id를 받아와 그 id가 존재하는 페이지 번호를 리턴함
		int cnt = 0; // 해당 공지사항 앞에 존재하는 공지사항 개수를 담는 변수
		int page = 0; // 페이지수를 담는 변수

		try { // 오류를 방지하기 위한 try문
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			GongjiService gongjiServiceDao = new GongjiServiceImpl();

			// "select count(*)+1 from gongji where id > "+id+";"
			ResultSet rset = stmt // 해당 페이지에 나오는 모든 학생들의 정보를 가져오는 명령어 실행
					.executeQuery("select * from gongji2 order by rootid desc, recnt asc");
			while (rset.next()) { // 읽어올 값이 있는 한 루프 반복
				if (rset.getInt(1) == id)
					break; // 동일 id가 검색되면 break
				cnt++; // cnt 1 추가
			}
			cnt++; // cnt 1 추가

			page = (cnt - 1) / countPerPage + 1; // 페이지수 계산
			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
			rset.close(); // ResultSet 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return 0; // null값 리턴
		}
		return page; // 페이지수 리턴
	}

	@Override
	public int addViewCnt(int id) { // 게시글의 조회수를 1 늘려줌
		try { // 오류를 방지하기 위한 try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			stmt.execute("update gongji2 set viewcnt= viewcnt + 1 where id=" + id + ";"); // 조회수 1 늘리기

			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return -1; // null 리턴
		}
		return 1; // 1 리턴
	}

	@Override
	public int getRecnt(int rootid, int relevel, int recnt) { // 모체의 rootid, relevel, recnt를 기반으로 새로운 댓글의 recnt를 계산해 리턴
		int cnt = 0; // cnt 담을 변수
		try { // 오류를 방지하기 위한 try문
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt // 해당 페이지에 나오는 모든 학생들의 정보를 가져오는 명령어 실행
					.executeQuery("select min(recnt) from gongji2 where rootid=" + rootid + " and relevel<=" + relevel
							+ " and recnt > " + recnt + ";");

			while (rset.next()) { // 읽어올 값이 있는 한 루프 반복
				recnt = rset.getInt(1); // recnt 받아오기
			}

			Statement stmt2 = conn.createStatement(); // Statement 새로 만들기

			if (recnt == 0) { // recnt가 0일 경우
				// recnt의 마지막 값에 1 추가한 값 가져오기
				ResultSet rset2 = stmt2.executeQuery("select max(recnt)+1 from gongji2 where rootid=" + rootid + ";");
				while (rset2.next()) { // 읽어올 값이 있는 한 루프 반복
					recnt = rset2.getInt(1); // recnt 받아오기
				}
			}

			if (recnt == 0)
				recnt = 1; // recnt가 0이면 1로 지정
			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
			rset.close(); // ResultSet 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return -1; // null값 리턴
		}
		return recnt; // recnt 값 리턴
	}

	@Override
	public int getNewId() { // 새로운 게시글이 배정받은 아이디 값을 리턴
		int id = 0; // id 값 담을 변수
		try { // 오류를 방지하기 위한 try문
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt // id의 max값 받아옴
					.executeQuery("select max(id) from gongji2;");

			while (rset.next()) { // 읽어올 값이 있는 한 루프 반복
				id = rset.getInt(1); // id 값 받아옴
			}
			conn.close(); // Connection 닫기
			stmt.close(); // Statement 닫기
			rset.close(); // ResultSet 닫기
		} catch (ClassNotFoundException | SQLException e) { // 오류를 잡았을 경우
			e.printStackTrace(); // 오류 내용 프린트
			return -1; // null값 리턴
		}
		return id; // id 값 리턴
	}

}
