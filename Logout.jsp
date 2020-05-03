<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try{
String uname = (String)session.getAttribute("uname");
String sid = (String)session.getAttribute("sid");
String sessionid = (String)session.getId();
	if(sid == sessionid) {
		//out.println(uname+" Is Logged Out Successfully"+"<br/>");
		session.invalidate();
		response.sendRedirect("home.jsp");	
		//out.println("<a href='Login.jsp'> Log In</a>");
	}
	else{
		response.sendRedirect("home.jsp");	
		//out.println(" User Never Logged In so cannot Log out <br/>");	
		//out.println("<a href='home.jsp'> Log In</a>");
	}
}
catch(Exception e){
	response.sendRedirect("home.jsp");
}
%>
</body>
</html>