package com.spring.learn.echo;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Service
@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {
	
	
	public EchoHandler() {
		System.out.println("EchoHandler() 실행:::");
	}
	
	// 세션 리스트
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);

	// 클라이언트가 연결 되었을 때 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("첫번쨰 클라 연결 실행");
		sessionList.add(session);
		
		System.out.println(session.getId());
		logger.info("{} 연결됨", session.getId());
		String id = session.getId();
	}

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	@Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("2번쨰 클라 연결 실행");
        logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
        //모든 유저에게 메세지 출력
        
        for(WebSocketSession sess : sessionList){
        	sess.sendMessage(new TextMessage(message.getPayload()));
        }
	}

    //클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	System.out.println("3번쨰 클라 연결 실행");
        sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getId());
    }
}