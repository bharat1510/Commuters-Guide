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

<title>Inserting Fare Details Into BackEnd</title>
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

try{

	String _type = request.getParameter("type");
	
		//Loop To get all the elements from the table row wise based on the text box name attribute
		loop:for(int i=1; i<=25 ; i++ )
		{
			String _km=null;
			_km = request.getParameter("km"+i);
			if (_km == null)
			{
				break loop;		
			}

			try{

			int _km1 = Integer.parseInt(_km);
			
			String sql1= "select km from fare where km=? and type=?";//searching if the values for tat particular km exist
			
			pstmt=con.prepareStatement(sql1);
			pstmt.setInt(1,_km1);
			pstmt.setString(2,_type);
			
			rs=pstmt.executeQuery();
			
			int flag=0;
			
			while(rs.next()){
				if (rs.getInt(1)==_km1){
					flag=1;
				}
			}

			Double _sl = Double.parseDouble(request.getParameter("sl"+i));
			Double _a1 = Double.parseDouble(request.getParameter("a1"+i));
			Double _a2 = Double.parseDouble(request.getParameter("a2"+i));
			Double _a3 = Double.parseDouble(request.getParameter("a3"+i));
			
			if(flag==0){
				String sql = "insert into fare values(?,?,?,?,?,?)";//if km is not in the backend inserting it for the first time
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1,_km1);
				pstmt.setString(2,_type);
				pstmt.setDouble(3,_sl);
				pstmt.setDouble(4,_a1);
				pstmt.setDouble(5,_a2);
				pstmt.setDouble(6,_a3);
				
				pstmt.executeUpdate();
				
			}
			else{
				String sql2="update fare set sl=?, a1=?, a2=?, a3=? where km=? and type=?";//if km are present in back end then updating tat row 

				pstmt=con.prepareStatement(sql2);

				pstmt.setInt(5,_km1);
				pstmt.setString(6,_type);

				pstmt.setDouble(1,_sl);
				pstmt.setDouble(2,_a1);
				pstmt.setDouble(3,_a2);
				pstmt.setDouble(4,_a3);

				pstmt.executeUpdate();
						
			}//End Of If Block for flag
			}//End Of Try block For Exceptions during parsing
			catch(Exception e){
				//Exception occurs while parsing a null string but no need to specify it to the user 
			}
			}//End Of For Loop
%>
	<div>
					<br/>
					<br/>					
					<br/>
					<br/>
	<h2 style="height: 600px;" > 
	Fare Updation Successfully Completed <br >
	<input type="button" Value="ok" onclick="parent.location='adminhome.jsp'" />
	</h2></div>

<%	
}
catch(Exception e){
	//out.println("<h2>Input error</h2>");
%>
	<div>
					<br/>
					<br/>					
					<br/>
					<br/>
	
	<h2>Input Error </h2> 
	</div>

<%	

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
