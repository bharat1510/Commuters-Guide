<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>User Registration</title>
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

<style>
p.big {
  line-height: 1.8;
}

</style>

</head>
<body>

<div id="templatemo_wrapper">

	<div id="templatemo_header">
    
    	<div id="site_title">
            <h1><a href="home.jsp">
                <img src="./images/train_logo.PNG" width="494" height="110" />
             
            </a></h1>
        </div>
 
        <div id="templatemo_menu">
    
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="SearchTrain.jsp">Trains</a></li>
                <li><a href="SeatAvail.jsp">Booking</a></li>
                <li><a href="Pnr.jsp">PNR Status</a></li>
                <li><a href="contactus.html">Contact Us</a></li>
            </ul>    	
    
    	</div> <!-- end of templatemo_menu -->
        
        <div class="cleaner"></div>
	</div> <!-- end of header -->
    
    <div id="templatemo_content">


	<!-- Form Body -->

<%
int _uid = 0;
String _fname= "";
String _lname= "";
String _uname = "";
String _gender= "";
String _sex = null;
String _dob = "";
String _mobile = "";
String _email = "";
String _credit = "";
String _pass = "";
String _addr = "";
String _city = "";
String _state = "";
String _pincode = "";
String _country = "";


try{
		_uid = Integer.parseInt(request.getParameter("userid"));
		_fname= request.getParameter("fname");
		_lname= request.getParameter("lname");
		_uname = _fname +" "+ _lname ;
		_gender= request.getParameter("gender");
		_sex = null;
		if(_gender.equals("Male"))
		{
			_sex = "M";
		}
		else
		{
			_sex = "F";	
		}
		_dob = request.getParameter("dob");
		//_dob.format("dd-MM-yyyy");
		//SimpleDateFormat formater = new SimpleDateFormat("dd-MM-yyyy");
		//String dob = formater.format(_dob);
		//String dob1 = dob1.format("yyyy-MM-dd",_dob);
		
		//Date dob = Date.UTC(_dob);
		//DateFormat dob = DateFormat.getDateInstance(_dob);
		
		_mobile = request.getParameter("mobile");
		_email = request.getParameter("email");
		_credit = request.getParameter("credit");
		_pass = request.getParameter("password2");
		_addr = request.getParameter("addr");
		_city = request.getParameter("city");
		_state = request.getParameter("state");
		_pincode = request.getParameter("pin");
		_country = request.getParameter("country");
		
			
		String sql="insert into reg_user values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		pstmt=con.prepareStatement(sql);
	
		//Date _dob1 = Date.parse("_dob");
		
		pstmt.setInt(1,_uid);
		pstmt.setString(2,_uname.toUpperCase());
		pstmt.setString(3,_sex);
		pstmt.setString(4,_dob);
		pstmt.setString(5,_mobile);
		pstmt.setString(6,_email);
		pstmt.setString(7,_credit);
		pstmt.setString(8,_pass);
		pstmt.setString(9,_addr);
		pstmt.setString(10,_city);
		pstmt.setString(11,_state);
		pstmt.setString(12,_pincode);
		pstmt.setString(13,_country);
		if(pstmt.executeUpdate() > 0){
%>
	<div>
					<br/>
					<br/>					
					<br/>
					<br/>
	<p class="big">
	<h2 style="height: 600px;" > 
	User Registration Completed for <span style=" color: red;"> <%= _uname.toUpperCase() %> </span><br>
	with Email Id <span style=" color:maroon; "> <%= _email  %> </span><br><br>
	<a href="./home.jsp" > OK </a>
	</h2></p></div>
<%		
		}
		else{
%>
	<div>
					<br/>
					<br/>					
					<br/>
					<br/>
	<h2 style="height: 600px;"> User Registration Error </h2></div>
<%			
	}
}
catch(SQLException se){

	//se.printStackTrace();

%>
	<div>
					<br/>
					<br/>					
					<br/>
					<br/>
	<p class="big">
	<h2>Email Id <span style="color: maroon;"> <%= _email %> </span> Already Registered<br> Try Another </h2> 
	</p></div>

<%	
}

try{
		String sql3="insert into login values (?,?,?,?,'user')";
		
		pstmt = con.prepareStatement(sql3);
		
		pstmt.setInt(1,_uid);
		pstmt.setString(2,_email);
		pstmt.setString(3,_uname.toUpperCase());
		pstmt.setString(4,_pass);
		
		pstmt.executeUpdate();
		
		
		String sql4="insert into credit values(?,?,'50000')";
		
		pstmt = con.prepareStatement(sql4);
		
		pstmt.setInt(1,_uid);
		pstmt.setString(2,_credit);
		
		pstmt.executeUpdate();

}
catch(Exception e){
	e.printStackTrace();
}
%>

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
