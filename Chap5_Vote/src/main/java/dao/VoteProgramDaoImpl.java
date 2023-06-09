package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import domain.VoteProgram;

public class VoteProgramDaoImpl implements VoteProgramDao {

	@Override
	public int insertHubo(String name) { // Hubo테이블에 데이터 추가
		int id = 0; // id 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("SELECT id FROM hubo ORDER BY id ASC"); // 쿼리문 실행 후 rset에 저장

			int newId = 1; // newId 변수 선언 및 1 대입
            while (rset.next()) { // rset 루프
				int currentId = rset.getInt("id"); // 쿼리에서 id가져와서 currentId에 저장
				if (newId < currentId) { // newId가 currentId보다 작으면
					break; // 루프 탈출
				}
				newId = currentId + 1; // 아니면 1 더하기
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지

			id = newId; // id에 newId 저장
			stmt.execute("INSERT INTO hubo (id, name) VALUES ('" + id + "', '" + name + "');"); // 쿼리문 실행

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id; // id 리턴
	}

	@Override
	public int CalcId() { // id 저장해주는 메소드
		int id = 0; // id 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("SELECT id FROM hubo ORDER BY id ASC"); // 쿼리문 실행 후 rset에 저장

			int newId = 1; // newId 변수 선언 및 1 대입
            while (rset.next()) { // rset 루프
				int currentId = rset.getInt("id"); // 쿼리에서 id가져와서 currentId에 저장
				if (newId < currentId) { // newId가 currentId보다 작으면
					break; // 루프 탈출
				}
				newId = currentId + 1; // 아니면 1 더하기
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지

			id = newId; // id에 newId 저장

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id; // id 리턴
	}

	@Override
	public void insertTupyo(int id, int age) { // tupyo테이블에 데이터 추가
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			stmt.execute("INSERT INTO tupyo VALUES (" + id + ", " + age + ");"); // 쿼리문 실행

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int deleteHubo(int id) { // Hubo테이블에 데이터 삭제
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행
 
			stmt.executeUpdate("delete from hubo where id = " + id + ";"); // 쿼리문 실행

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지

		} catch (Exception e) {
			e.printStackTrace();
		}
		return id; // id 리턴
	}

	@Override
	public int countAll() { // 총 투표수 계산
		int count = 0; // count 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("select count(*) from tupyo"); // 쿼리문 실행 후 rset에 저장

			while (rset.next()) { // rset 루프
				count = rset.getInt(1); // 첫번째 열 갯수 세기
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count; // count 리턴
	}

	@Override
	public int countVotes(int id) { // 후보별 득표수 계산
		int count = 0; // count 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("select id, count(*) from tupyo where id =" + id + " group by id"); // 쿼리문 실행 후 rset에 저장
			
            while (rset.next()) { // rset 루프
				count = rset.getInt(2); // 두번째 열 갯수 세기
			}
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count; // count 리턴
	}

	@Override
	public List<VoteProgram> selectAll() { // hubo테이블 모든 레코드 조회
		List<VoteProgram> votePrograms = new ArrayList<>(); // votePrograms 리스트 객체 생성
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from hubo"); // 쿼리문 실행 후 rset에 저장

			while (rset.next()) { // rset 루프
				VoteProgram voteProgram = new VoteProgram(); // VoteProgram 객체 생성
				voteProgram.setId(rset.getInt(1)); // 첫번째 열 값 저장
				voteProgram.setName(rset.getString(2)); // 두번째 열 값 저장

				votePrograms.add(voteProgram); // VoteProgram 객체를 리스트에 추가
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지  
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지 
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return votePrograms; // votePrograms 리턴
	}

	@Override
	public List<VoteProgram> selectOne(int id) { // 특정 id의 후보의 투표정보 조회 (후보별 연령대별 득표수 구하려고)
		List<VoteProgram> votePrograms = new ArrayList<>(); // votePrograms 리스트 객체 생성
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 DB와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 DB로 보내고 실행

			ResultSet rset = stmt.executeQuery("SELECT t.age, COUNT(*) AS voteCnt " + "FROM hubo as h "
					+ "JOIN tupyo as t ON h.id = t.id " + "WHERE h.id = '" + id + "'" + "GROUP BY t.age;"); // 쿼리문 실행 후 rset에 저장

			while (rset.next()) { // rset 루프
				VoteProgram voteProgram = new VoteProgram(); // VoteProgram 객체 생성
				voteProgram.setAge(rset.getInt(1)); // 첫번째 열 값 저장
				voteProgram.setCount(rset.getInt(2)); // 두번째 열 값 저장

				votePrograms.add(voteProgram); // VoteProgram 객체를 리스트에 추가
			}

			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace();
		}
		return votePrograms; // votePrograms 리턴
	}

}
