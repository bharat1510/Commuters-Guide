<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<script>

function change(){
	var id= document.getElementById("book").value;
	var cid=document.getElementById("book").selectedIndex;
	var val = document.getElementById("book").options[cid].text;
	var url = window.location.href;
	var urlindex = url.indexOf('?');
	var url1 = "";
	if(urlindex > -1){
		//alert("if");
		//alert(urlindex);
		url1 = url.substring(0, urlindex);
		alert(url1);
		window.location.replace(url1+"?id="+id+"&value="+val);
		//alert("if end");
	}
	else{
		window.location.replace(url+"?id="+id+"&value="+val);
	}
}

function extract(){
	var ide=document.getElementById("info").selectedIndex;
	var bookname = document.getElementById("info").options[ide].text;
	var url = window.location.href;
	var urlindex = url.indexOf('?');
	var url1 = "";
	if(urlindex > -1){
		//alert("if");
		//alert(urlindex);
		url1 = url.substring(0, urlindex);
		//alert(url1);
		window.location.replace(url1+"?book="+bookname);
		//alert("if end");
	}
	else{
		window.location.replace(url+"?book="+bookname);
	}
}
</script>
<%!
Connection conn = null;
ResultSet rs =null;
Statement st=null;
String query="";

%>
</head>
<body>
<form action="" name="form1">
First Name <input type="text" name="fnam">
Second Name <input type="text" name="snam">
<%
String value=request.getParameter("value");
Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/register","root", "");
st = conn.createStatement(); 
rs = st.executeQuery("select * from book");
%>

<select id="book" name="book" onchange="change();">
<option value="0">--Please Select--</option>
<% while(rs.next()){ %>
<% if(rs.getString("books").equals(value)){%>
<option value="<%= value%>" selected="selected" disabled="disabled" ><%=value%></option>
<%
}
else{
%>
<option value="<%=rs.getString("bookid")%>"><%=rs.getString("books")%></option>
<%
}
}
%>
</select>

<select id="info" name="binfo" onchange="extract(this)">
<option value="0">--Please Select--</option>
<%

String id=request.getParameter("id");
rs=st.executeQuery("select * from bookInformation where bookid='"+id+"'");
while(rs.next()){
%>
<option value="<%=rs.getString("id")%>" ><%=rs.getString("booknames")%></option>
<%
}
%>
</select>
<%
String book=request.getParameter("book");
String author="";
String price="";
rs=st.executeQuery("select * from bookInformation where booknames='"+book+"'");
//System.out.println(book);
while(rs.next()){
author=rs.getString("writer");
price=rs.getString("price");
}
if((book!=null)&&(author!=null)&&(price!=null)){
%>
<table >
<tr><td>Book Name</td><td><input type="text" value="<%=book%>" name="bname"></td></tr>
<tr><td>Author</td><td><input type="text" value="<%=author%>" name="auth"></td></tr>
<tr><td>Price</td><td><input type="text" value="<%=price%>" name="price"></td></tr>
<tr><td> <input type="submit"> </td></tr>
</table>
<%
}
%>
</form>
</body>
</html>