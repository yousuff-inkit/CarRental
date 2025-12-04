<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>



<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/newUiCss.css">



<style>
/* =========================================
   GLOBAL FONT + COLOR SYSTEM
========================================= */
* {
    font-family: 'Segoe UI', sans-serif;
    font-weight: 600;
    color: #1A3E7A;
    box-sizing: border-box;
}

/* =========================================
   PAGE WRAPPER
========================================= */
body {
    background: #f5f8ff;
    margin: 0;
    padding: 0;
}

#mainBG {
    background: #ffffff;
    width: 94%;
    margin: 20px auto;
    padding: 25px;
    border-radius: 6px;
    box-shadow: 0px 6px 22px rgba(0,0,0,0.07);
}

/* Remove background behind content */
.homeContent {
    background: transparent !important;
}

/* =========================================
   SECTION BLOCKS
========================================= */
.table-section {
    border: 1px solid #cdd8e9;
    background: #ffffff;
    padding: 20px;
    margin-bottom: 28px;
    border-radius: 6px;
    box-shadow: 0px 3px 10px rgba(130,160,220,0.10);
}

.table-section h3 {
    background: #eaf1ff;
    padding: 10px 12px;
    border-left: 4px solid #2f6dde;
    margin-bottom: 20px;
    font-size: 15px;
}

/* =========================================
   FORM GRID SYSTEM (MAIN STRUCTURE)
========================================= */
.form-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 18px 28px;
    width: 100%;
}

.field {
    display: flex;
    flex-direction: column;
    gap: 6px;
}

.field.full-width {
    grid-column: span 3;
}

/* Labels */
.field label {
    font-size: 14px;
    color: #1A3E7A;
}

/* Input Fields */
.field input,
.field select,
.field textarea,
.field div[id^="jqx"] {
    width: 100%;
    height: 38px;
    border: 1px solid #aebed5;
    padding: 6px 10px;
    border-radius: 4px;
    background: white;
    font-size: 14px;
}

/* Textarea Fix */
.field textarea {
    height: 70px;
    resize: none;
}

/* Focus Glow */
.field input:focus,
.field select:focus,
.field textarea:focus,
.field div[id^="jqx"]:focus {
    border-color: #2f6dde;
    outline: none;
    box-shadow: 0 0 6px rgba(47,109,222,0.25);
}

/* =========================================
   BUTTON + ICON STYLING
========================================= */
button,
.myButton,
.iconss,
.icons,
input[type="button"] {
    background: #2f6dde;
    border: none;
    padding: 7px 16px;
    border-radius: 4px;
    font-size: 14px;
    color: white !important;
    cursor: pointer;
    transition: 0.2s;
}

button:hover,
.myButton:hover,
.icons:hover {
    background: #114dc8;
}

button img, .icons img, .iconss img {
    width: 20px;
    height: 20px;
}

/* Icon button alignment */
.field.icon-group {
    flex-direction: row;
    align-items: center;
    gap: 14px;
}

/* =========================================
   APPLY SAME STYLE TO jqx GRIDS
========================================= */
.jqx-grid-header,
.jqx-grid-column-header {
    background: #eaf1ff !important;
    font-weight: 700 !important;
    color: #1A3E7A !important;
    border:none !important;
}

.jqx-grid-cell {
    font-size: 14px !important;
    color: #1A3E7A !important;
}

.jqx-grid-cell-hover {
    background: rgba(47,109,222,0.15) !important;
}

.jqx-grid-cell-selected {
    background: #2f6dde !important;
    color: white !important;
}

/* =========================================
   TOTALS SECTION MATCHING STYLE
========================================= */
.total-section {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 22px;
}

.total-section .field input {
    text-align: right;
}

/* =========================================
   SCROLL AREA STYLING
========================================= */
.hidden-scrollbar {
    overflow-y: auto;
    max-height: 80vh;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 6px;
}

.hidden-scrollbar::-webkit-scrollbar-thumb {
    background: #7ea5ff;
    border-radius: 5px;
}

/* =========================================
   POPUPS (UNCHANGED - ONLY VISUAL TWEAKS)
========================================= */
.jqx-window,
.jqx-window-content {
    border-radius: 6px !important;
    border: 1px solid #cdd8e9 !important;
    box-shadow: 0px 6px 20px rgba(90,115,255,0.25) !important;
}

/* Header style */
.jqx-window-header {
    background: #2f6dde !important;
    color: white !important;
    font-weight: 700 !important;
}

</style>




<script type="text/javascript">   
 
   $(document).ready(function () { 
		
	   /* Date */ 	
       $("#jqxBookingDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    
       $("#todate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
         var nexttodate=$('#todate').jqxDateTimeInput('getDate');
	    var onemonthafterdate=new Date(nexttodate.setMonth(nexttodate.getMonth()+1));
	 
	  $('#todate').jqxDateTimeInput('setDate', onemonthafterdate);
	
	  $("#jqxVehicleFromDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       $("#jqxVehicleToDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
     

       /* Time */
       $("#jqxVehicleFromTime").jqxDateTimeInput({ width: '30%', height: '15px', formatString: 'HH:mm', showCalendarButton: false });
       $("#jqxVehicleToTime").jqxDateTimeInput({ width: '25%', height: '15px', formatString: 'HH:mm', showCalendarButton: false });
       
       $('#bookqutSearch').jqxWindow({ width: '55%', height: '61%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Quotation Search' , position: { x: 540, y: 60 }, keyboardCloseKey: 27});
       $('#bookqutSearch').jqxWindow('close');
       $('#bookqutslnosearch').jqxWindow({ width: '50%', height: '48%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Slno Search' ,position: { x: 170, y: 100 }, keyboardCloseKey: 27});
       $('#bookqutslnosearch').jqxWindow('close');
       
       $('#bookclientsearch').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
       $('#bookclientsearch').jqxWindow('close');
       
       $('#brandsearchwndows').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 100 }, keyboardCloseKey: 27});
       $('#brandsearchwndows').jqxWindow('close'); 
       $('#modelsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 500, y: 100 }, keyboardCloseKey: 27});
       $('#modelsearchwndows').jqxWindow('close');
       $('#colorsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 720, y: 100 }, keyboardCloseKey: 27});
       $('#colorsearchwndows').jqxWindow('close');
       $('#groupsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 900, y: 100 }, keyboardCloseKey: 27});
       $('#groupsearchwndows').jqxWindow('close');
       $('#rentalsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Rental Type Search' ,position: { x: 1080, y: 100 }, keyboardCloseKey: 27});
       $('#rentalsearchwndows').jqxWindow('close');
       $('#Salesagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Sales Agent Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#Salesagentinfowindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '80%', height: '78%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Fleet Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   
	     $('#tariffinbtnwindow').jqxWindow({ width: '50%', height: '47%',  maxHeight: '95%' ,maxWidth: '50%' , title: 'Tariff Search' ,position: { x: 150, y: 150 }, keyboardCloseKey: 27});
	     $('#tariffinbtnwindow').jqxWindow('close'); 
	   
		 $('#usersearchwindow').jqxWindow({ width: '55%', height: '53%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'User Search' ,position: { x: 160, y: 150 }, keyboardCloseKey: 27});
		 $('#usersearchwindow').jqxWindow('close');
		 
	    
		 $("#btnEdit").attr('disabled', true ); 
		 
		 
		 
		 $('#jqxBookingDate').on('change', function (event) {
			  
		        var maindate = $('#jqxBookingDate').jqxDateTimeInput('getDate');
		      	 if ($("#mode").val() == "A") {   
		        funDateInPeriod(maindate);
		      	 }
		       });
		 
		  $('#jqxVehicleFromDate').on('change', function (event) {
			  if ($("#mode").val() == "A") {  

				  
			        var checkdate =document.getElementById("renttype").value;
					
					  var curdateout=new Date($('#jqxVehicleFromDate').jqxDateTimeInput('getDate')); 
					  
			             if(checkdate=="Daily")
			              {
			          			          
	                 var plusoneday=new Date(new Date(curdateout).setDate(curdateout.getDate()+1));
			                  $('#jqxVehicleToDate').jqxDateTimeInput('setDate', new Date(plusoneday));
							
			              }
			             else  if(checkdate=="Weekly")
		              {
			            	 var oneweek=new Date(new Date(curdateout).setDate(curdateout.getDate()+7));
			                  $('#jqxVehicleToDate').jqxDateTimeInput('setDate', new Date(oneweek));
		            	
		              }
			             else  if(checkdate=="Fortnightly")
		              {
			            	 var twoweek=new Date(new Date(curdateout).setDate(curdateout.getDate()+14));
			                  $('#jqxVehicleToDate').jqxDateTimeInput('setDate', new Date(twoweek));
		            	
		              }
			             else if(checkdate=="Monthly")
		              {
			            	    var onemounth=new Date(new Date(curdateout).setMonth(curdateout.getMonth()+1)); 
					    
					                 $('#jqxVehicleToDate').jqxDateTimeInput('setDate', new Date(onemounth));
		            	
		              }
			             else
			            	 {
			            	 
			            	 }
					  
				  
				  
			   var indate1=new Date($('#jqxVehicleFromDate').jqxDateTimeInput('getDate'));     // from date
				 var today = new Date();
		            today.setHours(0, 0, 0, 0);
			  
			   if(indate1<today){
			   document.getElementById("errormsg").innerText="From Date Cannot be Less than Current Date";
			   return false;
			  }   
			
			   else{
			  
			   document.getElementById("errormsg").innerText="";  
			   }
			  }
		
		       });
		 
		  
		  $('#jqxVehicleToDate').on('change', function (event) {
			  if ($("#mode").val() == "A") {   
				  
				
			   var indate1=new Date($('#jqxVehicleFromDate').jqxDateTimeInput('getDate'));     // from date
			  var agmtdate1=new Date($('#jqxVehicleToDate').jqxDateTimeInput('getDate')); //to date
			  
			   if(indate1>agmtdate1){
			   document.getElementById("errormsg").innerText="To Date Cannot be Less than From Date";
			   return false;
			  }   
			
			   else{
			  
			   document.getElementById("errormsg").innerText="";  
			   }
			  }
			  
			  
			  
		
		       });
		 
		
		  $('#jqxVehicleToTime').on('change', function (event) {
			   
			  if ($("#mode").val() == "A") {    
				  
			
				  
			   var indate1=new Date($('#jqxVehicleFromDate').jqxDateTimeInput('getDate'));     // from date
			  var agmtdate1=new Date($('#jqxVehicleToDate').jqxDateTimeInput('getDate'));  //to date
			 
			  var intime1=new Date($('#jqxVehicleFromTime').jqxDateTimeInput('getDate'));  //from time
			  var agmttime1=new Date($('#jqxVehicleToTime').jqxDateTimeInput('getDate')); // to time  
		
			  
			   if(indate1>agmtdate1){
			   document.getElementById("errormsg").innerText="To Date Cannot be Less than Out Date";
			   return false;
			  }   
			
			   if(indate1.valueOf()==agmtdate1.valueOf()){
			 
			  var out=intime1.getHours();
			  var del=agmttime1.getHours();
			
			  if(out > del){
				   
			    document.getElementById("errormsg").innerText="To Time Cannot be Less than From Time";
			    return false;
			   }
			   if(out==del){
			    if(intime1.getMinutes()>agmttime1.getMinutes()){
			     document.getElementById("errormsg").innerText="To Time Cannot be Less than From Time";
			     return false;
			    }
			   }
			  }
			  
			   document.getElementById("errormsg").innerText="";  
			  
			  }
		
		       });
		  
		 
		 
	
   /*     $('#fleetno').dblclick(function(){
    	  	 if ($("#mode").val() == "A") { 
	  	    $('#fleetwindow').jqxWindow('open');
	   
	  	  fleetsearchcontent('subvehinfo.jsp?', $('#fleetwindow')); 
    	  	 }
     }); 
        */
        
        $('#fleetno').dblclick(function(){
   	  	 if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
	  	    $('#fleetwindow').jqxWindow('open');
	   
	  	 /*  fleetsearchcontent('subvehinfo.jsp?', $('#fleetwindow'));  */
	  	 
	  	    var fromdate = $('#jqxBookingDate').val();  
	        var todate = $('#todate').val();      
	        var url = 'subvehinfo.jsp?fromdate=' + encodeURIComponent(fromdate) + '&todate=' + encodeURIComponent(todate);

	        fleetsearchcontent(url, $('#fleetwindow'));

   	  	 }   
    }); 
       
       $('#bookrefno').dblclick(function(){
    	   
    
	  	    $('#bookqutSearch').jqxWindow('open');
	   
	  	  bookqutSearchContent('quotbookmasterSearch.jsp?', $('#bookqutSearch')); 
    	   
    	  
    }); 
      
       $('#bookclientno').dblclick(function(){
    	  	 if ($("#mode").val() == "A") { 
	  	    $('#bookclientsearch').jqxWindow('open');
	   
	  	  bookclientSearchContent('bookclientINgridsearch.jsp?', $('#bookclientsearch')); 
    	  	 }
      });
        $('#bookbrand').dblclick(function(){
        	  if ($("#mode").val() == "A" && $('#fleetno').val()=="") {   
       		   if(document.getElementById("cmbreftype").value!="QOT")
       			   {
	  	    $('#brandsearchwndows').jqxWindow('open');
	   
	  	  bookbrandContent('brandbookSearch.jsp?', $('#brandsearchwndows')); 
       			   }
        	  }
     });
      
       
       $('#bookcolor').dblclick(function(){
    	   if ($("#mode").val() == "A" && $('#fleetno').val()=="") {   
    		   if(document.getElementById("cmbreftype").value!="QOT")
    			   {
	  	    $('#colorsearchwndows').jqxWindow('open');
	   
	  	  bookcolorContent('colorbooksearch.jsp?', $('#colorsearchwndows')); 
    			   }
    	   }
   });
       $('#bookgroup').dblclick(function(){
    	   if ($("#mode").val() == "A" && $('#fleetno').val()=="") {   
    		   if(document.getElementById("cmbreftype").value!="QOT")
    			   {
	  	    $('#groupsearchwndows').jqxWindow('open'); //bookbrandid bookmodelid
	   
	  	  bookgroupContent('groupbooksearch.jsp?brand='+document.getElementById("bookbrandid").value+'&model='+document.getElementById("bookmodelid").value); 
    			   }
    	   }
  });
        
       $('#renttype').dblclick(function(){
	  	    $('#rentalsearchwndows').jqxWindow('open');
	   
	  	  bookrentalContent('rentalbooksearch.jsp?', $('#rentalsearchwndows')); 
 });
       
       
       $('#booksalesAgent').dblclick(function(){
    	  	 if ($("#mode").val() == "A") { 
	  	    $('#Salesagentinfowindow').jqxWindow('open');
	   
	  	  salseagentsearch('salesbookmasterSearch.jsp?', $('#Salesagentinfowindow')); 
    	  	 }
    }); 
       
      
       
       $('#ratariffbutton').click(function(){
    		if(parseInt(document.getElementById("bookslno").value)>0)
    		{
    			 document.getElementById("errormsg").innerText="Need Not Be Searched";
    			  return false;
    		}
    		
    		else
    			{

		     	  if(($('#bookclientno').val()!=""))
		     		  {
		     	  	 if ($("#mode").val() == "A") { 
		     		  
					  	    $('#tariffinbtnwindow').jqxWindow('open');
					       $('#tariffinbtnwindow').jqxWindow('focus');     
					      
					       tariffbtnSearchContent('gettariffbtn.jsp?vehgpid='+document.getElementById("bookgroupid").value+"&cldocno="+document.getElementById("bookclientno").value);
		     	  	 }
		     		  }
		     	  else
		     		  {
		     		
		     		  if($('#bookclientno').val()=="")
		 			  {
		 		  document.getElementById("errormsg").innerText="  Select Client";
		     	  document.getElementById("bookclientno").focus(); 
		     	  return false;
		 		    }
		     		   /* if(c)
		 			  { */ 
		 		 /*  document.getElementById("errormsg").innerText="  Select Fleet";
		     	  document.getElementById("fleetno").focus(); 
		     	  return false; */
		 		    } 
	               /* } */
    			}
    		
    		
     	  
           });
       
       
       $('#searchuser').click(function(){
    	   if(parseInt(document.getElementById("bookslno").value)>0)
   		{
   			 document.getElementById("errormsg").innerText="Need Not Be Searched";
   			  return false;
   		}
    	   else
    		   
    		   {
    		   
				    		   
				    	   if(($('#ratariffdocno1').val()!=""))
				    		  {
				    		  	 if ($("#mode").val() == "A") { 
						  	    $('#usersearchwindow').jqxWindow('open');
						       $('#usersearchwindow').jqxWindow('focus');     
						   
				    		 
				    		  
						  searchuserContent('searchotheruser.jsp?vehgpid='+document.getElementById("bookgroupid").value+"&tarifdoc="+document.getElementById("tarifdoc").value); 
				    		  	 }
				    		  }
				    	   else
				    		   {
				    		   document.getElementById("errormsg").innerText="  Search Tariff";
				    		   return false;
				    		   }
    		   }
          });
    
    
       $('#clientreview').click(function(){
	  	   var url=document.URL;
	  		var reurl=url.split("com/");
	  		  window.parent.formName.value="Client Review";
	  		  window.parent.formCode.value="CRW";

	   top.addTab("Client Review",reurl[0]+"com/operations/clientrelations/clientreview/clientReview.jsp");

       }); 
	   $('#enqbutton').click(function(){
	  	   var url=document.URL;
	  		var reurl=url.split("com/");
	  		  window.parent.formName.value="Enquiry";
	  		  window.parent.formCode.value="ENQ";

	   top.addTab("Enquiry",reurl[0]+"com/operations/marketing/enquiry/enquiry.jsp");

	   }); 
       
});
   
   
   
   function fleetsearchcontent(url) {
       //alert(url);
          $.get(url).done(function (data) {
//alert(data);
        $('#fleetwindow').jqxWindow('setContent', data);

	}); 
    	}
   
  /*  function getfleet(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  	  $('#fleetwindow').jqxWindow('open');
	  
	  	fleetsearchcontent('subvehinfo.jsp?', $('#fleetwindow'));   }
	  	 else{
	  		 }
	  	 }  */
   
	  	 
	  	 function getfleet(event){
		  	 var x= event.keyCode;
		  	 if(x==114){
		  	  $('#fleetwindow').jqxWindow('open');
		  	    var fromdate = $('#jqxBookingDate').val();  
		        var todate = $('#todate').val();      
		        var url = 'subvehinfo.jsp?fromdate=' + encodeURIComponent(fromdate) + '&todate=' + encodeURIComponent(todate);

		        fleetsearchcontent(url, $('#fleetwindow'));
		        }
		  	 else{
		  		 }
		  	 } 
   
   function getsalagentdetails(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  	  $('#Salesagentinfowindow').jqxWindow('open');
	  
	  	salseagentsearch('salesbookmasterSearch.jsp?', $('#Salesagentinfowindow'));    }
	  	 else{
	  		 }
	  	 }  
		  function salseagentsearch(url) {
	        //alert(url);
	           $.get(url).done(function (data) {
	 //alert(data);
	         $('#Salesagentinfowindow').jqxWindow('setContent', data);

		}); 
	     	}
   
   function getrentaltypedetails(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  	  $('#rentalsearchwndows').jqxWindow('open');
	  
	  	bookrentalContent('rentalbooksearch.jsp?', $('#rentalsearchwndows'));   }
	  	 else{
	  		 }
	  	 }  
		  function bookrentalContent(url) {
	        //alert(url);
	           $.get(url).done(function (data) {
	 //alert(data);
	         $('#rentalsearchwndows').jqxWindow('setContent', data);

		}); 
	     	}
		  
		  
	        function tariffbtnSearchContent(url) {
                   //alert(url);
                    $.get(url).done(function (data) {
	                    //alert(data);
                  $('#tariffinbtnwindow').jqxWindow('setContent', data);

           	}); 
           	}

                 function searchuserContent(url) {
                   //alert(url);
                    $.get(url).done(function (data) {
	                    //alert(data);
                  $('#usersearchwindow').jqxWindow('setContent', data);

           	}); 
           	}

   function getgroupdetails(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  		if ($("#mode").val() == "A" && $('#fleetno').val()=="") {   
	    		   if(document.getElementById("cmbreftype").value!="QOT")
	    			   {
	  	  $('#groupsearchwndows').jqxWindow('open');
	  
	  	  bookgroupContent('groupbooksearch.jsp?brand='+document.getElementById("bookbrandid").value+'&model='+document.getElementById("bookmodelid").value);  }}  }
	  	 else{
	  		 }
	  	 }  
		  function bookgroupContent(url) {
	        //alert(url);
	           $.get(url).done(function (data) {
	 //alert(data);
	         $('#groupsearchwndows').jqxWindow('setContent', data);

		}); 
	     	}
   function getcolordetails(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  		if ($("#mode").val() == "A" && $('#fleetno').val()=="") {   
	    		   if(document.getElementById("cmbreftype").value!="QOT")
	    			   {
	  	  $('#colorsearchwndows').jqxWindow('open');
	  
	  	bookcolorContent('colorbooksearch.jsp?', $('#colorsearchwndows'));  
	    			   }
	  		}
	  		}
	  	 else{
	  		 }
	  	 }  
		  function bookcolorContent(url) {
	        //alert(url);
	           $.get(url).done(function (data) {
	 //alert(data);
	         $('#colorsearchwndows').jqxWindow('setContent', data);

		}); 
	     	}
		  
   function getbranddetails(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  		if ($("#mode").val() == "A" && $('#fleetno').val()=="") {   
	    		   if(document.getElementById("cmbreftype").value!="QOT")
	    			   {
	  	  $('#brandsearchwndows').jqxWindow('open');
	  
	  	bookbrandContent('brandbookSearch.jsp?', $('#brandsearchwndows'));  
	    			   }
	  		}
	  		}
	  	 else{
	  		 }
	  	 }  
		  function bookbrandContent(url) {
	        //alert(url);
	           $.get(url).done(function (data) {
	 //alert(data);
	         $('#brandsearchwndows').jqxWindow('setContent', data);

		}); 
	     	} 
   
   function getclientdetails(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  	  $('#bookclientsearch').jqxWindow('open');
	  
	  	bookclientSearchContent('bookclientINgridsearch.jsp?', $('#bookclientsearch'));    }
	  	 else{
	  		 }
	  	 }  
		  function bookclientSearchContent(url) {
	        //alert(url);
	           $.get(url).done(function (data) {
	 //alert(data);
	         $('#bookclientsearch').jqxWindow('setContent', data);

		}); 
	     	}
    		  
   function getqutrefno(event){
  	 var x= event.keyCode;
  	 if(x==114){
  	
  	  $('#bookqutSearch').jqxWindow('open');
  
  	  bookqutSearchContent('quotbookmasterSearch.jsp?', $('#bookqutSearch'));
  	  
 			   }
  	 else{
  		 }
  	 }  
   
	  function bookqutSearchContent(url) {
        //alert(url);
           $.get(url).done(function (data) {
 //alert(data);
         $('#bookqutSearch').jqxWindow('setContent', data);

	}); 
     	} 
	  
   function funReset(){
		//$('#frmBooking')[0].reset(); 
	}
   
	function funReadOnly(){
		$('#frmBooking input').attr('readonly', true );
		$('#frmBooking textarea').attr('readonly', true );
		$('#clientdetails').attr('readonly', true );
		$('#frmBooking select').attr('disabled', true);
		$('#jqxBookingDate').jqxDateTimeInput({ disabled: true}); 
		
		$('#jqxVehicleFromDate').jqxDateTimeInput({ disabled: true});
		$('#jqxVehicleToDate').jqxDateTimeInput({ disabled: true});
		
		$('#jqxVehicleFromTime').jqxDateTimeInput({ disabled: true});
		$('#jqxVehicleToTime').jqxDateTimeInput({ disabled: true});
		$('#bookrefno').attr('disabled', true);
		$('#bookslno').attr('disabled', true);
		
	      $("#jqxgridtarif").jqxGrid({ disabled: true});
	      $("#bookgridpayment").jqxGrid({ disabled: true});
	      
		    $('#delivery_chk').attr('disabled', true);
		    $('#chauffeur_chk').attr('disabled', true);
		    
		    $('#advance_chk').attr('disabled', true);
		    
		    
		  
		    
		
	}
	
	function funRemoveReadOnly(){
		$('#frmBooking input').attr('readonly', true );
		$('#frmBooking textarea').attr('readonly', false );
		$('#frmBooking select').attr('disabled', false);
		$('#clientdetails').attr('readonly', true );
		$('#jqxBookingDate').jqxDateTimeInput({ disabled: false});
	      $("#jqxgridtarif").jqxGrid({ disabled: false});
	      $("#bookgridpayment").jqxGrid({ disabled: false});
		
		$('#jqxVehicleFromDate').jqxDateTimeInput({ disabled: false});
		$('#jqxVehicleToDate').jqxDateTimeInput({ disabled: false});
		$('#jqxVehicleFromTime').jqxDateTimeInput({ disabled: false});
		$('#jqxVehicleToTime').jqxDateTimeInput({ disabled: false});

		$('#docno').attr('readonly', true);
		$('#bookrefno').attr('disabled', true);
		$('#bookslno').attr('disabled', true);
		$('#bookcontactno').attr('readonly', true);
		$('#guestremark').attr('readonly', false);
		$('#bookattention').attr('readonly', false);
		$('#bookemail').attr('readonly', true);
		$('#dellocation').attr('readonly', false);
		$('#bookremark').attr('readonly', false);
		$('#insuexcess').attr('readonly', false);
		$('#delcharge').attr('disabled', true);
		$('#delcharge').attr('readonly', false);
		
		 $('#delivery_chk').attr('disabled', false);
		    $('#chauffeur_chk').attr('disabled', false);
		    
		    $('#advance_chk').attr('disabled', false);
		
		if ($("#mode").val() == "A") {
			
			
/* 			 document.getElementById("docno").value="";
				document.getElementById("bookgroupid").value=="";
		
	   	   document.getElementById('delivery_chkval').value=0;
	 	   document.getElementById("chauffeur_chkval").value=0 ; 
	 	    */
	
	 		document.getElementById("rentalnumber").innerText="";    
	 		document.getElementById("rentalnumberval").innerText="";  
	 	    
	 		document.getElementById("setusername").innerText='<%=session.getAttribute("USERNAME")%>';
	 		$('#jqxBookingDate').val(new Date());
			$('#jqxVehicleFromDate').val(new Date());
			$('#jqxVehicleToDate').val(new Date());
			
			$('#jqxVehicleFromTime').val(new Date());
			$('#jqxVehicleToTime').val(new Date());
	 	       // $("#booktarifGrid").jqxGrid('clear');
	 	    //  $("#booktarifGrid").jqxGrid('addrow', null, {});
	 	     // $("#booktarifGrid").jqxGrid('addrow', null, {});
	 	  // $("#booktarifGrid").jqxGrid('addrow', null, {});
	 	 
	  		 $("#bookpaymentId").load('bookpaymentdetailsgrid.jsp?');
	  	      $("#tariffDivId").load('bookingrentalgrid.jsp');
		      $("#jqxgridtarif").jqxGrid({ disabled: false});
		      $("#bookgridpayment").jqxGrid({ disabled: false});
		      
		      
		      
		      
		     }
	 	   
	 	   
		/* if ($("#mode").val() == "E") {
			if( document.getElementById("cmbreftype").value=="QOT")
			{
			$('#bookrefno').attr('disabled', false);
			$('#bookslno').attr('disabled', false);
			}
		else{
			$('#bookrefno').attr('disabled', true);
			$('#bookslno').attr('disabled', true);
		     }
		      $("#booktarifGrid").jqxGrid({ disabled: false});
		      $("#bookgridpayment").jqxGrid({ disabled: false});
		      
		     }*/
		     
		     
		     
		if ($("#mode").val() == "D") {	  
			
			
			$('#bookrefno').attr('disabled', false);
			$('#cmbreftype').attr('disabled', false);
			
		
		}
		
		     
		} 

	
	function funNotify(){	
		
		
		
	if ($("#mode").val() == "A") {

		 var maindate = $('#jqxBookingDate').jqxDateTimeInput('getDate');
	     
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
	  
		
		
	   	  var cldocval= document.getElementById('bookclientno').value;
	   	  if(cldocval=="")
	   		  {
	   		  
	   		document.getElementById("errormsg").innerText=" Select Client";
	   		document.getElementById('bookclientno').focus();
			return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		}
	}
	
	 if( document.getElementById("cmbreftype").value=="QOT")
		{
      var refno= document.getElementById('bookrefno').value;
		 
		 if(refno=="")
		 {
			 document.getElementById("errormsg").innerText=" Select Ref NO";	
			 document.getElementById('bookrefno').focus();
			 return 0;
		 }
		 
		 else
			 {
			 document.getElementById("errormsg").innerText="";
			 }
		 
		
		 var srnoval= document.getElementById('bookslno').value;
		 
		 if(srnoval=="")
		 {
			 document.getElementById("errormsg").innerText=" Select SL NO";	
			 document.getElementById('bookslno').focus();
			 return 0;
		 }
		 
		 else
			 {
			 document.getElementById("errormsg").innerText="";
			 }
		 
		}
	 
	 else
		 {
		 document.getElementById("errormsg").innerText="";
		 }
	 
/* 	 var fleetno= document.getElementById('fleetno').value;
	 
	 if(fleetno=="")
	 {
		 document.getElementById("errormsg").innerText=" Select Fleet";	
		 document.getElementById('fleetno').focus();
		 return 0;
	 }
	 
	 else
		 {
		 document.getElementById("errormsg").innerText="";
		 }
	  */
	 
	   var indate1=new Date($('#jqxVehicleFromDate').jqxDateTimeInput('getDate'));     // from date
		 var today = new Date();
          today.setHours(0, 0, 0, 0);
	  
	   if(indate1<today){
	   document.getElementById("errormsg").innerText="From Date Cannot be Less than Current Date";
	   return false;
	  }   
	
	   else{
	  
	   document.getElementById("errormsg").innerText="";  
	   }
	 
	 
	 
	 if ($("#mode").val() == "A") {    
		   var indate1=new Date($('#jqxVehicleFromDate').jqxDateTimeInput('getDate'));     // out date
		  var agmtdate1=new Date($('#jqxVehicleToDate').jqxDateTimeInput('getDate'));  //del date
		 
		  var intime1=new Date($('#jqxVehicleFromTime').jqxDateTimeInput('getDate'));  //out time
		  var agmttime1=new Date($('#jqxVehicleToTime').jqxDateTimeInput('getDate')); // del time  
	
		  
		   if(indate1>agmtdate1){
		   document.getElementById("errormsg").innerText="To Date Cannot be Less than Out Date";
		   return false;
		  }   
		
		   if(indate1.valueOf()==agmtdate1.valueOf()){
		 
		  var out=intime1.getHours();
		  var del=agmttime1.getHours();
		
		  if(out > del){
			   
		    document.getElementById("errormsg").innerText="To Time Cannot be Less than From Time";
		    return false;
		   }
		   if(out==del){
		    if(intime1.getMinutes()>agmttime1.getMinutes()){
		     document.getElementById("errormsg").innerText="To Time Cannot be Less than From Time";
		     return false;
		    }
		   }
		  }
		  
		   document.getElementById("errormsg").innerText="";  
		  
		  }
	 
     
     if ((document.getElementById('delivery_chk').checked)) {
			   
       	   var delcharge=document.getElementById("delcharge").value;
				
				if(delcharge=="")
					{
					document.getElementById("errormsg").innerText="Enter Delivery Charges ";
					document.getElementById("delcharge").focus();  
					return 0;
					}
				
				else{
					 document.getElementById("errormsg").innerText="";
				}
		   }
          
/* 	  var rows = $("#booktarifGrid").jqxGrid('getrows');
	 
	    for(var i=0;i<rows.length;i++){
	  
		var rowlgt= rows.length-1; 
		 
		 if(i==rowlgt)
			 {
			
			 var rateval=rows[i].rate;
				
			
			if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN")
				{
				
				document.getElementById("errormsg").innerText="Tariff Is Not Selected";  
		    	return 0;
				}
			 }
	    }
	   
 */
	 
	 
/* 	
		var rows = $("#booktarifGrid").jqxGrid('getrows');
	    $('#tarifgridlength').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0;i<rows.length;i++){
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "test"+i)
	       .attr("name", "test"+i)
	           .attr("hidden", "true"); 
	   						    
	   newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+" :: "+rows[i].cdw+" :: "
			   +rows[i].pai+" :: "+rows[i].cdw1+" :: "+rows[i].pai1+" :: "+rows[i].gps+" :: "+rows[i].babyseater+" :: "+rows[i].cooler+" :: "+rows[i].kmrest+" :: "
			   +rows[i].exkmrte+" :: "+rows[i].oinschg+" :: "+rows[i].exhrchg+" :: ");
		//alert(newTextBox.val());
	   newTextBox.appendTo('form'); 
		
	   }
	   
	    */
	 var rows = $("#jqxgridtarif").jqxGrid('getrows');
	    $('#tarifgridlength').val(rows.length);
	   //alert($('#gridlength').val());
	   
	    for(var i=0;i<rows.length;i++){
	  
		var rowlgt= rows.length-1; 
		 
		 if(i==rowlgt)
			 {
			
			 var rateval=rows[i].rate;
				
			
			if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN")
				{
				
				document.getElementById("errormsg").innerText="Tariff Is Not Selected";  
		    	return 0;
				}
			 }
	    }
	   
	   for(var i=0;i<rows.length;i++){
	  
		
		
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "test"+i)
	       .attr("name", "test"+i)
	    .attr("hidden", "true");				    
	   newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+" :: "+rows[i].cdw+" :: "
			   +rows[i].pai+" :: "+rows[i].cdw1+" :: "+rows[i].pai1+" :: "+rows[i].gps+" :: "+rows[i].babyseater+" :: "+rows[i].cooler+" :: "+rows[i].kmrest+" :: "
			   +rows[i].exkmrte+" :: "+rows[i].oinschg+" :: "+rows[i].exhrchg+" :: "+rows[i].chaufchg+" :: "+rows[i].chaufexchg+" :: "+rows[i].status+" :: ");
    
	   newTextBox.appendTo('form'); 
		
	 
	   }

		
	     
    var checkinvoice =document.getElementById("rentaltype").value;
		var invoicevalue=document.getElementById("invoice").value;
		
		  
          if(checkinvoice!="Monthly")
           {
       		if(invoicevalue=="2")
       			{
       			document.getElementById("errormsg").innerText="Rental Type is "+checkinvoice+" Change Invoive Type" ;
					document.getElementById("invoice").focus(); 
					return 0;
       			}
       		else
       			{
       			document.getElementById("errormsg").innerText="";
       			}
           }
        
         	 
         	
	   var rows = $("#bookgridpayment").jqxGrid('getrows');
	   
	   var cardnum="";
	   var cardtype="";
	
	   for(var i=0 ; i < rows.length ; i++){
	    	
	 
		
	    if(rows[i].mode=="CARD"||rows[i].mode=="CASH")
		{
	    
	  
	 	    if(rows[i].amount==""||rows[i].amount=="0.00"||typeof(rows[i].amount)=="undefined"||typeof(rows[i].amount)=="NaN")
		
		{
		document.getElementById("errormsg").innerText="Enter Amount In   "+rows[i].payment;  
    	return 0;
		}
		} 
 	     
		 if(rows[i].mode=="CARD")
			 {
	
			
			 cardtype=rows[i].card;
			 cardnum=rows[i].cardno;
	
	
			 if(!(cardtype=="MASTER"||cardtype=="VISA"))
				{
		
				document.getElementById("errormsg").innerText="Select Card Type In "+rows[i].payment;  
		    	return 0;
				}
			 else {
				 
			  }
			
		
			if(cardnum==""||typeof(cardnum)=="undefined"||typeof(cardnum)=="NaN")
				{
		
				document.getElementById("errormsg").innerText="Enter Card NO In  "+rows[i].payment;  
		    	return 0;
				}
			else
				{
				
				}
			
			var str = ""+cardnum;
			var n = str.length;
	
			if(n!=16)
			{
		
			document.getElementById("errormsg").innerText="Invalid Card Number In  "+rows[i].payment;  
	    	return 0;
			}
		else
			{
			
			}
			
			 }
			
	    }
	   
	      
	   var rows = $("#bookgridpayment").jqxGrid('getrows');
	    $('#paymentgridlength').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "paytest"+i)
	       .attr("name", "paytest"+i)
	           .attr("hidden", "true"); 
	   
	   newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "
			   +rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "
			   +rows[i].invno+" :: "+rows[i].status+" :: ");
		                                                                            
	  //alert(newTextBox.val());
	   newTextBox.appendTo('form');

	    
	   }   
		
		return 1;
	} 

	function funChkButton() {
		/* funReset(); */
	}

	function funSearchLoad(){
		changeContent('bookmastersearch.jsp'); 
	}
		
	function funFocus(){
	   	$('#jqxBookingDate').jqxDateTimeInput('focus'); 	    		
	}
	function getslno(event){
  	  	 var x= event.keyCode;
  	  	 if(x==114){
  	  	  $('#bookqutslnosearch').jqxWindow('open');
  	  
  	  	bookqutslnoContent('quotbookslnoSearch.jsp?qrdocno='+document.getElementById("refqouteno").value, $('#bookqutslnosearch'));   }
  	  	 else{
  	  		 }
  	  	 } 
 	function searchslno()
	{
 		
 		 $('#bookslno').dblclick(function(){
 	  	    $('#bookqutslnosearch').jqxWindow('open');
 	   
 	  	 bookqutslnoContent('quotbookslnoSearch.jsp?qrdocno='+document.getElementById("refqouteno").value, $('#bookqutslnosearch'));
 	  	  
     });  
 	 
   		  function bookqutslnoContent(url) {
   	        //alert(url);
   	           $.get(url).done(function (data) {
   	 //alert(data);
   	         $('#bookqutslnosearch').jqxWindow('setContent', data);

   		}); 
   	     	}  
	} 
 	function getmodeldetails(event){
        var x= event.keyCode;
            if(x==114){
            	if ($("#mode").val() == "A" && $('#fleetno').val()=="") {   
         		   if(document.getElementById("cmbreftype").value!="QOT")
         			   {
        $('#modelsearchwndows').jqxWindow('open');

            bookmodelContent('modelbooksearch.jsp?bookbrandid='+document.getElementById("bookbrandid").value, $('#modelsearchwndows')); 
         			   }
            	}
            	}
         else{
	         }
                   }  
 	function bookmodelContent(url) {
	    //alert(url);
	       $.get(url).done(function (data) {
	//alert(data);
	     $('#modelsearchwndows').jqxWindow('setContent', data);
	
	            }); 
	 	} 
 	
 function searchmodel()
 {
	
			 	$('#bookmodel').dblclick(function(){
			 		if ($("#mode").val() == "A" && $('#fleetno').val()=="") {   
			    		   if(document.getElementById("cmbreftype").value!="QOT")
			    			   {
			  	    $('#modelsearchwndows').jqxWindow('open');
			   
			  	  bookmodelContent('modelbooksearch.jsp?bookbrandid='+document.getElementById("bookbrandid").value, $('#modelsearchwndows')); 
			    			   }
			 		}
			           });
			             
			  
 }
 
function advchk()
{
if(document.getElementById("advance_chk").checked)
	{
 document.getElementById("advance_chkval").value=1;

 }
else
 {
 
 document.getElementById("advance_chkval").value=0;

 }
 
}
 
 
 function fundelchk(){
 
 	   if (document.getElementById('delivery_chk').checked) {
 		    document.getElementById('delivery_chkval').value=1;	
 		    $("#chauffeur_chk").prop("disabled", true);
 		    $('#delcharge').attr('disabled', false);
 		    $('#delcharge').attr('readonly', false);
 		    document.getElementById('delcharge').value="";
 	   }
 	 
 	   	else 		  
 		   {   
 		
	 	   	$("#chauffeur_chk").prop("disabled", false);
	 	   	document.getElementById('delivery_chkval').value=0;
	 	    document.getElementById('delcharge').value="";
	 	    $('#delcharge').attr('disabled', true);
	 		$('#delcharge').attr('readonly', false);
 		   } 
             }
	

function funchafchk(){
	
	   if (document.getElementById('chauffeur_chk').checked) {
		   $("#delivery_chk").prop("disabled", true);
		   document.getElementById("chauffeur_chkval").value=1 ;   
		   document.getElementById('delcharge').value="";
		   $('#delcharge').attr('disabled', true);
		   $('#delcharge').attr('readonly', false);
		
	   }	else
		  
		   {   
		   $("#delivery_chk").prop("disabled", false);
		   document.getElementById("chauffeur_chkval").value=0 ;  
		   $('#delcharge').attr('disabled', true);
			$('#delcharge').attr('readonly', false);
		   document.getElementById('delcharge').value="";
		   
		   } 
         }
function fundisrefno()
{
	if( document.getElementById("cmbreftype").value=="QOT")
		{
		$('#bookrefno').attr('disabled', false);
		
		$('#bookslno').attr('disabled', false);
		}
	else{
		$('#bookrefno').attr('disabled', true);
		
		$('#bookslno').attr('disabled', true);
	}
			
}


function relodefun()
     {
	   if($('#invoval').val()!="")
		  {
		  
		 
		  $('#invoice').val($('#invoval').val());
		  }

if(document.getElementById("advance_chkval").value==1)
		  {
		  document.getElementById("advance_chk").checked = true;
		  document.getElementById("advance_chk").value=1;
		
		  }
	  else
		  {
		  document.getElementById("advance_chk").checked = false;
		  document.getElementById("advance_chk").value=0;
		
		  }
    
	if($('#reftypeval').val()!="")
	  {
	  
	  
	  $('#cmbreftype').val($('#reftypeval').val());
	  }
	
	
	if($('#reftypeval').val()=="QOT")
		
		
		{
					if( document.getElementById("mode").value=="A")
					{
					$('#bookrefno').attr('disabled', false);
					
					$('#bookslno').attr('disabled', false);
					}
				else{
					$('#bookrefno').attr('disabled', true);
					
					$('#bookslno').attr('disabled', true);
				   }
		
		
		}
		
	
	  if(document.getElementById("delivery_chkval").value=="1")
	  {
		 
		  
	  document.getElementById("delivery_chk").checked = true;
	  document.getElementById("delivery_chk").value = 1;
	  if ($("#mode").val() == "A") {   

	  $("#delcharge").attr("disabled", false);
	  }
	 
	  }
  
  else if(document.getElementById("chauffeur_chkval").value=="1")
	  {
	  document.getElementById("chauffeur_chk").checked = true;
	  document.getElementById("chauffeur_chk").value = 1;
	
	  }
  else
	  {

	  $("#delcharge").attr("disabled", true);
	  }
	  
	  
	
	  
     }
/*     if(document.getElementById("delivery_chkval").value==1)
	  {
	  document.getElementById("delivery_chk").checked = true;
	  document.getElementById("delivery_chk").value = 1;
	  alert("");
	   $('#delcharge').attr('disabled', false);
		$('#delcharge').attr('readonly', false);
		
		
	  }
      else
	  {
    	 
	  document.getElementById("delivery_chk").checked = false;
	  document.getElementById("delivery_chk").value = 0;
	   $('#delcharge').attr('disabled', true);
		$('#delcharge').attr('readonly', false);
	  } 
    if(document.getElementById("chauffeur_chkval").value==1)
	  {
	  document.getElementById("chauffeur_chk").checked = true;
	  document.getElementById("chauffeur_chk").value = 1;
	  $('#delcharge').attr('disabled', true);
		$('#delcharge').attr('readonly', false);
	  }
    else
	  {
	  document.getElementById("chauffeur_chk").checked = false;
	  document.getElementById("chauffeur_chk").value = 0;
	  $('#delcharge').attr('disabled', true);
		$('#delcharge').attr('readonly', false);
	  }
	
	} */
 
	
	function setValues() {
	
		// main
		if($('#hidjqxBookingDate').val()){
			$("#jqxBookingDate").jqxDateTimeInput('val', $('#hidjqxBookingDate').val());
		}
		// FROM
		if($('#hidjqxVehicleFromDate').val()){
			$("#jqxVehicleFromDate").jqxDateTimeInput('val', $('#hidjqxVehicleFromDate').val());
		}
		if($('#hidjqxVehicleFromTime').val()){
			$("#jqxVehicleFromTime").jqxDateTimeInput('val', $('#hidjqxVehicleFromTime').val());
		}
		
		// TO
		
		if($('#hidjqxVehicleToDate').val()){
			$("#jqxVehicleToDate").jqxDateTimeInput('val', $('#hidjqxVehicleToDate').val());
		}
		if($('#hidjqxVehicleToTime').val()){
			$("#jqxVehicleToTime").jqxDateTimeInput('val', $('#hidjqxVehicleToTime').val());
		}
	 	var dis=document.getElementById("masterdoc_no").value;
		if(dis>0)
			{     
			//alert("");
	 	        var indexval1 = document.getElementById("masterdoc_no").value;   
			  var revehGroup=document.getElementById("bookgroupid").value;
			  //alert("indexval1"+indexval1);
     	  		// $("#booktarifDivId").load("bookingrentalgrid.jsp?bookdocno="+indexval1+'&revehGroup='+revehGroup);
     	  
            	  
              $("#tariffDivId").load('bookingrentalgrid.jsp?txtrentaldocno='+indexval1+'&revehGroup='+revehGroup); 
     	  	
     	  		 $("#bookpaymentId").load("bookpaymentdetailsgrid.jsp?bookdocno1="+indexval1);
     			 
     			if($('#setusernametxt').val()!="")
     				{
     				document.getElementById("setusername").innerText=$('#setusernametxt').val();
     				}
     			else
     				{
     				document.getElementById("setusername").innerText='<%=session.getAttribute("USERNAME")%>';
     				}
     	  		
			 } 
		
		else
			{
				document.getElementById("setusername").innerText='<%=session.getAttribute("USERNAME")%>';
			
			}
		
	
		var ranois= document.getElementById("ranos").value;
		if(parseInt(ranois)>0)
			{
			
			document.getElementById("rentalnumber").innerText="RA NO Is :";
			document.getElementById("rentalnumberval").innerText=""+ranois;
			
			}
		
		 if($('#msg').val()!=""){
			
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 
		if($('#setusernametxt').val()!="")
			{
			document.getElementById("setusername").innerText=$('#setusernametxt').val();
			}
			
		
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		
		 if(parseInt(document.getElementById("fleetno").value)==0)
			 {
			 document.getElementById("fleetno").value="";
			 }
		 
		relodefun();
	}
	   $(function(){
	        $('#frmBooking').validate({
	                rules: { 
	              
	                
	                     
	                	bookremark:{maxlength:100},
	                	guestremark:{maxlength:100}
	             
	                 },
	                 messages: {
	                	 bookremark: {maxlength:" Max 100 chars"},
	                	 guestremark: {maxlength:" Max 100 chars"}
	               
	                
	               
	              
	                 }
	        });});
	

	   function funPrintBtn(){
	  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  	  
	  	   var url=document.URL;

	         var reurl=url.split("saveBooking");
	         
	         $("#docno").prop("disabled", false);                
	         
	   
	 var win= window.open(reurl[0]+"printBooking?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	      
	 win.focus();
	  	   } 
	  	  
	  	   else {
	 	    	      $.messager.alert('Message','Select a Document....!','warning');
	 	    	      return false;
	 	    	     }
	 	    	
	  	}
	   function isNumber(evt) {
           var iKeyCode = (evt.which) ? evt.which : evt.keyCode
           if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
           	{
        	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
              
               return false;
           	}
           document.getElementById("errormsg").innerText="";  
           return true;
       }
	   function errormsgdis()
	   {
		   document.getElementById("errormsg").innerText="";     
		   
	   }
	 
     
 	</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar">

<form id="frmBooking" action="saveBooking" autocomplete="off">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <br/>

    <!-- =====================
        BOOKING INFO
    ====================== -->
    <div class="table-section">
        <h3>Booking Info</h3>

        <div class="form-grid">

            <!-- Date -->
            <div class="field">
                <label>Date</label>
                <div id="jqxBookingDate" name="jqxBookingDate" value='<s:property value="jqxBookingDate"/>'></div>
                <input type="hidden" id="hidjqxBookingDate" name="hidjqxBookingDate" 
                       value='<s:property value="hidjqxBookingDate"/>'/>
                <input hidden id='todate' name='todate' value='<s:property value="todate"/>'>
            </div>

            <!-- Ref Type -->
            <div class="field">
                <label>Ref Type</label>
                <select id="cmbreftype" name="cmbreftype" onchange="fundisrefno();">
                    <option value="DIR">Direct</option>
                    <option value="QOT">Quotation</option>
                    <option value="ONL">Online</option>
                </select>
            </div>

            <!-- Ref No -->
            <div class="field">
                <label>Ref No</label>
                <input type="text" id="bookrefno" name="bookrefno"
                       placeholder="Press F3 to Search"
                       value='<s:property value="bookrefno"/>'
                       onkeydown="getqutrefno(event);" />
            </div>

            <!-- Client -->
            <div class="field full-width">
                <label>Client</label>
                <input type="text" id="bookclientno" name="bookclientno"
                       placeholder="Press F3 to Search"
                       value='<s:property value="bookclientno"/>'
                       onkeydown="getclientdetails(event);" />
                <input type="text" id="bookclientname" name="bookclientname"
                       value='<s:property value="bookclientname"/>' />
            </div>

            <!-- Mobile -->
            <div class="field">
                <label>MOB</label>
                <input type="text" id="bookcontactno" name="bookcontactno"
                       value='<s:property value="bookcontactno"/>' />
            </div>

            <!-- User Name -->
            <div class="field">
                <label>User</label>
                <label id="setusername" style="font-size:12px;color:#0045ff;"></label>
            </div>

            <!-- Doc No -->
            <div class="field">
                <label>Doc No</label>
                <input type="text" id="docno" name="bookingdocno"
                       value='<s:property value="bookingdocno"/>'
                       tabindex="-1" />
            </div>

            <!-- Sales Agent -->
            <div class="field">
                <label>Sales Agent</label>
                <input type="text" id="booksalesAgent" name="booksalesAgent"
                       placeholder="Press F3 to Search"
                       value='<s:property value="booksalesAgent"/>'
                       onkeydown="getsalagentdetails(event);" />
            </div>

            <!-- Attention -->
            <div class="field">
                <label>Attention</label>
                <input type="text" id="bookattention" name="bookattention"
                       value='<s:property value="bookattention"/>'>
            </div>

            <!-- Email -->
            <div class="field">
                <label>Email</label>
                <input type="email" id="bookemail" name="bookemail"
                       value='<s:property value="bookemail"/>' />
            </div>

            <!-- Guest -->
            <div class="field full-width">
                <label>Guest Details</label>
                <input type="text" id="guestremark" name="guestremark"
                       value='<s:property value="guestremark"/>' />
            </div>

            <!-- Icons -->
            <div class="field full-width" style="display:flex; gap:10px;">
                <button type="button" title="Enquiry" class="iconss" id="enqbutton">
                    <img src="<%=contextPath%>/icons/openenquiry.png">
                </button>
                <button type="button" title="Client Review" class="icons" id="clientreview">
                    <img src="<%=contextPath%>/icons/openclientreview.png">
                </button>
            </div>

            <!-- Client Details Textarea -->
            <div class="field full-width">
                <label>Client Details</label>
                <textarea id="clientdetails" name="clientdetails" readonly
                          style="height:60px; font-size:12px;">
<s:property value="clientdetails"/>
                </textarea>
            </div>

        </div>
    </div>



    <!-- =====================
        VEHICLE INFO
       (same pattern applied)
    ====================== -->
    <div class="table-section">
        <h3>Vehicle Info</h3>

        <div class="form-grid">

            <div class="field">
                <label>Sl No</label>
                <input type="text" id="bookslno" name="bookslno"
                       placeholder="Press F3 to Search"
                       value='<s:property value="bookslno"/>'
                       onkeydown="getslno(event);" />
            </div>

            <div class="field">
                <label>Fleet</label>
                <input type="text" id="fleetno" name="fleetno"
                       placeholder="Press F3 to Search"
                       value='<s:property value="fleetno"/>'
                       onkeydown="getfleet(event);" />
            </div>

            <div class="field">
                <label>Brand</label>
                <input type="text" id="bookbrand" name="bookbrand"
                       placeholder="Press F3 to Search"
                       value='<s:property value="bookbrand"/>'
                       onkeydown="getbranddetails(event);" />
            </div>

            <div class="field">
                <label>Model</label>
                <input type="text" id="bookmodel" name="bookmodel"
                       placeholder="Press F3 to Search"
                       value='<s:property value="bookmodel"/>'
                       onkeydown="getmodeldetails(event);" />
            </div>

            <div class="field">
                <label>Color</label>
                <input type="text" id="bookcolor" name="bookcolor"
                       placeholder="Press F3 to Search"
                       value='<s:property value="bookcolor"/>'
                       onkeydown="getcolordetails(event);" />
            </div>

            <div class="field">
                <label>Group</label>
                <input type="text" id="bookgroup" name="bookgroup"
                       placeholder="Press F3 to Search"
                       value='<s:property value="bookgroup"/>'
                       onkeydown="getgroupdetails(event);" />
            </div>


            <!-- Dates -->
            <div class="field">
                <label>From Date</label>
                <div id="jqxVehicleFromDate"></div>
                <input type="hidden" id="hidjqxVehicleFromDate">
            </div>

            <div class="field">
                <label>From Time</label>
                <div id="jqxVehicleFromTime"></div>
                <input type="hidden" id="hidjqxVehicleFromTime">
            </div>

            <div class="field">
                <label>To Date</label>
                <div id="jqxVehicleToDate"></div>
                <input type="hidden" id="hidjqxVehicleToDate">
            </div>

            <div class="field">
                <label>To Time</label>
                <div id="jqxVehicleToTime"></div>
                <input type="hidden" id="hidjqxVehicleToTime">
            </div>

            <div class="field">
                <label>Delivery Charge</label>
                <input type="text" id="delcharge" name="delcharge"
                       style="text-align:right;"
                       value='<s:property value="delcharge"/>' />
            </div>

            <!-- Remarks -->
            <div class="field full-width">
                <label>Remarks</label>
                <input type="text" id="bookremark" name="bookremark"
                       value='<s:property value="bookremark"/>' />
            </div>

        </div>
    </div>


<!-- =========================
     TARIFF INFO + GRID
========================= -->
<div class="table-section" style="width: 100%;">
    <h3>Tariff Info</h3>

    <!-- Keep same id="tariff" for scripts -->
    <div id="tariff">

        <div class="form-grid">

            <!-- Icon buttons row -->
            <div class="field full-width icon-group">
                <button type="button"
                        title="Search Tariff"
                        class="icon"
                        id="ratariffbutton"
                        value='<s:property value="ratariffbutton"/>'>
                    <img alt="tariffSearch" src="<%=contextPath%>/icons/tariffsearch.png">
                </button>

                <button type="button"
                        title="Search User"
                        class="icon"
                        id="searchuser"
                        value='<s:property value="searchuser"/>'>
                    <img alt="Search User" src="<%=contextPath%>/icons/searchusers.png">
                </button>
            </div>

            <!-- DOCNO -->
            <div class="field">
                <label>DOCNO</label>
                <input type="text"
                       id="tarifdoc"
                       name="tarifdoc"
                       value='<s:property value="tarifdoc"/>' />
            </div>

            <!-- Ins.Excess -->
            <div class="field">
                <label>Ins.Excess</label>
                <input type="text"
                       id="excessinsur"
                       name="excessinsur"
                       style="text-align:right;"
                       value='<s:property value="excessinsur"/>'
                       onblur="funRoundAmt(this.value,this.id);"
                       onkeypress="javascript:return isNumber(event);" />
            </div>

            <!-- Advance -->
            <div class="field">
                <label>Advance</label>
                <input type="checkbox"
                       id="advance_chk"
                       name="advance_chk"
                       value="0"
                       onclick="$(this).attr('value', this.checked ? 1 : 0);advchk()" />
            </div>

            <!-- Invoice -->
            <div class="field">
                <label>Invoice</label>
                <select name="invoice"
                        id="invoice"
                        value='<s:property value="invoice"/>'
                        onchange="errormsgdis()">
                    <option value="1">Month End</option>
                    <option value="2">Period</option>
                </select>
            </div>

            <!-- Tariff Grid -->
            <div class="field full-width">
                <label>Tariff Details</label>
                <div id="tariffDivId">
                    <jsp:include page="bookingrentalgrid.jsp"></jsp:include>
                </div>
            </div>

        </div> <!-- /.form-grid -->

    </div> <!-- /#tariff -->

    <%-- 
    <div id="booktarifDivId">
        <jsp:include page="booktarifGrid.jsp"></jsp:include>
    </div>
    --%>
</div>


<!-- =========================
     PAYMENT DETAILS + HIDDEN
========================= -->
<br>

<div class="table-section" style="width: 100%;">
    <h3>Payment Details</h3>

    <div id="bookpaymentId" class="payment-grid-wrapper">
        <jsp:include page="bookpaymentdetailsgrid.jsp"></jsp:include>
    </div>

    <!-- All hidden fields preserved exactly as in your original code -->
    <input type="hidden" id="masterdoc_no"    name="masterdoc_no"    value='<s:property value="masterdoc_no"/>'/> 
    <input type="hidden" id="refqouteno"      name="refqouteno"      value='<s:property value="refqouteno"/>'/>
    <input type="hidden" id="mode"            name="mode"            value='<s:property value="mode"/>'/>
    <input type="hidden" id="deleted"         name="deleted"         value='<s:property value="deleted"/>' />
    <input type="hidden" id="bookbrandid"     name="bookbrandid"     value='<s:property value="bookbrandid"/>'/> 
    <input type="hidden" id="bookmodelid"     name="bookmodelid"     value='<s:property value="bookmodelid"/>'/>
    <input type="hidden" id="bookcolorid"     name="bookcolorid"     value='<s:property value="bookcolorid"/>'/>
    <input type="hidden" id="bookgroupid"     name="bookgroupid"     value='<s:property value="bookgroupid"/>'/>
    <input type="hidden" id="delivery_chkval" name="delivery_chkval" value='<s:property value="delivery_chkval"/>'/>
    <input type="hidden" id="chauffeur_chkval" name="chauffeur_chkval" value='<s:property value="chauffeur_chkval"/>'/>
    <input type="hidden" id="booksalesAgentid" name="booksalesAgentid" value='<s:property value="booksalesAgentid"/>'/>
    <input type="hidden" id="msg"             name="msg"             value='<s:property value="msg"/>'/>  
    <input type="hidden" id="tarifgridlength" name="tarifgridlength" value='<s:property value="tarifgridlength"/>'/>
    <input type="hidden" id="paymentgridlength" name="paymentgridlength" value='<s:property value="paymentgridlength"/>'/>
    <input type="hidden" id="reftypeval"      name="reftypeval"      value='<s:property value="reftypeval"/>'/>
    <%-- <input type="hidden" id="tarifdoc" name="tarifdoc" value='<s:property value="tarifdoc"/>'/> --%>
    <input type="hidden" id="clientacno"      name="clientacno"      value='<s:property value="clientacno"/>'/>
    <input type="hidden" id="clientname"      name="clientname"      value='<s:property value="clientname"/>'/>
    <input type="hidden" id="rentaltype"      name="rentaltype"      value='<s:property value="rentaltype"/>'/>
    <%-- //<input type="hidden" name="insuexcess" id="insuexcess" value='<s:property value="insuexcess"/>' /> --%>
    <input type="hidden" id="normalinsu"      name="normalinsu"      value='<s:property value="normalinsu"/>'/> 
    <input type="hidden" id="cdwinsu"         name="cdwinsu"         value='<s:property value="cdwinsu"/>'/> 
    <input type="hidden" id="supercdwinsu"    name="supercdwinsu"    value='<s:property value="supercdwinsu"/>'/> 
    <input type="hidden" id="invoval"         name="invoval"         value='<s:property value="invoval"/>'/> 
    <input type="hidden" id="advance_chkval"  name="advance_chkval"  value='<s:property value="advance_chkval"/>'/>  
    <input type="hidden" id="vehloc"          name="vehloc"          value='<s:property value="vehloc"/>'/> 
    <input type="hidden" id="ranos"           name="ranos"           value='<s:property value="ranos"/>'/> 
    <input type="hidden" id="codenos"         name="codenos"         value='<s:property value="codenos"/>'/>  
    <input type="hidden" id="setusernametxt"  name="setusernametxt"  value='<s:property value="setusernametxt"/>'/>  

</div>
</body>

</html>