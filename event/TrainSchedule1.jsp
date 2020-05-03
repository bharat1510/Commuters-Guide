<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> Train Schedule Insertion Into BackEnd</title>
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

		String mon="N";
		String tue="N";
		String wed="N";
		String thu="N";
		String fri="N";
		String sat="N";
		String sun="N";

		try{	
			int trainno= Integer.parseInt(request.getParameter("trainno"));
			String tname=request.getParameter("tname");
			String type=request.getParameter("type");
			int srcid=Integer.parseInt(request.getParameter("srcid"));
			int destid=Integer.parseInt(request.getParameter("destid"));
			int km=Integer.parseInt(request.getParameter("km"));
			
			String[] day=request.getParameterValues("day");
	
			
			
			
			   if (day != null)
			   {
			      for (int i = 0; i < day.length; i++)
			      {
				         if(day[i].equals("mon")){
				        	 mon="Y";
				         }
				         else if(day[i].equals("tue")){
				        	 tue="Y";
				         }
				         else if(day[i].equals("wed")){
				        	 wed="Y";
				         }
				         else if(day[i].equals("thu")){
				        	 thu="Y";
				         }
				         else if(day[i].equals("fri")){
				        	 fri="Y";
				         }
				         else if(day[i].equals("sat")){
				        	 sat="Y";
				         }
				         else if(day[i].equals("sun")){
				        	 sun="Y";
				         }
			      }
			   }
			
			String sql1 = "insert into vehi_info values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql1);
			
			pstmt.setInt(1,trainno);
			pstmt.setString(2,tname.toUpperCase());
			pstmt.setString(3,type);
			pstmt.setInt(4,srcid);
			pstmt.setInt(5,destid);
			pstmt.setInt(6,km);
			pstmt.setString(7,mon);
			pstmt.setString(8,tue);
			pstmt.setString(9,wed);
			pstmt.setString(10,thu);
			pstmt.setString(11,fri);
			pstmt.setString(12,sat);
			pstmt.setString(13,sun);
			 
			if(pstmt.executeUpdate() > 0 ){
				%>
					<br/>
					<br/>					
					<br/>
					<br/>
					<h2> Insertion Of Event Information Was Successful</h2>
					<input type="button" value="OK" onclick="window.parent.location='adminhome.jsp'">
				<%
			}
			else{
				%>
					<br/>
					<br/>					
					<br/>
					<br/>
				<h2> Insertion Of Event Information Was Unsuccessful</h2>
				<input type="button" value="OK" onclick="window.parent.location='adminhome.jsp'">
			<%

			}
		}
		catch(Exception e){
			//e.printStackTrace();
			%>
					<br/>
					<br/>					
					<br/>
					<br/>
			<h3> <span style='color: red;'> Vehical NO Already Exist TRY AGAIN </span> </h3>
			<input type='button' Value='OK' onclick="parent.location='TrainInfo.jsp'" />
			<%

		}
		
		
		
		try{
			int trainno= Integer.parseInt(request.getParameter("trainno"));
				loop:for(int i=1; i<=25 ; i++ )
				{
					try{
					String sql2 = "insert into vehi_schedule values(?,?,?,?)";
					String _sid = request.getParameter("station"+i);
					if (_sid == null)
					{
						break loop;		
					}
					int _sid1 = Integer.parseInt(_sid);
					
					String _arv = request.getParameter("arv");
					String _dep = request.getParameter("dep");
	
					pstmt=con.prepareStatement(sql2);
					
					pstmt.setInt(1,trainno);
					pstmt.setInt(2,_sid1);
					pstmt.setString(3,_arv);
					pstmt.setString(4,_dep);
					
					pstmt.executeUpdate();
					
					}
					catch(Exception e){
						
					}
				}
			}			
			catch(Exception e){
				
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
