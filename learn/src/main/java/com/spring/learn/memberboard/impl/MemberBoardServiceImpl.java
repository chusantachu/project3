package com.spring.learn.memberboard.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.memberboard.CallcenterCommentVO;
import com.spring.learn.memberboard.MemberBoardService;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.memberboard.OrdersDetailVO;

// UserService
@Service("memberBoardService")
public class MemberBoardServiceImpl implements MemberBoardService {
	
	@Autowired
	private MemberBoardDAO memberBoardDAO;

	public MemberBoardServiceImpl() {
		System.out.println(">> BoardServiceImple ����");
	}

	@Override
	public void insertBoard(MemberBoardVO vo) {
		memberBoardDAO.insertBoard(vo);
	}

	@Override
	public void updateBoard(MemberBoardVO vo) {
		memberBoardDAO.updateBoard(vo);
	}

	@Override
	public void deleteBoard(MemberBoardVO vo) {
		memberBoardDAO.deleteBoard(vo);
	}

	@Override
	public MemberBoardVO getBoard(MemberBoardVO vo) {		
		return memberBoardDAO.getBoard(vo);
	}


	//전체데이터 조회 map
	@Override
	public List<MemberBoardVO> getBoardList(Map<String, String> map) {
		return memberBoardDAO.getBoardListMap(map);
	}
	
	//전체데이터 조회 vo
	@Override
	public List<MemberBoardVO> getBoardList(MemberBoardVO bvo) {
		return memberBoardDAO.getBoardList(bvo);
	}
	
	@Override
	public int countBoard(MemberBoardVO vo) {
		return memberBoardDAO.countBoard(vo);
	}

	@Override
	public void addCallcenterComment(CallcenterCommentVO cvo) {
		memberBoardDAO.addCallcenterComment(cvo);		
	}

	@Override
	public List<CallcenterCommentVO> getCallcenterComment(MemberBoardVO bvo) {
		return memberBoardDAO.getCallcenterComment(bvo);
	}

	@Override
	public void delCallcenterComment(CallcenterCommentVO cvo) {
		memberBoardDAO.delCallcenterComment(cvo);
	}


	@Override
	public List<MemberBoardVO> resolvedCBoardList(MemberBoardVO vo) {
		return memberBoardDAO.resolvedCBoardList(vo);
	}

	@Override
	public List<MemberBoardVO> unResolvedCBoardList(MemberBoardVO vo) {
		return memberBoardDAO.unResolvedCBoardList(vo);
	}

	@Override
	public List<OrdersDetailVO> goMyLectureList(OrdersDetailVO oov) {
		return memberBoardDAO.goMyLectureList(oov);
	}


  
}
