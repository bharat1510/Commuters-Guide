<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

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

</head>
<body>
<div>
<%
int pnr=0;
String pnr1="";
String pnr2="";
block:	try{
		pnr1=request.getParameter("pnr1");
		pnr2=request.getParameter("pnr2");
		
		pnr = Integer.parseInt(pnr1.concat(pnr2));

		
		// To Fetch Details Of Train And User Who Has Done The Booking Based On PNR No and dep_date should be greater than todays date
		String sql1="select p.PNR, p.train_no, p.class, p.dep_date, p.no_seats, p.adult, p.child, p.board_station, p.dest_station, p.total_km, p.book_date, p.book_date, p.user_id, u.name, t.train_name, t.type, t.distance, r.s_station_name, r.d_station_name from ticket_book as p, reg_user as u, train_info as t, route_main as r where p.train_no=t.train_no and p.user_id=u.user_id and t.s_station_id=r.s_station_id and t.d_station_id=r.d_station_id and p.PNR=? and p.dep_date > now();";
		
		pstmt = con.prepareStatement(sql1);
		pstmt.setInt(1,pnr);
	
		rs = pstmt.executeQuery();

		int getpnr = 0; //To Check wheteher the sql query gets any pnr no or not if not then to display a message to user
		while(rs.next()){
	    	
			getpnr = rs.getInt("PNR");
			String clas=rs.getString("class");
			String class1="";
	        if (clas.equals("sl")){
	       			class1="Sleeper Class";
	       	}else if(clas.equals("a1")){
					class1="AC First Class";
	       	}else if(clas.equals("a2")){
	       			class1="AC 2 Tier";
	       	}else if(clas.equals("a3")){
					class1="AC 3 Tier";
	       	}
			out.println("<table border='1' bordercolor=#333333>");
			out.println("<tr bgcolor=#333333>");
			out.println("<th align='left' colspan='6' style='color:white'> Train Details : </th> </tr>");
			out.println("<tr bgcolor=#333333 style='color:white'>	<th> Train No</th> <th> Train Name</th> <th> Type</th> <th> Source Station</th><th> Destination Station</th><th> Distance</th>	</tr>");
			out.println("<tr style='color:blue; font-weight:bold'>");
			out.println("<td>"+rs.getInt("train_no")+"</td><td>"+rs.getString("train_name")+"</td><td>"+rs.getString("type")+"</td><td>"+rs.getString("s_station_name")+"</td><td>"+rs.getString("d_station_name")+"</td><td>"+rs.getInt("distance")+"</td>");
			out.println("</tr>");
			out.println("</table>");

			out.println("<br/>");
			
			out.println("<table border='1' bordercolor=#333333>");
			out.println("<th align='left' colspan='5' bgcolor=#333333 style='color:white'> Reservation Details : </th>");
			out.println("<tr bgcolor=#333333 style='color:white'>	<th> PNR No</th> <th> Booked By</th><th> Booked Date</th><th> Departures On</th><th> Class Type</th>	</tr>");
			out.println("<tr style='color:blue; font-weight:bold'>");
			out.println("<td>"+rs.getInt("PNR")+"</td><td>"+rs.getString("name")+"</td><td>"+rs.getDate("book_date")+"</td><td>"+rs.getDate("dep_date")+"</td><td>"+class1+"</td>");			
			out.println("</tr>");
			out.println("<tr bgcolor=#333333 style='color:white'><th> Adults </th> <th> Childern </th><th> Boarding At </th><th> Reserv UPTO</th><th> Travel KM</th></tr>");
			out.println("<tr style='color:blue; font-weight:bold'>");
			out.println("<td>"+rs.getInt("adult")+"</td><td>"+rs.getInt("child")+"</td><td>"+rs.getString("board_station")+"</td><td>"+rs.getString("dest_station")+"</td><td>"+rs.getInt("total_km")+"</td>");			
			out.println("</tr>");
			out.println("</table>");
			
			out.println("<br/>");
		}
		if(getpnr == 0){
			out.println("<h3> <span style='color: red;'> PNR NO DOES NOT EXIST TRY AGAIN </span> </h3>");
			break block;
		}

		//To Fetch All the passenger details under the PNR No
		
		
		String sql3="select p.PNR, p.coach_no, p.seat_no, p.name, p.sex, p.age, p.status from passenger_info as p, ticket_book as t where t.PNR=p.PNR and t.PNR=?";
		
		pstmt = con.prepareStatement(sql3);
		pstmt.setInt(1,pnr);

		rs = pstmt.executeQuery();
		
		
		out.println("<table border='1' bordercolor=#333333>");
		out.println("<th align='left' colspan='6' style='color:white' bgcolor=#333333> Passenger Details : </th>");
		out.println("<tr bgcolor=#333333 style='color:white'>	<th> Coach No</th> <th> Seat No</th><th> Name </th><th> Sex</th><th> Age</th><th> Status</th>	</tr>");

		while(rs.next()){

			out.println("<tr style='color:blue; font-weight:bold'>");
			
			out.println("<td>"+rs.getString("coach_no")+"</td><td>"+rs.getString("seat_no")+"</td><td>"+rs.getString("name")+"</td><td>"+rs.getString("sex")+"</td><td>"+rs.getInt("age")+"</td>");
			out.println(rs.getString("seat_no"));
			if(rs.getString("status").equalsIgnoreCase("RESERVED")){
				out.println("<td><span style='color: green;font-weight: bold;'>");
			}else{
				out.println("<td><span style='color: red;font-weight: bold;'>");				
			}
			out.println(rs.getString("status") +"</span></td>");
			out.println("</tr>");
		}
		out.println("</table>");
		

	}
	catch(Exception e){
		//e.printStackTrace();
	}

%>
</div>
</body>
</html>