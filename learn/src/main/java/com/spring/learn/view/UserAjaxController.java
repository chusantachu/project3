package com.spring.learn.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;
import com.sun.mail.iap.Response;


@RestController
@RequestMapping("/member")
public class UserAjaxController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private JavaMailSender sender;
	
	private int size;
	
	public UserAjaxController() {
		System.out.println("SkUserAjaxController() 실행");
	}


	@RequestMapping("/findUserIdList.do")
	public List<UserVO> findUserIdList (@RequestBody UserVO user) {
		System.out.println("==== SkUserAjaxController findUserIdList() 실행 ====");
		
		System.out.println(user.getUserName());
		System.out.println(user.getUserBirth());
		
		List<UserVO> beforeEditUsers = userService.findUserIdList(user);
		
		List<UserVO> editingUserList = new ArrayList<UserVO>();
		
		for (UserVO vo : beforeEditUsers) {
			//str.indexOf("@");
			System.out.println("골뱅이 위치: " + vo.getUserId().indexOf("@"));
	
			StringBuilder sb = new StringBuilder(vo.getUserId());
			
			sb.setCharAt((vo.getUserId().indexOf("@")-3), '*');
			sb.setCharAt((vo.getUserId().indexOf("@")-2), '*');
			sb.setCharAt((vo.getUserId().indexOf("@")-1), '*');	
			
			vo.setUserId(sb.toString());
			
			System.out.println(vo);
			editingUserList.add(vo);
		}
		//System.out.println("findUserId: " + findUserId);
		return editingUserList;
	}

	
	@RequestMapping("/findPassword.do")
	public List<Map<String, String>> findUserId (@RequestBody UserVO user, HttpSession session) {
		System.out.println("==== SkUserAjaxController findPassword() 실행 ====");
		
		//System.out.println(user.getUserId());
		
		List data = new ArrayList<Object>();
        
		Map<String, String> map = new HashMap<String, String>();
        
		UserVO vo = userService.findUserId(user);
		System.out.println(vo);
		
		if (vo != null) {
			
			String userId = vo.getUserId();
			String userPwd = vo.getUserPwd();
			String socialType = vo.getSocialType();
			
			
			System.out.println("socialType: " + socialType);

			if (socialType != null) {
				
				map.put("userId", userId);
				map.put("userPwd", userPwd);
				map.put("socialType", socialType);
				
				data.add(map);
				
			} else {
				
				MimeMessage message = sender.createMimeMessage();
				
				try {
					
					message.setSubject("[아웃런] 비밀번호 변경 인증번호입니다.", "UTF-8");
					
					String htmlStr = "";
					String verifyNO = String.valueOf(getKey(6));
					System.out.println(verifyNO);
					htmlStr += "<h3>아웃런 비밀번호 재설정 인증 번호입니다</h3>";
					htmlStr += "<p>인증번호 "+verifyNO+"를 화면에 입력 후<br>";
					htmlStr += "비밀번호 변경 페이지로 이동합니다.<br>";
					htmlStr += "해당 인증번호는 전송 후 3 분 간 유효합니다.</p>";
					
					message.setText(htmlStr, "UTF-8", "html");
					
					message.addRecipient(RecipientType.TO, new InternetAddress(userId));
					
					sender.send(message);
					
					
					map.put("userId", userId);
					map.put("userPwd", userPwd);
					map.put("verifyNO", verifyNO);
					
					data.add(map);

					session.setAttribute("vo", vo);
					session.setAttribute("verifyNO", verifyNO);
					//System.out.println("session verifyNO 값: " + session.getAttribute("verifyNO"));
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			
			}
		}

		return data;
	}

	@RequestMapping("/checkVerifyNO.do")
	public List<String> checkVerifyNO (@RequestBody Map<String, String> checkNO, HttpSession session) {
		System.out.println("==== SkUserAjaxController checkVerifyNO() 실행 ====");
		System.out.println("insertNo: " +  checkNO.get("insertNo"));
		System.out.println("sessionNo: " +  session.getAttribute("verifyNO"));
		
		List<String> data = new ArrayList<String>();

		if (checkNO.get("insertNo").equals(session.getAttribute("verifyNO"))) {
			String userId = ((UserVO)session.getAttribute("vo")).getUserId();
			System.out.println(userId);
			data.add(userId);
		} 
		return data;
	}

	
	
    //인증키 생성
    private String getKey (int size) {
        this.size = size;
        return getAuthCode();
    }

    //인증코드 난수 발생
    private String getAuthCode () {
        Random random = new Random();
        StringBuffer buffer = new StringBuffer();
        int num = 0;
        
        while(buffer.length() < size) {
            num = random.nextInt(10);
            buffer.append(num);
        }
        
        return buffer.toString();
    }
}
