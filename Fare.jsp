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


<title>Fare Details</title>

	<SCRIPT language="javascript">
        function addRow(tableID) {
 
            var table = document.getElementById(tableID);
 
            var rowCount = table.rows.length;
            
			var row = table.insertRow(rowCount);
 
            var cell1 = row.insertCell(0);
            cell1.innerHTML = rowCount;

            var cell2 = row.insertCell(1);
            var element1 = document.createElement("input");
            element1.type = "text";
            element1.setAttribute("name", "km" + rowCount);
            element1.setAttribute("size", "5");
            cell2.appendChild(element1);
 
 
            var cell3 = row.insertCell(2);
            var element2 = document.createElement("input");
            element2.type = "text";
            element2.setAttribute("name", "sl" + rowCount);
            element2.setAttribute("size", "6");
            cell3.appendChild(element2);
 				
            
            var cell4 = row.insertCell(3);
            var element4 = document.createElement("input");
            element4.type = "text";
            element4.setAttribute("name", "a1" + rowCount);
            element4.setAttribute("size", "6");
            cell4.appendChild(element4);
            
            var cell5 = row.insertCell(4);
            var element5 = document.createElement("input");
            element5.type = "text";
            element5.setAttribute("name", "a2" + rowCount);
            element5.setAttribute("size", "6");
            cell5.appendChild(element5);

            var cell6 = row.insertCell(5);
            var element6 = document.createElement("input");
            element6.type = "text";
            element6.setAttribute("name", "a3" + rowCount);
            element6.setAttribute("size", "6");
            cell6.appendChild(element6);

            //document.form1."km" + rowCount.focus();
            //document.form1."km" + rowCount.select();
            
       }
 
        function value1() {
        	//alert("value");
        	var id = document.form1.type.selectedIndex;
        	if( id != 0){
				document.form1.submit();
        	}
        	else{
        		alert("Select the Train type");	
        		document.form1.type.focus();
        	}
        	}
    </SCRIPT>

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
try{
	//Session Validation

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

<form name="form1" action="./Fare1.jsp">
<h1 align="center"> 
 Fare Addition </h1>

<div id="divTable" align="center" style="">
<br />
<h4> Fare Details Updation</h4>

<p>
<span> Train type </span>
            <select name="type">
	            <option value="0">--Please Select--</option>
	            <option> ORDINARY </option>
	            <option> EXPRESS </option>
	            <option> RAJDHANI  </option>
	            <option> JAN SHATABADI </option>
	            <option> SHATABADI </option>
            </select>
</p>

<table id="table1" border="1" bordercolor=#333333>
	<tr bgcolor=#333333 style="color: white;">
    	<th> Sl.No </th>
		<th> KM </th>
		<th> Sleeper Class </th>
		<th> AC First Class </th>
		<th> AC 2 Tier </th>
		<th> AC 3 Tier </th>
    </tr>
	<tr>
    	<td> 1 </td>
    	<td> <input type="text" name="km1" size="5" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="sl1" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a11" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a21" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a31" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
    </tr>
	<tr>
    	<td> 2 </td>
    	<td> <input type="text" name="km2" size="5" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="sl2" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a12" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a22" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a32" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
    </tr>
	<tr>
    	<td> 3 </td>
    	<td> <input type="text" name="km3" size="5" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="sl3" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a13" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a23" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a33" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
    </tr>
	<tr>
    	<td> 4 </td>
    	<td> <input type="text" name="km4" size="5" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="sl4" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a14" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a24" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a34" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
    </tr>
	<tr>
    	<td> 5 </td>
    	<td> <input type="text" name="km5" size="5" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="sl5" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a15" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a25" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a35" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
    </tr>
	<tr>
    	<td> 6 </td>
    	<td> <input type="text" name="km6" size="5" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="sl6" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a16" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a26" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="a36" size="6" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" />  </td>
    </tr>

</table>


<p align="center" >
    <INPUT type="button" value="Add Another Field" onClick="addRow('table1')" />
</p>



<p>
<input type="button" value="Save Fare Details" onClick="value1()" />
</p>
</div>

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
