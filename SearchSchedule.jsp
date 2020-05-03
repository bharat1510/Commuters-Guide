<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Train Schedules</title>
<meta name="keywords" content="Home" />
<link href="./css/templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />

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

function change(){
		var val= document.form1.search.value;
		
		var url = window.location.href;
		var urlindex = url.indexOf('?');
		var url1 = "";
		if(urlindex > -1){
			url1 = url.substring(0, urlindex);
			window.location.replace(url1+"?search="+val);
		}
		else{
			window.location.replace(url+"?search="+val);
		}
}
</script>
	
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
<form name="form1">
<h1> Get Schedule Of A Train </h1>
<table>
	<tr>
		<td> <label> Train No </label> </td>
        <td> <input type="text" name="search" maxlength="4" size="4"/> </td>
	</tr>
</table>
<p>
	<input type="button" value="Search" onclick="change()" />
</p>

<hr />

<br />

<!-- 
<table border="1">
	<tr>
		<th rowspan="2"> Train No </th>
        <th rowspan="2"> Train Name </th>
		<th rowspan="2"> Type </th>
		<th rowspan="2"> Origin </th>
        <th rowspan="2"> Destination </th>
        <th colspan="7"> Days Of Run </th>
	</tr>
	<tr>
    	<td> Mon</td>
        <td> Tue</td>
        <td> Wed</td>
        <td> Thu</td>
        <td> Fri</td>
        <td> Sat</td>
        <td> Sun</td>
	</tr >
 -->
<%
try{
		int tno=Integer.parseInt(request.getParameter("search"));
		
		String sql1="select t.train_no, t.train_name, t.type, r.s_station_name, r.d_station_name, t.mon, t.tue, t.wed, t.thu, t.fri, t.sat, t.sun from train_info t, route_main r where t.s_station_id=r.s_station_id and t.train_no=?;";
		
		pstmt = con.prepareStatement(sql1);
		
		pstmt.setInt(1,tno);
		
		rs = pstmt.executeQuery();

		out.println("<h3> Train Details</h3>");
		out.println("<table border='1' bordercolor=#333333 style='color:white; font-weight: bold;'>");
		out.println("<tr bgcolor=#333333>");
		out.println("<th rowspan='2'> Train No </th>");
		out.println("<th rowspan='2'> Train Name </th>");
		out.println("<th rowspan='2'> Type </th>");
		out.println("<th rowspan='2'> Origin </th>");
		out.println("<th rowspan='2'> Destination </th>");
		out.println("<th colspan='7'> Days Of Run </th>");
		out.println("</tr>");
		out.println("<tr bgcolor=#333333>");
				out.println("<td> Mon</td>");
				out.println("<td> Tue</td>");
				out.println("<td> Wed</td>");
				out.println("<td> Thu</td>");
				out.println("<td> Fri</td>");
				out.println("<td> Sat</td>");
				out.println("<td> Sun</td>");
				out.println("</tr>");

		int flag=0;
		while(rs.next()){
			
			flag=1;
			out.println("<tr style='color:blue;font-weight: bold;'>");
			out.println("<td>"+ rs.getInt("train_no") +"</td>");
			out.println("<td>"+ rs.getString("train_name") +"</td>");
			out.println("<td>"+ rs.getString("type") +"</td>");
			out.println("<td>"+ rs.getString("s_station_name") +"</td>");
			out.println("<td>"+ rs.getString("d_station_name") +"</td>");
			
			if(rs.getString("mon").equalsIgnoreCase("Y")){
				out.println("<td><span style='color: green;font-weight: bold;'>");
			}else{
				out.println("<td><span style='color: red;font-weight: bold;'>");				
			}
			out.println(rs.getString("mon") +"</span></td>");

			
			if(rs.getString("tue").equalsIgnoreCase("Y")){
				out.println("<td><span style='color: green;font-weight: bold;'>");
			}else{
				out.println("<td><span style='color: red;font-weight: bold;'>");				
			}
			out.println(rs.getString("tue") +"</span></td>");

			
			if(rs.getString("wed").equalsIgnoreCase("Y")){
				out.println("<td><span style='color: green;font-weight: bold;'>");
			}else{
				out.println("<td><span style='color: red;font-weight: bold;'>");				
			}
			out.println(rs.getString("wed") +"</span></td>");

			
			if(rs.getString("thu").equalsIgnoreCase("Y")){
				out.println("<td><span style='color: green;font-weight: bold;'>");
			}else{
				out.println("<td><span style='color: red;font-weight: bold;'>");				
			}
			out.println(rs.getString("thu") +"</span></td>");

			
			if(rs.getString("fri").equalsIgnoreCase("Y")){
				out.println("<td><span style='color: green;font-weight: bold;'>");
			}else{
				out.println("<td><span style='color: red;font-weight: bold;'>");				
			}
			out.println(rs.getString("fri") +"</span></td>");

			
			if(rs.getString("sat").equalsIgnoreCase("Y")){
				out.println("<td><span style='color: green;font-weight: bold;'>");
			}else{
				out.println("<td><span style='color: red;font-weight: bold;'>");				
			}
			out.println(rs.getString("sat") +"</span></td>");

			
			if(rs.getString("sun").equalsIgnoreCase("Y")){
				out.println("<td><span style='color: green;font-weight: bold;'>");
			}else{
				out.println("<td><span style='color: red;font-weight: bold;'>");				
			}
			out.println(rs.getString("sun") +"</span></td>");
			
			out.println("</tr>");

%>
<!-- 	<tr>
		<td>  <%= rs.getInt("train_no") %> </td>
		<td>  <%= rs.getString("train_name") %> </td>
		<td>  <%= rs.getString("type") %> </td>
		<td>  <%= rs.getString("s_station_name") %> </td>
		<td>  <%= rs.getString("d_station_name") %> </td>
		<td>  <%= rs.getString("mon") %> </td>
		<td>  <%= rs.getString("tue") %> </td>
		<td>  <%= rs.getString("wed") %> </td>
		<td>  <%= rs.getString("thu") %> </td>
		<td>  <%= rs.getString("fri") %> </td>
		<td>  <%= rs.getString("sat") %> </td>
		<td>  <%= rs.getString("sun") %> </td></tr>
 -->
<%
		}
	out.println("</table>");
	
	if(flag==0){
		%>
		<script type="text/javascript">
		alert("Train No Doesnot Exist");
		</script>
		<%
	}
	}catch(Exception e){
		
	}
%>
<!-- 
</table>
 -->
<br />

<!-- 
<h3> Schedule Of The Train </h3>

<table border="1">
	<tr>
        <th> Stn Id </th>
        <th> Stn Name </th>
        <th> Arrival Time </th>
        <th> Dep. Time </th>
        <th> Distance </th>
	</tr>
 -->	
<% 	
try{
		int tno=Integer.parseInt(request.getParameter("search"));
		
		String sql2=" select t.station_id, r.station_name, t.arv_time, t.dep_time, r.km from train_schedule t, route r where t.train_no=? and t.station_id = r.station_id";
		
		pstmt = con.prepareStatement(sql2);
		
		pstmt.setInt(1,tno);
		
		rs = pstmt.executeQuery();

		out.println("<h3> Schedule Of The Train </h3>");

		out.println("<table border='1'  bordercolor=#333333 style='color:white; font-weight: bold;'>");
		out.println("<tr bgcolor=#333333>");
		out.println("<th> Stn Id </th>");
		out.println("<th> Stn Name </th>");
		out.println("<th> Arrival Time </th>");
		out.println("<th> Dep. Time </th>");
		out.println("<th> Distance </th>");
		out.println("</tr>");

		while(rs.next()){
			
			out.println("<tr style='color:blue;font-weight: bold;'>");
			out.println("<td>"+ rs.getInt("station_id") +"</td>");
			out.println("<td>"+ rs.getString("station_name") +"</td>");
			out.println("<td>"+ rs.getString("arv_time") +"</td>");
			out.println("<td>"+ rs.getString("dep_time") +"</td>");
			out.println("<td>"+ rs.getString("km") +"</td>");
			out.println("</tr>");
%>
<!-- 	<tr>
		<td>  <%= rs.getInt("station_id") %> </td>
		<td>  <%= rs.getString("station_name") %> </td>
		<td>  <%= rs.getString("arv_time") %> </td>
		<td>  <%= rs.getString("dep_time") %> </td>
		<td>  <%= rs.getString("km") %> </td>
		</tr>
 -->
<%
		}
		out.println("</table>");
	}catch(Exception e){
		
	}
%>
<!--  </table> -->
</form>
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
