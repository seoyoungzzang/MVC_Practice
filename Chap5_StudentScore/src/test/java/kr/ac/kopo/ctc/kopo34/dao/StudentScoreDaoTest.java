package kr.ac.kopo.ctc.kopo34.dao;

import java.util.List;

import org.junit.jupiter.api.Test;

import kr.ac.kopo.ctc.kopo34.domain.StudentScore;
import kr.ac.kopo.ctc.kopo34.dto.Pagination;
import kr.ac.kopo.ctc.kopo34.service.StudentScoreService;
import kr.ac.kopo.ctc.kopo34.service.StudentScoreServiceImpl;

class StudentScoreDaoTest {

	@Test
	void test_create() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		StudentScore studentScore = new StudentScore();

		studentScore.setName("세븐틴");
		studentScore.setKor(100);
		studentScore.setEng(100);
		studentScore.setMat(100);

		studentScoreDao.create(studentScore);
	}

	@Test
	void test_selectOne() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		StudentScore studentScore = new StudentScore();
		studentScore = studentScoreDao.selectOne("209901");
		System.out.println(studentScore.getName());
		System.out.println(studentScore.getStudentid());
		System.out.println(studentScore.getKor());
		System.out.println(studentScore.getEng());
		System.out.println(studentScore.getMat());

	}

	@Test
	void test_selectAll() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		StudentScoreService studentScoreService = new StudentScoreServiceImpl();
		Pagination pagination = studentScoreService.getPagination(11, 50);
		List<StudentScore> studentScores = studentScoreDao.selectAll(pagination.getC(), 50);
		System.out.println(studentScores.toString());
	}

	@Test
	void test_update() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		StudentScore studentScore = new StudentScore();
		studentScore.setName("최서영");
		studentScore.setKor(100);
		studentScore.setEng(10);
		studentScore.setMat(100);
		StudentScore updateStudentScore = studentScoreDao.update("209901", studentScore);
		System.out.println(updateStudentScore.getName());
		System.out.println(updateStudentScore.getKor());
		System.out.println(updateStudentScore.getEng());
		System.out.println(updateStudentScore.getMat());
	}

	@Test
	void test_delete() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		StudentScore studentScore = new StudentScore();
		studentScore = studentScoreDao.delete("209902");
	}
}
