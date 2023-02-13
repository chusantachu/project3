package com.spring.learn.board;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	NoticeVO getNotice(NoticeVO vo); //1개 데이터 조회
	void deleteNotice(NoticeVO vo); 
	void insertNotice(NoticeVO vo); 
	void updateNotice(NoticeVO vo);
	int lastNo();
	
//	List<NoticeVO> getNoticeList(NoticeVO vo); //전체 데이터 조회
//	void updateNoticeHit(NoticeVO vo); //공지사항 조회수 업데이트
//	List<NoticeVO> list(Criteria cri);//게시글 목록 조회
//	int listCount();//게시글 총 갯수
//	
//	int searchListCount(NoticeVO vo); //검색어에 해당하는 게시글 총 갯수
	
	List<NoticeVO> getBoardList(Map<String, String> map); // 전체글 조회
	int countBoard(NoticeVO vo);// 게시글 수 조회
	List<NoticeVO> latestInfo();
	
}
