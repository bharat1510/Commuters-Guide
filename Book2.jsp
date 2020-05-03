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


<!-- To Import CSS And jquery for the  Graphical Button Style -->
    <link rel="stylesheet" href="button/button_css/jquery-ui-1.8.17.custom.css">
    <link rel="stylesheet" href="button/button_css/jquery.ui.button.css">
    <script src="button/button_js/jquery-1.7.1.js"></script>
    <script src="button/button_js/jquery.ui.core.js"></script>
    <script src="button/button_js/jquery.ui.widget.js"></script>
    <script src="button/button_js/jquery.ui.button.js"></script>
<!-- To Import CSS And jquery for the  Graphical Button Style -->

<!-- Script To Call Graphical Button Style -->
    <script>
    $(function() {
    
        $("#format").buttonset();		//To Set Graphical Button Style To The Check Box 
        $("#format1").buttonset();
    });
    </script>
<!-- Script To Call Graphical Button Style -->

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
	var ad = document.form1.adult.value;
	var child = document.form1.child.value;
	var no = document.form1.seat.length;
	var chk=0;
	var total = parseInt(ad) + parseInt(child);
	
	for(var i=0; i<no; i++){

		if (document.form1.seat[i].checked == true){
		
			chk = chk +1;
		}	
	}
	
	if( chk > total){
		ele.checked=false;
		alert("Maximm "+total+" Seats Selected");
	}
}

function scrolldown(){
	window.scrollTo(0, screen.height + 400);
}

function scrollup(){
	window.scrollTo(0, window.height);
}
</script>
</head>
<body>
<div>
<form name="form1" action="">

<%
int tno=0;
String dt = "";
String clas="";
String adult="";
String child="";
String class1="";
String ch = "";
String[] seats= new String[72];
int no_seats = 0;
String[] wait= new String[10];
int no_wait = 0;
int block = 0;
try{
	
	tno = Integer.parseInt(request.getParameter("tno"));
	dt = request.getParameter("date1");
	clas = request.getParameter("clas");
	adult = request.getParameter("adult");
	child = request.getParameter("child");

	 ch = request.getParameter("ch");//Coach Name

%>
<input name="ch" type="hidden" value='<%= ch %>' />
<%

		if (clas.equals("sl")){				//Differnt class have differnet no of seats per coach
				no_seats = 72;
				no_wait = 10;
				block = 4;
		}else if(clas.equals("a1")){
				no_seats = 18;
				no_wait = 5;
				block = 2;
		}else if(clas.equals("a2")){
				no_seats = 45;
				no_wait = 5;
				block = 3;
		}else if(clas.equals("a3")){
				no_seats = 64;
				no_wait = 10;
				block = 4;
		}


	int avail_seats=0;

	loop: for(int i=1;	i <= no_seats;	i++){
			if(ch.equals(null)){
				break loop;
			}
				String s = "Sno_"+i;
				String sql2="select "+s+" from "+ch+" where train_no=? and dep_date=?;";
 
				pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1,tno);
				pstmt.setString(2,dt);
				
				rs = pstmt.executeQuery();
				while(rs.next()){
					if(rs.getString(1) == null){
						//out.print("<input type='checkbox'>");	
						//out.println(s);
						seats[i-1]="A";			//Stores Available into the seats array which holds the seats booked or not
						avail_seats = avail_seats + 1;
					}
					else{
						//out.print("<input type='checkbox' checked='checked' disabled='disabled' />");
						//out.println(s);
						seats[i-1]="B";			//Stores Booked in seats[]
				
					}				
			}
	}

		loop1: for(int i=1;	i <= no_wait;	i++){
			if(ch.equals(null)){
				break loop1;
			}
				String w = "wait_"+i;
				String sql3="select "+w+" from "+ch+" where train_no=? and dep_date=?;";
 
				pstmt = con.prepareStatement(sql3);
				pstmt.setInt(1,tno);
				pstmt.setString(2,dt);
				
				rs = pstmt.executeQuery();
				while(rs.next()){
					if(rs.getString(1) == null){
						//out.print("<input type='checkbox'>");	
						//out.println(s);
						wait[i-1]="A";			//Stores Available into the wait array which holds the seats booked or not
					}
					else{
						//out.print("<input type='checkbox' checked='checked' disabled='disabled' />");
						//out.println(s);
						wait[i-1]="B";			//Stores Booked tickets in wait[]
				
					}				
			}
	}


%>		

	<%--	out.println("<table>");
		out.println("<tr><th colspan="+block+"> Reservation Seats </th> </tr><tr>");		
		for(int j=0; j <= no_seats -1 ; j++){
			String sno ="Sno_"+(j+1);
			if (seats[j]=="A"){
				int no = j+1;
				out.println("<td>SeatNo:"+no+"</td>");
				out.print("<td><input name='seat' type='checkbox' onclick='check(this)' value='S"+no+"'></td>");
			}
			else{
				out.println("<td>SeatNo:"+(j+1)+"</td>");
				out.print("<td><input type='checkbox' checked='checked' disabled='disabled' /></td>");
			}
			if ((j+1) % block == 0){			//To Give the space between seats
				out.println("</tr><tr>");
			}
		}

		out.println("</table>");

		out.println("<br />");
	--%>

		<br />
<div style="font-size: 12pt">
			 Available Seat <img height="30px" width="50px" src="./images/avilable.PNG"> 
			 Booked Seat<img height="30px" width="50px" src="./images/booked.PNG"> 
			 Selected Seat<img height="30px" width="50px" src="./images/selected.PNG">  <br/><br/>

</div>		
		<h4>Coach:<%= ch %></h4>
		<h4>Available Seats:<%=avail_seats%></h4>
		<p style="font-weight: bold; color: navy;"> Reservation Seats</p>
		<div style="position: fixed; bottom:5%; left:58%;">
			<input type="button" value="Go To Top" onclick="scrollup()"> <br/><br/>
			<input type="button" value="Go To Bottom" onclick="scrolldown()">
		</div>
		<div id='format'>
<%		
		for(int j=0; j <= no_seats -1 ; j++){
			int no = j+1;
			if (seats[j]=="A"){
				out.print("&nbsp;");
				out.print("<input type='checkbox' name='seat'  id='s"+no+"' value='S"+no+"'  onclick='check(this)' />  <label for='s"+no+"' title='AVAILABLE' style=''>S"+no+"</label>");
                out.print("&nbsp;");			
			}
			else{
				out.print("&nbsp;");
                out.print("<input type='checkbox' id='s"+no+"' checked='checked' disabled='disabled' />  <label for='s"+no+"' title='BOOKED' style=''>S"+no+"</label>");
                out.print("&nbsp;");
			}
			if ((j+1) % block == 0){			//To Give the space between seats
				out.print("<br/>");
				out.print("<br/>");
			}
		}
%>
		</div>
		<br />
		<p style="font-weight: bold; color: navy;"> Waiting List Seats</p>
		<div id='format1'>
<%		

		for(int j=0; j <= no_wait - 1 ; j++){
			int no = j+1;
			if (wait[j]=="A"){
                out.print("&nbsp;");
                out.print("<input type='checkbox' name='seat'  id='w"+no+"' value='W"+no+"'  onclick='check(this)' />  <label for='w"+no+"' title='AVAILABLE'>W"+no+"</label>");
                out.print("&nbsp;");
			}
			else{
                out.print("&nbsp;");
                out.print("<input type='checkbox' id='w"+no+"' checked='checked' disabled='disabled' />  <label for='w"+no+"' title='BOOKED'>W"+no+"</label>");
                out.print("&nbsp;");
			}
			if ((j+1) % 5 == 0){			//To Give the space between seats
				out.print("<br/>");
				out.print("<br/>");
			}
		}
%>
		</div>
		<span style='color: red; font-size: 10pt;'> * Please Select Adjacent Seats in Waiting List </span>

<%--		

		out.println("<table>");
		out.println("<tr><th colspan="+block+"> Waiting List Seats </th> </tr><tr>");		
		
		for(int j=0; j <= no_wait -1 ; j++){
			String sno ="Sno_"+(j+1);
			if (wait[j]=="A"){
				int no = j+1;
				out.println("<td>WL No:"+no+"</td>");
				out.print("<td><input name='seat' type='checkbox' onclick='check(this)' value='W"+no+"'></td>");
			}
			else{
				out.println("<td>SeatNo:"+(j+1)+"</td>");
				out.print("<td><input type='checkbox' checked='checked' disabled='disabled' /></td>");
			}
			if ((j+1) % 5 == 0){			//To Give the space between seats
				out.println("</tr><tr>");
			}
		}

		out.println("</table>");
		
		out.println("<div align='left'>  <span style='color: red; font-size: 10pt;'> * Please Select Adjacent Seats in Waiting List </span> </div>");
--%>
<%
}
catch(Exception e){
//	e.printStackTrace();
}
%>

<input name="adult" type="hidden" value='<%= adult %>'>
<input name="child" type="hidden" value='<%= child %>'>
<input name="clas" type="hidden" value='<%= clas %>'>

</form>
</div>
<div id="footer"></div>
</body>
</html>
