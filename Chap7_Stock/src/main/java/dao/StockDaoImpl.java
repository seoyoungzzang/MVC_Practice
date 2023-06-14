package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import domain.Stock;

public class StockDaoImpl implements StockDao {

	@Override
	public int makeData() { // 테이블 생성 및 값 대입
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			stmt.executeUpdate("CREATE TABLE scmtable (rowid INT NOT NULL AUTO_INCREMENT, id VARCHAR(20) UNIQUE, name VARCHAR(70), stockNum INT, regDate DATE, "
					+ "stockDate DATE, content TEXT, image VARCHAR(100), PRIMARY KEY (rowid)) DEFAULT CHARSET=utf8;"); // 테이블 생성 쿼리 실행

			int stockNum = 0; // 재고수 변수 선언 및 초기화
			for (int i = 1; i <= 125; i++) { // 125개 데이터 생성
				String id = String.format("%013d", 1000000000000L + i); // id 생성
				String name = "name" + i; // 이름 데이터
				stockNum = stockNum + i; // 재고수 데이터	
				java.sql.Date regDate =  java.sql.Date.valueOf("2023-06-01"); // 날짜 데이터
				java.sql.Date stockDate = java.sql.Date.valueOf("2023-06-01"); // 날짜 데이터
				String content = "안녕하세요" + i; // 내용 데이터 
				String image = "./image/no_image.jpg"; // 이미지 데이터 

				String insertQuery = "INSERT INTO scmtable (id, name, stockNum, regDate, stockDate, content, image) VALUES ('" + id
						+ "', '" + name + "', " + stockNum + ", '" + regDate + "', '" + stockDate + "', '" + content + "', '" + image + "')"; // 데이터 삽입 쿼리문 저장

				stmt.executeUpdate(insertQuery); // 쿼리문 실행
			}
			// 테이블 생성하면 문구 출력하기
			System.out.println("테이블 만들기 OK");

			stmt.close(); // Statement 객체를 닫습니다.
			conn.close(); // Connection 객체를 닫습니다.
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
		return 1;// 오류메시지를 반환
	}



	@Override
	public int count() { // 전체 데이터 수 세기
		int count = 0; // 전체 데이터 수 세는 count 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select count(*) from scmtable"); // 데이터베이스로부터 검색한 결과 처리, 테이블 전체 조회

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
	public List<Stock> selectAll(int page, int countPerPage) { // 전체 데이터 조회 
		List<Stock> stocks = new ArrayList<>(); // 데이터 담을 list 객세 생성
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from scmtable order by rowid desc limit " + ((page - 1) * countPerPage) + ", " + countPerPage + ";"); // 쿼리문 실행 후 rset에 저장

			while (rset.next()) { // rset 루프
				Stock stock = new Stock(); // stock 객체 생성
				stock.setId(rset.getString(2)); // 두번째 열 값 저장
				stock.setName(rset.getString(3)); // 세번째 열 값 저장
				stock.setStockNum(rset.getInt(4)); // 네번째 열 값 저장
				stock.setRegDate(rset.getString(5)); // 여섯번째 열 값 저장
				stock.setStockDate(rset.getString(6)); // 다섯번째 열 값 저장
				stock.setContent(rset.getString(7)); // 일곱번째 열 값 저장
				stock.setImage(rset.getString(8)); // 여덟번째 열 값 저장

				stocks.add(stock); // stock 객체를 리스트에 추가
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return stocks; // stocks 리턴
	}
	
	@Override
	public Stock selectOne(String id) { // 선택 데이터 조회
		Stock stock = new Stock(); // 객체 생성
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("SELECT * FROM scmtable WHERE id = '" + id + "'"); // 쿼리문 실행 후 rset에 저장

			while (rset.next()) { // rset 루프
				stock.setId(rset.getString(2)); // 두번째 열 값 저장
				stock.setName(rset.getString(3)); // 세번째 열 값 저장
				stock.setStockNum(rset.getInt(4)); // 네번째 열 값 저장
				stock.setRegDate(rset.getString(5)); // 여섯번째 열 값 저장
				stock.setStockDate(rset.getString(6)); // 다섯번째 열 값 저장
				stock.setContent(rset.getString(7)); // 일곱번째 열 값 저장
				stock.setImage(rset.getString(8)); // 여덟번째 열 값 저장
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return stock; // stock 리턴
	}

	@Override
	public int insertProduct(Stock stock) { //데이터 삽입
		int result = -1; // 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			stmt.execute("INSERT INTO scmtable (id, name, stockNum, regDate, stockDate, content, image) VALUES ('"
					+ stock.getId() + "', '" + stock.getName() + "', " + stock.getStockNum()
					+ ", date(now()), date(now()), '" + stock.getContent() + "', '" + stock.getImage() + "')"); // sql문을 DB로 보내고 실행

			result = 1; // 데이터 삽입 성공 시 1 대입

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;// 업데이트된 객체를 반환
	}
	@Override
	public int updateStock(Stock stock) { // 데이터 수정
		int result = -1;// 업데이트된 객체를 반환하기위해 StudentScore 객체 선언
	      try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
				Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
				Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

	         // SQL 쿼리문을 실행하기 위해 executeUpdate 메서드를 호출합니다.
	         // 현재시간을 사용하려면 NOW() 함수를 사용
				String updateQuery = "UPDATE scmtable SET stockNum = '" + stock.getStockNum() + "', stockDate = NOW() WHERE id = '" + stock.getId() + "'"; // 쿼리문 작성하여 저장

	         stmt.executeUpdate(updateQuery); // 쿼리문 실행

	         System.out.println("update 성공"); 
	         result = 1; // 업데이트 성공 시 result 1 대입

	         stmt.close();// 사용한 Statement 객체 닫기
	         conn.close();// 사용한 Connection 객체 닫기

	      } catch (Exception e) {// 오류가 발생하면
	         e.printStackTrace();// 오류를 출력
	      }
	      return result;// 업데이트된 객체를 반환
	   }

	@Override
	public String deleteProduct(String id) { // 데이터 삭제
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행
 
			stmt.executeUpdate("DELETE FROM scmtable WHERE id = '" + id + "'"); // 쿼리문 실행

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지

		} catch (Exception e) {
			e.printStackTrace();
		}
		return id; // id 리턴
	}

	@Override
	public int currentPage(String id, int countPerPage) { // 현재 페이지 구하기
		int cnt = 0; // 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from scmtable order by rowid desc;"); // 학번 기준 정렬하여 전체 조회

			while (rset.next()) { // rset 돌면서 루프
				cnt++; // cnt 1씩 증가
				if (id.equals(rset.getString(2))) { // 조회한 상품번호가 상품번호와 같으면
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
	public boolean isIdExist(String id) { // 중복 id 걸러내는 메소드
		boolean exists = false;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행
 
			ResultSet rset = stmt.executeQuery("select id from scmtable where id = '" + id + "'"); // id가 같은 id 조회
			
			if(rset.next()) { // rset 존재하면
				exists = true; // id가 존재하면
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
		  return exists;
	}

}
