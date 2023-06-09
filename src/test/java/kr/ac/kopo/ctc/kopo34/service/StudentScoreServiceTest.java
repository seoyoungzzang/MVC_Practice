package kr.ac.kopo.ctc.kopo34.service;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import kr.ac.kopo.ctc.kopo34.dto.Pagination;

class StudentScoreServiceTest {

	@Test
	void test_50_1() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(1, 50);

		assertEquals(pagination.getC(), 1);
		assertEquals(pagination.getS(), 1);
		assertEquals(pagination.getE(), 10);
		assertEquals(pagination.getP(), -1);
		assertEquals(pagination.getPp(), -1);
		assertEquals(pagination.getN(), 11);
		assertEquals(pagination.getNn(), 23);
	}

	@Test
	void test_50_2() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(0, 50);

		assertEquals(pagination.getC(), 1);
		assertEquals(pagination.getS(), 1);
		assertEquals(pagination.getE(), 10);
		assertEquals(pagination.getP(), -1);
		assertEquals(pagination.getPp(), -1);
		assertEquals(pagination.getN(), 11);
		assertEquals(pagination.getNn(), 23);
	}

	@Test
	void test_50_3() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(-100, 50);

		assertEquals(pagination.getC(), 1);
		assertEquals(pagination.getS(), 1);
		assertEquals(pagination.getE(), 10);
		assertEquals(pagination.getP(), -1);
		assertEquals(pagination.getPp(), -1);
		assertEquals(pagination.getN(), 11);
		assertEquals(pagination.getNn(), 23);
	}

	@Test
	void test_50_4() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(5, 50);

		assertEquals(pagination.getC(), 5);
		assertEquals(pagination.getS(), 1);
		assertEquals(pagination.getE(), 10);
		assertEquals(pagination.getP(), -1);
		assertEquals(pagination.getPp(), -1);
		assertEquals(pagination.getN(), 11);
		assertEquals(pagination.getNn(), 23);
	}

	@Test
	void test_50_5() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(10, 50);

		assertEquals(pagination.getC(), 10);
		assertEquals(pagination.getS(), 1);
		assertEquals(pagination.getE(), 10);
		assertEquals(pagination.getP(), -1);
		assertEquals(pagination.getPp(), -1);
		assertEquals(pagination.getN(), 11);
		assertEquals(pagination.getNn(), 23);
	}

	@Test
	void test_50_6() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(11, 50);

		assertEquals(pagination.getC(), 11);
		assertEquals(pagination.getS(), 11);
		assertEquals(pagination.getE(), 20);
		assertEquals(pagination.getP(), 1);
		assertEquals(pagination.getPp(), 1);
		assertEquals(pagination.getN(), 21);
		assertEquals(pagination.getNn(), 23);
	}

	@Test
	void test_50_7() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(15, 50);

		assertEquals(pagination.getC(), 15);
		assertEquals(pagination.getS(), 11);
		assertEquals(pagination.getE(), 20);
		assertEquals(pagination.getP(), 1);
		assertEquals(pagination.getPp(), 1);
		assertEquals(pagination.getN(), 21);
		assertEquals(pagination.getNn(), 23);
	}

	@Test
	void test_50_8() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(20, 50);

		assertEquals(pagination.getC(), 20);
		assertEquals(pagination.getS(), 11);
		assertEquals(pagination.getE(), 20);
		assertEquals(pagination.getP(), 1);
		assertEquals(pagination.getPp(), 1);
		assertEquals(pagination.getN(), 21);
		assertEquals(pagination.getNn(), 23);
	}

	@Test
	void test_50_9() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(21, 50);

		assertEquals(pagination.getC(), 21);
		assertEquals(pagination.getS(), 21);
		assertEquals(pagination.getE(), 23);
		assertEquals(pagination.getP(), 11);
		assertEquals(pagination.getPp(), 1);
		assertEquals(pagination.getN(), -1);
		assertEquals(pagination.getNn(), -1);
	}

	@Test
	void test_50_10() {
//		fail("Not yet implemented");

		StudentScoreService studentScoreService = new StudentScoreServiceImpl();

		Pagination pagination = studentScoreService.getPagination(25, 50);

		assertEquals(pagination.getC(), 25);
		assertEquals(pagination.getS(), 21);
		assertEquals(pagination.getE(), 23);
		assertEquals(pagination.getP(), 11);
		assertEquals(pagination.getPp(), 1);
		assertEquals(pagination.getN(), -1);
		assertEquals(pagination.getNn(), -1);
	}

}
