package com.spring.learn.board.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.board.NoticeService;
import com.spring.learn.board.NoticeVO;

//@Service : @Component 상속확장 어노테이션
//비즈니스 로직 처리 서비스 영역에 사용
@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	@Autowired //타입이 일치하는 객체(인스턴스)주입 (DI)
	private NoticeDAO noticeDao;
	
	public NoticeServiceImpl() {
		System.out.println(">> NoticeServiceImple() 객체 생성");
	}

	@Override
	public NoticeVO getNotice(NoticeVO vo) {
		return noticeDao.getNotice(vo);
	}

	@Override
	public List<NoticeVO> getBoardList(Map<String, String> map) {
		return noticeDao.getBoardList(map);
	}

	@Override
	public int countBoard(NoticeVO vo) {
		return noticeDao.countBoard(vo);
	}

	@Override
	public void deleteNotice(NoticeVO vo) {
		noticeDao.deleteNotice(vo);
	}

	@Override
	public void insertNotice(NoticeVO vo) {
		noticeDao.insertNotice(vo);
	}

	@Override
	public void updateNotice(NoticeVO vo) {
		noticeDao.updateNotice(vo);
	}

	@Override
	public int lastNo() {
		return noticeDao.lastNo();
	}

	@Override
	public List<NoticeVO> latestInfo() {
		return noticeDao.latestInfo();
	}
	
	//@Override
	//public List<NoticeVO> getNoticeList(NoticeVO vo) {
	//	return noticeDao.getNoticeList(vo);
	//}

//	@Override
//	public void updateNoticeHit(NoticeVO vo) {
//		noticeDao.updateNoticeHit(vo);
//	}
//
//	@Override
//	public List<NoticeVO> list(Criteria cri) {
//		return noticeDao.list(cri);
//	}
//
//	@Override
//	public int listCount() {
//		return noticeDao.listCount();
//	}
//
//	@Override
//	public List<NoticeVO> getNoticeList(NoticeVO vo) {
//		return noticeDao.getnoticeList(vo);
//	}
//
//	@Override
//	public int searchListCount(NoticeVO vo) {
//		return noticeDao.searchListCount(vo);
//	}

}