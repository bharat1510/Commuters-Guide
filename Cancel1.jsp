<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Cancellation</title>
<meta name="keywords" content="Home" />
<link href="./css/templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />

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
function validate(no){
	
	
	var chk=0;
	if(no==1){
		if (document.form1.seat.checked == true){
			
			chk = chk +1;
		}			
	}
	else{
		for(var i=0; i< parseInt(no); i++){

			if (document.form1.seat[i].checked == true){
			
				chk = chk +1;
			}	
		}
	}

	if(chk == 0){
			alert("Please Select Passengers Whose Ticket is to be cancelled");
			return;
	}
	else{
			document.form1.submit();
	}
}
</script>

<script type="text/javascript">
//script to disable goback button of the browser

//function forwards to the next page from history of cache
function noBack(){
	window.history.forward();
}

//Calls noBack() function
function Back(){
	if (event.persisted){ 
		noBack();
	}
}

window.onload=noBack();
window.onpageshow = Back();
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

<div align="center">
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

		if(ssid == sessionid && author.equals("user")) {
		%>

<form name="form1" action="./Cancel2.jsp">
<%
int pnr=0;
String pnr1="";
String pnr2="";
block:	try{
		pnr1=request.getParameter("pnr1");
		pnr2=request.getParameter("pnr2");
		String pnrno = pnr1.concat(pnr2);
		pnr = Integer.parseInt(pnrno);
		
		
		// To Fetch Details Of Train And User Who Has Done The Booking Based On PNR No
		String sql1="select p.PNR, p.train_no, p.class, p.dep_date, p.no_seats, p.adult, p.child, p.board_station, p.dest_station, p.total_km, p.book_date, p.book_date, p.user_id, u.name, t.train_name, t.type, t.distance, r.s_station_name, r.d_station_name from ticket_book p, reg_user u, train_info t, route_main r  where p.train_no=t.train_no and p.user_id=u.user_id and t.s_station_id=r.s_station_id and t.d_station_id=r.d_station_id and p.PNR=? and p.dep_date > now();";
		
		pstmt = con.prepareStatement(sql1);
		pstmt.setInt(1,pnr);
	
		rs = pstmt.executeQuery();

		int getpnr = 0; //To Check wheteher the sql query gets any pnr no or not if not then to display a message to user

		while(rs.next()){
			int user_id = rs.getInt("user_id");

			if(user_id != Integer.parseInt(uid)){
				%>
				<h3> <span style='color: red;'> Ticket Booked By Other User Cannot Proceed </span> </h3>
				<input type='button' Value='OK' onclick="parent.location='Cancel.jsp'" />
				<%
				break block;
			}
			
			getpnr = rs.getInt("PNR");
			String clas=rs.getString("class");
			String class1="";
	        if (clas.equals("sl")){
	       			class1="Sleeper Class";
	       	}else if(clas.equals("a1")){
					class1="AC First Class";
	       	}else if(clas.equals("a2")){
	       			class1="AC 2 Tier";
	       	}else if(clas.equals("a3")){
					class1="AC 3 Tier";
	       	}
			
			out.println("<h1> Reservation Details </h1>");		

			out.println("<table border='1' bordercolor=#333333>");
			out.println("<tr bgcolor=#333333>");
			out.println("<th align='left' colspan='6' style='color:white'> Train Details : </th></tr>");
			out.println("<tr bgcolor=#333333 style='color:white'>	<th> Train No</th> <th> Train Name</th> <th> Type</th> <th> Source Station</th><th> Destination Station</th><th> Distance</th>	</tr>");
			out.println("<tr>");
			out.println("<td>"+rs.getInt("train_no")+"</td><td>"+rs.getString("train_name")+"</td><td>"+rs.getString("type")+"</td><td>"+rs.getString("s_station_name")+"</td><td>"+rs.getString("d_station_name")+"</td><td>"+rs.getInt("distance")+"</td>");
			out.println("</tr>");
			out.println("</table>");

			
			out.println("<table border='1' bordercolor=#333333>");
			out.println("<th align='left' colspan='5' bgcolor=#333333 style='color:white'> Reservation Details : </th>");
			out.println("<tr bgcolor=#333333 style='color:white'>	<th> PNR No</th> <th> Booked By</th><th> Booked Date</th><th> Departures On</th><th> Class Type</th>	</tr>");
			out.println("<tr>");
			out.println("<td>"+rs.getInt("PNR")+"</td><td>"+rs.getString("name")+"</td><td>"+rs.getDate("book_date")+"</td><td>"+rs.getDate("dep_date")+"</td><td>"+class1+"</td>");			
			out.println("</tr>");
			out.println("<tr bgcolor=#333333 style='color:white'><th> Adults </th> <th> Childern </th><th> Boarding At </th><th> Reserv UPTO</th><th> Travel KM</th></tr>");
			out.println("<tr>");
			out.println("<td>"+rs.getInt("adult")+"</td><td>"+rs.getInt("child")+"</td><td>"+rs.getString("board_station")+"</td><td>"+rs.getString("dest_station")+"</td><td>"+rs.getInt("total_km")+"</td>");			
			out.println("</tr>");
			out.println("</table>");
			
			out.println("<br/>");

		}
		if(getpnr == 0){
			%>
			<h3> <span style='color: red;'> PNR NO DOES NOT EXIST TRY AGAIN </span> </h3>
			<input type='button' Value='OK' onclick="parent.location='Cancel.jsp'" />
			<%
			break block;
		}

		//To Fetch All the passenger details under the PNR No
		
		
		String sql3="select p.PNR, p.coach_no, p.seat_no, p.name, p.sex, p.age, p.status from ticket_book t, passenger_info p where t.PNR=p.PNR and t.PNR=?";
		
		pstmt = con.prepareStatement(sql3);
		pstmt.setInt(1,pnr);

		rs = pstmt.executeQuery();
		
		out.println("<input type='hidden' name='pnrno' value='"+pnr+"'>");		
		out.println("<table border='1' bordercolor=#333333>");
		out.println("<th align='left' colspan='7' bgcolor=#333333 style='color:white'> Passenger Details : </th>");
		out.println("<tr bgcolor=#333333 style='color:white'><th> Select </th>	<th> Coach No</th> <th> Seat No</th><th> Name </th><th> Sex</th><th> Age</th><th> Status</th>	</tr>");

		int i =1;
		while(rs.next()){

			out.println("<tr style='color:blue; font-weight:bold'>");
			out.println("<td><input name='seat' type='checkbox' tabindex='"+i+"' value='"+rs.getString("seat_no")+"'</td>");
			out.println("<td>"+rs.getString("coach_no")+"</td>");
			out.println("<td>"+rs.getString("seat_no")+"</td>");
			out.println("<td>"+rs.getString("name")+"</td>");
			out.println("<td>"+rs.getString("sex")+"</td>");
			out.println("<td>"+rs.getInt("age")+"</td>");
			if(rs.getString("status").equalsIgnoreCase("RESERVED")){
				out.println("<td><span style='color: green;font-weight: bold;'>");
			}else{
				out.println("<td><span style='color: red;font-weight: bold;'>");				
			}
			out.println(rs.getString("status") +"</span></td>");
			out.println("</tr>");
			
			i=i+1;
		}
		out.println("</table>");
		out.println("<input type='button' value='Conform Cancellation' onclick='validate("+(i-1)+")'>"); //Passing No Of seats (i) to the function
		

	}
	catch(Exception e){
		//e.printStackTrace();
	}

%>
</form>
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
