<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Railway Reservation System</title>
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
<form action="adminvalid.jsp" method="get">
<h1> <em> Admin Login</em> </h1>

<table>
<tr>
	<td> <label> User Id </label> </td> 
	<td> <input type="text" id="userid" class="form-control"/> </td>
</tr>
<tr>
	<td> <label>Password </label> </td> 
	<td> <input type="password" id="password" class="form-control"/> </td>
</tr>
<tr>
	<td align="center"> <input type="submit" value="SignIn" id="signin" class="btn btn-warning"/> </td> 
	<td align="center"> <input type="button" value="Cancel" id="cancel" class="btn btn-warning" onclick="parent.location='./home.jsp'" /> </td>
</tr>
</table>
</form>
</div>

	<!-- Form Body -->

    </div> <!-- end of templatemo_content -->
    
    <div id="templatemo_sidebar">
      <div id="sidebar_featured_project">
        	<div class="cleaner"></div>

            
        </div>
        <div class="cleaner"></div>
    </div>

</div> <!-- end of wrapper -->

<div id="footer"></div>
</body>
</html>
