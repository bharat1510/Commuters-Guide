<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<%! 
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	
	public void jspInit(){
		try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/train","root","");
		}
		catch(Exception e ){
			e.printStackTrace();
		}
		}
%>


</head>
<body>
<%

String email = "";
String pass = "";

try{
	String sid = request.getSession().getId();
	session.setAttribute("sid",sid);

	email = request.getParameter("email");
	pass = request.getParameter("pass");


	String sql1 ="select user_id, author, uname from login where email=? and pass=?";

	pstmt = con.prepareStatement(sql1);

	pstmt.setString(1,email.trim());
	pstmt.setString(2,pass.trim());

	rs = pstmt.executeQuery();

	String uname ="";
	String author = "";

	if(rs.next()){
		uname = rs.getString("uname");
		author = rs.getString("author");
		String uid = rs.getString("user_id");
		
		session.setAttribute("uname",uname);	
		session.setAttribute("uid",uid);				
		session.setAttribute("author",author);
		session.setAttribute("error","N");			//User defined error name and value
		
		if(rs.getString("author").equalsIgnoreCase("admin"))				
		{
			response.sendRedirect("adminhome.jsp");	
		}
		else if(rs.getString("author").equalsIgnoreCase("user"))
		{
			response.sendRedirect("userhome.jsp");						
		}
	}
	else{
			session.setAttribute("error","Y");       //User defined error name and value
			response.sendRedirect("home.jsp");						
	}
}
catch(Exception e){
	e.printStackTrace();
	session.setAttribute("error","Y");
	response.sendRedirect("home.jsp");						
}

%>
</body>
</html>