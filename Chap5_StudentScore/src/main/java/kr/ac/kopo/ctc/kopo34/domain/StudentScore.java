package kr.ac.kopo.ctc.kopo34.domain;

public class StudentScore {
	private String name; // name 변수 선언
	private String studentid; // student 변수 선언
	private int kor; // kor 변수 선언
	private int eng; // eng 변수 선언
	private int mat; // mat 변수 선언
	private int sum; // sum 변수 선언
	private double avg; // avg 변수 선언
	private int rank; // rank 변수 선언

	public String getName() { // 이름 불러오는 메소드
		return name; // 이름 리턴
	}

	public void setName(String name) { // 이름 저장하는 메소드
		this.name = name; // 이름 저장
	}

	public String getStudentid() { // 학번 불러오는 메소드
		return studentid; // 학번 리턴
	}

	public void setStudentid(String studentid) { // 학번 저장하는 메소드
		this.studentid = studentid; // 학번 저장
	}

	public int getKor() { // 국어 점수 불러오는 메소드
		return kor; // 국어 점수 리턴
	}

	public void setKor(int kor) { // 국어 점수 저장하는 메소드
		this.kor = kor; // 국어 점수 저장
	}

	public int getEng() { // 영어 점수 불러오는 메소드
		return eng; // 영어 점수 리턴
	}

	public void setEng(int eng) { // 영어 점수 저장하는 메소드
		this.eng = eng; // 영어 점수 저장
	}

	public int getMat() { // 수학 점수 불러오는 메소드
		return mat; // 수학 점수 리턴
	}

	public void setMat(int mat) { // 수학 점수 저장하는 메소드
		this.mat = mat; // 수학 점수 저장
	}

	public int getSum() { // 합계 불러오는 메소드
		return sum; // 합계 리턴
	}

	public void setSum(int sum) { // 합계 저장하는 메소드
		this.sum = sum; // 합계 저장
	}

	public double getAvg() { // 평균 불러오는 메소드
		return avg; // 평균 리턴
	}

	public void setAvg(double avg) { // 평균 저장하는 메소드
		this.avg = avg; // 평균 저장
	}

	public int getRank() { // 등수 불러오는 메소드
		return rank; // 등수 리턴
	}

	public void setRank(int rank) { // 등수 저장하는 메소드
		this.rank = rank; // 등수 저장
	}

}
