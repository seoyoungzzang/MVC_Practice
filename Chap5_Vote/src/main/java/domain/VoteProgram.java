package domain;

public class VoteProgram {
	public int id; // 변수 선언 
	public String name; // 변수 선언
	public int age; // 변수 선언
	public int count; // 변수 선언

	public int getId() { // id 불러오는 메소드
		return id; // id 리턴
	}

	public void setId(int id) { // id 저장하는 메소드
		this.id = id; // id 저장
	}

	public String getName() { // name 불러오는 메소드
		return name; // name 리턴
	}

	public void setName(String name) { // name 저장하는 메소드
		this.name = name; // name 저장
	}

	public int getAge() { // age 불러오는 메소드
		return age; // age 리턴
	}

	public void setAge(int age) { // age 저장하는 메소드
		this.age = age; // age 저장
	}

	public int getCount() { // count 불러오는 메소드
		return count; // count 리턴
	}

	public void setCount(int count) { // count 저장하는 메소드
		this.count = count; // count 저장
	}

}
