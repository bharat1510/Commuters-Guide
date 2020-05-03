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
<link href="css/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />

<title> Fare Chart </title>

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
function values(){
		var id= document.form1.type.value;
		var cid=document.form1.type.selectedIndex;
		var val = document.form1.type.options[cid].text;

		var url = window.location.href;
		var urlindex = url.indexOf('?');
		var url1 = "";
		if(urlindex > -1){
			url1 = url.substring(0, urlindex);
			window.location.replace(url1+"?value="+val);
		}
		else{
			window.location.replace(url+"?value="+val);
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

<form name="form1" action="">

<h1>Fare Chart</h1>
<br/>
<p>
<span style="font-weight: bold;">Select Bus type </span>
            <select name="type" onchange="values()">
	            <option value="0">--Please Select--</option>
	            <option value="ORDINARY"> ORDINARY </option>
	            <option value="EXPRESS"> EXPRESS </option>
	            <option value="RAJDHANI"> RAJDHANI  </option>
            </select>
</p>

<%
	tryloop: try{
	String value = request.getParameter("value");	
	if (value == null)
	{
		value = "Not Specified";
		break tryloop;
	}
		String sql="select * from fare1 where type='"+value+"';";
		pstmt=con.prepareStatement(sql);
		
		rs=pstmt.executeQuery();

		out.println("<table border='1' bordercolor=#333333 style='color:white; font-weight: bold;'>");
		out.println("<tr bgcolor=#333333>");
		out.println("<th colspan='5'> Bus Type : <span style='color: white;'>"+ value +"</span> </th>");
		out.println("</tr>");
		out.println("<tr bgcolor=#333333>");
			out.println("<th> KM </th>");
			out.println("<th> Sleeper Class </th>");
			out.println("<th> AC First Class </th>");
			out.println("<th> AC 2 Tier </th>");
			out.println("<th> AC 3 Tier </th>");

		out.println("</tr>");

		int flag=0;
		
		while (rs.next()){
			flag=1;
			out.println("<tr style='color:blue; font-weight: bold;'>");
			out.println("<td style='color:black;'>" + rs.getInt("km") + "</td>");
			out.println("<td>" +rs.getDouble("sl") + "</td>");
			out.println("<td>" +rs.getDouble("a1") + "</td>");
			out.println("<td>" +rs.getDouble("a2") + "</td>");
			out.println("<td>" +rs.getDouble("a3") + "</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		if(flag==0){
			%>
				<script type="text/javascript">
				alert("No Data Found");
				</script>
			<%
		}
	}
	catch(Exception e){
		
	}

%>

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
            
              <h6 ><a href="SearchTrain.jsp">Bus Btw Stations</a></h6>
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
</body>
</html>
