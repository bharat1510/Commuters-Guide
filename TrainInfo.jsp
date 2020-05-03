<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>New Train Updation</title>
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
		var id= document.getElementById("select1").value;
		var cid=document.getElementById("select1").selectedIndex;
		var val = document.getElementById("select1").options[cid].text;
		
		var url = window.location.href;
		var urlindex = url.indexOf('?');
		var url1 = "";
		if(urlindex > -1){
			url1 = url.substring(0, urlindex);
			window.location.replace(url1+"?id="+id+"&value="+val);
		}
		else{
			window.location.replace(url+"?id="+id+"&value="+val);
		}
}

//function extract(){
//		var sid= document.getElementById("select2").value;
//		var id1=document.getElementById("select2").selectedIndex;
//		var val1 = document.getElementById("select2").options[id1].text;
//		window.location.replace("http://localhost:8080/Railways/TrainInfo.jsp?sid="+sid+"&des="+val1);
//}

function valid() {
	var tno = document.form1.trainno.value;
	if (document.getElementById("select1").value == 0){
		alert("Select The Source Station");	
		document.getElementById("select1").focus();
		return false;		
	}
	else if (document.getElementById("select2").value == 0){
		alert("Select The Destination Station");	
		document.getElementById("select1").focus();
		document.form1.focus();
		return false;		
	}
	else if (document.form1.trainno.value==""){
		alert("Train No Cannot be left blank");	
		document.form1.trainno.focus();
		return false;
	}
	else if(tno.length < 4){
		alert("Train No Should be of 4 digts");	
		document.form1.trainno.focus();
		return false;		
	}
	else{
		document.form1.submit();
		return true;
	}      		
}

</script>

<!-- Input Validation Script -->
<script type="text/javascript" src="InputValidation.js">
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
		if(ssid == sessionid && author.equals("admin")) {
		%>
		
		<form name="form1" action="TrainInfo1.jsp" onsubmit="valid();">
		<h1> New Train Details Addition </h1>
<br/>		
		<table id="table1" align="center" style="font-weight: bold;" >
			  <tr>
      			<th colspan="2" style="font-size: 18px;"> Train Details </th>
			</tr>
			
			
			<tr>
				<td>	Source Station	</td>
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
				<select id="select2" name="destid" onchange="extract();">
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

          	<tr>
            	<td><label> Train N0 </label></td>
            	<td><input type="text" name="trainno" size="4" maxlength="4" onkeyup="num(this)" onkeydown="num(this)"/></td>
          	</tr>
			
		</table>
		<input type="button" Value="Continue" onclick="valid()">		
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
