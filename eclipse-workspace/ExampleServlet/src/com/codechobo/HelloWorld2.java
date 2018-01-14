package com.codechobo;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HelloWorld2")

public class HelloWorld2 extends HttpServlet{
@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// TODO Auto-generated method stub

		resp.setContentType("text/html");

		PrintWriter  out=resp.getWriter();

		for(int i=1;i<=5;i++) { //  괄호 () 안에 내용을 5번 반복

			for(int j=1;j<=i;j++) {

				out.print("*");  // alt + up , down 

			}

			out.println("<br>");
		}
		out.println("<html>");
		out.println("<head>");
		out.println("</head>");
		out.println("<body>");
		out.println("tmalak");
		out.println("<h1>");
		for(int i=0;i<2;i++) {

			int n= (int) (Math.random()*6);

			System.out.println(n+1);
			out.println("<img src=dice"+(n+1)+".jpg>");
		}
		out.println("</h1>");
		out.println("</body>");
		out.println("</html>");
		out.println("Hello,Sevlet");
	}
	@Override

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// TODO Auto-generated method stub
		doGet(req, resp);

	}
}

