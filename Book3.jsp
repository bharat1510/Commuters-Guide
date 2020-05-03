<%@page import="sun.security.jca.GetInstance"%>
<%@page import="java.util.Calendar"%>
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
function check(ele){
	var value = ele.name;	//To Get The Element That Called This Function
	
	var no = value.charAt(3);	//To Get The Row No Of The Element So That Other Elements Of The Row Could Be Accessed
	
	var sex = "sex1"+no;
	var val = document.getElementById(sex).value;	//Getting The Value Specified In The Gender Field Of The Particular row
//	document.form1.seat[i].checked == true;

	var sen = "senior1"+no;
	var ele1 = document.getElementById(sen);	//To Get The Check Box Element Of The row

	var sen2 = "senior2"+no;
	var ele2 = document.getElementById(sen2);	//To Get The Hidden Element Of The row
	
		
	if(val=="F" && ele.value > 57){			//Validation For Female Senior Citizen age abo 60
		ele1.checked=true;
		ele2.value="Y";
		return;
	}else if(val=="F" && ele.value <= 57){
		ele1.checked=false;
		ele2.value="N";
		return;
	}else if(val=="M" && ele.value > 59){			//Validation For Male Senior Citizen age abo 60
		ele1.checked=true;
		ele2.value="Y";
		return;
	}else if(val=="M" && ele.value <= 59){
		ele1.checked=false;
		ele2.value="N";
		return;
	}
	
}

function validate(){
	document.form1.submit();
}
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
		if(ssid == sessionid && author.equals("user")) {
		%>

<form name="form1" action="./Book4.jsp">
<h1> Travel Details </h1>


<table border="1" bordercolor=#333333>
	<tr bgcolor=#333333>
		<th colspan="6" align="left" style="color:white"> Ticket Reservation </th>
	</tr>
	<tr>
    	<th> PNR NO : </th>
    	<td> <input type="text" name="pnrno" size="15" value=
<%

String sql1="select MAX(PNR) + 1 from ticket_book";
pstmt = con.prepareStatement(sql1);	
rs=pstmt.executeQuery();
int _pnr=1;
while (rs.next()){
	_pnr = rs.getInt(1);
%>

 <%--=rs.getString(1) + 1 --%>
<%
}
if (_pnr == 0){
	_pnr = 1231234567;
}
%>
		"<%= _pnr%>"	
readonly="readonly" tabindex="-1" /></td>
<%
Calendar cal = Calendar.getInstance();
int month1 = cal.get(Calendar.MONTH) + 1;

String _date = ""+cal.get(Calendar.YEAR)+"-"+month1+"-"+cal.get(Calendar.DATE)+"";
int tno = 0 ;
String date1 ="";
String clas = "";
String class1 = "";

try{
		tno = Integer.parseInt(request.getParameter("tno"));
		date1 = request.getParameter("date1");
		clas = request.getParameter("clas1");
		
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
		pstmt.setString(2,date1);
	
		rs=pstmt.executeQuery();
		
		while(rs.next()){
%>
    	
    	<th> Date Of Booking : </th>
        <td> <input name="date_book" type="text" readonly="readonly" size="15" value="<%= _date  %>" tabindex="-1" />  </td> 
		<th> Date Of Departure : </th>
        <td> <input name="date_dep" type="text" readonly="readonly" size="15"  value="<%= date1 %>" tabindex="-1" /> </td>
    </tr>
	<tr> 
		    	<th> Train No : </th>
				<td>  <input type="text" name="tno" size="5" value="<%= rs.getString("train_no") %>" readonly="readonly" tabindex="-1" /> </td>
		        <th> Train Name : </th>
				<td>  <input type="text" size="15" value="<%= rs.getString("train_name") %>" readonly="readonly" tabindex="-1" /> </td>
		        <th> Type : </th>
				<td>  <input name="type" type="text" size="13" value="<%= rs.getString("type") %>" readonly="readonly" tabindex="-1" /> </td>
			</tr>
			<tr>
		    	<th> Source Station : </th>
				<td>  <input type="text" size="13" value="<%= rs.getString("s_station_name") %>" readonly="readonly" tabindex="-1" /> </td>
				<th> Destination Station : </th>	
				<td>  <input type="text" size="13" value="<%= rs.getString("d_station_name") %>" readonly="readonly" tabindex="-1" /></td>
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
	adult = request.getParameter("adult");
	child = request.getParameter("child");
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
	    		<td>  <input type="text" size="9" value="<%= date1 %>" readonly="readonly" tabindex="-1" /> </td>
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

<br />
<hr />
<h1> Passenger Details </h1>

<%
int adult1 =0;
int child1 =0;
String coach ="";
String[] seat= new String[8];
try{
		adult1 = Integer.parseInt(request.getParameter("adult1"));
		child1 = Integer.parseInt(request.getParameter("child1"));
		coach = request.getParameter("ch");
		seat=request.getParameterValues("seat");
%>
		<input name="coach" type="hidden" value="<%= coach %>" > 
		<input name="adult1" type="hidden" value="<%= adult1 %>" > 
		<input name="child1" type="hidden" value="<%= child1 %>" > 
<%


		if(adult1 != 0){			//Executes only if the adults seats are present
		out.print("<table border='1' bordercolor=#333333>");
		out.print("	<tr bgcolor=#333333> <th align='left' colspan='4' style='color:white'> Adult's Details : </th> <th align='right' colspan='2' style='color:white'> Coach No = "+coach+" </th>  </tr> ");
		out.print("<tr> <th> No </th> <th> Seat No </th> <th> Name </th> <th> Sex </th> <th> Age </th>  <th> Senior Citizen </th> </tr>");

		int sno = 0;	//To Innitialize the seat[] array
		for(int i =1; i<= adult1;i++){
			out.print("<tr><th> "+i+" </th>");	
			out.print("<td> <input name='seat"+i+"' type='text' value="+seat[sno]+" size='4' readonly='readonly' tabindex='-1' /> </td>");			
			out.print("<td> <input name='name"+i+"' type='text' maxlength='30' onkeyup='alp1(this)' onkeydown='alp1(this)' /> </td>");
			out.print("<td> <select id='sex1"+i+"' name='sex"+i+"'> <option value='M'> MALE </option> <option value='F'> FEMALE </option> </select> </td> ");
			out.print("<td> <select name='age"+i+"' onchange='check(this)'> ");
			for(int k =13 ;k <=100 ; k++){
				out.print("<option value='"+k+"'> "+k+" </option>");        
			}
			out.print(" </select>  </td>");

	        //Hidden Input Type For The Values To Change At Run Time As CheckBox With Disabled Property Doesn't Forward The Values
	        out.println("<td align='center'> <input type='hidden' id='senior2"+i+"' name='senior"+i+"' >");	        

	        //Check Box For Front End View For Check and UnCheck At Run Time
	        out.print(" <input type='checkbox' id='senior1"+i+"' disabled='disabled'/> </td> </tr>");
	        sno=sno+1;
		}
			out.print(" </table>");
		}

	
		
		if(child1 != 0){			//Executes only if the Child seats are present
		
		out.print("<table border='1' bordercolor=#333333>");
		out.print("	<tr bgcolor=#333333> <th align='left' colspan='3' style='color:white'> Children Details : </th> <th align='right' colspan='2' style='color:white'> Coach No = "+coach+" </th>  </tr> ");
		out.print("<tr> <th> No </th> <th> Seat No </th> <th> Name </th> <th> Sex </th> <th> Age </th> </tr>");
				
		int sno1 = adult1;//To start With The End Seat No After The Adults Seat
		for(int i = adult1+1; i<= (adult1+child1);i++){
			out.print("<tr><th> "+i+" </th>");	
			out.print("<td> <input name='seat"+i+"' type='text' value="+seat[sno1]+" size='4' readonly='readonly' tabindex='-1' /> </td>");			
			out.print("<td> <input name='name"+i+"' type='text' maxlength='30' onkeyup='alp1(this)' onkeydown='alp1(this)'/> </td>");
			out.print("<td> <select name='sex"+i+"'> <option value='M'> MALE </option> <option value='F'> FEMALE </option> </select> </td> ");
			out.print("<td> <select name='age"+i+"'> ");
			for(int k =5 ;k <=12 ; k++){
				out.print("<option value='"+k+"'> "+k+" </option>");        
			}
			out.print(" </select>  </td> </tr>");
			sno1=sno1+1;
		}
		out.print(" </table>");
		}
}
catch(Exception e){

}
%>
<br  />
<p align="center">
<input type="button" value="Generate Amount" onclick="validate()" />
</p>
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
