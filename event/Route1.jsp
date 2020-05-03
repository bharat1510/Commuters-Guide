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

<title>Storing Route Details to back End</title>

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

<%

try_block: try{
		String sql = "Select MAX(station_id) from route";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		String _sid = null;
		int _s = 0;
		int sid=0;
		while(rs.next()){
			_sid = rs.getString(1);
		}
		if (_sid == null){
			_s = 100;
			
		}else{
			sid = Integer.parseInt(_sid);
			sid = sid + 100;
			_s = sid / 100;
			_s = _s * 100 ;
		}
		sid = _s;		

		String _rst = request.getParameter("start");
		String _rst1 = request.getParameter("end");
		
		//To check if route already Exist at the backend if so then terminate the process
	String sql5="select * from route_main where s_station_name=? and d_station_name=?";	
	pstmt = con.prepareStatement(sql5);
	pstmt.setString(1,(_rst.toUpperCase()).trim());
	pstmt.setString(2,(_rst1.toUpperCase()).trim());
	rs= pstmt.executeQuery();
	{
		while(rs.next()){			
			if(rs.getString(1) != null){
				out.println("<h2> Route Alredy Exist Insertion Not Possible <h2/>");
				break try_block;
			}
		}
	}
		
	
	String rsql= "insert into route_main values(?,?,?,?,?)";
	String rsql1="select MAX(route_id) + 1 from route_main";
	pstmt = con.prepareStatement(rsql1);	
	rs = pstmt.executeQuery();
	int _rid=0;
	while (rs.next()){
		_rid= rs.getInt(1);
	}	

	int _s1 = _s +99;
	pstmt = con.prepareStatement(rsql);
	pstmt.setInt(1,_rid);
	pstmt.setInt(2,_s);
	pstmt.setString(3,_rst.toUpperCase());
	pstmt.setInt(4,_s1);
	pstmt.setString(5,_rst1.toUpperCase());
	
	
	pstmt.executeUpdate();
	
		
		
	String sql1 = "insert into route values(?,?,?)";
	int _km = 0;
	String _st = request.getParameter("start");

	pstmt=con.prepareStatement(sql1);
	pstmt.setInt(1,_s);
	pstmt.setString(2,_st.toUpperCase());
	pstmt.setInt(3,_km);
	
	pstmt.executeUpdate();
	
		_s=_s+1;
		
		loop:for(int i=1; i<=25 ; i++ )
		{
			try{
			String sql2 = "insert into route values(?,?,?)";
			String _km1 = request.getParameter("km"+i);
			if (_km1 == null)
			{
				break loop;		
			}
			int _km2 = Integer.parseInt(_km1);
			String _st1 = request.getParameter("station"+i);

			pstmt=con.prepareStatement(sql2);
			
			pstmt.setInt(1,_s);
			pstmt.setString(2,_st1.toUpperCase());
			pstmt.setInt(3,_km2);
			
			if(pstmt.executeUpdate()>0)
			{
				_s = _s + 1;
			}
			else
			{
				break loop;
			}//End OF loop
			}			
			catch(Exception e){
				
			}
		}
	
		String sql3 = "insert into route values(?,?,?)";
		int _km3 = Integer.parseInt(request.getParameter("totalkm"));
		String _st2 = request.getParameter("end");

		sid = sid + 99;	
		pstmt=con.prepareStatement(sql3);
		pstmt.setInt(1,sid);
		pstmt.setString(2,_st2.toUpperCase());
		pstmt.setInt(3,_km3);
		
		pstmt.executeUpdate();

%>
	<div>
					<br/>
					<br/>					
					<br/>
					<br/>
	<h2 style="height: 600px;" > 
	Route Updation From <%= request.getParameter("start") %>
	Station to <%= request.getParameter("end")  %>
	Station Successfully Completed <br >
	<a href="./adminhome.jsp" > OK </a>
	</h2></div>

<%	
}
catch(Exception e){
	e.printStackTrace();

	out.println("<br/><br/><br/><br/>Input Error");
}

%>
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
