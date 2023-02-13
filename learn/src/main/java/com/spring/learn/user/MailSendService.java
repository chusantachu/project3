package com.spring.learn.user;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class MailSendService {
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber; 
	// 난수 발생(여러분들 맘대러)
	
		public void makeRandomNumber() {
			// 난수의 범위 111111 ~ 999999 (6자리 난수)
			Random r = new Random();
			int checkNum = r.nextInt(888888) + 111111;
			System.out.println("인증번호 : " + checkNum);
			authNumber = checkNum;
		}
		
		
				//이메일 보낼 양식! 
		public String joinEmail(String email) {
			makeRandomNumber();
			System.out.println("여기까지옵니까???3333");
			String setFrom = "dldldlwjdans@gmail.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "회원 가입 인증 이메일 입니다."; // 이메일 제목 
			String content = 
					"홈페이지를 방문해주셔서 감사합니다." + 	//html 형식으로 작성 ! 
	                "<br><br>" + 
				    "인증 번호는 " + authNumber + "입니다." + 
				    "<br>" + 
				    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
			System.out.println("여기까지 옵니까???11");
			mailSend(setFrom, toMail, title, content);
			System.out.println("여기까지옵니까?!222222");
			return Integer.toString(authNumber);
		}
		
		//이메일 전송 메소드
		public void mailSend(String setFrom, String toMail, String title, String content) { 
			System.out.println(">>>>>>>>>>>>>>>>여기는 오는거죠??????????????");
			MimeMessage message = mailSender.createMimeMessage();
			System.out.println(">>>>>>>>여기는 오는거죠!!!!!!!!!!!!!");
			// true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.
			try {
				System.out.println(">>>>>>>>여기는 ????????????");
				MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				// true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
				helper.setText(content,true);
				System.out.println(">>>>>>>>여기는 !!!!!!!!!!!!!!!!!!");
				mailSender.send(message);
				System.out.println(">>>>>>>>여기도 제발!!!!!!!!!!!!!!!!!!!!!!!!!!");
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
		
		//관리자페이지 메일발송 추가 기능=========================
		public String rejectResumeMail(String email) {
			System.out.println(">>> rejectResumeMail 접속");
			String setFrom = "dldldlwjdans@gmail.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "[아웃풋런]강의자 신청 결과 안내드립니다."; 
			String content = 
					"안녕하세요.<br>" +
					"아웃풋런 관리자입니다.<br>" + 	
					"먼저 저희 아웃풋런에 관심을 가져주신 점 대단히 감사드립니다.<br>" +
					"또한 회원님께서 신청하여주신 강의자 심사 결과를 메일로 전달드리게 되어 죄송하다는 말씀드립니다. " +
					"<br><br>" + 
					"아쉽게도 신청하신 강의자 심사 결과 <부적합>으로 판단되어 거절되었음을 알려드립니다.<br>" +
					"자세한 심사 결과 안내를 원하시는 경우 아웃풋런 고객센터(02-123-1234)로 연락하여 주시기 바랍니다.<br>" +
					"앞으로도 저희 아웃풋런에 많은 관심 부탁드립니다." +
					"<br><br>" + 
					"감사합니다.<br>";
			System.out.println(" 메일 내용 확인 : " + content);
			mailSend(setFrom, toMail, title, content);
			return title;
		}

		public String approveResumeMail(String email) {
			System.out.println(">>> approveResumeMail 접속");
			String setFrom = "dldldlwjdans@gmail.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "[아웃풋런]강의자 신청 결과 안내드립니다."; 
			String content = 
					"축하드립니다! 신청하신 강의자 심사 결과 <적합>으로 판단되어 승인되었음을 알려드립니다.<br>" +
					"저희 아웃풋런에 로그인하시면 강의자 페이지가 활성화 되어 있는 것을 확인하실 수 있습니다.<br>" +
					"강의자 활동과 관련하여 문의사항이 있을경우 아웃풋런 고객센터(02-123-1234)로 연락주시기 바랍니다.<br>" +
					"앞으로도 저희 아웃풋런에 많은 관심 부탁드립니다." +
					"<br><br>" + 
					"감사합니다.<br>";
			System.out.println(" 메일 내용 확인 : " + content);
			mailSend(setFrom, toMail, title, content);
			return title;
		}

		//==============================================
		
	
}
