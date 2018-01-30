package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;
import org.zerock.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Inject
	private BoardDAO dao;
	
	@Override
	public void regist(BoardVO board) throws Exception{  //글 만들
		dao.create(board);
	}
	
	@Override
	public BoardVO read(Integer bno) throws Exception{  /// 인덱스 bno) 	 로 글 읽어오기 
		return dao.read(bno);
	}
	@Override
	public void modify(BoardVO board)throws Exception{  // 업데이트 수정 
		dao.update(board);
		
	}
	@Override
	public void remove(Integer bno)throws Exception{   // 인덱스 bno)  글 삭제 
		dao.delete(bno);
		
	}
	@Override
	public List<BoardVO> listAll() throws Exception{    // 모두 읽어오기 
		return dao.listAll();
	}
	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception{
		return dao.listCriteria(cri);
	}
	@Override
	public int listCountCriteria(Criteria cri)throws Exception{
		return dao.countPaging(cri);
	}
	@Override
	public List<BoardVO> listSearchCriteria(SearchCriteria cri)throws Exception{
		return dao.listSearch(cri);
	}
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception{
		
		return dao.listSearchCount(cri);
	}
}
