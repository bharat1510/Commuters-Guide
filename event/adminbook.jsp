<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> Bookings</title>
<meta name="keywords" content="Home" />
<link href="./css/templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />

<!--  Date Picker code -->

		<link type="text/css" href="jsDate/css/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="jsDate/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="jsDate/jquery-ui-1.8.17.custom.min.js"></script>
		<script type="text/javascript" src="jsDate/jquery.effects.core.js"></script>
		<script type="text/javascript" src="jsDate/jquery.effects.bounce.js"></script>
		<script type="text/javascript">   //date Picker to show date of travel for a week starting from the next date of today
		$(function() {
			  $( "#datepicker" ).datepicker({ showAnim: 'bounce',
				  minDate: "-1W -0D", maxDate: "0D" });
		});
		</script>
		<style type="text/css">
			body{ font: 62.5% "Arial", sans-serif; margin: 50px;}
		</style>
		
<!-- Date Picker Code End -->		

<!-- To Over Write the CSS Style OF date over Body -->
 <style type="text/css">
	body
	{
	margin-bottom:0;
	margin-left:0;
	margin-right:0;
	margin-top:0;
	}
</style>


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

<script type="text/javascript">
function valid(){
	if(document.form1.date.value != ""){
		document.form1.submit();
	}else{
		alert("Please Select a Date to view Bookings");
		document.form1.date.focus();
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

<div style=" font-family:'Times New Roman', Times, serif;font-size:16px;">
<%
//Session Validation
try{
	if(session.isNew()){
			out.println("<h3><span style='color: red;'>Access Denied please login to access </span></h3>");	
	}
	else{
	String uname = (String)session.getAttribute("uname");
	String ssid = (String)session.getAttribute("sid");
	String author = (String)session.getAttribute("author");
	String sessionid = (String)session.getId();
	String uid = (String)session.getAttribute("uid");
		if(ssid == sessionid && author.equals("admin")) {
		%>
		<div align="center">
		<form name="form1" action="./adminbook.jsp">
			<h1 align="center"> Bookings </h1>
			<br/>
			<label style="font-weight: bold; color: red;"> Select A Date To View Bookings</label>
			<p>
			<input type="text" name="date" readonly="readonly" id="datepicker" title="YYYY/MM/DD" size="12"/>
			<img alt="" src="./jsDate/css/images/date.png" height="35px" width="35px" onclick="document.form1.date.focus()">
			</p>
			<input type="button" value="Search" onclick="valid();">
			<br/>
			<br/>
			<div>
			<%
		tryblock:	try{
				String date = request.getParameter("date");
				
				if(date.equalsIgnoreCase(null)){
					break tryblock;
				}
				String sql1="select distinct t.PNR, t.train_no, t.dep_date, t.adult, t.child, t.no_seats, t.board_station, t.dest_station, t.total_km, u.name from ticket_book t, reg_user u where t.user_id=u.user_id and t.book_date='"+date+"' ";
				
				pstmt = con.prepareStatement(sql1);
				
				rs = pstmt.executeQuery();
				
				out.println("<table border='1' bordercolor=#333333>");
				out.println("<tr bgcolor=#333333>");
				out.println("<th align='left' colspan='8' style='color:white'> Booking Details : </th> </tr>");
				out.println("<tr bgcolor=#333333 style='color:white'>	<th> PNR No</th> <th> Train No</th> <th> Dep_Date</th> <th> No_Seats</th><th> Boarding Station</th><th> Destination Station</th><th> Distance</th><th> Booked By</th>	</tr>");

				int flag=0;
				while(rs.next()){
					flag=1;
					out.println("<tr style='color:blue; font-weight:bold'>");
					out.println("<td>"+rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(6)+"</td><td>"+rs.getString(7)+"</td><td>"+rs.getString(8)+"</td><td>"+rs.getString(9)+"</td><td>"+rs.getString(10)+"</td>");
					out.println("</tr>");
				}
				out.println("</table>");
				
				if(flag==0){
					%>
					<script type="text/javascript">
						alert("No Bookings Found");
					</script>
					<%
				}
				
			}
			catch(Exception e){
			}
			%>
			</div>
		</form>
		</div>
		<%
		//Session Validation

		}
		else{
			out.println("<h3><span style='color: red;'>Access Denied please login to access </span></h3>");	
		}
	}
}
catch(Exception e){
	out.println("<h3><span style='color: red;'>Access Denied please login to access </span></h3>");	
}
%>

</div>

	<!-- Form Body -->

    </div> <!-- end of templatemo_content -->
    
    <div id="templatemo_sidebar">
    	<div id="request_a_quote">
        <%
        	try{
			if(session.isNew()){			//session.isNew is true for the first time when the page is loaded
			}
			else{
			String uname = (String)session.getAttribute("uname");
			String ssid = (String)session.getAttribute("sid");
			String author = (String)session.getAttribute("author");
			String error = (String)session.getAttribute("error");
			String sessionid = (String)session.getId();
				if(error=="Y"){				//error=Y is set when the email and password are mismatched
				}
				else if(ssid == sessionid) {			//To verify the session id of page and sid i.e session id set during session creation match
				%>
					<h2> Login Details</h2><br/>
					<p style="font-size: 12pt">
					<label style="color:#DD0000;"> UserName</label> &nbsp; <%= uname %>	<br/>
					<label style="color:#DD0000;"> Authority </label> &nbsp; <%= author.toUpperCase() %>	<br/>
					<br/>
					<a href="<%= author%>home.jsp"> <%= author.toUpperCase() %>	Home</a>
					<a href='Logout.jsp'> Logout</a>
					</p>
				<%
				}
				else{			//if all cases fail login is prompted
				}
			}
        }
        catch(Exception e){       	
        }
		%>
        </div>
    
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
