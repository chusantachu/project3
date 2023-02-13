package com.spring.learn.view;

import com.spring.learn.common.PagingJS;
import com.spring.learn.lecture.CategoryVO;
import com.spring.learn.lecture.ClassService;
import com.spring.learn.lecture.ClassVO;
import com.spring.learn.lecture.LectureService;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.lecture.OfftimetableService;
import com.spring.learn.lecture.OfftimetableVO;
import com.spring.learn.roadmap.RoadmapService;
import com.spring.learn.roadmap.RoadmapVO;
import com.spring.learn.user.UserVO;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/Teacher")
public class TeacherController {

    @Autowired
    private LectureService lectureService;

    @Autowired
    private RoadmapService roadmapService;

    @Autowired
    private ClassService classService;

    @Autowired
    private OfftimetableService offtimetableService;

    // 공통: 페이징 처리
    private PagingJS makePaging(String cPage, int totalRecord) {

        PagingJS p = new PagingJS();

        // 1. 전체 게시물 수량 구하기
        p.setTotalRecord(totalRecord);
        p.setTotalPage();

        // 2. 현재 페이지 구하기
        if(cPage != null) {
            p.setNowPage(Integer.parseInt(cPage));
        }

        // 3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
        p.setEnd(p.getNowPage() * p.getNumPerPage());
        p.setBegin(p.getEnd() - p.getNumPerPage() + 1);

        // 3-1.(선택적) 끝번호(end)가 건수보다 많으면 데이터 건수와 동일하게 처리
        if (p.getEnd() > p.getTotalRecord()) {
            p.setEnd(p.getTotalRecord());
        }

        // 4. 블록 시작페이지, 끝페이지 구하기(현재페이지 번호 사용)
        int nowPage = p.getNowPage();
        int beginPage = (nowPage - 1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
        p.setBeginPage(beginPage);
        p.setEndPage(beginPage + p.getNumPerBlock() - 1);

        // 끝페이지(endPage)가 전체 페이지 수(totalPage) 보다 크면
        // 끝페이지를 전체페이지 수로 변경 처리
        if (p.getEndPage() > p.getTotalPage()) {
            p.setEndPage(p.getTotalPage());
        }

        return p;
    }

    // 공통: 이미지 업로드
    @RequestMapping("/uploadImage.do")
    @ResponseBody
    public String uploadImage(@RequestParam("file") MultipartFile uploadFile) throws IOException {

        System.out.println("uploadFile.isEmpty() : " + uploadFile.isEmpty());
        String fileName = uploadFile.getOriginalFilename(); //원본파일명
        System.out.println("::: 원본파일명 : " + fileName);

        String savedFileName = UUID.randomUUID().toString();
        System.out.println("::: 저장파일명 : " + savedFileName);

        //물리적 파일 복사
        String url = "\\\\192.168.18.11\\temp\\" + savedFileName;
        uploadFile.transferTo(new File(url));

        return savedFileName;
    }

    /****************************************************
    * 1. 대시보드
    ****************************************************/

    // 대시보드 화면 이동
    @RequestMapping("/dashboard.do")
    public String dashboard(HttpSession session, Model model,
        @RequestParam(value = "cPage", required = false) String cPage) {
        UserVO user = (UserVO) session.getAttribute("user");
        String userId = user.getUserId();

        // 총 수강생 수
        Integer studentCnt = lectureService.getStudentCount(userId);
        
        // 총 강의 수
        Integer lectureCnt = lectureService.getTeacherLectureCount(userId);

        // 평균 평점
        String lectureRate = String.format("%.2f", lectureService.getLectureAvgRate(userId));

        // 총 수익
        Integer lectureSales = lectureService.getLectureSales(userId);

        // 실시간 수익 현황
        PagingJS p = makePaging(cPage, lectureService.getOrderLectureCount(userId));
        Map<String, String> pmap = new HashMap<>();
        pmap.put("userId", userId);
        pmap.put("begin", Integer.toString(p.getBegin()));
        pmap.put("end", Integer.toString(p.getEnd()));
        List<LectureVO> realtimeSales = lectureService.getRealtimeSales(pmap);

        // 이번달 현황
        model.addAttribute("salesByMonth", lectureService.salesByMonth(userId));

        // 강의별 수익 분포
        model.addAttribute("salesByLecture", lectureService.salesByLecture(userId));

        // 온/오프라인 수익 분포
        model.addAttribute("salesByLine", lectureService.salesByLine(userId));

        Map<String, Integer> map = new HashMap<>();
        map.put("lectureCnt", lectureCnt);
        map.put("studentCnt", studentCnt);
        map.put("lectureSales", lectureSales);
        model.addAttribute("map", map);
        model.addAttribute("lectureRate", lectureRate);
        model.addAttribute("realtimeSales", realtimeSales);
        model.addAttribute("pvo", p);

        return "/Teacher/dashboard.jsp";
    }

    // 실시간 수익 현황 ajax 처리
    @RequestMapping("/getRealtimeSales.do")
    @ResponseBody
    public Map<Object, Object> getRealtimeSales(@RequestParam String cPage, HttpSession session) {

        Map<Object, Object> map = new HashMap<>();

        UserVO user = (UserVO) session.getAttribute("user");
        String userId = user.getUserId();

        PagingJS p = makePaging(cPage, lectureService.getOrderLectureCount(userId));
        Map<String, String> pmap = new HashMap<>();
        pmap.put("userId", userId);
        pmap.put("begin", Integer.toString(p.getBegin()));
        pmap.put("end", Integer.toString(p.getEnd()));

        map.put("pmap", lectureService.getRealtimeSales(pmap));
        map.put("pvo", p);

        return map;
    }

    /****************************************************
     * 2. 강의관리
     ****************************************************/

    // 강의 관리 화면 이동
    @RequestMapping("/lectureManager.do")
    public String lectureManager(@RequestParam(value = "cPage", required = false) String cPage,
        HttpSession session, Model model) {

        UserVO user = (UserVO) session.getAttribute("user");
        String userId = user.getUserId();

        PagingJS p = makePaging(cPage, lectureService.getTeacherLectureCount(userId));

        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("begin", Integer.toString(p.getBegin()));
        map.put("end", Integer.toString(p.getEnd()));

        List<LectureVO> list = lectureService.getTeacherLectureList(map);
        model.addAttribute("lectureList", list);
        model.addAttribute("pvo", p);

        return "/Teacher/lectureManager.jsp";
    }

    // 강의 추가 화면 이동
    @RequestMapping("/lectureWrite.do")
    public String lectureWrite(Model model) {

        // 카테고리 불러오기
        List<CategoryVO> categories = lectureService.getCategories();
        model.addAttribute("categories", categories);

        return "/Teacher/lectureWrite.jsp";
    }

    // 강의 수정 화면 이동
    @RequestMapping("/lectureEdit.do")
    public String lectureEdit(Model model,
        @RequestParam(value = "lectureNo", required = false) String lectureNo) {

        // 카테고리 불러오기
        List<CategoryVO> categories = lectureService.getCategories();
        model.addAttribute("categories", categories);

        // 강의 불러오기
        LectureVO lecture = lectureService.getLecture(lectureNo);
        model.addAttribute("lecture", lecture);

        // 클래스 리스트 불러오기
        List<ClassVO> classList = classService.getClassList(lectureNo);
        model.addAttribute("classList", classList);

        return "/Teacher/lectureEdit.jsp";
    }

    // 강의(Lecture) 수정
    @RequestMapping(value = "/editLecture.do", method = RequestMethod.POST)
    @ResponseBody
    public int editLecture(@ModelAttribute LectureVO lecture) throws IOException, ParseException {

        MultipartFile uploadFile = lecture.getUploadFile();

        if (uploadFile == null) {
            System.out.println("::: uploadFile 파라미터가 전달되지 않았을때~");
        } else if (uploadFile.isEmpty()) {
            System.out.println("::: 전달받은 파일 데이터가 없을 경우");
            String img = lectureService.getLecture(lecture.getLectureNo()).getLectureCoverimg();
            lecture.setLectureCoverimg(img);
        } else {
            System.out.println("uploadFile.isEmpty() : " + uploadFile.isEmpty());
            String fileName = uploadFile.getOriginalFilename(); //원본파일명
            System.out.println("::: 원본파일명 : " + fileName);

            String savedFileName = UUID.randomUUID().toString();
            System.out.println("::: 저장파일명 : " + savedFileName);

            //물리적 파일 복사
            uploadFile.transferTo(new File("\\\\192.168.18.11\\temp\\" + savedFileName));
            lecture.setLectureCoverimg(savedFileName);
        }

        if(!lecture.getQsStartStr().equals("")) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            lecture.setQsStart(format.parse(lecture.getQsStartStr()));
            lecture.setQsEnd(format.parse(lecture.getQsEndStr()));
        }

        System.out.println(lecture);

        lectureService.editLecture(lecture);

        return 1;
    }

    // 강의(Lecture) 추가
    @RequestMapping(value="/addLecture.do", method = RequestMethod.POST)
    @ResponseBody
    public int addLecture(@ModelAttribute LectureVO lecture) throws ParseException, IOException {

        MultipartFile uploadFile = lecture.getUploadFile();

        if (uploadFile == null) {
            System.out.println("::: uploadFile 파라미터가 전달되지 않았을때~");
        } else if (uploadFile.isEmpty()) {
            System.out.println("::: 전달받은 파일 데이터가 없을 경우");
        } else {
            System.out.println("uploadFile.isEmpty() : " + uploadFile.isEmpty());
            String fileName = uploadFile.getOriginalFilename(); //원본파일명
            System.out.println("::: 원본파일명 : " + fileName);

            String savedFileName = UUID.randomUUID().toString();
            System.out.println("::: 저장파일명 : " + savedFileName);

            //물리적 파일 복사
            uploadFile.transferTo(new File("\\\\192.168.18.11\\temp\\" + savedFileName));
            lecture.setLectureCoverimg(savedFileName);
        }

        if(!lecture.getQsStartStr().equals("")) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            lecture.setQsStart(format.parse(lecture.getQsStartStr()));
            lecture.setQsEnd(format.parse(lecture.getQsEndStr()));
        }

        System.out.println(lecture);

        lectureService.addLecture(lecture);
        return lectureService.getLectureNo();
    }

    // 수업(Class) 추가
    @RequestMapping(value="/addClass.do", method = RequestMethod.POST)
    @ResponseBody
    public int addLecture(@ModelAttribute ClassVO classVO) throws IOException {

        System.out.println("classVO: " + classVO);

        MultipartFile uploadBook = classVO.getUploadBook();
        MultipartFile uploadVideo = classVO.getUploadVideo();

        if(uploadBook == null) {
            System.out.println("::: uploadBook 파라미터가 전달되지 않았을때~");
        } else if(uploadBook.isEmpty()) {
            System.out.println("::: 전달받은 uploadBook 파일 데이터가 없을 경우");
        } else {
            String oriname = uploadBook.getOriginalFilename();
            String filename = UUID.randomUUID().toString();
            uploadBook.transferTo(new File("\\\\192.168.18.11\\temp\\" + filename));
            classVO.setOriname(oriname);
            classVO.setFilename(filename);
        }

        if(uploadVideo == null) {
            System.out.println("::: uploadVideo 파라미터가 전달되지 않았을때~");
        } else if(uploadVideo.isEmpty()) {
            System.out.println("::: 전달받은 uploadVideo 파일 데이터가 없을 경우");
        } else {
            String videoname = UUID.randomUUID().toString();
            uploadVideo.transferTo(new File("\\\\192.168.18.11\\temp\\" + videoname));
            classVO.setVideoname(videoname);
        }

        classService.addClass(classVO);

        return 0;
    }

    // 시간표 관리 화면 이동
    @RequestMapping("/timetableManager.do")
    public String timetableManager(@RequestParam(value = "cPage", required = false) String cPage,
        @RequestParam String lectureNo, Model model) {
        PagingJS p = makePaging(cPage, offtimetableService.getOfftimetableCount(lectureNo));

        Map<String, String> map = new HashMap<>();
        map.put("lectureNo", lectureNo);
        map.put("begin", Integer.toString(p.getBegin()));
        map.put("end", Integer.toString(p.getEnd()));

        List<OfftimetableVO> ttList = offtimetableService.getOfftimetableList(map);
        model.addAttribute("ttList", ttList);
        model.addAttribute("pvo", p);
        model.addAttribute("lectureNo", lectureNo);

        return "/Teacher/timetableManager.jsp";
    }

    // 수강생 관리 화면 이동
    @RequestMapping("/studentManager.do")
    public String studentManager(@RequestParam(value = "cPage", required = false) String cPage,
        @RequestParam(value = "lectureNo", required = false) String lectureNo,
        @RequestParam(value = "timetableNo", required = false) String timetableNo, Model model) {
        Map<String, String> map = new HashMap<>();
        PagingJS p;
        List<UserVO> studentList;

        if(lectureNo == null) { // 오프라인 시간표
            p = makePaging(cPage, offtimetableService.getStudentCount(timetableNo));
            map.put("timetableNo", timetableNo);
            map.put("begin", Integer.toString(p.getBegin()));
            map.put("end", Integer.toString(p.getEnd()));
            studentList = offtimetableService.getStudentList(map);
            model.addAttribute("timetableNo", timetableNo);
        } else { // 온라인 강의
            p = makePaging(cPage, lectureService.getLecture(lectureNo).getStudentCount());
            map.put("lectureNo", lectureNo);
            map.put("begin", Integer.toString(p.getBegin()));
            map.put("end", Integer.toString(p.getEnd()));
            studentList = lectureService.getLectureStudentList(map);
            model.addAttribute("lectureNo", lectureNo);
        }

        model.addAttribute("studentList", studentList);
        model.addAttribute("pvo", p);

        return "/Teacher/studentManager.jsp";

    }

    // 시간표 추가
    @RequestMapping("/addTimetable.do")
    public String studentManager(@ModelAttribute OfftimetableVO tt) {
        System.out.println(tt);

        String ttStart = tt.getTtStart().substring(0, 10) + " " + tt.getTtStart().substring(11, 16) + ":00";
        String ttEnd = tt.getTtEnd().substring(0, 10) + " " + tt.getTtEnd().substring(11, 16) + ":00";

        tt.setTimetableStart(Timestamp.valueOf(ttStart));
        tt.setTimetableEnd(Timestamp.valueOf(ttEnd));

        offtimetableService.insertTimetable(tt);

        return "redirect:/Teacher/timetableManager.do?lectureNo=" + tt.getLectureNo();
    }

    // 실시간 질문
    @RequestMapping("/realtimeQuestion.do")
    public String realtimeQuestion(@RequestParam String lectureNo, Model model) {
        LectureVO lecture = lectureService.getLecture(lectureNo);
        model.addAttribute("lecture", lecture);
        return "/Teacher/realtimeQuestion.jsp";
    }

    /****************************************************
     * 3. 매출 조회
     ****************************************************/

    // 매출 조회 화면 이동
    @RequestMapping("/salesView.do")
    public String salesView(@RequestParam(value = "cPage", required = false) String cPage,
        HttpSession session, Model model) {

        UserVO user = (UserVO) session.getAttribute("user");
        String userId = user.getUserId();

        PagingJS p = makePaging(cPage, lectureService.getOrderLectureCount(user.getUserId()));

        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("begin", Integer.toString(p.getBegin()));
        map.put("end", Integer.toString(p.getEnd()));

        List<LectureVO> list = lectureService.getRealtimeSales(map);
        Integer lectureSales = lectureService.getLectureSales(userId);

        model.addAttribute("salesList", list);
        model.addAttribute("lectureSales", lectureSales);
        model.addAttribute("pvo", p);
        model.addAttribute("count", lectureService.getOrderLectureCount(userId));

        return "/Teacher/salesView.jsp";
    }

    // 매출 조회 엑셀 파일 저장
    @RequestMapping("/saveAllExcel.do")
    @ResponseBody
    public void saveExcel(HttpSession session, HttpServletResponse response) throws IOException {

        UserVO user = (UserVO) session.getAttribute("user");
        String userId = user.getUserId();

        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("begin", "1");
        map.put("end", Integer.toString(lectureService.getOrderLectureCount(user.getUserId())));

        List<LectureVO> list = lectureService.getRealtimeSales(map);

        Workbook wb = new HSSFWorkbook(); // 엑셀파일 객체 생성
        Sheet sheet = wb.createSheet("테스트 시트"); //시트 생성 ( 첫번째 시트이며, 시트명은 테스트 시트 )

        CellStyle style = wb.createCellStyle(); // 셀 스타일 생성
        Font font = wb.createFont(); // 폰트 스타일 생성

        font.setBoldweight(Font.BOLDWEIGHT_BOLD); // 글자 진하게
        font.setFontHeight((short)400); // 글자 크기
        font.setFontName("맑은 고딕"); // 글씨체

        // 자바의 배열처럼 첫번째 인덱스가 0 부터 시작한다.  첫번째는 0 , 두번째는 1 , 세번째는 2
        Row titleRow = sheet.createRow(0); // 타이틀행을 생성한다. 첫번째줄이기때문에 createRow(0)
        int titleColNum = 0; // 첫번째 열이기 때문에 0
        Cell titleCell = titleRow.createCell(titleColNum); // 첫번째행의 첫번째열을 지정한다.
        titleCell.setCellValue("강의별 \n 매출 조회"); // setCellValue 셀에 값넣기.
        titleRow.setHeight((short)1100); // Row에서 setHeight를 하면 행 높이가 조정된다.
        sheet.addMergedRegion(new CellRangeAddress(0,0,0,5)); // 셀 병합  첫번째줄~아홉번째 열까지 병합
        for(int i = 3; i < 4 + list.size(); i++) {
            sheet.addMergedRegion(new CellRangeAddress(i,i,1,4));
        }

        // new CellRangeAddress(시작 row, 끝 row, 시작 col, 끝 col)

        style.setWrapText(true); //문자열을 입력할때 \n 같은 개행을 인식해준다.
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); // 수직 가운데 정렬
        style.setAlignment(CellStyle.ALIGN_CENTER); // 수평 가운데 정렬
        style.setFont(font); // 스타일에 font 스타일 적용하기
        titleCell.setCellStyle(style); // 정리한 스타일들을 titleCell에 적용해주자 !

        CellStyle dataStyle = wb.createCellStyle(); // 데이터스타일은 테두리를 만들어보자

        Font cfont = wb.createFont(); // 폰트 스타일 생성
        cfont.setFontHeight((short)250); // 글자 크기
        cfont.setFontName("맑은 고딕"); // 글씨체
        dataStyle.setFont(cfont);

        CellStyle bdataStyle = wb.createCellStyle();

        Font cbfont = wb.createFont(); // 폰트 스타일 생성
        cbfont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        cbfont.setFontHeight((short)250); // 글자 크기
        cbfont.setFontName("맑은 고딕"); // 글씨체
        bdataStyle.setFont(cbfont);

        //입력받은 날짜 출력하기
        Row dayRow = sheet.createRow(1);
        int dayCol = 0;
        Cell dayCell = dayRow.createCell(dayCol++); // 두번째줄의 첫번째열을 셀로 지정. 즉 두번째줄 첫째칸
        dayCell.setCellValue("총 강의 수"); // 두번째 행은 입력받은 날짜를 출력
        dayCell.setCellStyle(bdataStyle);
        dayCell = dayRow.createCell(dayCol); // 두번째줄의 첫번째열을 셀로 지정. 즉 두번째줄 첫째칸
        dayCell.setCellValue(list.size()); // 두번째 행은 입력받은 날짜를 출력
        dayCell.setCellStyle(dataStyle);

        //헤더 만들기
        Row headerRow = sheet.createRow(3); // 네번째줄 생성
        int headerCol = 0;
        Cell headerCell = headerRow.createCell(headerCol++);
        headerCell.setCellValue("강의번호");
        headerCell.setCellStyle(bdataStyle);
        headerCell = headerRow.createCell(headerCol++);
        headerCell.setCellValue("강의명");
        headerCell.setCellStyle(bdataStyle);
        headerCol++;
        headerCol++;
        headerCol++;
        headerCell = headerRow.createCell(headerCol);
        headerCell.setCellValue("총수익");
        headerCell.setCellStyle(bdataStyle);

        //데이터 삽입하기
        int rowNum = 4; // 네번째줄이 헤더니까 그 밑에서부터 데이터 삽입
        int cellNum;
        Row dataRow; // for문을 돌려주기위해.
        Cell dataCell = null;

        for(int i = 0; i<list.size(); i++) {
            cellNum = 0;
            dataRow = sheet.createRow(rowNum++); // for문 돌면서 행 1줄씩 추가

            dataCell = dataRow.createCell(cellNum++); //열 한줄씩 추가
            dataCell.setCellValue(list.get(i).getLectureNo()); // 첫번째칸은 순번이기때문에
            dataCell.setCellStyle(dataStyle); // 테두리 스타일 적용

            dataCell = dataRow.createCell(cellNum++); // 두번째 열은 이름이니까
            dataCell.setCellValue(list.get(i).getLectureTitle()); // list에 저장된 이름 출력
            dataCell.setCellStyle(dataStyle); // 테두리 스타일 적용

            cellNum++;
            cellNum++;
            cellNum++;
            dataCell = dataRow.createCell(cellNum); // 두번째 열은 이름이니까
            dataCell.setCellValue(Integer.parseInt(list.get(i).getLecturePrice())); // list에 저장된 이름 출력
            dataCell.setCellStyle(dataStyle);
        }
        if (dataCell != null) {
            dataCell.setCellStyle(dataStyle);
        }

        dataRow = sheet.createRow(++rowNum); // 총 인원을 작성해보자
        dataCell = dataRow.createCell(4); // 첫번쨰칸
        dataCell.setCellValue("수익합");
        dataCell.setCellStyle(bdataStyle);
        dataCell = dataRow.createCell(5); // 두번쨰칸
        int num = 4 + list.size();
        dataCell.setCellFormula("SUM(F5:F" + num + ")"); // 함수식을 입력할 수 있는 기능
        dataCell.setCellStyle(dataStyle);

        /* 엑셀 파일 생성 */
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=salesView.xls");
        wb.write(response.getOutputStream());

    }

    // 강의별 매출 조회 화면 이동
    @RequestMapping("/salesLectureView.do")
    public String salesLectureView(@RequestParam String lectureNo, Model model,
        @RequestParam(value = "cPage", required = false) String cPage) {

        PagingJS p = makePaging(cPage, lectureService.getSalesLectureViewCount(lectureNo));

        Map<String, String> map = new HashMap<>();
        map.put("lectureNo", lectureNo);
        map.put("begin", Integer.toString(p.getBegin()));
        map.put("end", Integer.toString(p.getEnd()));

        List<LectureVO> salesList = lectureService.getSalesByLecture(map);
        int lectureSales = lectureService.getSalesSumByLecture(lectureNo);
        LectureVO lec = lectureService.getLecture(lectureNo);

        model.addAttribute("salesList", salesList);
        model.addAttribute("count", lectureService.getSalesLectureViewCount(lectureNo));
        model.addAttribute("lectureSales", lectureSales);
        model.addAttribute("lectureTitle", lec.getLectureTitle());
        model.addAttribute("lectureNo", lec.getLectureNo());
        model.addAttribute("pvo", p);

        return "/Teacher/salesLectureView.jsp";
    }

    // 강의별 매출 조회 엑셀 파일 저장
    @RequestMapping("/saveDetailExcel.do")
    @ResponseBody
    public void saveDetailExcel(@RequestParam String lectureNo, HttpServletResponse response)
        throws IOException {

        Map<String, String> map = new HashMap<>();
        map.put("lectureNo", lectureNo);
        map.put("begin", "1");
        map.put("end", Integer.toString(lectureService.getSalesLectureViewCount(lectureNo)));

        List<LectureVO> salesList = lectureService.getSalesByLecture(map);
        String lectureTitle = lectureService.getLecture(lectureNo).getLectureTitle();

        Workbook wb = new HSSFWorkbook(); // 엑셀파일 객체 생성
        Sheet sheet = wb.createSheet("테스트 시트"); //시트 생성 ( 첫번째 시트이며, 시트명은 테스트 시트 )

        CellStyle style = wb.createCellStyle(); // 셀 스타일 생성
        Font font = wb.createFont(); // 폰트 스타일 생성

        font.setBoldweight(Font.BOLDWEIGHT_BOLD); // 글자 진하게
        font.setFontHeight((short)400); // 글자 크기
        font.setFontName("맑은 고딕"); // 글씨체

        // 자바의 배열처럼 첫번째 인덱스가 0 부터 시작한다.  첫번째는 0 , 두번째는 1 , 세번째는 2
        Row titleRow = sheet.createRow(0); // 타이틀행을 생성한다. 첫번째줄이기때문에 createRow(0)
        int titleColNum = 0; // 첫번째 열이기 때문에 0
        Cell titleCell = titleRow.createCell(titleColNum); // 첫번째행의 첫번째열을 지정한다.
        titleCell.setCellValue("강의별 \n 매출 조회"); // setCellValue 셀에 값넣기.
        titleRow.setHeight((short)1100); // Row에서 setHeight를 하면 행 높이가 조정된다.
        sheet.addMergedRegion(new CellRangeAddress(0,0,0,4)); // 셀 병합  첫번째줄~아홉번째 열까지 병합
        sheet.addMergedRegion(new CellRangeAddress(1,1,1,4)); // 셀 병합  첫번째줄~아홉번째 열까지 병합

        // new CellRangeAddress(시작 row, 끝 row, 시작 col, 끝 col)

        style.setWrapText(true); //문자열을 입력할때 \n 같은 개행을 인식해준다.
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); // 수직 가운데 정렬
        style.setAlignment(CellStyle.ALIGN_CENTER); // 수평 가운데 정렬
        style.setFont(font); // 스타일에 font 스타일 적용하기
        titleCell.setCellStyle(style); // 정리한 스타일들을 titleCell에 적용해주자 !

        CellStyle dataStyle = wb.createCellStyle(); // 데이터스타일은 테두리를 만들어보자

        Font cfont = wb.createFont(); // 폰트 스타일 생성
        cfont.setFontHeight((short)250); // 글자 크기
        cfont.setFontName("맑은 고딕"); // 글씨체
        dataStyle.setFont(cfont);

        CellStyle bdataStyle = wb.createCellStyle();

        Font cbfont = wb.createFont(); // 폰트 스타일 생성
        cbfont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        cbfont.setFontHeight((short)250); // 글자 크기
        cbfont.setFontName("맑은 고딕"); // 글씨체
        bdataStyle.setFont(cbfont);

        //입력받은 날짜 출력하기
        Row dayRow = sheet.createRow(1);
        int dayCol = 0;
        Cell dayCell = dayRow.createCell(dayCol++); // 두번째줄의 첫번째열을 셀로 지정. 즉 두번째줄 첫째칸
        dayCell.setCellValue("강의명"); // 두번째 행은 입력받은 날짜를 출력
        dayCell.setCellStyle(bdataStyle);
        dayCell = dayRow.createCell(dayCol); // 두번째줄의 첫번째열을 셀로 지정. 즉 두번째줄 첫째칸
        dayCell.setCellValue(lectureTitle); // 두번째 행은 입력받은 날짜를 출력
        dayCell.setCellStyle(dataStyle);

        //헤더 만들기
        Row headerRow = sheet.createRow(3); // 네번째줄 생성
        int headerCol = 0;
        Cell headerCell = headerRow.createCell(headerCol++);
        headerCell.setCellValue("번호");
        headerCell.setCellStyle(bdataStyle);
        headerCell = headerRow.createCell(headerCol++);
        headerCell.setCellValue("이름");
        headerCell.setCellStyle(bdataStyle);
        headerCell = headerRow.createCell(headerCol++);
        headerCell.setCellValue("이메일");
        headerCell.setCellStyle(bdataStyle);
        headerCell = headerRow.createCell(headerCol++);
        headerCell.setCellValue("구매일");
        headerCell.setCellStyle(bdataStyle);
        headerCell = headerRow.createCell(headerCol);
        headerCell.setCellValue("구매금액");
        headerCell.setCellStyle(bdataStyle);

        //데이터 삽입하기
        int rowNum = 4; // 네번째줄이 헤더니까 그 밑에서부터 데이터 삽입
        int cellNum;
        Row dataRow; // for문을 돌려주기위해.
        Cell dataCell = null;

        for(int i = 0; i<salesList.size(); i++) {
            cellNum = 0;
            dataRow = sheet.createRow(rowNum++); // for문 돌면서 행 1줄씩 추가

            dataCell = dataRow.createCell(cellNum++); //열 한줄씩 추가
            dataCell.setCellValue(salesList.get(i).getLectureNo()); // 첫번째칸은 순번이기때문에
            dataCell.setCellStyle(dataStyle); // 테두리 스타일 적용

            dataCell = dataRow.createCell(cellNum++); // 두번째 열은 이름이니까
            dataCell.setCellValue(salesList.get(i).getLectureWriter()); // list에 저장된 이름 출력
            dataCell.setCellStyle(dataStyle); // 테두리 스타일 적용

            dataCell = dataRow.createCell(cellNum++); // 두번째 열은 이름이니까
            dataCell.setCellValue(salesList.get(i).getUserId()); // list에 저장된 이름 출력
            dataCell.setCellStyle(dataStyle); // 테두리 스타일 적용

            dataCell = dataRow.createCell(cellNum++); // 두번째 열은 이름이니까
            dataCell.setCellValue(salesList.get(i).getLectureRegdate().substring(0, 10)); // list에 저장된 이름 출력
            dataCell.setCellStyle(dataStyle); // 테두리 스타일 적용

            dataCell = dataRow.createCell(cellNum); // 두번째 열은 이름이니까
            dataCell.setCellValue(Integer.parseInt(salesList.get(i).getLecturePrice())); // list에 저장된 이름 출력
            dataCell.setCellStyle(dataStyle); // 테두리 스타일 적용

        }
        if (dataCell != null) {
            dataCell.setCellStyle(dataStyle);
        }

        dataRow = sheet.createRow(++rowNum); // 총 인원을 작성해보자
        dataCell = dataRow.createCell(3); // 첫번쨰칸
        dataCell.setCellValue("수익합");
        dataCell.setCellStyle(bdataStyle);
        dataCell = dataRow.createCell(4); // 두번쨰칸
        int num = 4 + salesList.size();
        dataCell.setCellFormula("SUM(E5:E" + num + ")"); // 함수식을 입력할 수 있는 기능
        dataCell.setCellStyle(dataStyle);

        /* 엑셀 파일 생성 */
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=salesView.xls");
        wb.write(response.getOutputStream());

    }

    /****************************************************
     * 4. 로드맵 관리
     ****************************************************/

    // 로드맵 작성 화면 이동
    @RequestMapping("/roadmapWrite.do")
    public String roadmapWrite(@RequestParam(value = "rboardNo", required = false) String rboardNo,
        HttpSession session, Model model) {
        // 수정인지 작성인지 확인
        if(rboardNo != null) { // 수정
            model.addAttribute("roadmap", roadmapService.getRoadmapDetail(rboardNo));
        }

        //카테고리 가져오기
        List<CategoryVO> categories = lectureService.getCategories();
        System.out.println(categories);
        model.addAttribute("categories", categories);

        // 강의 목록 가져오기
        UserVO userVO = (UserVO) session.getAttribute("user");

        List<LectureVO> lectureList = lectureService.getOnlineLecturebyUserId(userVO.getUserId());
        model.addAttribute("lectureList", lectureList);

        return "/Teacher/roadmapWrite.jsp";
    }

    // 로드맵 작성
    @RequestMapping("/goRoadmapWrite.do")
    public String goRoadmapWrite(@ModelAttribute RoadmapVO roadmapVO) throws IllegalStateException,
        IOException {
        System.out.println("작성: " + roadmapVO);

        uploadRoadmapFile(roadmapVO);

        roadmapService.insertRoadmap(roadmapVO);

        return "redirect:/Teacher/roadmapManager.do";
    }

    // 로드맵 파일 업로드 공통 부분
    private void uploadRoadmapFile(
        @ModelAttribute RoadmapVO roadmapVO)
        throws IOException {
        MultipartFile uploadFile = roadmapVO.getUploadFile();

        if (uploadFile == null) {
            System.out.println("::: uploadFile 파라미터가 전달되지 않았을때~");
        } else if (uploadFile.isEmpty()) {
            System.out.println("::: 전달받은 파일 데이터가 없을 경우");
            roadmapVO.setRboardCoverimg(roadmapService.getFileName(roadmapVO.getRboardNo()));
        } else {
            System.out.println("uploadFile.isEmpty() : " + uploadFile.isEmpty());
            String fileName = uploadFile.getOriginalFilename(); //원본파일명
            System.out.println("::: 원본파일명 : " + fileName);

            String savedFileName = UUID.randomUUID().toString();
            System.out.println("::: 저장파일명 : " + savedFileName);

            //물리적 파일 복사
            uploadFile.transferTo(new File("\\\\192.168.18.11\\temp\\" + savedFileName));
            roadmapVO.setRboardCoverimg(savedFileName);
        }
    }

    // 로드맵 수정
    @RequestMapping("/goRoadmapEdit.do")
    public String goRoadmapEdit(@ModelAttribute RoadmapVO roadmapVO) throws IllegalStateException,
        IOException {
        System.out.println("수정: " + roadmapVO);

        uploadRoadmapFile(roadmapVO);

        roadmapService.editRoadmap(roadmapVO);
        return "redirect:/Teacher/roadmapManager.do";
    }

    // 강의 이름 불러오기
    @RequestMapping(value="/getLecture.do", produces="application/text; charset=utf8")
    @ResponseBody
    public String getLecture(String lectureNo) {
        LectureVO lectureVO = lectureService.getLecture(lectureNo);
        return lectureVO.getLectureTitle();
    }

    // 내가 작성한 로드맵 조회
    @RequestMapping("/roadmapManager.do")
    public String roadmapManager(@RequestParam(value = "cPage", required = false) String cPage,
        HttpSession session, Model model) {

        UserVO user = (UserVO) session.getAttribute("user");
        String userId = user.getUserId();

        PagingJS p = makePaging(cPage, roadmapService.getRoadmapCount(userId));

        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("begin", Integer.toString(p.getBegin()));
        map.put("end", Integer.toString(p.getEnd()));

        List<RoadmapVO> list = roadmapService.getRoadmapManager(map);
        model.addAttribute("roadmapList", list);
        model.addAttribute("pvo", p);

        return "/Teacher/roadmapManager.jsp";
    }

    // 내가 작성한 로드맵 삭제
    @RequestMapping("/removeRoadmap.do")
    public String removeRoadmap(@RequestParam String rboardNo, HttpSession session) {

        UserVO userVO = (UserVO) session.getAttribute("user");
        Map<String, String> map = new HashMap<>();
        map.put("rboardNo", rboardNo);
        map.put("userId", userVO.getUserId());

        roadmapService.removeRoadmap(map);

        return "redirect:/Teacher/roadmapManager.do";
    }

    // 로드맵 페이징 ajax 처리
    @RequestMapping("/getRoadmapPaging.do")
    @ResponseBody
    public Map<Object, Object> getRoadmapPaging(@RequestParam String cPage, HttpSession session) {

        Map<Object, Object> map = new HashMap<>();

        UserVO user = (UserVO) session.getAttribute("user");
        String userId = user.getUserId();


        PagingJS p = makePaging(cPage, roadmapService.getRoadmapCount(userId));

        Map<String, String> pmap = new HashMap<>();
        pmap.put("userId", userId);
        pmap.put("begin", Integer.toString(p.getBegin()));
        pmap.put("end", Integer.toString(p.getEnd()));

        map.put("pmap", roadmapService.getRoadmapManager(pmap));
        map.put("pvo", p);

        return map;
    }

}
