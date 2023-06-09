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
	public int makeData() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			stmt.executeUpdate("create table scmtable ( id int not null primary key, " + "name varchar(70),"
					+ "stockNum int, " + "regDate date, " + "stockDate date,"+ "content text," + "image varchar(100))" + "DEFAULT CHARSET=utf8;"); // 테이블 생성 쿼리를

			int id = 0;
			int stockNum = 0;
			for (int i = 1; i <= 125; i++) {
				id = 100000 + i;
				String name = "name" + i;
				stockNum = stockNum + i;
				java.sql.Date regDate = new java.sql.Date(System.currentTimeMillis());
				java.sql.Date stockDate = new java.sql.Date(System.currentTimeMillis());
				String content = "안녕하세요" + i;
				String image = "사진"+i;
				

				String insertQuery = "INSERT INTO scmtable (id, name, stockNum, regDate, stockDate, content, image) VALUES ('" + id
						+ "', '" + name + "', '" + stockNum + "', '" + regDate + "', '" + stockDate + "', '" +content + "', '" + image+"')";

				stmt.executeUpdate(insertQuery);
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
	public int count() {
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
	public List<Stock> selectAll(int page, int countPerPage) {
		List<Stock> stocks = new ArrayList<>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from scmtable order by id desc limit " + ((page - 1) * countPerPage) + ", " + countPerPage + ";"); // 쿼리문 실행 후 rset에 저장

			while (rset.next()) {
				Stock stock = new Stock();
				stock.setId(rset.getInt(1));
				stock.setName(rset.getString(2));
				stock.setStockNum(rset.getInt(3));
				stock.setRegDate(rset.getString(5));
				stock.setStockDate(rset.getString(4));
				stock.setContent(rset.getString(6));
				stock.setImage(rset.getString(7));

				stocks.add(stock);
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return stocks; // votePrograms 리턴
	}
	
	@Override
	public Stock selectOne(int id) {
		Stock stock = new Stock();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from scmtable where id=" + id); // 쿼리문 실행 후 rset에 저장

			while (rset.next()) {
				stock.setId(rset.getInt(1));
				stock.setName(rset.getString(2));
				stock.setStockNum(rset.getInt(3));
				stock.setRegDate(rset.getString(5));
				stock.setStockDate(rset.getString(4));
				stock.setContent(rset.getString(6));
				stock.setImage(rset.getString(7));
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return stock; // votePrograms 리턴
	}

	@Override
	public int insertProduct(Stock stock) {
		int result = -1;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			stmt.execute("INSERT INTO scmtable (id, name, stockNum, regDate, stockDate, content, image) VALUES ('"
					+ stock.getId() + "', '" + stock.getName() + "', " + stock.getStockNum()
					+ ", date(now()), date(now()), '" + stock.getContent() + "', '" + stock.getImage() + "')");

			result = 1;

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;// 업데이트된 객체를 반환
	}
	@Override
	public int updateStock(Stock stock) {
		int result = -1;// 업데이트된 객체를 반환하기위해 StudentScore 객체 선언
	      try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
				Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
				Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

	         // SQL 쿼리문을 실행하기 위해 executeUpdate 메서드를 호출합니다.
	         // 현재시간을 사용하려면 NOW() 함수를 사용
	         String updateQuery = "UPDATE scmtable SET stockNum = '" + stock.getStockNum() + "', stockDate = NOW() WHERE id = " + stock.getId();

	         stmt.executeUpdate(updateQuery);

	         System.out.println("update 성공");
	         result = 1;

	         stmt.close();// 사용한 Statement 객체 닫기
	         conn.close();// 사용한 Connection 객체 닫기

	      } catch (Exception e) {// 오류가 발생하면
	         e.printStackTrace();// 오류를 출력
	      }
	      return result;// 업데이트된 객체를 반환
	   }

	@Override
	public int deleteProduct(int id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행
 
			stmt.executeUpdate("delete from scmtable where id = " + id + ";"); // 쿼리문 실행

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지

		} catch (Exception e) {
			e.printStackTrace();
		}
		return id; // id 리턴
	}

	@Override
	public int currentPage(int id, int countPerPage) {
		int cnt = 0; // 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from scmtable order by id desc;"); // 학번 기준 정렬하여 전체 조회

			while (rset.next()) { // rset 돌면서 루프
				cnt++; // cnt 1씩 증가
				if (id == rset.getInt(1)) { // 조회한 상품번호가 상품번호와 같으면
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

}
