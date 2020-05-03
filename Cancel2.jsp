<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Cancellations</title>
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
int pnrno = 0;
double refund =0.0;
try{
	String[] seat = new String[6];
	String[] seats=request.getParameterValues("seat");
	if (seats != null)
	{
		for (int i = 0; i < seats.length; i++)
		{
			seat[i] = seats[i];			//Assigning values fetched from the request object to variable declared in try block
		}
	}
	
	pnrno = Integer.parseInt(request.getParameter("pnrno"));
   
   String sql1="select * from ticket_book where PNR=?";
   
   pstmt = con.prepareStatement(sql1);
   
   pstmt.setInt(1,pnrno);
   
   rs = pstmt.executeQuery();
   int no_seats = 0;
   int trainno=0;
   String dep_date ="";
   String clas ="";
   String coach ="";
   if(rs.next()){
		no_seats = rs.getInt("no_seats"); 
		trainno = rs.getInt("train_no");
   		clas =rs.getString("class");
   		dep_date = rs.getString("dep_date");
   }
   
   
	// Deletion Of One Seat At a time by using for loopi from seat[] array   
   for(int i=0; i< seats.length;i++){
	   
	   String sno = seat[i];
	   String sql2="select * from passenger_info where PNR=? and seat_no=?";	//To Fetch Details Of The Passenger as per PNR and Seat No
	   
	   pstmt = con.prepareStatement(sql2);	   
	   pstmt.setInt(1,pnrno);
	   pstmt.setString(2,sno);
	   
	   rs = pstmt.executeQuery();
	   
	   String coach_no ="";
	   String name = "";
	   String sex = "";
	   int age = 0;
	   String quota = "";
	   double amount = 0.0;
	   String status = "";
	   
	   if(rs.next()){
			coach = rs.getString("coach_no");
			coach_no = rs.getString("coach_no");
		    name = rs.getString("name");
		    sex = rs.getString("sex");
		    age = rs.getInt("age");
		    quota = rs.getString("quota");
		    amount = rs.getDouble("amount");
		    status = rs.getString("status");
	   }
	   
		//To get the amount from the credit table
		String q1 ="select amt from credit where user_id="+uid+" ";
		
		pstmt = con.prepareStatement(q1);
		rs = pstmt.executeQuery();
		
		double amount1 = 0;
		if(rs.next()){
			amount1 = rs.getDouble("amt");
		}
		
		double add = amount1 + amount  ;
		
		refund = refund + amount;		//total refunded amount
		
		//to add amount for the credit based on userid and seat selected to cancel
		String q2 = "update credit set amt=? where user_id="+uid+" ";
		pstmt = con.prepareStatement(q2);
		
		pstmt.setDouble(1,add);		
		pstmt.executeUpdate();

	   
	   //To insert records into cancel_info table as a back up before deletion

	   	String sql3="insert into cancel_info values("+pnrno+",'"+coach_no+"','"+sno+"','"+name+"','"+sex+"','"+age+"','"+quota+"','"+amount+"','"+status+"','"+uid+"',now());";
  
   		pstmt = con.prepareStatement(sql3);
   		pstmt.executeUpdate();

   		//To delete the booking from passenger_info
   		String sql4="delete from passenger_info where PNR=? and seat_no=?";
   	 	pstmt = con.prepareStatement(sql4);
	   
		pstmt.setInt(1,pnrno);
		pstmt.setString(2,sno);
	   
		pstmt.executeUpdate();
		
		
		String coach_seat="";		//To Create The Seat No's for updation of seat in coaches
		if(sno.charAt(0)=='S'){
			coach_seat ="Sno_"+sno.substring(1);
		}
		else{
			coach_seat ="wait_"+sno.substring(1);;
		}

		//Deletion Of PNR no's from the particular coach so that to make the seat empty affter deleting tat particular reservation
		String sql5="update "+coach_no+" set "+coach_seat+"=NULL where train_no="+trainno+" and dep_date='"+dep_date+"' "; 

		pstmt = con.prepareStatement(sql5);
		pstmt.executeUpdate();
   }
   
   if(no_seats == seats.length){		//To delete all the passenger details for full booking cancellation
	   	
	   String sql6="delete from ticket_book where PNR="+pnrno+"";	

   		pstmt = con.prepareStatement(sql6);
   		pstmt.executeUpdate();

  %> 		
					<br/>
					<br/>					
					<br/>
					<br/>
  		<h2>Cancellation Of All Seats in Ticket</h2> 	
  <%		
   }
   else{			//to update no of seats booked after deletion of some seats during cancellation

	   String sql7 ="select COUNT(PNR) from passenger_info where pnr="+pnrno+" ";
	    
	   pstmt = con.prepareStatement(sql7);
	   rs = pstmt.executeQuery();
	   
	   int final_no_seats=0;
	   if(rs.next()){
		   final_no_seats = rs.getInt(1);
	   }
	
	   //To update total no of seats
	   String sql8="update ticket_book set no_seats="+final_no_seats+" where pnr="+pnrno+" ";	
	   pstmt = con.prepareStatement(sql8);
	   pstmt.executeUpdate();
	   
	   
	  String sql="select age from passenger_info where pnr="+pnrno+" ";
	
	  pstmt = con.prepareStatement(sql);
	  rs = pstmt.executeQuery();
	   int no_adult=0;
	   int no_child=0;
	   while(rs.next()){
		   int age = rs.getInt("age");
		   if(age < 13){
			   no_child = no_child + 1;
		   }
		   else if(age >= 13){
			   no_adult = no_adult + 1;
		   }
	   }
	
	   //To update total no of adult and children
	   String query="update ticket_book set adult="+no_adult+", child="+no_child+" where pnr="+pnrno+" ";	
	   pstmt = con.prepareStatement(query);
	   pstmt.executeUpdate();
	  
	   
  		
 %> 		
					<br/>
					<br/>					
					<br/>
					<br/>
 		<h2>Cancellation Of Selected Seats in Ticket</h2> 	
 <%		
   }
   
	// To fetch The Seats which are in waiting list and to put them to the cancelled seats
   	
	int no_wait=0;
	int coach_seats=0;
	if (clas.equals("sl")){				//Differnt class have differnet no of seats per coach
		coach_seats = 72;
		no_wait = 10;
	}else if(clas.equals("a1")){
		coach_seats = 18;
		no_wait = 5;
	}else if(clas.equals("a2")){
		coach_seats = 45;
		no_wait = 5;
	}else if(clas.equals("a3")){
		coach_seats = 64;
		no_wait = 10;
	}
	//System.out.println(coach);

	String[] wait=new String[no_wait+1];
	String[] pnr=new String[no_wait+1];

	
	loopi:	for(int i=1; i <= coach_seats;	i++){	//loopi to check all the seats in a particular coach

			for(int j=1;	j <= no_wait;	j++){		//To Fetch The Waiting List No's into wait[]
					String w = "wait_"+j;
					String sql9="select "+w+" from "+coach+" where train_no="+trainno+" and dep_date='"+dep_date+"';";
		
					pstmt = con.prepareStatement(sql9);
					rs = pstmt.executeQuery();
					while(rs.next()){
									wait[j-1]=w;			//Stores Waiting list PNR no's
									pnr[j-1]=rs.getString(1);
					}
			}
			
			wait[no_wait]="";			//Stores Null in the Waiting list and PNR no at the end of array
			pnr[no_wait]="";
			
			String s = "Sno_"+i;
			String sql10="select "+s+" from "+coach+" where train_no="+trainno+" and dep_date='"+dep_date+"';";
			
			pstmt = con.prepareStatement(sql10);

			//System.out.println(pstmt);
			rs = pstmt.executeQuery();
			int wno=0;	//Waiting and pnr List array initializer

			while(rs.next()){
				if(rs.getString(1) == null){		//If The Seat In The Coach Is empty Then Waiting List upgrades
					//System.out.println(i);
					//System.out.println(wait[wno]);
					//System.out.println(pnr[wno]);
	
					if(pnr[wno]== null || wait[wno]==""){		//If waiting list contains no PNR no then to exit loopi
						break loopi;
					}
					else{
						//System.out.println(wait[wno]);		
						String num = wait[wno].substring(5);	//fetching the waiting list no from the wait_1

						//Updating passenger_info for the new status from waiting to reserved for the seat no
						String sql11="update passenger_info set status='RESERVED',seat_no='S"+i+"' where PNR="+pnr[wno]+" and seat_no='W"+num+"' ; ";
						pstmt = con.prepareStatement(sql11);
						//System.out.println(pstmt);
						pstmt.executeUpdate();
	
						
						// s is the S_no with an increment value from loopi Placing the PNR no of waiting list to the new seat
						String sql12="update "+coach+" set "+s+"='"+pnr[wno]+"' where train_no="+trainno+" and dep_date='"+dep_date+"'; ";								
						pstmt = con.prepareStatement(sql12);
						//System.out.println(pstmt);
						pstmt.executeUpdate();
	
						//out.println(wait.length);
						
						wno = wno+1;
	
						String[] pnr1 = new String[no_wait+1];
						for(int m=0 ; m<no_wait+1; m++){
							pnr1[m]=pnr[m];
						}
						
						
						//for loopi changing the waiting list no in the coach and passenger_info table 
					  for(int k=1; k <= no_wait ;k++ ){		 
						
						  //System.out.println(pnr1[k]);
							if(pnr1[k]==""){
									pnr1[k]="NULL";							
							}
							//To decrease the no of waiting lists from coach based on no of seats cancled
							String sql13="update "+coach+" set wait_"+k+"="+pnr1[k]+" where train_no="+trainno+" and dep_date='"+dep_date+"'; ";								
							pstmt = con.prepareStatement(sql13);
							//System.out.println(pstmt);
							pstmt.executeUpdate();

							//System.out.println(pnr1[k]);
	
	
							// To Fetch The Waiting list from passenger_info and decreasing the no of it
							String sql15="select p.PNR from passenger_info p, ticket_book t where t.pnr=p.pnr and t.dep_date='"+dep_date+"' and p.seat_no='W"+(k)+"' and p.coach_no='"+coach+"'";
							pstmt = con.prepareStatement(sql15);
							//System.out.println(pstmt);
							rs = pstmt.executeQuery();

							String newpnr="";

							if(rs.next()){
								newpnr=rs.getString(1);
							
									if(newpnr != null){
									//Updating passenger_info for the new status from waiting to reserved for the seat no
									String sql14="update passenger_info set status='WAITING',seat_no='W"+(k-1)+"' where PNR="+newpnr+" and seat_no='W"+(k)+"' ; ";
									pstmt = con.prepareStatement(sql14);
									//System.out.println(pstmt);
									pstmt.executeUpdate();
									}
							}
						}// Close of k for loopi

						if(wno == no_wait){		
							break loopi;
						}
					}
				}
			}
} 		
%>   
	<h2>was successful</h2>
	Refunded amount is <span style="color: red"> Rs. <%= refund %></span>
	<a href="./userhome.jsp" > OK </a>
	
<%
}
catch(Exception e){
%>
	<h2> Input Error</h2>
<%
	//e.printStackTrace();
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
