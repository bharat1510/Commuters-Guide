<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="keywords" content="Home" />
<link href="./css/templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />

<title> Route Addition </title>


<!-- JavaScript To add Rows Dynamically On Click Event Of Add Another Station Button-->
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
            element1.setAttribute("size", "8");
            cell2.appendChild(element1);
 
            var cell3 = row.insertCell(2);
            var element2 = document.createElement("input");
            element2.type = "text";
            element2.setAttribute("name", "station" + rowCount);
            cell3.appendChild(element2);
       }
// End Of JavaScript To add Rows Dynamically 

function value1() {
//        	alert("value");
        	if (document.form1.start.value==""){
        		alert("Starting Station Cannot be left blank");	
        		return false;
        	}
        	else{
    			document.form1.submit();
        	}      		
        }
    </SCRIPT>

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

<form name="form1" action="./Route1.jsp">
<h1 align="center"> Route Addition </h1>


<div id="divHead">
<br />
<table align="center">
	<tr>
	  <th colspan="2"> Enter The Route Information </th>
	</tr>
	<tr>
		<td><label> Starting Station </label></td>
		<td><input type="text" name="start" maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" /></td>
	</tr>
	<tr>
		<td><label> Ending Station </label></td>
		<td><input type = "text" name="end" maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" /></td>
	</tr>
	<tr>
		<td><label> Total Distance (km) </label></td>
		<td><input type = "text" name="totalkm" maxlength="5" onkeyup="num(this)" onkeydown="num(this)"/></td>
	</tr>
</table>
</div>

<div id="divTable" align="center" style="">
<br />
<hr />
<h4> List Of Stations In The Route</h4>
<table id="table1" border="1" bordercolor=#333333>
	<tr bgcolor=#333333 style="color: white">
    	<th> Sl.No </th>
    	<th> Kilometers From Source </th>
        <th> Station Name </th>
    </tr>
	<tr>
    	<td> 1 </td>
    	<td> <input type="text" name="km1" size="8" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="station1" maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" />  </td>
    </tr>
	<tr>
    	<td> 2 </td>
    	<td> <input type="text" name="km2" size="8" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="station2" maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" />  </td>
    </tr>
	<tr>
    	<td> 3 </td>
    	<td> <input type="text" name="km3" size="8" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="station3" maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" />  </td>
    </tr>
	<tr>
    	<td> 4 </td>
    	<td> <input type="text" name="km4" size="8" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="station4" maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" />  </td>
    </tr>
	<tr>
    	<td> 5 </td>
    	<td> <input type="text" name="km5" size="8" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="station5" maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" />  </td>
    </tr>
	<tr>
    	<td> 6 </td>
    	<td> <input type="text" name="km6" size="8" maxlength="5" onkeyup="num(this)" onkeydown="num(this)" />  </td>
        <td> <input type="text" name="station6" maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" />  </td>
    </tr>

</table>

<p align="center" >
    <INPUT type="button" value="Add Another Station" onClick="addRow('table1')" />
</p>



<p>
<input type="button" value="Save New Route" onClick="value1()" />
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
