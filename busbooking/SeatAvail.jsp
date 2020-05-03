<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Search Trains</title>
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
				 minDate: +1, maxDate: "+1W +0D" });
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
	PreparedStatement pstmt = null, pstmt1 = null, pstmt2 = null;
	ResultSet rs = null, rs1 = null ;
	
	
	
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
			window.location.replace(url1+"?sid="+sid+"&did="+did+"&des="+val1);
		}
		else{
			window.location.replace(url+"?sid="+sid+"&did="+did+"&des="+val1);
		}
}

function search(){

	var src = document.form1.source1.value;
	var des = document.form1.destination1.value;
	var date = document.form1.date.value;
	
	if(src == 0){
		alert("Please Select The source And Destination Stations");
		document.getElementById("select1").focus();
	}else if(date == ""){
		alert("Please Select The Date Of Travel");
		document.form1.date.focus();		
	}
	else{
		var url = window.location.href;
		var urlindex = url.indexOf('?');
		var url1 = "";
		if(urlindex > -1){
			url1 = url.substring(0, urlindex);
			window.location.replace(url1+"?sid="+src+"&did="+des+"&date="+date);
		}
		else{
			window.location.replace(url+"?sid="+src+"&did="+des+"&date="+date);
		}
	}
}

function next(){
//	alert("Start");
	document.form1.submit();
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

<div align="center" style=" font-family:'Times New Roman', Times, serif;font-size:16px;">
<%
//Session Validation
try{
	if(session.isNew()){
			out.println("<h3><span style='color: red;'>Access Denied Only Registered Users Can Make The Booking</span></h3>");	
	}
	else{
	String uname = (String)session.getAttribute("uname");
	String ssid = (String)session.getAttribute("sid");
	String author = (String)session.getAttribute("author");
	String sessionid = (String)session.getId();
		if(ssid == sessionid && author.equals("user")) {
		%>

<form name="form1" action="./Book.jsp">
<h1> Search Trains Between Stations </h1>
<br/>
<table>
	<tr align="left">
		<td> <label style="font-weight: bold;"> Source Station </label> </td>
       
				<td>

					<%
					String value = request.getParameter("value");
					String sql1="select * from route_main";
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
	var sel = document.getElementById("select1");
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

	}
}
</script>
<!-- End JavaScript To Eliminate Similar Station Names Generated From BackEnd -->
						
				</td>



	</tr>
	<tr align="left">
		<td> <label style="font-weight: bold;"> Destination Station </label> </td>

			<td>
				<select id="select2" name="destid" onchange="extract()">
				<option value="0">--Please Select--</option>
				<%
				String s_sta=request.getParameter("value");
				String sql2 ="select * from route_main where s_station_name='"+s_sta+"'";
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
<hr>

<br />

<table border="1" bordercolor=#333333>
	<tr bgcolor=#333333 style="color:white;">
		<th> Source Station </th>
        <th> Destination Station </th>
	</tr>

	<tr>
<%
String src="";
String des="";
int did=0;
int sid=0;
try{
	 did=Integer.parseInt(request.getParameter("did"));
	 sid = did - 99;
	
	String sql3 ="select station_name from route where station_id=?";
	
	pstmt = con.prepareStatement(sql3);
	
	pstmt.setInt(1,sid);
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		src = rs.getString("station_name");
	}
	
	pstmt.setInt(1,did);
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		des = rs.getString("station_name");
	}
	
}
catch(Exception e){
	
}

%>		

		<td>
		
		<input type="hidden" name="source1" readonly="readonly" value="<%= sid %>"/>
		<input type="hidden" name="destination1" readonly="readonly" value="<%= did %>"/>
		
		<input type="text" readonly="readonly" value="<%= src %>"/> </td>
		<td><input type="text" readonly="readonly" value="<%= des %>"/> </td>


	</tr>
	<tr align="left">
    	<td bgcolor=#333333 style="color:white; font-weight:bold;"> <label > Date Of Travel </label> </td>
       	<td> <input type="text" name="date" id="datepicker" title="YYYY/MM/DD" style="background-color: white;" /> </td>
    </tr>
</table>
<p>
	<input type="button" value="Search" onclick="search()" />
</p>
<br />

<!-- <h3> Trains Between a Pair Of Stations </h3>

<table border="1" align="left">
	<tr>
		<th> Train No </th>
        <th> Train Name </th>
		<th> Type </th>
	    <td> Date <br> (Y-MM-DD)</td>
    	<th> Origin </th>
		<th> Destination </th>
    </tr>
 -->
<%
int srcid = 0;
int desid = 0;
String dt = "";
try{
	
	
	
		srcid = Integer.parseInt(request.getParameter("sid"));
		desid = Integer.parseInt(request.getParameter("did"));
		dt = request.getParameter("date");		//Requested Date Of Travel
		
		String d1 = dt;			//d1 contains "YYYY/MM/DD"
		String y = d1.substring(0,4);		//To Fetch Year
		String m = d1.substring(5,7);		//To Fetch Month
		String d = d1.substring(8);			//To Fetch Date

		Calendar cal2 = Calendar.getInstance();
		cal2.set(Integer.parseInt(y),Integer.parseInt(m) - 1,Integer.parseInt(d) );	//Month statrs from 0 in Calendar, subtracting 1 from present Month
		

		int week3 = cal2.get(Calendar.DAY_OF_WEEK);
				
		String week_travel = "";
		if(week3 == 1){						//DAY_OF_WEEK = 1 => Sunday
			week_travel = "sun";
		}else if(week3 == 2){				//DAY_OF_WEEK = 2 => Monday
			week_travel = "mon";
		}else if(week3 == 3){				//DAY_OF_WEEK = 3 => Tuesday
			week_travel = "tue";
		}else if(week3 == 4){				//DAY_OF_WEEK = 4 => Wednesday
			week_travel = "wed";
		}else if(week3 == 5){				//DAY_OF_WEEK = 5 => Thursday
			week_travel = "thu";
		}else if(week3 == 6){				//DAY_OF_WEEK = 6 => Friday
			week_travel = "fri";
		}else if(week3 == 7){				//DAY_OF_WEEK = 7 => Saturday
			week_travel = "sat";
		}
		
		//Checking in train_info if the train travels on that DAY_OF_WEEK
		//if train travles and there is no data in backEnd then insertion of data into coaches as per the no of coaches
		String sql3="select distinct * from train_info where s_station_id=? and d_station_id=?; ";
		
		pstmt = con.prepareStatement(sql3);
		pstmt.setInt(1,srcid);
		pstmt.setInt(2,desid);
		rs=pstmt.executeQuery();

//		System.out.println(week_travel);
		while(rs.next()){
//			System.out.println(rs.getString("train_no"));
			
			//if condition to check if the train travels on that day of week
			if(rs.getString(week_travel).equalsIgnoreCase("Y")){
	//			System.out.println(rs.getString("train_no"));
	//			System.out.println(week_travel);
	//			System.out.println(rs.getString(week_travel));
							
				//select statement to check if the data of train on that particular day is present in backend
				String sql5 = "select dep_date from s1 where train_no="+rs.getString("train_no")+" and dep_date='"+dt+"';";
				pstmt1 = con.prepareStatement(sql5);
				rs1 = pstmt1.executeQuery();

					int flag = 0 ;		//A Flag Variable for checking				
					// If the train details on that particular day is present in BackEnd it returns one row of data
					if(rs1.next()){
						
						flag = 1;		// here flag variable should be set to 1 as a row is been retrived
					}
				
					//flag remains 0 if there is no data availabel at backend of train travelling on the particular day
					if(flag == 0)
					{
						int sl=Integer.parseInt(rs.getString("sl"));		//Fetching the no of sleeper class coaches from the rs resultset
						int a1=Integer.parseInt(rs.getString("a1"));		//Fetching the no of AC First class coaches from the rs resultset
						int a2=Integer.parseInt(rs.getString("a2"));		//Fetching the no of AC 2 Tier class coaches from the rs resultset
						int a3=Integer.parseInt(rs.getString("a3"));		//Fetching the no of AC 3 Tier class coaches from the rs resultset

						for(int i=1; i<= a1; i++){			//Inserting values into ac first class i.e tables with "a1" type coach no
							String sql6 = "insert into a"+i+" (train_no, dep_date) values ("+rs.getString("train_no")+",'"+dt+"')";
							pstmt2 = con.prepareStatement(sql6);
							pstmt2.executeUpdate();
						}

						for(int i=1; i<= sl; i++){			//Inserting values into Sleeper class i.e tables with "s1" type coach no
							String sql7 = "insert into s"+i+" (train_no, dep_date) values ("+rs.getString("train_no")+",'"+dt+"')";
							pstmt2 = con.prepareStatement(sql7);
							pstmt2.executeUpdate();
						}

						for(int i=1; i<= a2; i++){			//Inserting values into AC 2 Tier Class i.e tables with "b1" type coach no
							String sql8 = "insert into b"+i+" (train_no, dep_date) values ("+rs.getString("train_no")+",'"+dt+"')";
							pstmt2 = con.prepareStatement(sql8);
							pstmt2.executeUpdate();
						}

						for(int i=1; i<= a3; i++){			//Inserting values into AC 3 Tier class i.e tables with "c1" type coach no
							String sql9 = "insert into c"+i+" (train_no, dep_date) values ("+rs.getString("train_no")+",'"+dt+"')";
							pstmt2 = con.prepareStatement(sql9);
							pstmt2.executeUpdate();
						}

					}		//End of if(flag==0) loop
				
			}	//Close Of if condition for week_travel
		}
		
		
		
		
		
		//to fetch trains available in th selected route and on selected departure date
		String sql4="select distinct t.train_no, t.train_name, t.type, r.s_station_name, r.d_station_name, s.dep_date from train_info t, route_main r, s1 s where t.s_station_id=r.s_station_id and t.s_station_id=? and t.d_station_id=? and s.dep_date=? and s.train_no=t.train_no";

		pstmt = con.prepareStatement(sql4);
		pstmt.setInt(1,srcid);
		pstmt.setInt(2,desid);
		pstmt.setString(3,dt);
	
		rs=pstmt.executeQuery();

		
		out.println("<h3> Trains Between a Pair Of Stations </h3>");
		out.println("<div align='left'>");
		out.println("<span style='color:red;'> Select The Train No To Proceed For Booking</span>");
		out.println("<table border='1' align='left' bordercolor=#222222>");
		out.println("<tr bgcolor=#3333333 style='color:white; font-weight: bold;'>");
		out.println("<th> Train No </th>");
		out.println("<th> Train Name </th>");
		out.println("<th> Type </th>");
		out.println("<th> Date <br> (Y-MM-DD)</th>");
		out.println("<th> Origin </th>");
		out.println("<th> Destination </th>");
		out.println("</tr>");

		int flag=0;
		while(rs.next()){
			flag=1;
			out.println("<tr style='color:blue; font-weight: bold;'>");
			out.println("<td>  <input type='radio' name='tno' size='5' value="+rs.getInt("train_no")+" onclick='next()' /> "+rs.getInt("train_no")+" </td> ");
			out.println("<td>  <input type='text' value="+rs.getString("train_name")+" readonly='readonly' /> </td>");
			out.println("<td>  <input type='text' size='10' value="+rs.getString("type")+" readonly='readonly' /> </td>");
			out.println("<td>  <input type='text' name='date1' size='10' value="+rs.getDate("dep_date")+" readonly='readonly' /> </td>");
			out.println("<td>  <input type='text' size='15' value="+rs.getString("s_station_name")+" readonly='readonly' /> </td>");
			out.println("<td>  <input type='text' size='15' value="+rs.getString("d_station_name")+" readonly='readonly' /> </td>");
			out.println("</tr>");
			
			
%>
<!-- 			<tr>
			<td>  <input type="radio" name="tno" size="5" value="<%= rs.getInt("train_no") %>" onclick="next()" /> <%= rs.getInt("train_no") %> </td>
			<td>  <input type="text" value="<%= rs.getString("train_name") %>" readonly="readonly" /> </td>
			<td>  <input type="text" size="10" value="<%= rs.getString("type") %>" readonly="readonly" /> </td>
			<td>  <input type="text" name="date1" size="10" value="<%= rs.getDate("dep_date") %>" readonly="readonly" /> </td>
			<td>  <input type="text" size="15" value="<%= rs.getString("s_station_name") %>" readonly="readonly" /> </td>
			<td>  <input type="text" size="15" value="<%= rs.getString("d_station_name") %>" readonly="readonly" /> </td>
			</tr>
-->
<%	
		}
		out.println("</table>");
		out.println("</div>");
		if(flag==0){
			%>
			<script type="text/javascript">
				alert("No Trains Found For The Date Of Travel");
			</script>
			<%
		}
}catch(Exception e){
}
%>

<!-- </table> -->
</form>
		<%
		//Session Validation

		}
		else{
			out.println("<h3><span style='color: red;'>Access Denied Only Registered Users Can Make The Booking</span></h3>");	
		}
	}
}
catch(Exception e){
	out.println("<h3><span style='color: red;'>Access Denied Only Registered Users Can Make The Booking</span></h3>");	
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
              <h6><a href="SearchSchedule.jsp">Bus Schedules</a></h6>
              <h6><a href="ViewFare.jsp">Fare List</a></h6>
              <h6><a href="http://www.indianrail.gov.in" target="_new">Other Railway Websites </a></h6>
         
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
