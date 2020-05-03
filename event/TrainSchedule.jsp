<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> Vehical Schedule Insertion </title>
<meta name="keywords" content="Home" />
<link href="./css/templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />
<link title="theme" type="text/css" href="timepicker/jquery-ui-1.8.17.custom.css" media="screen" rel="Stylesheet" id="themeCSS" />
<link rel="stylesheet" media="screen" href="timepicker/ui.timepickr.css" />
<script type="text/javascript" src="timepicker/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="timepicker/jquery.timepickr.min.js"></script>
<script type="text/javascript">  
$(document).ready(function(){ 
$('#timestart').timepickr({
		rangeMin: ['00','05','10','15','20','25','30','35','40','45','50','55'],
		convention: 24} ).focus(); //timestart.timepickr
}); //document ready
</script>

<script type="text/javascript">  
$(document).ready(function(){ 
	for(var i=1; i<60; i++){
		$('#timestart'+i).timepickr({
				rangeMin: ['00','05','10','15','20','25','30','35','40','45','50','55'],
				convention: 24} ).focus(); //timestart.timepickr
		}
	}
); //document ready

</script>


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
<!-- Input Validation Script -->
<script type="text/javascript" src="InputValidation.js">
</script>


<script type="text/javascript">
function validate(){
	if(Empty(document.form1.arv1)){		//Empty Field Validation Call
		   if(Empty(document.form1.dep1)){
		     if(Empty(document.form1.arv2)){
			   if(Empty(document.form1.dep2)){
					document.form1.submit();
			   }
		     }
		   }
	}
}
</script>

<script type="text/javascript">
function num2(ele){
	var val = ele.value;
	var len = val.length;
	if(val.search(/[^0-9\:]/) != -1){			// \D is For Not A Digit searc i.e [^0-9]
		alert("Enter Only Digits and :");
		ele.value = ele.value.substring(0,len-1);
		ele.focus();
		return false;
 }
	 return true;
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


<form name="form1" action="./TrainSchedule1.jsp">
<h1 align="center"> Updation Of Event Schedule</h1>
	<%
	
	String trainno = request.getParameter("trainno");
	String tname= request.getParameter("tname");
	String type= request.getParameter("type");
	String src= request.getParameter("src");
	String dest= request.getParameter("dest");
		
	String srcid= request.getParameter("srcid");
	String destid= request.getParameter("destid");
	String km= request.getParameter("km");
	String[] days = new String[7];
		
	String[] day=request.getParameterValues("days");
	
	   if (day != null)
	   {
	      for (int i = 0; i < day.length; i++)
	      {
	         days[i] = day[i];
	       %>
	       <input type="hidden" name="day" value=<%= days[i] %> />
	      <%
	      }
	   }
%>
	
<!-- Values to forward to the next page -->	
<input type="hidden" name="srcid" value=<%= srcid%> />
<input type="hidden" name="destid" value=<%= destid%> />
<input type="hidden" name="km" value=<%= km%> />


<div id="divHead">
<br />
<table align="center">
	<tr>
	  <th colspan="2"> Event Details </th>
	</tr>
		
	<tr>
		<td><label> Vehical No </label></td>
		<td><input type="text" name="trainno" value="<%= trainno %>" readonly="readonly" tabindex="-1"/></td>
	</tr>
	<tr>
		<td><label> Vehical Name </label></td>
		<td><input type = "text" name="tname" value="<%= tname%>" readonly="readonly" tabindex="-1"/></td>
	</tr>
	<tr>
		<td><label> Type </label></td>
		<td><input type = "text" name="type" value="<%= type %>" readonly="readonly" tabindex="-1"/></td>
	</tr>
	<tr>
		<td><label> Source </label></td>
		<td><input type = "text" value="<%= src %>" readonly="readonly" tabindex="-1"/></td>
	</tr>
	<tr>
		<td><label> Destination </label></td>
		<td><input type = "text" value="<%= dest %>" readonly="readonly" tabindex="-1"/></td>
	</tr>
</table>
</div>

<div id="divTable" align="center" style="">

<br />
<hr />
<h4> Schedule Table </h4>
<span style=" font-size: 14px; color: red;"> *Use 24hr Format</span>
<table id="table1" border="1" bordercolor=#333333>
<tr bgcolor=#333333 style="color: white">
    	<th> Station No </th>
    	<th> Kilometers</th>
        <th> Station Name </th>
        <th> Arrival Time </th>
        <th> Departure Time </th>
    </tr>

<%

String id = request.getParameter("srcid");		//TO FETCH THE SOURCE STATION ID 
int len = id.length();
String id1 = id.substring(0,len-2);			//To get the starting digits of station id by eliminating the last to digits
id1 = id1 + "%%";		//Adding %% to find the stations which come under the range of station id ex: 1%% i.e 100 to 199
String sql1="select * from route where station_id like '"+id1+"' ";		//SQL Query that gets station id's which come under one route

pstmt = con.prepareStatement(sql1);

rs = pstmt.executeQuery();

int i =1;

while(rs.next()){
%>
	<tr>
	<td> <input type="text" name="station<%=i %>" size="4" readonly="readonly" tabindex="-1" value="<%= rs.getInt("station_id") %>" /> </td>
	<td> <input type="text" size="5" readonly="readonly" tabindex="-1" value="<%= rs.getInt("km")%>" /> </td>
	<td> <input type="text" readonly="readonly" tabindex="-1" value="<%= rs.getString("station_name")%>" /> </td>
	<td> <input type="text" id="arv"  size="8" maxlength="5" onkeyup="num2(this)" onkeydown="num2(this)" style="font-weight: bold;  background-color: white;" /> </td>
	<td> <input type="text" id="dep"  size="8" maxlength="5" onkeyup="num2(this)" onkeydown="num2(this)" style="font-weight: bold; background-color: white;" /> </td>
	</tr>
<%
	i=i+1;
}

%>

</table>


<p>
<input type="submit" value="Save" onclick="validate()" />
</p>

</div>

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
        </div>
        <div class="cleaner"></div>
    </div>

</div> <!-- end of wrapper -->

<div id="footer"></div>
</body>
</html>
