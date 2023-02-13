package com.spring.learn.view;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.learn.admin.AdminRevenueDatailVO;
import com.spring.learn.admin.AdminService;
import com.spring.learn.admin.JoinerVO;
import com.spring.learn.admin.RevenueVO;
import com.spring.learn.common.PagingSK;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.resume.ResumeVO;
import com.spring.learn.user.ChatService;
import com.spring.learn.user.ChatVO;
import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;

// @RequestMapping 클래스 선언부 사용시
// 모든 메소드 요청경로의 부모(root) 경로로 추가됨
@RequestMapping({"/admin", "/Admin"})
@Controller
public class adminController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private JavaMailSender sender;
	
	
	@RequestMapping("/chatGoAdmin.do") // 4.3버전 부터 사용가능
	 public String chatGoAdmin(UserVO vo, Model model){
		 System.out.println(">>> chatGoAdmin 처리임");
		 System.out.println("vo : " + vo);
		 
		 List<ChatVO> contentRoomList = chatService.getContentRoomList(); // 채팅방 조회하기
		 model.addAttribute("contentRoomList", contentRoomList);
		 
		 //실시간 상담 게시판 불러와서 리스트로 나열하기.
		 // 채팅 방 입장할때 select해서 컨텐트내용 가져와서 출력할 준비도 해야 합니다. ㅇㅋ? 잘 됬으면 좋겠네요
		 
		 return "/Admin/chatGoAdmin.jsp";
	 }
		
	// 채팅방 입장
	@RequestMapping("/chatTest2.do")
	public String view_chat(UserVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		System.out.println("채팅방 입장하니?");
		System.out.println("vo : " + vo);
		UserVO vo2 = userService.confirmUser(vo);
		ChatVO ch = chatService.CheckList(vo);
		System.out.println("vo2 : " + vo2);
		System.out.println("ch : " + ch);
		if(vo2.getGrade().equals("관리자")) {
			List<ChatVO> contentList = chatService.getContentList(ch); // 조회하고
			System.out.println(contentList);
			model.addAttribute("contentList", contentList); // 값 저장하고
			return "chatTest2.jsp";
		} else {
			if(ch == null) {
				chatService.insertChatList(vo2);
			}
			else {
				List<ChatVO> contentList = chatService.getContentList(ch); // 조회하고
				model.addAttribute("contentList", contentList);
				System.out.println(contentList);
				return "chatTest2.jsp";
			}
		}
		// 채팅방 입장할때 기존에 만들어 져있는 채팅방없으면 채팅방 하나 insert하면서 들어가기
		// 기존에 만들어져 있는 채팅방 없으면 기존에 대화 내용 불러오기 ㅇㅋ? 가능하겟니...
		return "chatTest2.jsp";
	}
	
	@RequestMapping("/updateContent.do")
	@ResponseBody
	public String updateContent(ChatVO vo, UserVO vo2) {
		System.out.println("아이디 체크 요청이 들어옴!");
		System.out.println("vo : " + vo);
		
		System.out.println("vo2 : " + vo2);
		vo.setChatNo(chatService.CheckList(vo2).getChatNo());//채팅방이 있는지 확인하고 채팅방의 번호를 가져오기
		chatService.insetChatContent(vo);
		vo2.setUserId(vo.getSendId());
		UserVO vo3 = userService.confirmUser(vo2);
		System.out.println("vo3 : " + vo3);
		if(vo3.getGrade().equals("관리자")) {
			chatService.updateChatList1(vo);
		} else {
			chatService.updateChatList0(vo);
		}
		
		return "성공";
	}
	
	//sk controller 수정 부분
	@RequestMapping("/adminIndex.do")
	public String goAdminMain(Model model) {
		List<String> bestTeachers = adminService.getBestTeacher();
		List<LectureVO> newWeeklyLectures = adminService.getNewWeeklyLectures();

		Map<String, String> map1 =  new HashMap<>();
		Map<String, String> map2 =  new HashMap<>();

		PagingSK pResume = paging("resume", null, null, null);
		map1.put("begin", String.valueOf(pResume.getBegin()));
		map1.put("end", String.valueOf(pResume.getEnd()));
		List<ResumeVO> resumes = adminService.getResumes(map1);
		
		PagingSK pCallcenter = paging("callcenter", null, null, null);
		map2.put("begin", String.valueOf(pCallcenter.getBegin()));
		map2.put("end", String.valueOf(pCallcenter.getEnd()));
		List<MemberBoardVO> callcenters = adminService.getCallcenters(map2);
		
		System.out.println("resumes:" + resumes);
		System.out.println("callcenters:" + callcenters);
		
		//최다 강의 건수 판매자 
		model.addAttribute("bestTeachers", bestTeachers);
		//신규 강의
		model.addAttribute("newWeeklyLectures", newWeeklyLectures);
		//미승인 지식공유자 신청
		model.addAttribute("resumes", resumes);		
		model.addAttribute("pr", pResume);
		//콜센터
		model.addAttribute("callcenters", callcenters);
		model.addAttribute("pc", pCallcenter);
		
		return "/Admin/adminIndex.jsp";
		
	}
	
	@ResponseBody
	@RequestMapping("/getInfos.do")
	public List<Map<String, Integer>> getInfos (Model model) {		
		List<Map<String, Integer>> info = new ArrayList<>();	

		Map<String, Integer> revenue = new HashMap<String, Integer>();	
		Map<String, Integer> joiner = new HashMap<String, Integer>();	
		
		//매출 계산
		Map<String, String> map = new HashMap<String, String>();	
		
		for (int i = 0; i <= 1; i++) {
			if (i == 0) {
				map.put("onoff", "0");
				revenue.put("thisMonthOnRevenue", (int)(adminService.getRevenueThisMonth(map)*0.15));
			} else {
				map.put("onoff", "1");
				revenue.put("thisMonthOffRevenue", (int)(adminService.getRevenueThisMonth(map)*0.15));
			}
		}
		info.add(revenue);
		
		//가입자 계산
		for (int i = 0; i <= 2; i++) {
			if (i == 0) {
				joiner.put("thisMonthGeneralJoiner", adminService.getNewUserforThisMonth(map));
			} else if (i == 1) {
				map.put("socialType", "naver");
				joiner.put("thisMonthNaverJoiner", adminService.getNewUserforThisMonth(map));
			} else {
				map.put("socialType", "google");
				joiner.put("thisMonthGoogleJoiner", adminService.getNewUserforThisMonth(map));
			}
		}
		info.add(joiner);
		
		System.out.println(info);
		
		return info;
		
	}
	
	
	@RequestMapping("/adminRevenue.do")
	public String goAdminRevenue(Model model) {	
		Map<String, String> map = new HashMap<String, String>();
		
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
		String date = format1.format(new Date());
		PagingSK p =  paging("revenue", null, date, null);
		
		map.put("begin", String.valueOf(p.getBegin()));
		map.put("end", String.valueOf(p.getEnd()));
		
		List<AdminRevenueDatailVO> orderList = adminService.getRevenueDetail(map);
		
		for (AdminRevenueDatailVO vo : orderList) {
			vo.setCommission();
		}
		model.addAttribute("orderList", orderList);
		model.addAttribute("p", p);
		
		System.out.println(orderList);
		return "/Admin/adminRevenue.jsp";
	}

	@ResponseBody
	@RequestMapping("/getRevenues.do")
	public List<RevenueVO> getRevenue() {	
		Map<String, String> map = new HashMap<String, String>();	

		//오늘
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
		String today = format1.format(new Date());
		//System.out.println("today: " + today);

		//6개월 전
		Calendar cal = Calendar.getInstance();
		//System.out.println(cal.get(Calendar.MONTH));
		cal.add(Calendar.MONTH, -5);
		//System.out.println("6개월 전: " + new java.text.SimpleDateFormat("yyyyMMdd").format(cal.getTime()));
		
		map.put("startDate", new java.text.SimpleDateFormat("yyyyMMdd").format(cal.getTime()));
		map.put("endDate", today);
		
		List<RevenueVO> list = adminService.getRevenueEachMonth(map);
		System.out.println(list);
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/getRevenueFiltering.do")
	public Map<String, Object> getAjaxRevenue(@RequestBody Map<String, String> find) {
		Map<String, Object> data = new HashMap<String, Object>();
		
		//오늘
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
		String date = format1.format(new Date());
		
		//6개월전
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -5);
		
		Map<String, String> map = new HashMap<String, String>();
		
		System.out.println(find.get("startDate"));
		System.out.println(find.get("endDate"));
	
		//리스트 출력
		PagingSK p =  new PagingSK();
		if (find.get("startDate") != "" && find.get("endDate") != "") {
			p = paging("revenue", find.get("startDate"), find.get("endDate"), find.get("page"));
			map.put("startDate", find.get("startDate"));
			map.put("endDate", find.get("endDate"));
		} else {
			p = paging("revenue", null, date, find.get("page"));
			map.put("startDate", new java.text.SimpleDateFormat("yyyyMMdd").format(cal.getTime()));
			map.put("endDate", date);
		}
		
		//통계 데이터 조회
		if ("byMonth".equals(find.get("filter")) || null == find.get("filter")) {
			List<RevenueVO> list = adminService.getRevenueEachMonth(map);
			data.put("list", list);			
		} else if ("byWeek".equals(find.get("filter"))) {
			List<RevenueVO> list = adminService.getRevenueEachWeekly(map);
			data.put("list", list);						
		} else {
			List<RevenueVO> list = adminService.getRevenueEachDaily(map);
			data.put("list", list);			
		}
		
		
		map.put("begin", String.valueOf(p.getBegin()));
		map.put("end", String.valueOf(p.getEnd()));
		
		List<AdminRevenueDatailVO> orderList = adminService.getRevenueDetail(map);
		
		for (AdminRevenueDatailVO vo : orderList) {
			vo.setCommission();
		}
		
		data.put("orderList", orderList);
		data.put("p", p);
		return data;
	};
	
	
	@RequestMapping("/getRevenueExcel.do")
	public void getRevenueExcel(@RequestParam String startDate, @RequestParam String endDate, HttpServletResponse response) throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		System.out.println(startDate + "," + endDate);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		List<AdminRevenueDatailVO> list = adminService.getRevenueTotalInfo(map);
		for (AdminRevenueDatailVO vo : list) {
			vo.setCommission();
		}
		
		System.out.println("getRevenueExcel 실행");
		System.out.println(list);
		System.out.println(list.size());
		
		Workbook workbook = new XSSFWorkbook();
		
        CellStyle numberCellStyle = workbook.createCellStyle();
        numberCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
        Sheet sheet = workbook.createSheet("아웃풋런 매출 통계");
        
        //파일명
        final String fileName = "아웃풋런 매출 통계";

        //헤더
        final String[] header = {"주문번호", "구매자", "강의명", "강의자", "온/오프", "주문일", "결제가", "수수료"};
        Row row = sheet.createRow(0);
        for (int i = 0; i < header.length; i++) {
            Cell cell = row.createCell(i);
            cell.setCellValue(header[i]);
        }
        
        //바디
        int rnum = 1;
	    for (AdminRevenueDatailVO detail : list) {
	    	row = sheet.createRow(rnum++);  //헤더 이후로 데이터가 출력되어야하니 +1
	    	
            Cell cell = null;        
	        row.createCell(0).setCellValue(detail.getOrderNo());
	        row.createCell(1).setCellValue(detail.getBuyer());
	        row.createCell(2).setCellValue(detail.getLectureTitle());
	        row.createCell(3).setCellValue(detail.getTeacher());
	        row.createCell(4).setCellValue(detail.getLectureOnOff());
	        row.createCell(5).setCellValue(detail.getOrderRegdate());
	        row.createCell(6).setCellStyle(numberCellStyle);
	        row.createCell(6).setCellValue(detail.getLecturePrice());
	        row.createCell(7).setCellStyle(numberCellStyle);
	        row.createCell(7).setCellValue(detail.getCommission());
	    }
	
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode(fileName, "UTF-8")+".xlsx");
        //파일명은 URLEncoder로 감싸주는게 좋다!

        workbook.write(response.getOutputStream());
        //workbook.close(); java8부터는 자동으로 안전하게 닫아 줌
		
	}
	
	@ResponseBody
	@RequestMapping("/getJoiner.do")
	public List<JoinerVO> getJoiner (@RequestBody Map<String, String> find, Model model) {	
		Map<String, String> map = new HashMap<String, String>();	
		
		System.out.println(find.get("startDate"));
		System.out.println(find.get("endDate"));
		
		List<JoinerVO> list = new ArrayList<JoinerVO>();
		
		if (find.get("startDate") != null && find.get("endDate") != null) {
			map.put("startDate", find.get("startDate"));
			map.put("endDate", find.get("endDate"));
			list = adminService.getJoinerEachMonth(map);
		} else {			
			//오늘
			SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
			String today = format1.format(new Date());
			//System.out.println("today: " + today);
			
			//6개월 전
			Calendar cal = Calendar.getInstance();
			//System.out.println(cal.get(Calendar.MONTH));
			cal.add(Calendar.MONTH, -5);
			//System.out.println("6개월 전: " + new java.text.SimpleDateFormat("yyyyMMdd").format(cal.getTime()));
			map.put("startDate", new java.text.SimpleDateFormat("yyyyMMdd").format(cal.getTime()));
			map.put("endDate", today);
			list = adminService.getJoinerEachMonth(map);
		}
		System.out.println("map: " + map);
		System.out.println(list);
		return list;
	}
	
	
	@ResponseBody
	@RequestMapping("/getUsers")
	public List<UserVO> getUsers(@RequestBody Map<String, String> find) {
		System.out.println(find);
		
		List<UserVO> list = adminService.getUsers(find);
		System.out.println(list);
		return list;
	}
	
	/*@RequestMapping("mailImgUpload.do")
	@ResponseBody
	public String uploadMailImageFile(@RequestParam("file") MultipartFile file) throws IOException {
        
		System.out.println("uploadFile.isEmpty() : " + file.isEmpty());
        String fileName = file.getOriginalFilename(); //원본파일명
        System.out.println("::: 원본파일명 : " + fileName);

        String savedFileName = UUID.randomUUID().toString();
        System.out.println("::: 저장파일명 : " + savedFileName);

        //물리적 파일 복사
        String url = "\\\\192.168.18.11\\temp\\" + savedFileName;
        file.transferTo(new File(url));

        return savedFileName;
	}*/
	
	
	@RequestMapping("/sendMail.do")
	public String sendMail(HttpServletRequest request) throws MessagingException {
	    String title = request.getParameter("title");
	    String[] receiver = request.getParameterValues("receiver");
	    String html = request.getParameter("editordata");

	    System.out.println(title);
	    System.out.println(receiver.length);
	    System.out.println(receiver[0]);
	    System.out.println(html);
	 
	    MimeMessage message = sender.createMimeMessage();
	    message.setSubject(title);
	    InternetAddress[] receiverArr = new InternetAddress[receiver.length];
	    for (int i = 0; i < receiverArr.length; i++) {
	        receiverArr[i] = new InternetAddress(receiver[i]);
	    }
	    message.addRecipients(RecipientType.TO, receiverArr);
	    System.out.println(receiverArr);

	    message.setText(html, "UTF-8", "html");		
	    sender.send(message);

	    return "/Admin/adminIndex.jsp";
	}
	
	@ResponseBody
	@RequestMapping("/adminPaginging.do")
	public Map<String, Object>getAdminMainFiltering (@RequestBody Map<String, String> find) {
		
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();

		PagingSK p = paging(find.get("type"), null, null, find.get("page"));
		data.put("p", p);
		
		map.put("begin", String.valueOf(p.getBegin()));
		map.put("end", String.valueOf(p.getEnd()));
		
		if ("resume".contentEquals(find.get("type"))) {
			List<ResumeVO> list = adminService.getResumes(map);			
			data.put("list", list);
		} else {
			List<MemberBoardVO> list = adminService.getCallcenters(map);
			data.put("list", list);
		}
		return data;
	}
	
	public PagingSK paging (String type, String startDate, String endDate, String page) {
		
		PagingSK p =  new PagingSK();
		p.setNumPerPage(5);
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		if ("revenue".equals(type)) {
			p.setTotalRecord(adminService.getRevenueTotal(map));							
		} else if ("resume".equals(type)) {
			p.setTotalRecord(adminService.getResumeTotal());
		} else {
			//callcenter
			p.setTotalRecord(adminService.getCallcenterTotal());
		}
		p.setTotalPage();
		
		if (page != null && page != "") {
			if (Integer.valueOf(page) > p.getTotalPage()) {
				p.setNowPage(p.getTotalPage());
			} else {				
				p.setNowPage(Integer.valueOf(page));
			}
		}
		
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		
		if (p.getEnd() > p.getTotalRecord()) {
			p.setEnd(p.getTotalRecord());
		}
		
		int nowPage = p.getNowPage();
		int beginPage = (nowPage - 1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
		
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
		
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
		}
		
		return p;
		
	}
	//sk controller 수정 끝
	
	//카테 고리별 정령
	@RequestMapping("/chatSearchAdmin.do")
	@ResponseBody
	public List<ChatVO> chatSearchAdmin(ChatVO vo) {
		System.out.println("카테고리 정렬 요청이 들어옴!");
		System.out.println("vo : " + vo);
		List<ChatVO> contentRoomList = new ArrayList<ChatVO>(); 
		if (vo.getSearchStatus().equals("미응답")) {
			if(vo.getSearchOrder().equalsIgnoreCase("chat_no")) {
				contentRoomList = chatService.getContentRoomList(); // 채팅방 조회하기				
			} else {
				contentRoomList = chatService.getRegRoomList(); // 채팅방 조회하기 <<<<이부분먼저
			}
		} else if(vo.getSearchStatus().equals("응답")){
			if(vo.getSearchOrder().equalsIgnoreCase("chat_no")) {
				contentRoomList = chatService.getReversRoomList(); // 채팅방 조회하기				
			} else {
				contentRoomList = chatService.getReversRegRoomList(); // 채팅방 조회하기 <<<<이부분먼저
			}
		}
		System.out.println("보내기전 contrntRoomList" + contentRoomList);
		
		return contentRoomList;
	}
}
