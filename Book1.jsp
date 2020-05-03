<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Booking</title>
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
function call(){

	var tno = document.form1.tno.value;
	var date1 = document.form1.date1.value;
	var adult = document.form1.adult1.value;
	var child = document.form1.child1.value;
	var clas = document.form1.clas1.value;
	var src = document.form1.src.value;
	var des = document.form1.des.value;
		
	var id= document.getElementById("select1").value;
	var cid=document.getElementById("select1").selectedIndex;
	var val = document.getElementById("select1").options[cid].text;
	
	var url = window.location.href;
	var urlindex = url.indexOf('?');
	var url1 = "";
	if(urlindex > -1){
		url1 = url.substring(0, urlindex);
		window.location.replace(url1+"?tno="+tno+"&date1="+date1+"&clas="+clas+"&adult="+adult+"&child="+child+"&src="+src+"&des="+des+"&ch="+val);
	}
	else{
		window.location.replace(url+"?tno="+tno+"&date1="+date1+"&clas="+clas+"&adult="+adult+"&child="+child+"&src="+src+"&des="+des+"&ch="+val);
	}
}


function validate(){
	
	try{
	var ad = document.form1.adult.value;
	var child = document.form1.child.value;
	var no = document.form1.seat.length;	//No of checkbox for seats per coach
	var chk=0;
	var total = parseInt(ad) + parseInt(child);		//Count no of seats for a ticket
	
	var w = new Array();	//To Store the values of waiting list seats
	var windex = 0;		//index initializer for w[]

	if(no==undefined){
		if (document.form1.seat.checked == true){			
			chk = chk +1;		//For single checkbox the lenght is undefined so checking once
		}			
	}
	else{
		for(var i=0; i< parseInt(no); i++){

			if (document.form1.seat[i].checked == true){			
				chk = chk +1;	//To Count The no of checkbox been selected

				var val = document.form1.seat[i].value;
				if ( val.charAt(0) == 'W'){			//To Check if the user has selected Waiting list
					w[windex]= val;
					windex = windex + 1;
				}	
			
			}	
		}
	}

	if(chk < total){	
		alert("Please Select Seats For All "+total+" Passengers");
		return false;
	}
	
	//If any 2 waiting list seats are selected then this block executes to check whether user selects consecutive no's are not
	if(windex > 1){			
		for(var j=0; j< parseInt(w.length)-1 ;j++){
			var n1 = w[j].substring(1);
			var n2 = w[j+1].substring(1);
			if( (parseInt(n2) - 1) != parseInt(n1) ){
				alert("Select Consecutive Seats from Waiting list");
				return false;
			}
		}
	}
		document.form1.submit();	//Submit the value to next page when return false is not executed
	}
	catch (e) {
		alert("Select The Coach");
		// TODO: handle exception
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
		if(ssid == sessionid && author.equals("user")) {
		%>

<form name="form1" action="./Book3.jsp">
<h1>Ticket Reservation</h1>
<br />

<table border="1" bordercolor=#333333>
	<tr bgcolor=#333333>
		<th colspan="6" align="left" style="color:white;"> Train Details : </th>
	</tr>
	
<%
int tno=0;
String dt = "";
String clas="";
String adult="";
String child="";
String class1="";
String srcid = "";
String desid = "";
int coach_size=0; //To Get The No Of Coaches as per The Selected Class Type
try{
	
		tno = Integer.parseInt(request.getParameter("tno"));
		dt = request.getParameter("date1");
		clas = request.getParameter("clas");
		adult = request.getParameter("adult");
		child = request.getParameter("child");
		srcid = request.getParameter("src");
		desid = request.getParameter("des");
		
		
        if (clas.equals("sl")){
       			class1="Sleeper Class";
       	}else if(clas.equals("a1")){
				class1="AC First Class";
       	}else if(clas.equals("a2")){
       			class1="AC 2 Tier";
       	}else if(clas.equals("a3")){
				class1="AC 3 Tier";
       	}
		
		String sql4="select distinct t.train_no, t.train_name, t.type, t.distance, t.sl, t.a1, t.a2, t.a3, r.s_station_name, r.d_station_name, s.dep_date from train_info t, route_main r, s1 s where t.train_no=? and t.s_station_id=r.s_station_id and s.dep_date=? and s.train_no=t.train_no;";

		pstmt = con.prepareStatement(sql4);
		pstmt.setInt(1,tno);
		pstmt.setString(2,dt);
	
		rs=pstmt.executeQuery();
		
		while(rs.next()){
%>

			<tr>
		    	<th> Train No: </th>
				<td>  <input type="text" name="tno" size="5" value="<%= rs.getString("train_no") %>" readonly="readonly" tabindex="-1" /> </td>
		        <th> Train Name: </th>
				<td>  <input type="text" size="20" value="<%= rs.getString("train_name") %>" readonly="readonly" tabindex="-1" /> </td>
				<th> Class: </th>
				<td>  <input type="text" size="13" value="<%= class1 %>" readonly="readonly" tabindex="-1" /> </td>
			</tr>
			<tr>
				<th> Distance : </th>
	    		<td>  <input type="text" size="9" value="<%= rs.getString("distance") %>" readonly="readonly" tabindex="-1" /> </td>
		    	<th> Source Station: </th>
				<td>  <input type="text" size="13" value="<%= rs.getString("s_station_name") %>" readonly="readonly" tabindex="-1" /> </td>
				<th> Destination Station: </th>	
				<td>  <input type="text" size="13" value="<%= rs.getString("d_station_name") %>" readonly="readonly" tabindex="-1" /> </td>
			</tr>

<%	
			coach_size = rs.getInt(clas);//No Of coach based on the selected class
		}
}catch(Exception e){
}
%>	
</table>

<input name="adult1" type="hidden" value="<%= adult %>" />
<input name="child1" type="hidden" value='<%= child %>' />
<input name="clas1" type="hidden" value='<%= clas %>' />
<input name="src" type="hidden" value='<%= srcid %>' />
<input name="des" type="hidden" value='<%= desid %>' />

<%
String source = "";
String dest = "";
int skm=0;
int dkm=0;
int totalkm=0;

try{

	String sql5 = "select * from route where station_id=?";
	
	pstmt = con.prepareStatement(sql5);
	
	pstmt.setString(1,srcid);			//To fetch the details of source station
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		source = rs.getString("station_name");
		skm = rs.getInt("km");
	}
	
	pstmt.setString(1,desid);			//To fetch the details of destination station
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		dest = rs.getString("station_name");
		dkm = rs.getInt("km");
	}
	
	totalkm = dkm - skm;			//The calculate the travelling distance
	
}
catch(Exception e){
	
}

%>

<br>
<table border="1" bordercolor=#3333333>
	<tr bgcolor=#333333>
		<th align="left" colspan="6" style="color:white"> Travel Details : </th>
	</tr>
	<tr>
				<th> Travel Date: </th>
	    		<td>  <input type="text" name="date1" size="9" value="<%= dt %>" readonly="readonly" tabindex="-1" /> </td>
				<th> No Of Adult Seats: </th>
	    		<td>  <input type="text" size="9" value="<%= adult %>" readonly="readonly" tabindex="-1" /> </td>
				<th> No Of Child Seats: </th>
	    		<td>  <input type="text" size="9" value="<%= child %>" readonly="readonly" tabindex="-1" /> </td>
	</tr>
	<tr>
				<th> Travel Km: </th>
	    		<td>  <input type="text" name="totalkm" size="9" value="<%= totalkm %>" readonly="readonly" tabindex="-1" /> </td>
				<th> Boarding Station: </th>
	    		<td>  <input type="text" size="9" value="<%= source %>" readonly="readonly" tabindex="-1" /> </td>
				<th> RESV. UPTO: </th>
	    		<td>  <input type="text" size="9" value="<%= dest %>" readonly="readonly" tabindex="-1" /> </td>
	</tr>
</table>




<br />
<h3> Seat Selection </h3>
<p>
<%
	out.println("<span style='color:red;'>Select Coach</span>");
	out.println("<select id='select1' onchange='call()' >");
	out.println("<option selected='selected'>--Select Coach--</option>");
	for(int i=1; i<= coach_size; i++){
			if (clas.equals("sl")){
				out.println("<option value=S"+i+"> S"+i+" </option>");
	   		}else if(clas.equals("a1")){
				out.println("<option value=A"+i+"> A"+i+" </option>");
	   		}else if(clas.equals("a2")){
				out.println("<option value=B"+i+"> B"+i+" </option>");
	   		}else if(clas.equals("a3")){
				out.println("<option value=C"+i+"> C"+i+" </option>");
		   	}		
	}
	out.println("</select>");


%>
<!-- 	Coach
	<select id="select1" onchange="call()" >
	<option selected="selected">--Select Coach--</option>
	<option value="s1"> s1 </option>
	<option value="s2"> s2 </option>
	<option value="s3"> s3 </option>
	</select> -->
</p>
	<jsp:include page ="./Book2.jsp" />
	

<p>
<input type="button" value="Continue Reservation" onclick="validate()"   />
</p>

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
