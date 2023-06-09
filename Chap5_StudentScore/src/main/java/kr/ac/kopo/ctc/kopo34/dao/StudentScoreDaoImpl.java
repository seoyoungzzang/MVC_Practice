package kr.ac.kopo.ctc.kopo34.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo34.domain.StudentScore;

public class StudentScoreDaoImpl implements StudentScoreDao {

	@Override
	public int count() { // 전체 데이터 수 리턴
		int count = 0; // 전체 데이터 수 세는 count 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select count(*) from examtable"); // 데이터베이스로부터 검색한 결과 처리, 테이블 전체 조회

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
	public StudentScore create(StudentScore studentScore) { // 데이터 삽입
		String name = studentScore.getName(); // StudentScore 객체에서 name 가져옴
		int kor = studentScore.getKor(); // StudentScore 객체에서 kor 가져옴
		int eng = studentScore.getEng(); // StudentScore 객체에서 eng 가져옴
		int mat = studentScore.getMat(); // StudentScore 객체에서 mat 가져옴

		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행
			
			ResultSet rset = stmt.executeQuery("select studentid from examtable order by studentid asc"); // 학번 오름차순으로 정렬하여 조회

			int newId = 209901; // 새로운 학번 변수 선언 및 초기값 설정
			while (rset.next()) { // rset 돌면서 루프
				int currentId = rset.getInt("studentid"); // currentId에 현재 학번 대입
				if (newId < currentId) { // newId가 작으면
					break; // 루프 탈출
				}
				newId = currentId + 1; // 비어있는 학번에 새로운 학번 추가
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지

			String studentid = String.format("%06d", newId);// studentid 값 설정

			studentScore.setStudentid(studentid); // 부여된 학번을 studentScore에 넣어줌

			stmt.execute("insert into examtable (name, studentid, kor, eng, mat) VALUES ('" + name + "', " + studentid
					+ "," + kor + "," + eng + "," + mat + ");"); // 테이블에 학번 삽입

			rset = stmt.executeQuery("select studentid from examtable where studentid = " + studentid); // 삽입된 학번 조회

			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace(); // 에러 프린트
			return null;
		}
		return studentScore; // studentScore 리턴
	}

	@Override
	public StudentScore selectOne(String studentid) { // 선택한 데이터 1개 구하기
		StudentScore studentScore = new StudentScore(); // StudentScore 객체 생성

		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select *, b.kor + b.eng + b.mat, (b.kor + b.eng + b.mat) / 3,"
					+ "(select count(*) + 1 from examtable as a where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat)) from examtable as b "
					+ "WHERE studentid = " + studentid); // id를 이용해서 해당 학생 정보 조회

			while (rset.next()) { // rset 돌면서 루프
				studentScore.setName(rset.getString(1)); // 이름 저장
				studentScore.setStudentid(rset.getString(2)); // 학번 저장
				studentScore.setKor(rset.getInt(3)); // 국어 점수 저장
				studentScore.setEng(rset.getInt(4)); // 영어 점수 저장
				studentScore.setMat(rset.getInt(5)); // 수학 점수 저장
				studentScore.setSum(rset.getInt(6)); // 합계 저장
				studentScore.setAvg(rset.getDouble(7)); // 평균 저장
				studentScore.setRank(rset.getInt(8)); // 등수 저장
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace(); // 에러 프린트
			return null;
		}
		return studentScore; // studentScore 리턴
	}

	@Override
	public List<StudentScore> selectAll(int page, int countPerPage) { // 전체 조회 (페이지네이션)
		List<StudentScore> studentScores = new ArrayList<>(); // StudentScore 객체 리스트 생성, 값 출력해서 넣는 용도

		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결																													
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select *, b.kor + b.eng + b.mat, (b.kor + b.eng + b.mat) / 3,"
					+ "(select count(*) + 1 from examtable as a where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat)) from examtable as b "
					+ "LIMIT " + ((page - 1) * countPerPage) + "," + countPerPage + ";"); // 지정

			while (rset.next()) { // rset 돌면서 루프
				StudentScore studentScore = new StudentScore(); // StudentScore 객체 생성
				studentScore.setName(rset.getString(1)); // 이름 저장
				studentScore.setStudentid(rset.getString(2)); // 학번 저장
				studentScore.setKor(rset.getInt(3)); // 국어 점수 저장
				studentScore.setEng(rset.getInt(4)); // 영어 점수 저장
				studentScore.setMat(rset.getInt(5)); // 수학 점수 저장
				studentScore.setSum(rset.getInt(6)); // 합계 저장
				studentScore.setAvg(rset.getDouble(7)); // 평균 저장
				studentScore.setRank(rset.getInt(8)); // 등수 저장

				studentScores.add(studentScore); // StudentScore 객체를 리스트에 추가
			}
			rset.close(); // 객체 닫고 반환하여 자원 소모 방지
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace(); // 에러 프린트
			return null;
		}
		return studentScores; // studentScore 리턴
	}

	@Override
	public StudentScore update(String studentid, StudentScore studentScore) { // 데이터 수정
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			String updateQuery = "UPDATE examtable SET name = '" + studentScore.getName() + "', kor = "
					+ studentScore.getKor() + ", eng = " + studentScore.getEng() + ", mat = " + studentScore.getMat()
					+ " WHERE studentid = " + studentid; // 해당 학생 정보 업데이트 쿼리
			stmt.executeUpdate(updateQuery); // 쿼리 실행

			String Query = "select studentid from examtable where studentid = " + studentid; // 학번으로 조회
			ResultSet rset = stmt.executeQuery(Query); // 쿼리 실행

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace(); // 에러 프린트
			return null;
		}
		return studentScore; // studentScore 리턴
	}

	@Override
	public StudentScore delete(String studentid) { // 데이터 삭제
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			String deleteQuery = "delete from examtable where studentid = " + studentid; // 해당 학생 정보 삭제하는 쿼리
			stmt.executeUpdate(deleteQuery); // 쿼리 실행

			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			e.printStackTrace(); // 에러 프린트
			return null;
		}
		return null; // null 리턴
	}

	@Override
	public String createTable() { // 테이블 생성
		try { // try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결																										
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			stmt.execute("create table examtable(" // examtable 테이블 생성
					+ "name varchar(20)," // 문자열 이름 필드 생성
					+ "studentid varchar(20) not null primary key," // 정수형 학번 필드 생성 및 not null, primary key 속성 부여
					+ "kor int," // 정수형 국어 점수 필드 생성
					+ "eng int," // 정수형 영어 점수 필드 생성
					+ "mat int) DEFAULT CHARSET=utf8"); // 정수형 수학 점수 필드 생성 및 인코딩 설정
			
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			return e.toString(); // 에러 프린트
		}
		return "테이블 생성 완료"; // 생성 완료 메세지 리턴
	}

	@Override
	public String dropTable() { // 테이블 삭제
		try { // try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			stmt.execute("drop table examtable;"); // examtable 테이블 삭제 명령 실행
			
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			return e.toString(); // 에러 프린트
		}
		return "테이블 삭제 완료"; // 삭제 완료 메세지 리턴
	}

	@Override
	public String insertAll(int last) { // 랜덤 데이터 삽입
		try { // try문 시작
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결																														// 연결
			Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			String name; // 변수 선언
			String studentid; // 변수 선언
			int cnt = 0; // 변수 선언 및 초기화

			stmt.executeUpdate("DELETE FROM examtable WHERE studentid > 0"); // studentid가 0보다 큰 데이터가 있으면 삭제

			while (true) { // 루프
				cnt++; // cnt 1씩 증가
				name = "홍길" + cnt; // 이름은 홍길 뒤에 번호 하나씩 증가하면서 저장
				studentid = String.valueOf(209900 + cnt); // 학번도 

				stmt.executeUpdate("INSERT INTO examtable (name, studentid, kor, eng, mat) VALUES ('" + name + "', "
						+ studentid + ", RAND()*100, RAND()*100, RAND()*100)"); // 데이터 랜덤 생성하여 삽입

				if (cnt == last) { // 인자와 cnt가 같아지면
					break; // 루프 종료
				}
			}
			stmt.close(); // 객체 닫고 반환하여 자원 소모 방지
			conn.close(); // 객체 닫고 반환하여 자원 소모 방지
		} catch (Exception e) {
			return e.toString(); // 에러 프린트
		}
		return "데이터 삽입 완료"; // 삽입 완료 메세지 리턴
	}

	@Override
	public int currentPage(String studentid, int countPerPage) { // 현재 페이지 구하기
		int cnt = 0; // 변수 선언 및 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34", "root", "kopo34"); // DB 연결																														

			java.sql.Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

			ResultSet rset = stmt.executeQuery("select * from examtable order by studentid"); // 학번 기준 정렬하여 전체 조회

			while (rset.next()) { // rset 돌면서 루프
				cnt++; // cnt 1씩 증가
				if (studentid.equals(rset.getString(2))) { // 조회한 학번이랑 학번이 같으면
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
