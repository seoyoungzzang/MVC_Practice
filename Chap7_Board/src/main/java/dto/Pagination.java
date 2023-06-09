package dto;

public class Pagination {
	private int c; // 현재 페이지
	private int s; // 페이지그룹 시작 페이지
	private int e; // 페이지그룹 마지막 페이지
	private int p; // 페이지그룹 앞으로 가기
	private int pp; // 1페이지로 가기
	private int n; // 페이지그룹 뒤로 가기
	private int nn; // 페이지그룹 맨 뒤로 가기

	public int getC() { // 현재 페이지 불러오는 메소드
		return c; // 현재 페이지 리턴
	}

	public void setC(int c) { // 현재 페이지 저장하는 메소드
		this.c = c; // 현재 페이지 저장
	}

	public int getS() { // 페이지그룹 시작 페이지 불러오는 메소드
		return s; // 페이지그룹 시작 페이지 리턴
	}

	public void setS(int s) { // 페이지그룹 시작 페이지 저장하는 메소드
		this.s = s; // 페이지그룹 시작 페이지 저장
	}

	public int getE() { // 페이지그룹 마지막 페이지 불러오는 메소드
		return e; // 페이지그룹 마지막 페이지 리턴
	}

	public void setE(int e) { // 페이지그룹 마지막 페이지 저장하는 메소드
		this.e = e; // 페이지그룹 마지막 페이지 저장
	}

	public int getP() { // 페이지그룹 앞으로 가기 불러오는 메소드
		return p; // 페이지그룹 앞으로 가기 리턴
	}

	public void setP(int p) { // 페이지그룹 앞으로 가기 저장하는 메소드
		this.p = p; // 페이지그룹 앞으로 가기 저장
	}

	public int getPp() { // 1번 페이지로 가기 불러오는 메소드
		return pp; // 1번 페이지로 가기 리턴
	}

	public void setPp(int pp) { // 1번 페이지로 가기 저장하는 메소드
		this.pp = pp; // 1번 페이지로 가기 저장
	}

	public int getN() { // 페이지그룹 뒤로 가기 불러오는 메소드
		return n; // 페이지그룹 뒤로 가기 리턴
	}

	public void setN(int n) { // 페이지그룹 뒤로 가기 저장하는 메소드
		this.n = n; // 페이지그룹 뒤로 가기 저장
	}

	public int getNn() { //마지막 페이지로 가기 불러오는 메소드
		return nn; // 마지막 페이지로 가기 리턴
	}

	public void setNn(int nn) { // 마지막 페이지로 가기 저장하는 메소드
		this.nn = nn; // 마지막 페이지로 가기 저장
	}

}
