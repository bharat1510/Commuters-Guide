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
			int sl=Integer.parseInt(request.getParameter("sl"));
			int a1=Integer.parseInt(request.getParameter("a1"));
			int a2=Integer.parseInt(request.getParameter("a2"));
			int a3=Integer.parseInt(request.getParameter("a3"));
			
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
			
			String sql1 = "insert into train_info values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql1);
			
			pstmt.setInt(1,trainno);
			pstmt.setString(2,tname.toUpperCase());
			pstmt.setString(3,type);
			pstmt.setInt(4,srcid);
			pstmt.setInt(5,destid);
			pstmt.setInt(6,km);
			pstmt.setInt(7,sl);
			pstmt.setInt(8,a1);
			pstmt.setInt(9,a2);
			pstmt.setInt(10,a3);
			pstmt.setString(11,mon);
			pstmt.setString(12,tue);
			pstmt.setString(13,wed);
			pstmt.setString(14,thu);
			pstmt.setString(15,fri);
			pstmt.setString(16,sat);
			pstmt.setString(17,sun);
			 
			if(pstmt.executeUpdate() > 0 ){
				%>
					<br/>
					<br/>					
					<br/>
					<br/>
					<h2> Insertion Of Train Information Was Successful</h2>
					<input type="button" value="OK" onclick="window.parent.location='adminhome.jsp'">
				<%
			}
			else{
				%>
					<br/>
					<br/>					
					<br/>
					<br/>
				<h2> Insertion Of Train Information Was Unsuccessful</h2>
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
			<h3> <span style='color: red;'> Train NO Already Exist TRY AGAIN </span> </h3>
			<input type='button' Value='OK' onclick="parent.location='TrainInfo.jsp'" />
			<%

		}
		
		
		
		try{
			int trainno= Integer.parseInt(request.getParameter("trainno"));
				loop:for(int i=1; i<=25 ; i++ )
				{
					try{
					String sql2 = "insert into train_schedule values(?,?,?,?)";
					String _sid = request.getParameter("station"+i);
					if (_sid == null)
					{
						break loop;		
					}
					int _sid1 = Integer.parseInt(_sid);
					
					String _arv = request.getParameter("arv"+i);
					String _dep = request.getParameter("dep"+i);
	
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

		<%
		try{
			int sl=Integer.parseInt(request.getParameter("sl"));
			int a1=Integer.parseInt(request.getParameter("a1"));
			int a2=Integer.parseInt(request.getParameter("a2"));
			int a3=Integer.parseInt(request.getParameter("a3"));


			String w[]={sun,mon,tue,wed,thu,fri,sat};

			String trainno = request.getParameter("trainno");
			
			for(int i=1; i<= a1; i++){			//Inserting values into ac first class i.e tables with "a1" type coach no
				String sql3 = "insert into a"+i+" (train_no, dep_date) values (?,?)";
				pstmt = con.prepareStatement(sql3);
				pstmt.setString(1,trainno);

				
				for( int j =0; j<7;j++)		//To get the date of travel based on the Y or N in the train_info table of weeks
				{

					Calendar cal1 = Calendar.getInstance();
			    	cal1.set(cal1.get(Calendar.YEAR),cal1.get(Calendar.MONTH),cal1.get(Calendar.DATE));	//Present Date
					int week2 = cal1.get(Calendar.DAY_OF_WEEK);	//Week of the present date, sunday=1 till sat=7

						if(w[(week2+j)%7] == "Y")
						{
							cal1.add(Calendar.DATE, j+1);
	
							int month1 = cal1.get(Calendar.MONTH) + 1;
							
							String _date = cal1.get(Calendar.YEAR)+"/"+month1+"/"+cal1.get(Calendar.DATE);
							
							pstmt.setString(2,_date);
							pstmt.executeUpdate();

						}		
				}
			}
				
			for(int i=1; i<= sl; i++){			//Inserting values into Sleeper class i.e tables with "s1" type coach no
					String sql4 = "insert into s"+i+" (train_no, dep_date) values (?,?)";
					pstmt = con.prepareStatement(sql4);
					pstmt.setString(1,trainno);
						
					
					for( int j =0; j<7;j++)
					{

						Calendar cal1 = Calendar.getInstance();
				    	cal1.set(cal1.get(Calendar.YEAR),cal1.get(Calendar.MONTH),cal1.get(Calendar.DATE));
						int week2 = cal1.get(Calendar.DAY_OF_WEEK);

							if(w[(week2+j)%7] == "Y")
							{
								cal1.add(Calendar.DATE, j+1);
		
								int month1 = cal1.get(Calendar.MONTH) + 1;
								
								String _date = cal1.get(Calendar.YEAR)+"/"+month1+"/"+cal1.get(Calendar.DATE);
								
								pstmt.setString(2,_date);
								pstmt.executeUpdate();

							}						
					}
			}

			for(int i=1; i<= a2; i++){			//Inserting values into AC 2 Tier Class i.e tables with "b1" type coach no
				String sql4 = "insert into b"+i+" (train_no, dep_date) values (?,?)";
				pstmt = con.prepareStatement(sql4);
				pstmt.setString(1,trainno);
					
				
				for( int j =0; j<7;j++)
				{

					Calendar cal1 = Calendar.getInstance();
			    	cal1.set(cal1.get(Calendar.YEAR),cal1.get(Calendar.MONTH),cal1.get(Calendar.DATE));
					int week2 = cal1.get(Calendar.DAY_OF_WEEK);

						if(w[(week2+j)%7] == "Y")
						{
							cal1.add(Calendar.DATE, j+1);
	
							int month1 = cal1.get(Calendar.MONTH) + 1;
							
							String _date = cal1.get(Calendar.YEAR)+"/"+month1+"/"+cal1.get(Calendar.DATE);
							
							pstmt.setString(2,_date);
							pstmt.executeUpdate();

						}						
				}
		}

			for(int i=1; i<= a3; i++){			//Inserting values into AC 3 Tier class i.e tables with "c1" type coach no
				String sql4 = "insert into c"+i+" (train_no, dep_date) values (?,?)";
				pstmt = con.prepareStatement(sql4);
				pstmt.setString(1,trainno);
					
				
				for( int j =0; j<7;j++)
				{

					Calendar cal1 = Calendar.getInstance();
			    	cal1.set(cal1.get(Calendar.YEAR),cal1.get(Calendar.MONTH),cal1.get(Calendar.DATE));
					int week2 = cal1.get(Calendar.DAY_OF_WEEK);

						if(w[(week2+j)%7] == "Y")
						{
							cal1.add(Calendar.DATE, j+1);
	
							int month1 = cal1.get(Calendar.MONTH) + 1;
							
							String _date = cal1.get(Calendar.YEAR)+"/"+month1+"/"+cal1.get(Calendar.DATE);
							
							pstmt.setString(2,_date);
							pstmt.executeUpdate();

						}						
				}
		}

		}
		catch(Exception e){
			//e.printStackTrace();
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
