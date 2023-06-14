package domain;

public class Gongji {
	public int id; // 변수 선언
	public String title; // 변수 선언
	public String date; // 변수 선언
	public String content; // 변수 선언

	public int getId() { // id 불러오는 메소드
		return id; // id 리턴
	}

	public void setId(int id) { // id 저장하는 메소드
		this.id = id; // id 저장
	}

	public String getTitle() { // title 불러오는 메소드
		return title; // title 리턴
	}

	public void setTitle(String title) { // title 저장하는 메소드
		this.title = title; // title 저장
	}

	public String getDate() { // date 불러오는 메소드
		return date; // date 리턴
	}

	public void setDate(String date) { // date 저장하는 메소드
		this.date = date; // date 저장
	}

	public String getContent() { // content 불러오는 메소드
		return content; // content 리턴
	}

	public void setContent(String content) { // content 저장하는 메소드
		this.content = content; // content 저장
	}

}
