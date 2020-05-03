<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="keywords" content="Home" />
<link href="./css/templatemo_style.css" rel="stylesheet" type="text/css" />

<title> Feed Back </title>
<!-- Input Validation Script -->
<script type="text/javascript" src="InputValidation.js">
</script>

<script type="text/javascript">
function valid(){
	if(Empty(document.form1.emailid)){		//Empty Field Validation Call
		       if(validateEmail(document.form1.emailid)) {		//Email Input Type Validation Call
		    	   if(Empty(document.form1.feed)){
						document.form1.submit();
					}
	  		   }
	}
}
</script>

	<!-- Special Font & Symbol -->	
   <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	
	
<script> 
    $(function(){
      $("#header").load("header.html"); 
    });
    </script>
	
		<script> 
    $(function(){
      $("#footer").load("footer.html"); 
    });
    </script>
	
</head>
<body>


<div id="templatemo_wrapper">

	<div id="templatemo_header">
		
		<div id="site_title">
            <h1><a href="home.jsp">
                <img src="./images/logo.jpg" alt="Commuters Guide" width="480" height="93" />
             
            </a></h1>
        </div>
 
        <!-- end of templatemo_menu -->
        
      <div class="cleaner"></div>
	</div> <!-- end of header -->
	<div id="header"></div>
    
    <div id="templatemo_content">


	<!-- Form Body -->
<div>
<%
//Session Validation
try{
	String uname = (String)session.getAttribute("uname");
	String ssid = (String)session.getAttribute("sid");
	String author = (String)session.getAttribute("author");
	String sessionid = (String)session.getId();
	String uid = (String)session.getAttribute("uid");
		if(ssid == sessionid && author.equals("admin")) {
			response.sendRedirect("adminfeed.jsp");		
		}else{
		%>

<h1 align="center"> Feed Backs </h1>
<br/>
<br/>
<p style="color: maroon; font-size: 16px; font-weight: bold;">
Please drop us a line! <br/>
If you have a query, an idea or a suggestion, we would be most happy to listen and will do our best to implement the same 
</p>

<form name="form1" action="feedback1.jsp" >
<table align="center">
<tr>
<th> Email ID :</th>
<td> <input type="text" name="emailid"> </td>
</tr>
<tr>
<th> Feed Back :</th>
<td> <textarea rows="4" cols="35" name="feed"></textarea> </td>
</tr>
</table>
<p align="center">
<input type="button" value="Submit" onclick="valid()"> 
<input type="reset" value="Clear">
</p>
</form>

<%
		}
}
		catch(Exception e){
			%>

			<h1 align="center"> Feed Backs </h1>
			<br/>
			<br/>
			<p style="color: maroon; font-size: 16px; font-weight: bold;">
			Please drop us a line! <br/>
			If you have a query, an idea or a suggestion, we would be most happy to listen and will do our best to implement the same 
			</p>

			<form name="form1" action="feedback1.jsp" >
			<table align="center">
			<tr>
			<th> Email ID :</th>
			<td> <input type="text" name="emailid"> </td>
			</tr>
			<tr>
			<th> Feed Back :</th>
			<td> <textarea rows="4" cols="35" name="feed"></textarea> </td>
			</tr>
			</table>
			<p align="center">
			<input type="button" value="Submit" onclick="valid()"> 
			<input type="reset" value="Clear">
			</p>
			</form>

			<%
		}
%>
</div>

	<!-- Form Body -->

    </div> <!-- end of templatemo_content -->
    
    <div id="templatemo_sidebar">
      
      <div id="sidebar_featured_project">
        	<div class="cleaner"></div>
        	<div class="cleaner"></div>
        	<div class="cleaner"></div>
        	<div class="cleaner"></div>
            <h3>Information</h3>
            <div class="right" >
            
              <h6 ><a href="SearchTrain.jsp">Trains Btw Stations</a></h6>
              <h6><a href="SearchSchedule.jsp">Train Schedules</a></h6>
              <h6><a href="ViewFare.jsp">Fare List</a></h6>
              <h6><a href="http://www.indianrail.gov.in" target="_new">Other Railway Websites </a></h6>
         
            </div>
            
             <div class="cleaner"></div>
            
        </div>
        <div class="cleaner"></div>
    </div>

</div> <!-- end of wrapper -->

<div id="footer"></div>
</body>
</html>
