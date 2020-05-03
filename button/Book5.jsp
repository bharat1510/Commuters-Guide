<%@page import="com.itextpdf.text.PageSize"%>
<%@page import="com.itextpdf.text.Font"%>
<%@page import="com.itextpdf.text.Element"%>
<%@page import="com.itextpdf.text.pdf.PdfPCell"%>
<%@page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@page import="com.itextpdf.text.Image"%>
<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="java.sql.Time"%>
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
	String uid = (String)session.getAttribute("uid");

		if(ssid == sessionid && author.equals("user")) {
		%>


<%

int pnrno=0;
String date_book="";
String date_dep="";

int tno=0;
int km=0;
String clas="";
String coach="";

int adult1=0;
int child1=0;

String src="";
String des="";
String source="";
String dest="";
double total1= 0;

	try{
		
		total1 = Double.parseDouble(request.getParameter("total1"));
		
		//To get the amount from the credit table
		String sql8 ="select amt from credit where user_id="+uid+" ";
		
		pstmt = con.prepareStatement(sql8);
		rs = pstmt.executeQuery();
		
		double amount = 0;
		if(rs.next()){
			amount = rs.getDouble("amt");
		}
		
		double dec = amount - total1;
		
		//to deduct amount from the credit based on userid
		String sql9 = "update credit set amt=? where user_id="+uid+" ";
		pstmt = con.prepareStatement(sql9);
		
		pstmt.setDouble(1,dec);		
		pstmt.executeUpdate();
		
		
		pnrno=Integer.parseInt(request.getParameter("pnrno"));
		date_book=request.getParameter("date_book");
		date_dep=request.getParameter("date_dep");

		tno=Integer.parseInt(request.getParameter("tno"));
		km=Integer.parseInt(request.getParameter("totalkm"));
		clas=request.getParameter("clas");
		coach=request.getParameter("coach");

		src = request.getParameter("src");
		des = request.getParameter("des");
		

		//to get the station name based on station_id
		String sql5 = "select * from route where station_id=?";
		
		pstmt = con.prepareStatement(sql5);
		
		pstmt.setString(1,src);			//To fetch the details of source station
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			source = rs.getString("station_name");
		}
		
		pstmt.setString(1,des);			//To fetch the details of destination station
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			dest = rs.getString("station_name");
		}
			
		adult1=Integer.parseInt(request.getParameter("adult1"));
		child1=Integer.parseInt(request.getParameter("child1"));

		int no = adult1+child1;		//Total No Of Seats Per Ticket
		
		
		Calendar cal1 = Calendar.getInstance();
		int h = cal1.get(Calendar.HOUR_OF_DAY);
		int m = cal1.get(Calendar.MINUTE);
		int s = cal1.get(Calendar.SECOND);

		String time1 = h+":"+m+":"+s;		//To fetch current time in 24 hrs format
		
		String sql1="insert into ticket_book (PNR, train_no, user_id, class, dep_date, adult, child, no_seats, board_station, dest_station, total_km, book_date, book_time) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		pstmt = con.prepareStatement(sql1);
	
		pstmt.setInt(1,pnrno);
		pstmt.setInt(2,tno);
		pstmt.setInt(3,Integer.parseInt(uid));
		pstmt.setString(4,clas);
		pstmt.setString(5,date_dep);
		pstmt.setInt(6,adult1);
		pstmt.setInt(7,child1);
		pstmt.setInt(8,no);
		pstmt.setString(9,source);
		pstmt.setString(10,dest);
		pstmt.setInt(11,km);
		pstmt.setString(12,date_book);
		pstmt.setString(13,time1);
		
		pstmt.executeUpdate();
		
		// Pdf Generation 
		Document doc = new Document(PageSize.A4);
		
		//String User = System.getProperty("user.name");
		//PdfWriter.getInstance(doc,new FileOutputStream("C:/Users/"+User+"/Desktop/"+pnrno+".pdf"));
		//doc.open();
		
		String file_path = application.getRealPath("");		

		int pos = file_path.indexOf(".metadata");

		//System.out.println(pos);
		
		String file_path1 = file_path.substring(0,pos);
		
		//System.out.println(file_path1);

		String proj = application.getServletContextName();
		//System.out.println(proj);

		PdfWriter.getInstance(doc,new FileOutputStream(file_path1+proj+"/WebContent/pdf/Ticket.pdf"));
		PdfWriter.getInstance(doc,new FileOutputStream(file_path+"/pdf/Ticket.pdf"));
		doc.open();

		
		Font f1 = new Font(Font.getFamily("arial"), 18, Font.BOLD);
		f1.setColor(0x11, 0x11, 0xFF);
		
		Paragraph head = new Paragraph("\n\nCommuters Guide Ticket", f1);
		head.setAlignment(1);
		head.add(" ©");
		doc.add(head);

		Paragraph pag1 = new Paragraph("\n\n\n");
		doc.add(pag1);

		String pnrdetails="PNR Number: "+pnrno+"                                                                                Date="+date_book;
	    doc.addTitle(pnrdetails);
	    
	    doc.add(new Paragraph(pnrdetails));
	    


	    PdfPTable table = new PdfPTable(8); //Code 3		8 is the no of columns
	 
	    PdfPCell cell = new PdfPCell(new Paragraph("Passengers Details"));	//cell with style n values into it
	    cell.setHorizontalAlignment(Element.ALIGN_CENTER);	//allignment for cell
	    cell.setColspan(8);	//column span of 5 to header
	    cell.setGrayFill(0.8f);
	    	    
	    table.addCell(cell);
	    table.setWidthPercentage(100);

	    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    
	    table.addCell("Coach");
	    table.addCell("Seat No.");
	    table.addCell("Name");
	    table.addCell("Sex");
	    table.addCell("Age");
	    table.addCell("Quota");
	    table.addCell("Amount");
	    table.addCell("Status");
	    
	    float[] widths = {8f, 8f, 25f, 6f, 6f, 15f, 8f, 15f};
	    table.setWidths(widths);

		
		for(int i = 1; i<=no; i++){
				String sql2="insert into passenger_info (PNR, coach_no, seat_no, name, sex, age, quota, amount, status) values(?,?,?,?,?,?,?,?,?)";

				pstmt = con.prepareStatement(sql2);
				
				String _seatno = request.getParameter("seat"+i);
				String _name = request.getParameter("name"+i);
				String _sex = request.getParameter("sex"+i);
				int _age = Integer.parseInt(request.getParameter("age"+i));
				double _amt = Double.parseDouble(request.getParameter("amt"+i));
				String _status = request.getParameter("status"+i);
				String SEAT = "";	
				
				String _quota="";
				if(_age < 13){
					_quota="CHILD";
				}else if(_age > 57 && _sex.equals("F")){
					_quota="ADULT";
				}else if(_age > 59 && _sex.equals("M")){
					_quota="ADULT";
				}else{
					_quota="GENERAL";
				}
				
				//Insert into pdf
			    table.addCell(coach);
			    table.addCell(_seatno);
			    table.addCell(_name.toUpperCase());
			    table.addCell(_sex);
			    table.addCell(String.valueOf(_age));
			    table.addCell(_quota);
			    table.addCell(String.valueOf(_amt));
			    table.addCell(_status);
				//pdf code end
			    
			    
				pstmt.setInt(1,pnrno);
				pstmt.setString(2,coach);
				pstmt.setString(3,_seatno);
				pstmt.setString(4,_name.toUpperCase());
				pstmt.setString(5,_sex);
				pstmt.setInt(6,_age);
				pstmt.setString(7,_quota);
				pstmt.setDouble(8,_amt);
				pstmt.setString(9,_status);

				pstmt.executeUpdate();
				
				if (_status.equals("RESERVED")){
					SEAT = "Sno_";				//To define wheteher it is reserved or booked seat i.e Sno_1 or wait_1
				}
				else{
					SEAT = "wait_";						
				}
				String _seatno1 = _seatno.substring(1);			//To fetch only no part from the seat no so tat to insert into particular row in coaches tables
				
				String sql3="update "+coach+" set "+SEAT+_seatno1+" ='"+pnrno+"' where train_no="+tno+" and dep_date='"+date_dep+"'";
				
				pstmt = con.prepareStatement(sql3);
				pstmt.executeUpdate();
		}
		
	    //To add table into pdf    
	    
	    table.setSpacingBefore(12);
	    
	    doc.add(table);
	    String details1 = "\nBooking Time= "+time1+"                                                            Total Amount: "+total1+".Rs";
	    doc.add(new Paragraph(details1));

	    String details4 = "Booked By: "+uname+"\n\n\n";
	    doc.add(new Paragraph(details4));

		Font f2 = new Font(Font.getFamily("arial"), 14, Font.UNDERLINE);
	    doc.add(new Paragraph("Train Details",f2));

	    String details2 = "Train Number: "+tno+" \n Departures on: "+date_dep;
	    doc.add(new Paragraph(details2));
	   
	    String details3 = "Reservation From: "+source+"    UpTo:  "+dest+" \nDistance: "+km;
		doc.add(new Paragraph(details3));
	    doc.close();
		
%>
					<br/>
					<br/>					
					<br/>
					<br/>

	<h3> BOOKING SUCCESSFULL  WITH PNRNO: <span style="color: red;"> <%= pnrno %></span> <br/><br/> 
		<br/></h3>
	<span style="color: red; font-size: 16px; font-weight: bold; font-style: italic;">	Right Click on the below link and select <span style="color: black;"> Save Target as.. or Save Link as.. </span> 
	<br/> To Download the Ticket in pdf format <br/><br/>
	</span>
<%

	out.println("<a href='./pdf/Ticket.pdf' target='_new'> Link To Ticket</a>");		
	}
	catch(Exception e){
		e.printStackTrace();
		out.println("<h1> INPUT ERROR</h1>");
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
