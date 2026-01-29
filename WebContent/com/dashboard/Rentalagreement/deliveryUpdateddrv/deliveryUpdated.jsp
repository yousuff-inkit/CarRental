
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100vh !important;
        overflow: hidden !important;
        color: black !important;
    }

    .sidebar-filters {
        width: 350px; 
        flex: 0 0 350px;
        background-color: #ffffff;
        border-right: 1px solid #e1e8ed;
        display: flex;
        flex-direction: column;
        z-index: 10;
        box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        height: 100vh !important;
    }

    .sidebar-fixed-top {
        padding: 20px 20px 15px 20px;
        background-color: #ffffff;
        border-bottom: 1px solid #f0f4f8;
        flex-shrink: 0;
    }

    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 20px 25px 20px;
    }

    /* Cleaned Cards */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 12px;
    }

    /* Reset legacy styles and force black text */
    .filter-card *, fieldset, legend, .branch, td, tr, label, span {
        background-color: transparent !important;
        background: none !important;
        color: black !important;
    }

    .filter-table { 
        width: 100%; 
        border-spacing: 0 8px; 
    }

    .label-cell {
        text-align: right;
        padding-right: 10px;
        font-size: 13px;
        font-weight: 600;
        width: 90px;
    }

    /* Input & Select Styling */
    input[type="text"], select {
        width: 100%;
        border: 1px solid #ccd6e0;
        border-radius: 6px;
        padding: 6px 10px;
        font-size: 13px;
        color: black !important;
        box-sizing: border-box;
        background-color: #ffffff !important;
    }

    /* RHS Visibility */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 350px);
        overflow: hidden !important; 
        position: relative;
        background-color: #ffffff;
    }

    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto !important;
        padding: 20px;
    }

    /* FINALIZED BUTTONS (#2563eb) */
    .myButton {
        background-color: #2563eb !important;
        color: #ffffff !important; 
        border: none !important;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        padding: 10px 15px;
        text-align: center;
        display: block;
        width: 100%;
        margin-top: 5px;
        transition: background 0.2s;
    }

    .myButton:hover { background-color: #1d4ed8 !important; }

    .branch { font-size: 13px; font-weight: 600; }
</style>


<script type="text/javascript">

$(document).ready(function () {
	$("#del_Driver").attr('disabled',false);
	  $('#ratariff_checkout').dblclick(function(){
	  	    $('#Checkoutinfowindow').jqxWindow('open');
	       $('#Checkoutinfowindow').jqxWindow('focus');
       checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow')); 
    });
	
	 $("#jqxDeliveryOut").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#jqxDelTimeOut").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 $("#jqxDateOut").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#jqxTimeOut").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
	     $('#chauffeurinfowindow').jqxWindow('close');
	     
	     $('#Checkoutinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Checkout Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		 $('#Checkoutinfowindow').jqxWindow('close');

	 $('#jqxDeliveryOut').on('change', function (event) {
		 if( $('#del_Driver').val()!="")
			{
		   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
				
			  indate1.setHours(0,0,0,0);
			  agmtdate1.setHours(0,0,0,0); 
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Delivery Date Cannot be Less than Out Date','warning');   
			  /*  $.messager.alert('Warning', ' Delivery Date Cannot be Less than Out Date ', function(r){
				     
			     }); */
		   return false;
		  }   
		
			}
		  
	
	       });
	 
	 
	  $('#jqxDelTimeOut').on('change', function (event) {
		   
		  if( $('#del_Driver').val()!="")
			{  
		   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
		  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
		 
		  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
		  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  
		  indate1.setHours(0,0,0,0);
		  agmtdate1.setHours(0,0,0,0); 
		  
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Delivery Date Cannot be Less than Out Date','warning');   
			 
		//  alert("Delivery Date Cannot be Less than Out Date");
		   return false;
		  }   
		
		   if(indate1.valueOf()==agmtdate1.valueOf()){
		 
		  var out=intime1.getHours();
		  var del=agmttime1.getHours();
		
		  if(out > del){
			  $.messager.alert('Message',' Delivery Time Cannot be Less than Out Time ','warning');   
			  
		  // alert("Delivery Time Cannot be Less than Out Time");
		    return false;
		   }
		   if(out==del){
		    if(intime1.getMinutes()>agmttime1.getMinutes()){
		    	  $.messager.alert('Message',' Delivery Time Cannot be Less than Out Time ','warning');   
		    	
		    // alert("Delivery Time Cannot be Less than Out Time");
		     return false;
		    }
		   }
		  }
		  
			}
		  
		  
	
	       });
	  
	  
      $('#del_Driver').dblclick(function(){
    	  /* if($("#chktype").val()=="VCU")
    		  { */
	  	    $('#chauffeurinfowindow').jqxWindow('open');
  chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow')); 
    		  /* } */
	 });
      
	  
    
});
function getchauffeur(event){
	 /*  if($("#chktype").val()=="VCU")
	  { */
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#chauffeurinfowindow').jqxWindow('open');
     chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow'));  	 }
    	 else{
    		 }
	 /*  } */
    	 }

function chauffeurSearchContent(url) {
     
  $.get(url).done(function (data) {
	
   $('#chauffeurinfowindow').jqxWindow('setContent', data);

	   }); 
  }


function funAttachBtn(){
	if ($("#rentaldoc").val()!="" && $("#chktype").val()=="RAG" ) {
		  $("#windowattach").jqxWindow('setTitle',"RAG - "+document.getElementById("rentaldoc").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=RAG&docno="+document.getElementById("rentaldoc").value+"&barchvals="+document.getElementById("branchids").value);		
	}
<%-- 	else if ($("#rentaldoc").val()!="" && $("#chktype").val()=="VCU" ) {
		  $("#windowattach").jqxWindow('setTitle',"VCU - "+document.getElementById("rentaldoc").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=RAG&docno="+document.getElementById("rentaldoc").value+"&barchvals="+document.getElementById("branchids").value);		
	} --%>
	
	else {
		$.messager.alert('Message','Select a Document....!','warning');
		return;
	}
}
function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}

function funreload(event)
{
	disitems();
	 var barchval = document.getElementById("cmbbranch").value;
	   $("#overlay, #PleaseWait").show();
 
	  $("#delupdiv").load("delupdateGrid.jsp?barchval="+barchval);
	
	
	}

function funupdate()
{
 
	 if(document.getElementById("ratariff_checkout").value=="")
	 {
		  $.messager.alert('Message',' Select Checkout','warning'); 
		 return 0;
	 }
	 if(document.getElementById("del_Driver").value=="")
	 {
		  $.messager.alert('Message',' Search Driver','warning'); 
		 return 0;
	 }
	
	 if(document.getElementById("del_KM").value=="")
	 {
		  $.messager.alert('Message',' Enter KM ','warning'); 
		 return 0;
	 }
	 if($('#del_Fuel').val()=="")
	 {
		 $.messager.alert('Message',' Select Fuel','warning'); 
		 return 0;
	 }
	 var outkm=document.getElementById("out_km").value;
		//alert("out"+outkm);
	 	var delkm=document.getElementById("del_KM").value;
	   if((parseFloat(delkm)<parseFloat(outkm)))
	 	{
		   $.messager.alert('Message',' Delivery KM Less Than Out KM','warning'); 
		   return 0;
	 	}
	  var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
	  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
	  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
	  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  

	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0); 
	  
	  
		var validdeldate=funDateInPeriod(agmtdate1);
		if(validdeldate==0){
			return 0; 
		}
		
		var curdate=new Date();
		curdate.setHours(0,0,0,0);
		
		if(agmtdate1-curdate==0){
        	var curtime=new Date();
        	if(agmttime1.getHours()>curtime.getHours()){
        		$.messager.alert('Warning','Future Time Restricted');
                return 0;	
        	}
        	else if(agmttime1.getHours()==curtime.getHours()){
        		if(agmttime1.getMinutes()>curtime.getMinutes()){
        			$.messager.alert('Warning','Future Time Restricted');
                    return 0;	
        		}
        	}
        }
		
	   if(indate1>agmtdate1){
		   $.messager.alert('Message',' Delivery Date Cannot be Less than Out Date ','warning');     
		 
	
	   return 0;
	  }   
	
	   if(indate1.valueOf()==agmtdate1.valueOf()){
	 
	  var out=intime1.getHours();
	  var del=agmttime1.getHours();
	
	  if(out > del){
		   $.messager.alert('Message',' Delivery Time Cannot be Less than Out Time ','warning');    
		 
	 
	    return 0;
	   }
	   if(out==del){
	    if(intime1.getMinutes()>agmttime1.getMinutes()){
	    	 $.messager.alert('Message','Delivery Time Cannot be Less than Out Time ','warning');    
	    	 
	     return 0;
	    }
	   }
	  }
	
	var rentaldoc=document.getElementById("rentaldoc").value;
	var rentaldate=document.getElementById("rentaldate").value;
	var fleetno=document.getElementById("fleetno").value;
	var del_Driverid=document.getElementById("del_Driverid").value;
	var del_KM=document.getElementById("del_KM").value;
	var del_Fuel=document.getElementById("del_Fuel").value;
	var jqxDeliveryOut= $('#jqxDeliveryOut').val();
	var jqxDelTimeOut= $('#jqxDelTimeOut').val();
	 var group=document.getElementById("group").value;
	var vlocation=document.getElementById("vehloca").value;
	
	var branchval=document.getElementById("branchids").value;
	var cldocno=document.getElementById("cldocno").value;
	var checkoutid=document.getElementById("ratariff_checkoutid").value;
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		delsave(rentaldoc,rentaldate,fleetno,del_Driverid,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno,checkoutid);
     	}
	     });
	
	
}
	function delsave(rentaldoc,rentaldate,fleetno,del_Driverid,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno,checkoutid)
         {
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
		
			 	var items= x.responseText;
			 	document.getElementById("cldocno").value="";
				document.getElementById("rentaldoc").value="";
				document.getElementById("chktype").value="";
				 $('#del_Driver').attr('placeholder', ''); 
				
				document.getElementById("rentaldate").value="";
			    document.getElementById("fleetno").value="";
				document.getElementById("del_Driverid").value="";
				document.getElementById("del_Driver").value="";
				document.getElementById("del_KM").value="";
				document.getElementById("del_Fuel").value="";
				$('#jqxDeliveryOut').val(new Date());
				$('#jqxDelTimeOut').val(new Date());
				document.getElementById("group").value="";
				document.getElementById("vehloca").value="";
				document.getElementById("out_km").value="";
				document.getElementById("out_fuel").value="";
				document.getElementById("branchids").value="";
				
				document.getElementById("ratariff_checkoutid").value="";
				
				$('#jqxDateOut').val(new Date());
				$('#jqxTimeOut').val(new Date());
				disitems();
				funreload(event);
			 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
					     
				     });
	    }
		}
	     x.open("GET","savedeldate.jsp?rentaldoc="+rentaldoc+"&rentaldate="+rentaldate+"&fleetno="+fleetno+
	    		 "&del_Driverid="+del_Driverid+"&del_KM="+del_KM+"&del_Fuel="+del_Fuel+"&jqxDeliveryOut="+jqxDeliveryOut+
	    		 "&jqxDelTimeOut="+jqxDelTimeOut+"&group="+group+"&vlocation="+vlocation+"&branchval="+branchval+
	    		 "&cldocno="+cldocno+"&chktype="+document.getElementById("chktype").value+"&checkoutid="+checkoutid,true);
	     x.send();
		
		}
	
	function disitems()
	{
		document.getElementById("rentaldoc").value="";
		document.getElementById("chktype").value="";
		 $('#del_Driver').attr('placeholder', ''); 
		
		document.getElementById("rentaldate").value="";
	    document.getElementById("fleetno").value="";
		document.getElementById("del_Driverid").value="";
		document.getElementById("del_Driver").value="";
		document.getElementById("del_KM").value="";
		document.getElementById("del_Fuel").value="";
		$('#jqxDeliveryOut').val(new Date());
		$('#jqxDelTimeOut').val(new Date());
		document.getElementById("group").value="";
		document.getElementById("vehloca").value="";
		document.getElementById("out_km").value="";
		document.getElementById("out_fuel").value="";
		document.getElementById("branchids").value="";
		document.getElementById("cldocno").value="";
		$('#jqxDateOut').val(new Date());
		$('#jqxTimeOut').val(new Date());
		
		
		 $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: true});
		 $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: true});
		 
		 
		 $('#del_KM').attr("readonly",true);
		 $('#del_Fuel').attr("disabled",true);
		 $('#driverUpdate').attr("disabled",true);
		 $('#driverUpdate').attr("disabled",true);
		
		 $('#attachbtns').attr("disabled",true);
		
	}
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
        	
        
        	 $.messager.alert('Message',' Enter Numbers Only ','warning');    
        	
        	 
            return false;
        	}
        
        return true;
    }	
	function funchkkm()
	{
		 var outkm=document.getElementById("out_km").value;
			//alert("out"+outkm);
		 	var delkm=document.getElementById("del_KM").value;
		   if((parseFloat(delkm)<parseFloat(outkm)))
			   
		 	
		 	{
			   
			   $.messager.alert('Message',' Delivery KM Less Than Out KM','warning'); 
			
			 
			   return 0;
		 	}
	
		
	}
	function getcheckout(event){
	       	 var x= event.keyCode;
	       	 if(x==114){
	       	  $('#Checkoutinfowindow').jqxWindow('open');
	       
	        checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow'));   }
	       	 else{
	       		 }
	       	 }
		       function checkoutSearchContent(url) {
	                  
		                 $.get(url).done(function (data) {
               
			           $('#Checkoutinfowindow').jqxWindow('setContent', data);
	
	           	}); 
		           	}
	
	function funExportBtn(){
		 //  $("#delupdategrid").jqxGrid('exportdata', 'xls', 'RAG-Delivery Update');
		   
		   
		   
		   if(parseInt(window.parent.chkexportdata.value)=="1")
		    {
		    JSONToCSVCon(datasssss, 'RAG-Delivery Update', true);
		    }
		   else
		    {
		    $("#delupdategrid").jqxGrid('exportdata', 'xls', 'RAG-Delivery Update');
		    }
		   
		   
		   
		 }	
	
</script>
</head>
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Checkout</td>
                        <td>
                            <input type="text" id="ratariff_checkout" placeholder="Press F3 To Search" name="ratariff_checkout" value='<s:property value="ratariff_checkout"/>' onKeyDown="getcheckout(event);"/>
                            <input type="hidden" id="ratariff_checkoutid" name="ratariff_checkoutid" value='<s:property value="ratariff_checkoutid"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Driver</td>
                        <td>
                            <input type="text" name="del_Driver" id="del_Driver" readonly="readonly" onKeyDown="getchauffeur(event);" value='<s:property value="del_Driver"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">KM</td>
                        <td>
                            <input type="text" name="del_KM" id="del_KM" value='<s:property value="del_KM"/>' onblur="funchkkm()" onkeypress="javascript:return isNumber (event)">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fuel</td>
                        <td>
                            <select name="del_Fuel" id="del_Fuel" value='<s:property value="del_Fuel"/>'>
                                <option value="" selected>-Select-</option>
                                <option value="0.000">Level 0/8</option>
                                <option value="0.125">Level 1/8</option>
                                <option value="0.250">Level 2/8</option>
                                <option value="0.375">Level 3/8</option>
                                <option value="0.500">Level 4/8</option>
                                <option value="0.625">Level 5/8</option>
                                <option value="0.750">Level 6/8</option>
                                <option value="0.875">Level 7/8</option>
                                <option value="1.000">Level 8/8</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Date</td>
                        <td>
                            <div id='jqxDeliveryOut' name='jqxDeliveryOut' value='<s:property value="jqxDeliveryOut"/>'></div>
                            <input type="hidden" id="hidjqxDeliveryOut" name="hidjqxDeliveryOut" value='<s:property value="hidjqxDeliveryOut"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Time</td>
                        <td>
                            <div id='jqxDelTimeOut' name='jqxDelTimeOut' value='<s:property value="jqxDelTimeOut"/>'></div>
                            <input type="hidden" id="hidjqxDelTimeOut" name="hidjqxDelTimeOut" value='<s:property value="hidjqxDelTimeOut"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 0 5px;">
                <input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="Update" onclick="funupdate()">
                <input type="Button" name="attachbtns" id="attachbtns" class="myButton" value="Attach" onclick="funAttachBtn()">
            </div>

            <div style="display:none;">
                <input type="hidden" name="rentaldoc" id="rentaldoc" value='<s:property value="rentaldoc"/>' >
                <input type="hidden" name="chktype" id="chktype" value='<s:property value="chktype"/>' >
                <input type="hidden" name="rentaldate" id="rentaldate" value='<s:property value="rentaldate"/>' >
                <input type="hidden" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' >
                <input type="hidden" name="del_Driverid" id="del_Driverid" value='<s:property value="del_Driverid"/>' >
                <input type="hidden" name="out_km" id="out_km" value='<s:property value="out_km"/>' >
                <input type="hidden" name="out_fuel" id="out_fuel" value='<s:property value="out_fuel"/>' >
                <div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
                <div id='jqxTimeOut' name='jqxTimeOut' value='<s:property value="jqxTimeOut"/>'></div>
                <input type="hidden" name="branchids" id="branchids" value='<s:property value="branchids"/>' >
                <input type="hidden" name="group" id="group" value='<s:property value="group"/>' >
                <input type="hidden" name="vehloca" id="vehloca" value='<s:property value="vehloca"/>' >
                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="delupdiv">
                <jsp:include page="delupdateGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>

     
</div>
<div id="chauffeurinfowindow">
   <div ></div>
</div>
<div id="Checkoutinfowindow">
   <div ></div>
</div>
</div>
</body>
