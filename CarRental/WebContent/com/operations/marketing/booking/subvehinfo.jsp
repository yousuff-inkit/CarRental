<%--  
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
 --%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%@page import="com.operations.marketing.booking.ClsbookingDAO" %>
  
  <%         
 
  ClsbookingDAO viewDAO=new ClsbookingDAO();
  String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
  String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
 // System.out.println("fromdate----------"+fromdate+"----todate------"+todate);
  
  %>
  
 <html>

 <table  align="right" width="99%" style="padding-bottom:5px" >
 <tr>
  <td  width="4%">
 <td style="background-color: #ACF6CB;" width="5%"></td> <td align="left"><label class="branch">&nbsp;Available</label></td>
 <td  width="4%">
 <td style="background-color: #ff99c8;" width="5%"></td> <td align="left"><label class="branch">&nbsp;Not Available (Daily / Weekly)</label></td>
  <td  width="4%">
 <td style="background-color: #ff6347;" width="5%"></td> <td align="left"><label class="branch">&nbsp;Not Available (Monthly)</label></td>
  <td  width="4%">
 <td style="background-color: #eedd82;" width="5%"></td> <td align="left"><label class="branch">&nbsp;Due Date Expired</label></td>
 <td  width="4%">
 <td style="background-color: #adb3fc;" width="5%"></td> <td align="left"><label class="branch">&nbsp;Booking List</label></td>
 
 </tr>
 </table>


 </html>
 
 <%@page import="java.util.*" %>
 <%@page import="java.text.SimpleDateFormat" %>
<%--   <%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpSession" %> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%




String a1="";String a2="";String a3="";String a4="";String a5="";String a6="";String a7="";String a8="";  
String a9="";String a10="";String a11="";String a12="";String a13="";String a14="";String a15="";
String a16="";String a17="";String a18="";String a19="";String a20="";String a21="";String a22="";String a23="";
String a24="";String a25="";String a26="";String a27="";String a28="";String a29="";String a30="";

String b1="";String b2="";String b3="";String b4="";String b5="";String b6="";String b7="";String b8="";  
String b9="";String b10="";String b11="";String b12="";String b13="";String b14="";String b15="";
String b16="";String b17="";String b18="";String b19="";String b20="";String b21="";String b22="";String b23="";
String b24="";String b25="";String b26="";String b27="";String b28="";String b29="";String b30="";


String[] parts = fromdate.split("\\.");

//Extract day, month, and year
if (parts.length > 1) {
String day = parts[0];
String month = parts[1];
String year = parts[2];

//Print the results
//System.out.println("Day: " + day);
//System.out.println("Month: " + month);
//System.out.println("Year: " + year);

int dayInt = Integer.parseInt(day);
int monthInt = Integer.parseInt(month) - 1; // Month is 0-based in Calendar
int yearInt = Integer.parseInt(year);
Calendar calendar = Calendar.getInstance();
calendar.set(yearInt, monthInt, dayInt);

for (int i = 0; i <= 29; i++) {
//Add i days to the initialized date
calendar.add(Calendar.DATE, i);

//Format and assign the date to corresponding variables

int years = calendar.get(Calendar.YEAR);
int lastTwoDigits = years % 100;
//System.out.println(lastTwoDigits);
String formattedDate = (calendar.get(Calendar.MONTH)+ 1) + "-" + calendar.get(Calendar.DATE) + "-" + lastTwoDigits;
String formattedDate2 = calendar.get(Calendar.DATE) + "-" + (calendar.get(Calendar.MONTH)+ 1) ;
if (i == 0) { a1 = formattedDate; }
if (i == 1) { a2 = formattedDate; }
if (i == 2) { a3 = formattedDate; }
if (i == 3) { a4 = formattedDate; } 
if (i == 4) { a5 = formattedDate; }
if (i == 5) { a6 = formattedDate; }
if (i == 6) { a7 = formattedDate; }
if (i == 7) { a8 = formattedDate; }
if (i == 8) { a9 = formattedDate; }
if (i == 9) { a10 = formattedDate; }
if (i == 10) { a11 = formattedDate; }
if (i == 11) { a12 = formattedDate; }
if (i == 12) { a13 = formattedDate; }
if (i == 13) { a14 = formattedDate; }
if (i == 14) { a15 = formattedDate; }
if (i == 15) { a16 = formattedDate; }
if (i == 16) { a17 = formattedDate; }
if (i == 17) { a18 = formattedDate; }
if (i == 18) { a19 = formattedDate; }
if (i == 19) { a20 = formattedDate; }
if (i == 20) { a21 = formattedDate; }
if (i == 21) { a22 = formattedDate; }
if (i == 22) { a23 = formattedDate; }
if (i == 23) { a24 = formattedDate; }
if (i == 24) { a25 = formattedDate; }
if (i == 25) { a26 = formattedDate; }
if (i == 26) { a27 = formattedDate; }
if (i == 27) { a28 = formattedDate; }
if (i == 28) { a29 = formattedDate; }
if (i == 29) { a30 = formattedDate; }

if (i == 0) { b1 = formattedDate2; }
if (i == 1) { b2 = formattedDate2; }
if (i == 2) { b3 = formattedDate2; }
if (i == 3) { b4 = formattedDate2; }
if (i == 4) { b5 = formattedDate2; }
if (i == 5) { b6 = formattedDate2; }
if (i == 6) { b7 = formattedDate2; }
if (i == 7) { b8 = formattedDate2; }
if (i == 8) { b9 = formattedDate2; }
if (i == 9) { b10 = formattedDate2; }
if (i == 10) { b11 = formattedDate2; }
if (i == 11) { b12 = formattedDate2; }
if (i == 12) { b13 = formattedDate2; }
if (i == 13) { b14 = formattedDate2; }
if (i == 14) { b15 = formattedDate2; }
if (i == 15) { b16 = formattedDate2; }
if (i == 16) { b17 = formattedDate2; }
if (i == 17) { b18 = formattedDate2; }
if (i == 18) { b19 = formattedDate2; }
if (i == 19) { b20 = formattedDate2; }
if (i == 20) { b21 = formattedDate2; }
if (i == 21) { b22 = formattedDate2; }
if (i == 22) { b23 = formattedDate2; }
if (i == 23) { b24 = formattedDate2; }
if (i == 24) { b25 = formattedDate2; }
if (i == 25) { b26 = formattedDate2; }
if (i == 26) { b27 = formattedDate2; }
if (i == 27) { b28 = formattedDate2; }
if (i == 28) { b29 = formattedDate2; }
if (i == 29) { b30 = formattedDate2; }


//Reset the calendar to the original date for the next iteration
calendar.set(yearInt, monthInt, dayInt);
}
}
%>

<style>

  .yellowClass
        {
        
       
       background-color: #eedd82; 
        /*   background-color: #eedd82;  */
        }
 .greenClass
        {
            background-color: #ACF6CB;
        }
   .redClass
        {
            background-color: #ff6347; 
         /*  background-color: #FFEBEB; */
        }
        		   .blueClass
        {
            background-color: #adb3fc; 
        }
          .monthlyClass
        {
            background-color: #ff758f; 
        }
         .dailyweeklyClass
        {
            background-color: #ff99c8; 
        }
       
 </style>

 <script type="text/javascript">




 var a1='<%=a1%>'; 
var a2='<%=a2%>';
var a3='<%=a3%>';
var a4='<%=a4%>';
var a5='<%=a5%>';
var a6='<%=a6%>';
var a7='<%=a7%>';
var a8='<%=a8%>';
var a9='<%=a9%>';
var a10='<%=a10%>';
var a11='<%=a11%>';
var a12='<%=a12%>';
var a13='<%=a13%>';
 var a14='<%=a14%>';
 var a15='<%=a15%>';
 
 
 var a16='<%=a16%>'; 
 var a17='<%=a17%>';
 var a18='<%=a18%>';
 var a19='<%=a19%>';
 var a20='<%=a20%>';
 var a21='<%=a21%>';
 var a22='<%=a22%>';
 var a23='<%=a23%>';
 var a24='<%=a24%>';
 var a25='<%=a25%>';
 var a26='<%=a26%>';
 var a27='<%=a27%>';
 var a28='<%=a28%>';
 var a29='<%=a29%>';
  var a30='<%=a30%>';
  
  var b1='<%=b1%>'; 
  var b2='<%=b2%>';
  var b3='<%=b3%>';
  var b4='<%=b4%>';
  var b5='<%=b5%>';
  var b6='<%=b6%>';
  var b7='<%=b7%>';
  var b8='<%=b8%>';
  var b9='<%=b9%>';
  var b10='<%=b10%>';
  var b11='<%=b11%>';
  var b12='<%=b12%>';
  var b13='<%=b13%>';
   var b14='<%=b14%>';
   var b15='<%=b15%>';
   
   
   var b16='<%=b16%>'; 
   var b17='<%=b17%>';
   var b18='<%=b18%>';
   var b19='<%=b19%>';
   var b20='<%=b20%>';
   var b21='<%=b21%>';
   var b22='<%=b22%>';
   var b23='<%=b23%>';
   var b24='<%=b24%>';
   var b25='<%=b25%>';
   var b26='<%=b26%>';
   var b27='<%=b27%>';
   var b28='<%=b28%>';
   var b29='<%=b29%>';
    var b30='<%=b30%>';

 var vehdata='<%=viewDAO.vehSearch(session,fromdate,todate)%>';    
        $(document).ready(function () { 	
        	
        	 
        	        
        	    
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                	{name : 'fleet_no', type: 'String'  },
						{name : 'flname', type: 'String'  },
						{name : 'days', type: 'String'  },
						
		
					  	{name : 'color', type: 'String'  },
						{name : 'clrid', type: 'String'  },
						{name : 'gname', type: 'String'  },
						
					  	{name : 'vgrpid', type: 'String'  },
						{name : 'brand_name', type: 'String'  },
						{name : 'brdid', type: 'String'  },
						
					  	{name : 'model', type: 'String'  },
						{name : 'vmodid', type: 'String'  },
						
						{name : 'a_loc', type: 'String'  },
						
						{name : 'reg_no', type: 'String'  },
						{name : 'frmdate', type: 'String'  },
						{name : 'todate', type: 'String'  },
						{name : 'rstatus', type: 'String'  },
						{name : 'date1', type: 'string' },
						{name : 'date2', type: 'string' },
						{name : 'date3', type: 'string' },
						{name : 'date4', type: 'string' },
						{name : 'date5', type: 'string' },
						{name : 'date6', type: 'string' },
						{name : 'date7', type: 'string' },
						{name : 'date8', type: 'string' },
						{name : 'date9', type: 'string' },
						{name : 'date10', type: 'string' },
						{name : 'date11', type: 'string' },
						{name : 'date12', type: 'string' },
						{name : 'date13', type: 'string' },
						{name : 'date14', type: 'string' },
						{name : 'date15', type: 'string' },
						{name : 'date16', type: 'string' },
						{name : 'date17', type: 'string' },
						{name : 'date18', type: 'string' },
						{name : 'date19', type: 'string' },
						{name : 'date20', type: 'string' },
						{name : 'date21', type: 'string' },
						{name : 'date22', type: 'string' },
						{name : 'date23', type: 'string' },
						{name : 'date24', type: 'string' },
						{name : 'date25', type: 'string' },
						{name : 'date26', type: 'string' },
						{name : 'date27', type: 'string' },
						{name : 'date28', type: 'string' },
						{name : 'date29', type: 'string' },
						{name : 'date30', type: 'string' },
					
			     		
						     
     			     		
     						            	
                          	],
             
                          	localdata: vehdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var cellclassname = function (rowIndex, column, value, data) {
            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
           // var no=parseInt(column);
          var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  		
         	          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
            	if(ss>=no && renttypechk!='Monthly')
            		{
            		
            		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
            	
            		}
          	if(ss>=no && renttypechk=='Monthly')
        		{
        		
        		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
        	
        		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	 
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a11=new Date(a1);
      		 	 if (a11 >= newfrmDayMonth && a11<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}		
  					 
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
              	
           	};
              

              var cellclassname1 = function (rowIndex, column, value, data) {
           	   

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
          
             var no= parseInt(column.replace("date", ""));

          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
          
          
          if(parseInt(ss)<0 )
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			       	if(ss>=no && renttypechk!='Monthly')
  	          		{
  	          		
  	          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  	          	
  	          		}
  	        	if(ss>=no && renttypechk=='Monthly')
  	      		{
  	      		
  	      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  	      	
  	      		}
  			        	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a21=new Date(a2);
      		 	 if (a21 >= newfrmDayMonth && a21<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}		
  					 
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
              	
           	};
              
              
          var cellclassname2 = function (rowIndex, column, value, data) {

        	  if(typeof(data.days)=="undefined" || data.days=="" ){
        		return "greenClass";
            }  
          
   
    
       var no= parseInt(column.replace("date", ""));

      var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
      var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  	  
  		          if(parseInt(ss)<0)
  		  		{
  		  		
  		  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  		  	
  		  		}
  		          if(ss>=no && renttypechk!='Monthly')
  	          		{
  	          		
  	          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  	          	
  	          		}
  	        	if(ss>=no && renttypechk=='Monthly')
  	      		{
  	      		
  	      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  	      	
  	      		}
  				
        	if(ss=='bookstatus')
    		{
    		
    		     /*   blue - booking status 3 */
  					var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
       	    
       	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
       	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
       	    
       	    var frmDateParts = frmdate.split('-');
       	    var toDateParts = toodate.split('-');
       	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
  		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  		 var newtoDayMonth = new Date(toDayMonth);
  		  var a31=new Date(a3);
  		 	 if (a31 >= newfrmDayMonth && a31<= newtoDayMonth) {
  				    return "blueClass";
  				} else {
  				    return "greenClass";
  				}		 
    	
    		}
        	  else{
              	//alert(data.amount);
              	return "greenClass"; /*   green - vehicle  available that date */
              };
          
       	};
             
              
          var cellclassname3 = function (rowIndex, column, value, data) {
          	 if(typeof(data.days)=="undefined" || data.days=="" ){
           		return "greenClass";
               }  
             
            var no= parseInt(column.replace("date", ""));
         var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
         var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
  					
  		        	if(ss=='bookstatus')
       		{
       		
       		     /*   blue - booking status 3 */
  					var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
       	    
       	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
       	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
       	    
       	    var frmDateParts = frmdate.split('-');
       	    var toDateParts = toodate.split('-');
       	    
       	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
  		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  		 var newtoDayMonth = new Date(toDayMonth);
  		  var a41=new Date(a4);
  		 	 if (a41 >= newfrmDayMonth && a41<= newtoDayMonth) {
  				    return "blueClass";
  				} else {
  				    return "greenClass";
  				}		
  					 
       	
       		}
           	  else{
                 	//alert(data.amount);
                 	return "greenClass"; /*   green - vehicle  available that date */
                 };
          
       	};
              
              
          var cellclassname4 = function (rowIndex, column, value, data) {
          	 if(typeof(data.days)=="undefined" || data.days=="" ){
           		return "greenClass";
               }  
             
            var no= parseInt(column.replace("date", ""));
         var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
         var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
           	if(ss=='bookstatus')
       		{
       		
       		     /*   blue - booking status 3 */
  					var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
       	    
       	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
       	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
       	    
       	    var frmDateParts = frmdate.split('-');
       	    var toDateParts = toodate.split('-');
       	    
       	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
  		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  		 var newtoDayMonth = new Date(toDayMonth);
  		  var a51=new Date(a5);
  		 	 if (a51 >= newfrmDayMonth && a51<= newtoDayMonth) {
  				    return "blueClass";
  				} else {
  				    return "greenClass";
  				}		
       	
       		}
           	  else{
                 	//alert(data.amount);
                 	return "greenClass"; /*   green - vehicle  available that date */
                 };
          
       	};
              
              
          var cellclassname5 = function (rowIndex, column, value, data) {
          	 if(typeof(data.days)=="undefined" || data.days=="" ){
           		return "greenClass";
               }  
             
            var no= parseInt(column.replace("date", ""));
         var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
         var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
           	if(ss=='bookstatus')
       		{
       		
       		     /*   blue - booking status 3 */
  					 
  			var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
       	    
       	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
       	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
       	    
       	    var frmDateParts = frmdate.split('-');
       	    var toDateParts = toodate.split('-');
       	    
       	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
  		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  		 var newtoDayMonth = new Date(toDayMonth);
  		  var a61=new Date(a6);
  		 	 if (a61 >= newfrmDayMonth && a61<= newtoDayMonth) {
  				    return "blueClass";
  				} else {
  				    return "greenClass";
  				}		
       		}
           	  else{
                 	//alert(data.amount);
                 	return "greenClass"; /*   green - vehicle  available that date */
                 };
          	
       	};
              
              
          var cellclassname6 = function (rowIndex, column, value, data) {
          	 if(typeof(data.days)=="undefined" || data.days=="" ){
           		return "greenClass";
               }  
             
            var no= parseInt(column.replace("date", ""));
         var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
         var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
           	if(ss=='bookstatus')
       		{
       		
       		     /*   blue - booking status 3 */
  			var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
       	    
       	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
       	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
       	    
       	    var frmDateParts = frmdate.split('-');
       	    var toDateParts = toodate.split('-');
       	    
       	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
  		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  		 var newtoDayMonth = new Date(toDayMonth);
  		  var a71=new Date(a7);
  		 	 if (a71 >= newfrmDayMonth && a71<= newtoDayMonth) {
  				    return "blueClass";
  				} else {
  				    return "greenClass";
  				}		
       		}
           	  else{
                 	//alert(data.amount);
                 	return "greenClass"; /*   green - vehicle  available that date */
                 };
          	
       	};
              
              
     
              
            /*     var cellclassname7 = function (rowIndex, column, value, data) {
              	    // Get the grid instance
              	    var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
              	    for (var row = 0; row < rowsCount; row++) {
              	        // Get the frmdate and todate for the current row
              	        var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', row, "frmdate");
              	        var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', row, "todate");
  console.log("frmdate----"+frmdate+"====todate===="+toodate);
              	        // Assuming format is 'DD-MM' and splitting the dates
              	        var frmDateParts = frmdate.split('-');
              	        var toDateParts = toodate.split('-');

              	        var frmDayMonth = frmDateParts[2] + '-' + frmDateParts[1]+ '-' + frmDateParts[0].slice(-2);// 'DD-MM'
              	        frmDayMonth = frmDayMonth.replace(/^0+/, '').replace(/-0+/, '-');
              	      var toDayMonth = toDateParts[2] + '-' + toDateParts[1] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
              	        toDayMonth = toDayMonth.replace(/^0+/, '').replace(/-0+/, '-');

              	        if (frmDayMonth >= a8 && toDayMonth <= a8) {
              	            return "blueClass";
              	        } else {
              	            return "greenClass";
              	        }
              	    }
              	};  
   */

  	
  	var cellclassname7 = function (rowIndex, column, value, data) {

  	  if(typeof(data.days)=="undefined" || data.days=="" ){
  		return "greenClass";
     }  
   
   var no= parseInt(column.replace("date", ""));
  var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
  var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
           if(parseInt(ss)<0)
   		{
   		
   		return "yellowClass";       /*   yellow - vehicle due pending/expired */
   	
   		}
           if(ss>=no && renttypechk!='Monthly')
     		{
     		
     		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
     	
     		}
   	if(ss>=no && renttypechk=='Monthly')
  		{
  		
  		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  	
  		}
  	if(ss=='bookstatus')
  	{
  	
  	     /*   blue - booking status 3 */
  		 // Get the grid instance
  	 /*   var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
  	    
  	    // Get the frmdate and todate for the current row (rowIndex represents the current row)
  	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
  	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
  	   // console.log("frmdate----" + frmdate + "====todate====" + toodate);
  	    
  	    // Assuming format is 'DD-MM' and splitting the dates
  	    var frmDateParts = frmdate.split('-');
  	    var toDateParts = toodate.split('-');
  	 
  	    //var frmDayMonth = frmDateParts[2] + '-' + frmDateParts[1]+ '-' + frmDateParts[0]; // 'DD-MM'
  	    var frmDayMonth = frmDateParts[2] + '-' + frmDateParts[1]+ '-' + frmDateParts[0].slice(-2);// 'DD-MM'
  	    frmDayMonth = frmDayMonth.replace(/^0+/, '').replace(/-0+/, '-');
  	   // var toDayMonth = toDateParts[2] + '-' + toDateParts[1]+ '-' + toDateParts[0]; // 'DD-MM'
  	 var toDayMonth = toDateParts[2] + '-' + toDateParts[1] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  	    toDayMonth = toDayMonth.replace(/^0+/, '').replace(/-0+/, '-');
  	    //console.log("frmDayMonth----" + frmDayMonth + "====toDayMonth====" + toDayMonth+ "====a8====" + a8);
  	    // Assuming a8 is defined elsewhere in your code and is in a comparable format
  	   	   console.log("a8---"+a8+"frmday-----"+frmDayMonth+"today----"+toDayMonth);
         			
  	    if (a8 >= frmDayMonth && a8 <= toDayMonth) {
  						    return "blueClass";
  						} else {
  						    return "greenClass";
  						}*/
  						
  						
  						var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
  		        	    
  		        	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
  		        	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
  		        	    
  		        	    var frmDateParts = frmdate.split('-');
  		        	    var toDateParts = toodate.split('-');
  		        	    
  		        	    var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
  		        		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  		        		 var newtoDayMonth = new Date(toDayMonth);
  		        		  var a81=new Date(a8);
  		        		 	 if (a81 >= newfrmDayMonth && a81<= newtoDayMonth) {
  		        				    return "blueClass";
  		        				} else {
  		        				    return "greenClass";
  		        				}			
  						
  		 

  	}
  	  else{
       	//alert(data.amount);
       	return "greenClass"; /*   green - vehicle  available that date */
       };
  	
  	};


              
  	var cellclassname8 = function (rowIndex, column, value, data) {

    	  if(typeof(data.days)=="undefined" || data.days=="" ){
    		return "greenClass";
        }  
      
     var no= parseInt(column.replace("date", ""));
  var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
  var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  	          if(parseInt(ss)<0)
  	  		{
  	  		
  	  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  	  	
  	  		}
  	          if(ss>=no && renttypechk!='Monthly')
          		{
          		
          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
          	
          		}
        	if(ss>=no && renttypechk=='Monthly')
      		{
      		
      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
      	
      		}
    	if(ss=='bookstatus')
  		{
  		
  		     /*   blue - booking status 3 */
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
  	    
  	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
  	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
  	    
  	    var frmDateParts = frmdate.split('-');
  	    var toDateParts = toodate.split('-');
  	    
  	    var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);// 'DD-MM'
  	  //  console.log("a9---"+a9);
  	    //frmDayMonth = frmDayMonth.replace(/^0+/, '').replace(/-0+/, '-');
  	    var newfrmDayMonth = new Date(frmDayMonth);
  	    
  	  var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  	 //  toDayMonth = toDayMonth.replace(/^0+/, '').replace(/-0+/, '-');
  	   var newtoDayMonth = new Date(toDayMonth);
  	   var a91=new Date(a9);
  	  //  console.log("a91---"+a91+"newfrmDayMonth-----"+newfrmDayMonth+"today----"+newtoDayMonth);
  	  //  console.log("condition check---"+a91 >= newfrmDayMonth && a91<= newtoDayMonth);
     				 if (a91 >= newfrmDayMonth && a91<= newtoDayMonth) {
  			    return "blueClass";
  			} else {
  			    return "greenClass";
  			}
  			 
  	
  		}
    	  else{
          	//alert(data.amount);
          	return "greenClass"; /*   green - vehicle  available that date */
          };
  	
  	};

         
              var cellclassname9 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus"); 
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
          	    
          	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
          	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
          	    
          	    var frmDateParts = frmdate.split('-');
          	    var toDateParts = toodate.split('-');
          	    
          	    var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
          		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
          		 var newtoDayMonth = new Date(toDayMonth);
          		  var a101=new Date(a10);
          		 	 if (a101 >= newfrmDayMonth && a101<= newtoDayMonth) {
          				    return "blueClass";
          				} else {
          				    return "greenClass";
          				}
          	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
              	
          	};
              
          	 var cellclassname10 = function (rowIndex, column, value, data) {

             	  if(typeof(data.days)=="undefined" || data.days=="" ){
             		return "greenClass";
                 }  
               
              var no= parseInt(column.replace("date", ""));
           var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
           var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus"); 
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
             	if(ss=='bookstatus')
         		{
         		
         		     /*   blue - booking status 3 */
  					 
  					 var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a111=new Date(a11);
      		 	 if (a111 >= newfrmDayMonth && a111<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
         	
         		}
             	  else{
                   	//alert(data.amount);
                   	return "greenClass"; /*   green - vehicle  available that date */
                   };
          	
           	};
               
          
              
           	var cellclassname11 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus"); 
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a121=new Date(a12);
      		 	 if (a121 >= newfrmDayMonth && a121<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
           
              
           	var cellclassname12 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus"); 
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  					 
  					var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); 
      		   var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a131=new Date(a13);
      		 	 if (a131 >= newfrmDayMonth && a131<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
            
           	var cellclassname13 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  					 
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a141=new Date(a14);
      		 	 if (a141 >= newfrmDayMonth && a141<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
              
           	var cellclassname14 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus"); 
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  					 var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a151=new Date(a15);
      		 	 if (a151 >= newfrmDayMonth && a151<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  }; 
           	};
           	var cellclassname15 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  			var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a161=new Date(a16);
      		 	 if (a161 >= newfrmDayMonth && a161<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
           	
           	var cellclassname16 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  						var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a171=new Date(a17);
      		 	 if (a171 >= newfrmDayMonth && a171<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
  					 
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           	
           	};
              
              
           	var cellclassname17 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  					var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a181=new Date(a18);
      		 	 if (a181 >= newfrmDayMonth && a181<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
  					 
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
            
              
           	var cellclassname18 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus"); 
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  					 
  					var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a191=new Date(a19);
      		 	 if (a191 >= newfrmDayMonth && a191<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           	
           	};
            
              
           	var cellclassname19 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus"); 
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a201=new Date(a20);
      		 	 if (a201 >= newfrmDayMonth && a201<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
              
              
           	var cellclassname20 = function (rowIndex, column, value, data) {
           	 

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a211=new Date(a21);
      		 	 if (a211 >= newfrmDayMonth && a211<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
             
              
           	var cellclassname21 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  					var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a221=new Date(a22);
      		 	 if (a221 >= newfrmDayMonth && a221<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           	
           	};
              
              
           	var cellclassname22 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a231=new Date(a23);
      		 	 if (a231 >= newfrmDayMonth && a231<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           	
           	};
              
              
           	var cellclassname23 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  					 
  					 var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a241=new Date(a24);
      		 	 if (a241 >= newfrmDayMonth && a241<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
             
              
           	var cellclassname24 = function (rowIndex, column, value, data) {

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}          	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a251=new Date(a25);
      		 	 if (a251 >= newfrmDayMonth && a251<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
  					 
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
             
              
           	var cellclassname25 = function (rowIndex, column, value, data) {
           	 

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");  
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  					 
  					var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a261=new Date(a26);
      		 	 if (a261 >= newfrmDayMonth && a261<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           		
           	};
             
              
           	var cellclassname26 = function (rowIndex, column, value, data) {
           	   

            	  if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }  
              
             var no= parseInt(column.replace("date", ""));
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
          var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
           if(ss>=no && renttypechk!='Monthly')
            		{
                		
                		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
                	
                		}
              	if(ss>=no && renttypechk=='Monthly')
            		{
            		
            		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
            	
            		}
            	if(ss=='bookstatus')
        		{
        		
        		     /*   blue - booking status 3 */
  					 
  					var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
           	    
           	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
           	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
           	    
           	    var frmDateParts = frmdate.split('-');
           	    var toDateParts = toodate.split('-');
           	    
           	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
      		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
      		 var newtoDayMonth = new Date(toDayMonth);
      		  var a271=new Date(a27);
      		 	 if (a271 >= newfrmDayMonth && a271<= newtoDayMonth) {
      				    return "blueClass";
      				} else {
      				    return "greenClass";
      				}
      	
        	
        		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   green - vehicle  available that date */
                  };
           	
           	};
             
              
           	 var cellclassname27 = function (rowIndex, column, value, data) {

             	  if(typeof(data.days)=="undefined" || data.days=="" ){
             		return "greenClass";
                 }  
               
              var no= parseInt(column.replace("date", ""));
           var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
           var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  			          if(parseInt(ss)<0)
  			  		{
  			  		
  			  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  			  	
  			  		}
  			          if(ss>=no && renttypechk!='Monthly')
  		          		{
  		          		
  		          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  		          	
  		          		}
  		        	if(ss>=no && renttypechk=='Monthly')
  		      		{
  		      		
  		      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  		      	
  		      		}
             	if(ss=='bookstatus')
         		{
         		
         		     /*   blue - booking status 3 */
  					 
  					 
         	 var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
            	    
            	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
            	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
            	    
            	    var frmDateParts = frmdate.split('-');
            	    var toDateParts = toodate.split('-');
            	    
            	  var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
     		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
     		 var newtoDayMonth = new Date(toDayMonth);
     		  var a281=new Date(a28);
     		 	 if (a281 >= newfrmDayMonth && a281<= newtoDayMonth) {
     				    return "blueClass";
     				} else {
     				    return "greenClass";
     				}
     	
         		}
             	  else{
                   	//alert(data.amount);
                   	return "greenClass"; /*   green - vehicle  available that date */
                   };
           		
            	};
            
              
          var cellclassname28 = function (rowIndex, column, value, data) {

        	  if(typeof(data.days)=="undefined" || data.days=="" ){
        		return "greenClass";
            }  
          
         var no= parseInt(column.replace("date", ""));
      var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
      var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  		          if(parseInt(ss)<0)
  		  		{
  		  		
  		  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  		  	
  		  		}
  		          if(ss>=no && renttypechk!='Monthly')
  	          		{
  	          		
  	          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  	          	
  	          		}
  	        	if(ss>=no && renttypechk=='Monthly')
  	      		{
  	      		
  	      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  	      	
  	      		}
        	if(ss=='bookstatus')
    		{
    		
    		     /*   blue - booking status 3 */
  				 
  				var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
       	    
       	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
       	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
       	    
       	    var frmDateParts = frmdate.split('-');
       	    var toDateParts = toodate.split('-');
       	    
       	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
  		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  		 var newtoDayMonth = new Date(toDayMonth);
  		  var a291=new Date(a29);
  		 	 if (a291 >= newfrmDayMonth && a291<= newtoDayMonth) {
  				    return "blueClass";
  				} else {
  				    return "greenClass";
  				}
  	
    	
    		}
        	  else{
              	//alert(data.amount);
              	return "greenClass"; /*   green - vehicle  available that date */
              };
          
       	};
       	var cellclassname29 = function (rowIndex, column, value, data) {

        	  if(typeof(data.days)=="undefined" || data.days=="" ){
        		return "greenClass";
            }  
          
         var no= parseInt(column.replace("date", ""));
      var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "days");
      var renttypechk= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "rstatus");
  		          if(parseInt(ss)<0)
  		  		{
  		  		
  		  		return "yellowClass";       /*   yellow - vehicle due pending/expired */
  		  	
  		  		}
  		          if(ss>=no && renttypechk!='Monthly')
  	          		{
  	          		
  	          		return "dailyweeklyClass";         /*   red - vehicle Not  available that date for Daily/Weekly */
  	          	
  	          		}
  	        	if(ss>=no && renttypechk=='Monthly')
  	      		{
  	      		
  	      		return "monthlyClass";         /*   red - vehicle Not  available that date for Monthly */
  	      	
  	      		}
        	if(ss=='bookstatus')
    		{
    		
    		     /*   blue - booking status 3 */
  			var rowsCount = $('#jqxfleetsearch').jqxGrid('getrows').length;
       	    
       	    var frmdate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "frmdate");
       	    var toodate = $('#jqxfleetsearch').jqxGrid('getcellvalue', rowIndex, "todate");
       	    
       	    var frmDateParts = frmdate.split('-');
       	    var toDateParts = toodate.split('-');
       	    
       	   var frmDayMonth = frmDateParts[1] + '-' + frmDateParts[2]+ '-' + frmDateParts[0].slice(-2);
  		   var newfrmDayMonth = new Date(frmDayMonth); var toDayMonth = toDateParts[1] + '-' + toDateParts[2] + '-' + toDateParts[0].slice(-2); // 'DD-MM'
  		 var newtoDayMonth = new Date(toDayMonth);
  		  var a301=new Date(a30);
  		 	 if (a301 >= newfrmDayMonth && a301<= newtoDayMonth) {
  				    return "blueClass";
  				} else {
  				    return "greenClass";
  				}
  	
    	
    		}
        	  else{
              	//alert(data.amount);
              	return "greenClass"; /*   green - vehicle  available that date */
              };
       		
       	};
              
    	        
    	        
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxfleetsearch").jqxGrid(
            {
                width: '99%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
              /*   filtermode:'excel',
                filterable: true, */
               filterable: true,
              showfilterrow: true, 
                selectionmode: 'singlerow',
                pagermode: 'default',
                theme: theme,
                //Add row method
	
                columns: [
                	{ text: 'FLEET', datafield: 'fleet_no', width: '5%', pinned: true},
					{ text: 'FLEET NAME', datafield: 'flname', width: '12%', pinned: true},
					{ text: 'Reg NO', datafield: 'reg_no', width: '5%', pinned: true},
					{ text: 'Model', datafield: 'model', width: '10%', pinned: true},
					{ text: ''+b1, datafield: 'date1', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					{ text: ''+b2, datafield: 'date2', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname1 , filterable: false},
					{ text: ''+b3, datafield: 'date3', width: '2.5%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname2, filterable: false},
					{ text: ''+b4, datafield: 'date4', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname3, filterable: false},
					{ text: ''+b5, datafield: 'date5', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname4 , filterable: false},
					{ text: ''+b6, datafield: 'date6', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname5 , filterable: false},
					{ text: ''+b7, datafield: 'date7', width: '2.5%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname6, filterable: false},
					{ text: ''+b8, datafield: 'date8', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname7, filterable: false },
					{ text: ''+b9, datafield: 'date9', width: '2.5%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname8, filterable: false},
					{ text: ''+b10, datafield: 'date10', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname9 , filterable: false},
					{ text: ''+b11, datafield: 'date11', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname10, filterable: false},
					{ text: ''+b12, datafield: 'date12', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname11 , filterable: false},
					{ text: ''+b13, datafield: 'date13', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname12, filterable: false},
					{ text: ''+b14, datafield: 'date14', width: '2.5%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname13, filterable: false},
					{ text: ''+b15, datafield: 'date15', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname14, filterable: false},
					
					{ text: ''+b16, datafield: 'date16', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname15, filterable: false},
					{ text: ''+b17, datafield: 'date17', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname16 , filterable: false},
					{ text: ''+b18, datafield: 'date18', width: '2.5%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname17, filterable: false},
					{ text: ''+b19, datafield: 'date19', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname18, filterable: false},
					{ text: ''+b20, datafield: 'date20', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname19, filterable: false },
					{ text: ''+b21, datafield: 'date21', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname20, filterable: false },
					{ text: ''+b22, datafield: 'date22', width: '2.5%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname21, filterable: false},
					{ text: ''+b23, datafield: 'date23', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname22, filterable: false },
					{ text: ''+b24, datafield: 'date24', width: '2.5%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname23, filterable: false},
					{ text: ''+b25, datafield: 'date25', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname24, filterable: false },
					{ text: ''+b26, datafield: 'date26', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname25, filterable: false},
					{ text: ''+b27, datafield: 'date27', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname26 , filterable: false},
					{ text: ''+b28, datafield: 'date28', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname27, filterable: false},
					{ text: ''+b29, datafield: 'date29', width: '2.5%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname28, filterable: false},
					{ text: ''+b30, datafield: 'date30', width: '2.5%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname29, filterable: false},
					
				
					{ text: 'days', datafield: 'days', width: '5%', cellsalign: 'center', align:'center',hidden:true},
					
					{ text: 'Brand', datafield: 'brand_name', width: '27%' ,hidden:true},
						{ text: 'Brid', datafield: 'brdid', width: '10%' ,hidden:true},
						{ text: 'modid', datafield: 'vmodid', width: '10%' ,hidden:true},
						{ text: 'Color', datafield: 'color', width: '15%',hidden:true },
						{ text: 'clrid', datafield: 'clrid', width: '10%',hidden:true  },
						{ text: 'grpid', datafield: 'vgrpid', width: '5%' ,hidden:true},
						{ text: 'Group', datafield: 'gname', width: '10%',hidden:true },
						{ text: 'a_loc', datafield: 'a_loc', width: '10%',hidden:true },
					   { text: 'frmdate', datafield: 'frmdate', width: '10%',hidden:true },
						{ text: 'todate', datafield: 'todate', width: '10%',hidden:true },
						{ text: 'rstatus', datafield: 'rstatus', width: '10%',hidden:true },
	
				
					]
            });
            
    /*         $("#jqxfleetsearch").jqxGrid('addrow', null,  {}); */ 
            
            $('#jqxfleetsearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              	
              	 document.getElementById("fleetno").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
              	  document.getElementById("bookbrand").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "brand_name");
              	 document.getElementById("bookbrand").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "brand_name");
                 document.getElementById("bookbrandid").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "brdid");
                 
                 document.getElementById("bookmodel").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "model");
                 document.getElementById("bookmodelid").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "vmodid");
                 
                 document.getElementById("bookcolor").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "color");
                 document.getElementById("bookcolorid").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "clrid");
                 
                 
                 document.getElementById("bookgroup").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "gname");
                 document.getElementById("bookgroupid").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "vgrpid");
                document.getElementById("vehloc").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "a_loc");
                $("#tariffDivId").load('bookingrentalgrid.jsp');
                 
                $('#fleetwindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="jqxfleetsearch"></div>
    