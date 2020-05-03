<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Booking</title>
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

//to calculate total amount
function calc(){
		var ad = document.form1.adult1.value;
		var child = document.form1.child1.value;
		var no = parseInt(ad) + parseInt(child);
		
		var total =0;
		var i = 0;
		for (i=1;i<=no;i++)
		{
			var amt = "amt1"+i;
			var ele = document.getElementById(amt);	//Getting The Amount from Particular row
	
			total = total + parseInt(ele.value);
		}		
		document.getElementById("total2").value = total;
}

function validate(){
	var credit = document.getElementById("credit1").value;
	var credit1 = document.getElementById("credit2").value;
	if( credit == credit1 ){
		document.form1.submit();		
	}
	else{
		alert("Invalid Credit Card No Cannot Book The Ticket");
		document.getElementById("credit2").focus();
		document.getElementById("credit2").select();
	}
}

</script>




<script type="text/javascript">
//script to disable goback button of the browser

//function forwards to the next page from history of cache
function noBack(){
	window.history.forward();
}

//Calls noBack() function
function Back(){
	if (event.persisted){ 
		noBack();
	}
}

window.onload=noBack();
window.onpageshow = Back();
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
<body onload="calc();">
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
	String uid = (String)session.getAttribute("uid");

	//	out.println(uid);
		if(ssid == sessionid && author.equals("user")) {
		%>

<form name="form1" action="./Book5.jsp">
<h1> Conform Reservation </h1>
<%
String credit="";
String sql=" select * from credit where user_id="+uid+" ";

pstmt = con.prepareStatement(sql);
rs = pstmt.executeQuery();
if(rs.next()){
	credit = rs.getString("credit_no");
}
out.println(credit);
out.println("<input id='credit1' name='credit' type='hidden' value='"+credit+"' />");
%>

<table border="1" bordercolor=#333333>
	<tr bgcolor=#333333>
		<th colspan="6" align="left" style="color:white"> Ticket Reservation :</th>
	</tr>
<%

int pnrno = 0 ;
String date_book ="";
String date_dep ="";

int tno = 0 ;
String clas = "";
String class1 = "";

try{

		pnrno = Integer.parseInt(request.getParameter("pnrno"));
		date_book = request.getParameter("date_book");
		date_dep = request.getParameter("date_dep");
		tno = Integer.parseInt(request.getParameter("tno"));
		clas = request.getParameter("clas");
		
        if (clas.equals("sl")){
       			class1="Sleeper Class";
       	}else if(clas.equals("a1")){
				class1="AC First Class";
       	}else if(clas.equals("a2")){
       			class1="AC 2 Tier";
       	}else if(clas.equals("a3")){
				class1="AC 3 Tier";
       	}
		
		String sql4="select t.train_no, t.train_name, t.type, r.s_station_name, r.d_station_name, r1.km, s.dep_date from train_info t, route_main r, s1 s, route r1 where t.train_no=? and t.s_station_id=r.s_station_id and r.d_station_id=r1.station_id and s.dep_date=? and s.train_no=t.train_no;";
		pstmt = con.prepareStatement(sql4);
		pstmt.setInt(1,tno);
		pstmt.setString(2,date_dep);
	
		rs=pstmt.executeQuery();
		
		while(rs.next()){
%>
	<tr>
    	<th> PNR NO : </th>
    	<td> <input type="text" name="pnrno" size="15" value="<%= pnrno  %>"" tabindex="-1" /> </td>    	
    	<th> Date Of Booking : </th>
        <td> <input name="date_book" type="text" readonly="readonly" size="15" value="<%= date_book  %>" tabindex="-1" />  </td> 
		<th> Date Of Departure : </th>
        <td> <input name="date_dep" type="text" readonly="readonly" size="15"  value="<%= date_dep %>" tabindex="-1" /> </td>
    </tr>
	<tr> 
		    	<th> Train No : </th>
				<td>  <input type="text" name="tno" size="5" value="<%= rs.getString("train_no") %>" readonly="readonly" tabindex="-1" /> </td>
		        <th> Train Name : </th>
				<td>  <input type="text" size="15" value="<%= rs.getString("train_name") %>" readonly="readonly" tabindex="-1" /> </td>
		        <th> Type : </th>
				<td>  <input type="text" size="13" value="<%= rs.getString("type") %>" readonly="readonly" tabindex="-1" /> </td>
			</tr>
			<tr>
		    	<th> Source Station : </th>
				<td>  <input type="text" size="13" value="<%= rs.getString("s_station_name") %>" readonly="readonly" tabindex="-1" /> </td>
				<th> Destination Station : </th>	
				<td>  <input type="text" size="13" value="<%= rs.getString("d_station_name") %>" readonly="readonly" tabindex="-1" />
					<input name="km" type="hidden" value="<%= rs.getString("km") %>" >
 				</td>
 				<th> Class : </th>
				<td>  <input  type="text" size="13" value="<%= class1 %>" readonly="readonly" tabindex="-1" /> 
						<input name="clas" type="hidden" value="<%= clas %>" > 
				</td>
			</tr>

<%	
		}
}catch(Exception e){
}
%>	
</table>
<%
String adult = "";
String child = "";
String srcid = "";
String desid = "";
String source = "";
String dest = "";
int skm=0;
int dkm=0;
int totalkm=0;

try{
	adult = request.getParameter("adult1");
	child = request.getParameter("child1");
	srcid = request.getParameter("src");
	desid = request.getParameter("des");

	String sql5 = "select * from route where station_id=?";
	
	pstmt = con.prepareStatement(sql5);
	
	pstmt.setString(1,srcid);			//To fetch the details of source station
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		source = rs.getString("station_name");
		skm = rs.getInt("km");
	}
	
	pstmt.setString(1,desid);			//To fetch the details of destination station
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		dest = rs.getString("station_name");
		dkm = rs.getInt("km");
	}
	
	totalkm = dkm - skm;			//The calculate the travelling distance
	
}
catch(Exception e){
	
}
%>

<input name="src" type="hidden" value='<%= srcid %>' />
<input name="des" type="hidden" value='<%= desid %>' />

<table border="1" bordercolor=#333333>
	<tr bgcolor=#333333>
		<th align="left" colspan="6" style="color:white"> Travel Details : </th>
	</tr>
	<tr>
				<th> Travel Date: </th>
	    		<td>  <input type="text" size="9" value="<%= date_dep %>" readonly="readonly" tabindex="-1" /> </td>
				<th> No Of Adult Seats: </th>
	    		<td>  <input type="text" size="9" value="<%= adult %>" readonly="readonly" tabindex="-1" /> </td>
				<th> No Of Child Seats: </th>
	    		<td>  <input type="text" size="9" value="<%= child %>" readonly="readonly" tabindex="-1" /> </td>
	</tr>
	<tr>
				<th> Travel Km: </th>
	    		<td>  <input type="text" name="totalkm" size="9" value="<%= totalkm %>" readonly="readonly" tabindex="-1" /> </td>
				<th> Boarding Station: </th>
	    		<td>  <input type="text" size="9" value="<%= source %>" readonly="readonly" tabindex="-1" /> </td>
				<th> RESV. UPTO: </th>
	    		<td>  <input type="text" size="9" value="<%= dest %>" readonly="readonly" tabindex="-1" /> </td>
	</tr>
</table>



<br  />
<%
int adult1 =0;
int child1 =0;
String coach = "";
int km1 = 0;
String type="";
double price=0;

try{
		adult1 = Integer.parseInt(request.getParameter("adult1"));
		child1 = Integer.parseInt(request.getParameter("child1"));
		coach = request.getParameter("coach");
%>
		<input type="hidden" name="coach" value="<%= coach %>">

		<input type="hidden" name="adult1" value="<%= adult1 %>">
		<input type="hidden" name="child1" value="<%= child1 %>">
<%
		km1 = Integer.parseInt(request.getParameter("totalkm"));
		type = request.getParameter("type");
		
		String sql3="select * from fare where km<=? and type=?;"; //To Fetch The values which are lesser or equal to the total distance to calculate fare
		pstmt = con.prepareStatement(sql3);
		pstmt.setInt(1,km1);
		pstmt.setString(2,type);
		rs = pstmt.executeQuery();
		while(rs.next()){
				price = rs.getInt(clas); //clas is the class type already fetched in the previous scriplet
		}
		out.println("<div align='left'>  <span align='left' style='color: red; font-size: 14pt;'>Coach No = "+coach+" <br/> Total Km's = "+km1+" kms <br/> Fare Per Seat = "+price+" Rs </span> </div>");
		out.println("<br/>");
		
		if(adult1 != 0){			//Executes only if the adults seats are present
		out.print("<table border='1' bordercolor=#333333>");
		out.print("	<tr bgcolor=#333333> <th align='left' colspan='8' style='color:white'> Adult's Details :  </tr> ");
		out.print("<tr> <th> No </th> <th> Seat No </th> <th> Name </th> <th> Sex </th> <th> Age </th>  <th> Senior Citizen </th> <th> Amount </th> <th> Status </th> </tr>");

		loop:for(int i=1; i<=adult1 ; i++ )
			{
				String _seat = "";
				String _name = "";
				String _sex = "";
				String _age = "";
				String _senior="N";
				String _status="";
				try{
					_seat = request.getParameter("seat"+i);
					if (_seat == null)
					{
						break loop;		
					}
					if(_seat.charAt(0)=='S'){
						_status= "RESERVED";
					}
					else{
						_status= "WAITING";
					}
					 _name = request.getParameter("name"+i);
					 _sex = request.getParameter("sex"+i);
					 _age = request.getParameter("age"+i);
					_senior = request.getParameter("senior"+i);
			
					if(_senior == ""){
						_senior="N";
					}
					}			
					catch(Exception e){
						
				}
					out.print("<tr><th> "+i+" </th>");	
					out.print("<td> <input name='seat"+i+"' type='text' value='"+_seat+"' size='3' readonly='readonly' tabindex='-1' /> </td>");			
					out.print("<td> <input name='name"+i+"' type='text' value='"+_name+"' size='25' readonly='readonly' tabindex='-1'/> </td>");
					out.print("<td> <input name='sex"+i+"' type='text' value='"+_sex+"' size='2' readonly='readonly' tabindex='-1'/> </td>");
					out.print("<td> <input name='age"+i+"' type='text' value='"+_age+"' size='3' readonly='readonly' tabindex='-1'/> </td>");
					out.print("<td> <input name='senior"+i+"' type='text' value='"+_senior+"' size='2' readonly='readonly' tabindex='-1'/> </td>");
					double amt = 0;
					if( _senior.equals("Y")){
						amt = price - (price * 0.4 ); //40% Discount If Senior Citizen
					}else{
						amt = price;
					}
					out.print("<td> <input id='amt1"+i+"' name='amt"+i+"' type='text' value='"+amt+"' size='6' readonly='readonly' tabindex='-1'/> </td>");
					out.print("<td> <input name='status"+i+"' type='text' value='"+_status+"' size='10' readonly='readonly' tabindex='-1'/> </td>");
			}
		out.print(" </table>");
		}

		if(child1 != 0){			//Executes only if the Children seats are present	
		out.print("<table border='1' bordercolor=#333333>");
		out.print("<tr bgcolor=#333333> <th align='left' colspan='7' style='color:white'> Childeren Details : </th> </tr> ");
		out.print("<tr> <th> No </th> <th> Seat No </th> <th> Name </th> <th> Sex </th> <th> Age </th> <th> Amount </th> <th> Status </th> </tr>");
		
		int sno1 = adult1;//To start With The End Seat No After The Adults Seat
		loop1: for(int i = adult1+1; i<= (adult1+child1);i++){
				String _seat = "";
				String _name = "";
				String _sex = "";
				String _age = "";
				String _status = "";
				try{
					_seat = request.getParameter("seat"+i);
					if (_seat == null)
					{
						break loop1;		
					}
					if(_seat.charAt(0)=='S'){
						_status= "RESERVED";
					}
					else{
						_status= "WAITING";
					}
					 _name = request.getParameter("name"+i);
					 _sex = request.getParameter("sex"+i);
					 _age = request.getParameter("age"+i);
					
					}			
					catch(Exception e){
						
				}
					out.print("<tr><th> "+i+" </th>");	
					out.print("<td> <input name='seat"+i+"' type='text' value='"+_seat+"' size='3' readonly='readonly' tabindex='-1' /> </td>");			
					out.print("<td> <input name='name"+i+"' type='text' value='"+_name+"' size='25' readonly='readonly' tabindex='-1'/> </td>");
					out.print("<td> <input name='sex"+i+"' type='text' value='"+_sex+"' size='2' readonly='readonly' tabindex='-1'/> </td>");
					out.print("<td> <input name='age"+i+"' type='text' value='"+_age+"' size='3' readonly='readonly'tabindex='-1'/> </td>");
					double amt = price - (price * 0.5 ); //50% Discount For Childern
					out.print("<td> <input id='amt1"+i+"' name='amt"+i+"' type='text' value='"+amt+"' size='6' readonly='readonly' tabindex='-1'/> </td>");
					out.print("<td> <input name='status"+i+"' type='text' value='"+_status+"' size='10' readonly='readonly' tabindex='-1'/> </td>");
			}
		}

}
catch(Exception e){

}
%>
	
<table >
	
<thead> <tr><th colspan="2"> PAYMENT </th></tr> </thead>
	<tr>
    	<th> Total Amount </th>
        <td> <input id="total2" name="total1" type="text" readonly='readonly' tabindex='-1'/>  </td>
    </tr>
<!--     <tr>
		<td colspan="2"><input type="button" value="Generate Amount" onfocus="calc()" /></td>
	</tr> -->
    <tr> 
    	<th colspan="2"> Credit Card NO </th>
    </tr>
	<tr>
    	<td colspan="2" align="center"> <input id="credit2" type="text" maxlength="16" onkeyup="num(this)" onkeydown="num(this);" /> </td>
    </tr>
	<tr>
    	<td colspan="2" align="center"> <input type="button" value="Conform And Print eTicket" onclick="validate()" /> </td>
    </tr>
</table>
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
