<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Buses</title>
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


function change(){
		var sid= document.getElementById("select1").value;
		var cid=document.getElementById("select1").selectedIndex;
		var val = document.getElementById("select1").options[cid].text;
		
		var url = window.location.href;
		var urlindex = url.indexOf('?');
		var url1 = "";
		if(urlindex > -1){
			url1 = url.substring(0, urlindex);
			window.location.replace(url1+"?sid="+sid+"&value="+val);
		}
		else{
			window.location.replace(url+"?sid="+sid+"&value="+val);
		}
}

function extract(){
		var sid= document.getElementById("select1").value;
		var did= document.getElementById("select2").value;
		var id1=document.getElementById("select2").selectedIndex;
		var val1 = document.getElementById("select2").options[id1].text;

		var url = window.location.href;
		var urlindex = url.indexOf('?');
		var url1 = "";
		if(urlindex > -1){
			url1 = url.substring(0, urlindex);
			window.location.replace(url1+"?src="+sid+"&did="+did+"&des="+val1);
		}
		else{
			window.location.replace(url+"?src="+sid+"&did="+did+"&des="+val1);
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

<div align="center">
<form name="form1">
<h1> Search Buses Between Stations </h1>
<table>
			<tr>
				<td>	Source Station	</td>
				<td>

					<%
					String value = request.getParameter("value");
					String sql1="select * from route_main1";
					pstmt = con.prepareStatement(sql1);
					rs = pstmt.executeQuery();
					%>
					
					<select id="select1" name="source" onchange="change();" onfocus="back()">
					<option value="0">--Please Select--</option>
					<% while(rs.next()){ %>
					<% if(rs.getString(3).equals(value)){%>
					<option value="<%= value%>" selected="selected" disabled="disabled"><%=value%></option>
					<%
					}
					else{
					%>
					<option value="<%=rs.getString(2)%>"><%=rs.getString(3)%></option>
					<%
					}
					}
					%>
					
					</select>
					
			
<!-- JavaScript To Eliminate Similar Station Names Generated From BackEnd -->
<script type="text/javascript">
function back(){
	var sel = document.form1.source;
	try{
	//alert("Start back()" + sel.length);
	
	for (var i=0; i< sel.length - 1; i++)
	{
		//alert(sel.options[i].text);		
		for (var j=i+1; j< sel.length; j++)
		{
			//alert(sel.options[j].text);
			var a = sel.options[i].text;
			var b = sel.options[j].text;
			//alert("a="+a);
			//alert("b="+b);
			if (a == b)
			 {
				sel.remove(j);
				back();
			 }			
		}
	}
	}
	catch(e){
		alert(e+"NO Route In The table");
	}
}
</script>
<!-- End JavaScript To Eliminate Similar Station Names Generated From BackEnd -->
						
				</td>

			<tr>

			<td>
				Destination Station
			</td>
			<td>
				<select id="select2" name="destid" onchange="extract()">
				<option value="0">--Please Select--</option>
				<%
				String s_sta=request.getParameter("value");
				String sql2 ="select * from route_main1 where s_station_name='"+s_sta+"'";
				pstmt = con.prepareStatement(sql2);
				rs = pstmt.executeQuery();
				while(rs.next()){
				%>
				<option value="<%=rs.getString(4)%>" ><%=rs.getString(5)%></option>
				<%
				}
				%>
				</select>
			</td>
			</tr>
</table>

<hr />
<br />

<!-- 
<h3> Trains Between a Pair Of Stations </h3>
<br />
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
	</tr>
 -->
<%
try{

		int did=Integer.parseInt(request.getParameter("did"));
		int sid = did - 99;
		
		String sql3="select s.bus_no, s.bus_name, s.type, r.s_station_name, r.d_station_name, s.mon, s.tue, s.wed, s.thu, s.fri, s.sat, s.sun from bus_info as s, route_main1 as r where s.s_station_id=r.s_station_id and s.s_station_id=? and s.d_station_id=?;";
		pstmt = con.prepareStatement(sql3);
		
		
		
		pstmt.setInt(1,sid);
		pstmt.setInt(2,did);
		
		rs = pstmt.executeQuery();

		out.println("<h3> Bus Between a Pair Of Stations </h3>");
		out.println("<br />");
		out.println("<table border='1' bordercolor=#333333 style='color:white; font-weight: bold;'>");
		out.println("<tr bgcolor=#333333>");
		out.println("<th rowspan='2'> Bus No </th>");
		out.println("<th rowspan='2'> Bus Name </th>");
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
			out.println("<tr style='color:blue; font-weight: bold;'>");
			out.println("<td>"+ rs.getInt("bus_no") +"</td>");
			out.println("<td>"+ rs.getString("bus_name") +"</td>");
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
<span style="font-weight: bold;"></span>
<!-- 	<tr>
		<td>  <%= rs.getInt("bus_no") %> </td>
		<td>  <%= rs.getString("bus_name") %> </td>
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
				alert("No Buses Found");
			</script>
			<%
		}
		}catch(Exception e){
		
	}
%>
<!-- 
</table>
 -->
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
            
              <h6><a href="SearchTrain.jsp">Bus Btw Stations</a></h6>
				<h6><a href="SearchSchedule.jsp">Bus Schedules</a></h6>	
              <h6><a href="ViewFare.jsp">Fare List</a></h6>
              <h6><a href="https://gsrtc.in/site/" target="_new">Other Bus Websites </a></h6>
         
            </div>
            
             <div class="cleaner"></div>
            
        </div>
        <div class="cleaner"></div>
    </div>

</div> <!-- end of wrapper -->


<div id="footer"></div>
	<script src="js/jquery.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
