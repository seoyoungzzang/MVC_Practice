package domain;

public class Gongji {
	public int id; // 변수 선언
	public String title; // 변수 선언
	public String date; // 변수 선언
	public String content; // 변수 선언
	public int rootid;
	public int relevel;
	public int recnt;
	public int viewcnt;

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

	public int getRootid() { // rootid 불러오는 메소드
		return rootid; // rootid 리턴
	}

	public void setRootid(int rootid) { // rootid 저장하는 메소드
		this.rootid = rootid; // rootid 저장
	}

	public int getRelevel() { // relevel 불러오는 메소드
		return relevel; // relevel 리턴
	}

	public void setRelevel(int relevel) { // relevel 저장하는 메소드
		this.relevel = relevel; // relevel 저장
	}

	public int getRecnt() { // recnt 불러오는 메소드
		return recnt; // recnt 리턴
	}

	public void setRecnt(int recnt) { // recnt 저장하는 메소드
		this.recnt = recnt; // recnt 저장
	}

	public int getViewcnt() { // viewcnt 불러오는 메소드
		return viewcnt; // viewcnt 리턴
	}

	public void setViewcnt(int viewcnt) { // viewcnt 저장하는 메소드
		this.viewcnt = viewcnt; // viewcnt 저장
	}

}
