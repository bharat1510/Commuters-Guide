<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>User Registration Form</title>
<meta name="keywords" content="Home" />
<link href="./css/templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />

<!-- Special Font & Symbol -->	
   <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	
	
<!--  Date Picker code -->

		<link type="text/css" href="jsDate/css/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="jsDate/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="jsDate/jquery-ui-1.8.17.custom.min.js"></script>
		<script type="text/javascript" src="jsDate/jquery.effects.core.js"></script>
		<script type="text/javascript" src="jsDate/jquery.effects.bounce.js"></script>
		<script type="text/javascript">
		$(function() {			//Date Picker For DOB Whic show calendar for age above 18 years and starts from 1920
			  $( "#datepicker" ).datepicker({ showAnim: 'bounce',
				yearRange: '1900:2019',
				changeMonth: true,
				changeYear: true, maxDate: "-18Y -1D" 
			});
		});
		</script>
		<style type="text/css">
			body{ font: 62.5% "Arial", sans-serif; margin: 50px;}
		</style>
		
<!-- Date Picker Code End -->		

 <style type="text/css">
	body
	{
	margin-bottom:0;
	margin-left:0;
	margin-right:0;
	margin-top:0;
	}
</style>
		
		
<script type="text/javascript">
function valid(){
	var pass1 = document.getElementById("pass1").value;
	var pass2 = document.getElementById("pass2").value;
	if( pass1 == pass2){
		return true;
	}
	else{
		alert("Password missmatch");
		//pass2.focus();
		document.getElementById("pass2").focus();
		document.getElementById("pass2").select();
		document.getElementById("pass2").focus();
		return false;
	}
}

function credit(){
	var val = document.form1.credit.value;
	var len = val.length;
	
	if(len < 16 ){
		alert("Credit Card No should Be Of 16 Digits");
		document.form1.credit.focus();
		return false;
	}
	return true;
}

function validate(){
	if(Empty(document.form1.fname)){		//Empty Field Validation Call
	   if(Empty(document.form1.dob)){
	     if(Empty(document.form1.email)){
		   if(Empty(document.form1.credit)){
			if (credit()){
		     if(Empty(document.form1.pass1)){
		       if(validateEmail(document.form1.email)) {		//Email Input Type Validation Call
	             if(valid()){			//Retype Password Validation Call
						document.form1.submit();
				}
	  		   }
		     }
		   }
	     }
		}
	  }
	}
}
</script>

<!-- Input Validation Script -->
<script type="text/javascript" src="InputValidation.js">
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
    
<div style="font-family:'Times New Roman', Times, serif;font-size:16px">
<form name="form1" action="./UserReg1.jsp">
<h1 align="center"> <em> User Registration Form </em> </h1>

<br />
	<table>
	<tr>
	    <td ><label > First Name  </label></td>
	    <td><input type="text" name="fname" value="" maxlength="15" onkeyup="alp(this)" onkeydown="alp(this)" title="First Name" /> <span style="color: red;">*</span> </td>
	    <td><label> Last Name </label></td>
	    <td><input type="text" name="lname" value="" maxlength="15" onkeyup="alp(this)" onkeydown="alp(this)" /></td>
	</tr>    

	<tr>
	    <td><label> Gender </label></td>
	    <td><select name="gender">
	    	<option selected="selected"> Male </option>
	        <option> Female </option>
	    	</select>
	    </td>
		    <td><label>Date Of Birth </label></td>
	    	<td><input type="text" id="datepicker" title="YYYY/MM/DD" name="dob" readonly="readonly" />  <span style="color: red;">*</span> </td>
			<!--     <td><input title="YYYY/MM/DD" type="text" name="dob"  /></td> --> 
    </tr>

    <tr>
	    <td><label>Email ID</label></td>
    	<td><input type="text" name="email" maxlength="30" onkeyup="EmailInsert(this);" onkeydown="EmailInsert(this);" onblur="validEmail(this);" /> <span style="color: red;">*</span></td>
	    <td><label>Mobile</label></td>
    	<td><input type="text" name="mobile" maxlength="10" onkeyup="num(this);" onkeydown="num(this);" /></td>
  	</tr>

  <tr>
    <td><label>Credit Card No</label></td>
    <td><input type="text" name="credit" maxlength="16" onkeyup="num(this)" onkeydown="num(this);" /> <span style="color: red;">*</span> </td>
  </tr>

  <tr>
    <td rowspan="2"><label> Address </label></td>
 	<td rowspan="2"><textarea rows="3" cols="25" name="addr"> </textarea></td>
  </tr>
  <tr>
  </tr>
  <tr>
    <td><label> City </label></td>
    <td><input type="text" name="city" onkeyup="alp1(this)" onkeydown="alp1(this)" /></td>
  </tr>
  <tr>
    <td><label> State </label></td>
    <td><input type="text" name="state" maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" /></td>
  </tr>
  <tr>
    <td><label> Pin Code </label></td>
    <td> <input type="text" name ="pin" maxlength="6" onkeyup="num(this)" onkeydown="num(this)" /> </td>
  </tr>
  <tr>
    <td><label> Country </label></td>
    <td><input type="text" name="country"  maxlength="30" onkeyup="alp1(this)" onkeydown="alp1(this)" /> </td>
  </tr>
</table>

<br/>
<hr />
<h3>Login Information</h3>
<table border="0">
	<tr>
		<td><label>User Id</label> </td>
		<td> <input type="text" name="userid" value=
<%

String sql1="select MAX(User_Id) + 1 from reg_user";
pstmt = con.prepareStatement(sql1);	
rs=pstmt.executeQuery();
int _uid=1;
while (rs.next()){
	_uid = rs.getInt(1);
%>

 <%--=rs.getString(1) + 1 --%>
<%
}
if (_uid == 0){
	_uid = 1000;
}
%>
		"<%= _uid%>"	
readonly="readonly" /></td>

	</tr>
	<tr>
		<td><label>Enter Password</label> </td>
		<td> <input type="password" id="pass1" name="password1" maxlength="6" /> <span style="color: red;">*</span> </td> 		
	</tr>
	<tr>
		<td><label>Conform Password</label> </td>
		<td> <input type="password" id="pass2" name="password2" maxlength="6" onchange="valid()" />  </td>
	</tr>

</table>

<span style="color: red;">Field Marked With * Should be field</span>
<br />
<br />
<p align="center">

<button type="button" value="Register" class="btn btn-warning" id="sub" onclick="validate()">Register</button>
<button type ="reset" value="Clear" class="btn btn-warning" id="clear">Reset</button>
</p>


</form>
</div>


<!-- Form Body -->


    </div> <!-- end of templatemo_content -->
    
    <div id="templatemo_sidebar">
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
