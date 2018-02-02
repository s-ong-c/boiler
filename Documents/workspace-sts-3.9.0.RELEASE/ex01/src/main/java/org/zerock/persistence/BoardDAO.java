package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;

public interface BoardDAO {
	public void create(BoardVO vo)throws Exception; //한 게시글 만들기 
	public BoardVO read(Integer bno)throws Exception;//  bno에 맞게 게시글읽어오기 
	public void update(BoardVO vo)throws Exception; // 글 수정하기
	public void delete(Integer bno)throws Exception; // 인덱스 bno 로 불러와서 글 삭제 하기
	public List<BoardVO> listAll()throws Exception; //모든 게시글목록 보기 .// 메인? 
	public List<BoardVO> listPage(int page)throws Exception;// 페이지 처리 하기 ex 1.2.3.45.6.67.7.8.
	public List<BoardVO> listCriteria(Criteria cri)throws Exception;   // 페이지 넘기기처리 
	public int countPaging(Criteria cri)throws Exception; // total카운트 반환 하기 위해
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri)throws Exception;
	
	public void addAttach(String fullName)throws Exception;
	
	public void updateReplyCnt(Integer bno, int amount)throws Exception;
	public void updateViewCnt(Integer bno)throws Exception;
	
	public List<String> getAttach(Integer bno) throws Exception;

	public void deleteAttach(Integer bno) throws Exception;

	public void replaceAttach(String fullName, Integer bno) throws Exception;
	
	}
