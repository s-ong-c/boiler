package org.zerock.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	private static final String LOGIN = "login";
	private static final Logger logger =
			LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
							Object handler,ModelAndView modelAndView)throws Exception{
		
		HttpSession session = request.getSession();
		
		ModelMap modelMap = modelAndView.getModelMap();
		Object userVO = modelMap.get("userVO");
		
		if(userVO != null){
			logger.info("new Login SUCCESS");
			session.setAttribute(LOGIN, userVO);
			//response.sendRedirect("/");
			
			if(request.getParameter("useCookie")!=null){
				logger.info("remember me.........");
				Cookie loginCookie = new Cookie("loginCookie",session.getId());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60*60*24*7);  // 유효기간 1년 
				response.addCookie(loginCookie);
				  // 쿠키는 반드시 httpServletResponse 에 담겨서 전송 됨 
			}
			
			
			
			Object dest= session.getAttribute("dest");  // 페이지 정보를 dest 라는 이름으로 저장 
			
			response.sendRedirect(dest !=null ? (String)dest:"/");
		}
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response,
								Object handler)throws Exception{
		HttpSession session = request.getSession();
		
		if(session.getAttribute(LOGIN) != null){
			logger.info("clear Login data before");
			session.removeAttribute(LOGIN);
		}
		
		
		return true;
	}
}
