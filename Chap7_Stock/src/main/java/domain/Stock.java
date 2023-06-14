package domain;

public class Stock {
	public int rowid; // 변수 선언
	public String id; // 변수 선언
	public String name; // 변수 선언
	public int stockNum; // 변수 선언
	public String regDate; // 변수 선언
	public String stockDate; // 변수 선언
	public String content; // 변수 선언
	public String image; // 변수 선언

	public int getRowid() { // rowid 불러오는 메소드
		return rowid; // rowid 리턴
	}

	public void setRowid(int rowid) { // rowid 저장하는 메소드
		this.rowid = rowid; // rowid 저장
	}

	public String getId() { // id 불러오는 메소드
		return id; // id 리턴
	}

	public void setId(String id) { // id 저장하는 메소드
		this.id = id; // id 저장
	}

	public String getName() { // name 불러오는 메소드
		return name; // name 리턴
	}

	public void setName(String name) { // name 저장하는 메소드
		this.name = name; // name 저장
	}

	public int getStockNum() { // stockNum 불러오는 메소드
		return stockNum; // stockNum 리턴
	}

	public void setStockNum(int stockNum) { // stockNum 저장하는 메소드
		this.stockNum = stockNum; // stockNum 저장
	}

	public String getRegDate() { // regDate 불러오는 메소드
		return regDate; // regDate 리턴
	}

	public void setRegDate(String regDate) { // regDate 저장하는 메소드
		this.regDate = regDate; // regDate 저장
	}

	public String getStockDate() { // stockDate 불러오는 메소드
		return stockDate; // stockDate 리턴
	}

	public void setStockDate(String stockDate) { // stockDate 저장하는 메소드
		this.stockDate = stockDate; // stockDate 저장
	}

	public String getContent() { // content 불러오는 메소드
		return content; // content 리턴
	}

	public void setContent(String content) { // content 저장하는 메소드
		this.content = content; // content 저장
	}

	public String getImage() { // image 불러오는 메소드
		return image; // image 리턴
	}

	public void setImage(String image) { // image 저장하는 메소드
		this.image = image; // image 저장
	} 

}
