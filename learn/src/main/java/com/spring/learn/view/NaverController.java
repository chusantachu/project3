package com.spring.learn.view;

import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/Member")
@RestController
public class NaverController {

  @Autowired
  private UserService userService;

  @RequestMapping("/naverLogin.do")
  public UserVO naverLogin(@RequestBody UserVO vo, HttpServletRequest request) {
    HttpSession session = request.getSession();
    System.out.println(">>> 네이버 로그인");
    String userBirth = vo.getUserBirth();
    vo.setUserBirth(userBirth.substring(0, 6) + userBirth.substring(7));

    System.out.println("vo : " + vo);
    // 아이디 있는지 확인 -> 있으면 naver 업데이트 없으면 아래
    UserVO user = userService.confirmUser(vo);
    if(user == null) {
      userService.insertUser(vo);
      user = userService.confirmUser(vo);
    }
    System.out.println("user: " + user);
    userService.addNaverUser(user);
    session.setAttribute("user", user);

    return user;

  }
}
