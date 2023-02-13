package com.spring.learn.echo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.spring.learn.echo.EchoHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
	
	@Autowired
	private EchoHandler echoHandler;
	
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
    	System.out.println("registerWebSocketHandlers : 실행");
        registry.addHandler(echoHandler, "/echo").setAllowedOrigins("*").withSockJS();
    }
    

    
}
