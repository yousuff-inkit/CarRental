<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
    :root {
        --primary-teal: #20B2AA;
        --border-color: #d3d3d3;
        --bg-light: #f4f7f6;
        --card-bg: #ffffff;
        --text-main: #333;
    }

    body {
        background-color: var(--bg-light);
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Main Layout Container */
    .layout-container {
        display: flex;
        flex-direction: column;
        gap: 20px;
        padding: 15px;
    }

    /* TOP ACTION BAR: Strictly One Horizontal Line, NO Scrollbars */
    .top-bar {
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap; /* Forces a single line */
        align-items: center;
        justify-content: flex-start;
        background: var(--card-bg);
        padding: 10px 20px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        border-top: 3px solid var(--primary-teal);
        gap: 20px;
        overflow: hidden; /* Kills the scrollbar */
        white-space: nowrap;
    }

    /* ULTIMATE FLATTENER FOR heading.jsp
       Aggressively strips block layouts, fieldsets, and tables 
       inside the imported file and kills internal scrollbars.
    */
    .heading-container {
        display: flex !important;
        flex-direction: row !important;
        align-items: center !important;
        gap: 15px !important;
        overflow: hidden !important;
    }

    .heading-container fieldset,
    .heading-container legend,
    .heading-container div,
    .heading-container table,
    .heading-container tbody,
    .heading-container thead,
    .heading-container tr,
    .heading-container td,
    .heading-container form {
        display: flex !important;
        flex-direction: row !important;
        align-items: center !important;
        flex-wrap: nowrap !important;
        width: auto !important;
        border: none !important;
        padding: 0 !important;
        margin: 0 !important;
        background: transparent !important;
        box-shadow: none !important;
        gap: 10px !important;
        overflow: hidden !important; /* Forces injected elements to not scroll */
    }

    /* Hide any line breaks or horizontal rules from the imported file */
    .heading-container br,
    .heading-container hr {
        display: none !important;
    }

    /* Style the heading text itself to sit nicely inline */
    .heading-container h1, 
    .heading-container h2, 
    .heading-container h3 {
        margin: 0 !important;
        font-size: 16px !important;
        color: var(--primary-teal);
        white-space: nowrap !important;
    }

    /* From/To Date Filters in Horizontal Line */
    .horizontal-filters {
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: 15px;
    }

    .filter-group {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 13px;
        font-weight: 600;
        color: #555;
    }

    /* Action Logos / Buttons */
    .action-logos {
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: 15px;
        margin-left: auto; /* Pushes the logos to the far right */
    }

    .logo-btn {
        display: flex;
        flex-direction: row; /* Horizontal text and icon */
        align-items: center;
        justify-content: center;
        background: transparent;
        border: 1px solid var(--primary-teal);
        border-radius: 6px;
        padding: 6px 15px;
        cursor: pointer;
        color: var(--primary-teal);
        font-weight: bold;
        transition: all 0.2s ease-in-out;
        gap: 8px;
        white-space: nowrap;
    }

    .logo-btn span.icon {
        font-size: 18px;
    }

    .logo-btn:hover {
        background: var(--primary-teal);
        color: white;
        box-shadow: 0 4px 10px rgba(32,178,170,0.3);
    }

    /* GRIDS CONTAINER: Forced Vertical Stacking */
    .grids-container {
        display: flex;
        flex-direction: column; /* This stacks Grid 1 and Grid 2 one after another */
        gap: 20px;
        width: 100%;
    }

    .grid-card {
        background: var(--card-bg);
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 15px;
        overflow: hidden;
        width: 100%;
        box-sizing: border-box;
    }

    /* Modal Form Styling */
    .popup-window-content {
        padding: 10px 15px;
        display: flex;
        flex-direction: column;
        gap: 15px;
        overflow-y: auto;
        height: calc(100% - 10px);
    }

    .input-row {
        display: flex;
        flex-direction: column;
    }

    .input-row label {
        font-size: 12px;
        color: #555;
        font-weight: 600;
        margin-bottom: 5px;
    }

    .input-row input[type="text"], 
    .input-row select {
        width: 100%;
        padding: 6px 0;
        border: none;
        border-bottom: 1px solid var(--border-color);
        background: transparent;
        font-size: 13px;
        outline: none;
        transition: border-color 0.3s ease;
        box-sizing: border-box;
    }

    .input-row input[type="text"]:focus, 
    .input-row select:focus {
        border-bottom: 2px solid var(--primary-teal);
    }

    .myButton {
        background-color: var(--primary-teal);
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
        font-weight: bold;
        font-size: 13px;
        transition: background-color 0.2s;
        margin-top: 10px;
    }

    .myButton:hover {
        background-color: #1a9690;
    }

    .checkbox-group {
        display: flex;
        gap: 15px;
        align-items: center;
        font-size: 13px;
        font-weight: 600;
        color: #555;
    }
</style>

<script type="text/javascript">
$(document).ready(function () {
    // Initialize Primary Modals
    $('#updateActionWindow').jqxWindow({ width: '380px', height: '360px', resizable: false, isModal: true, autoOpen: false, title: 'Update Follow-up Information' });
    $('#rentalActionWindow').jqxWindow({ width: '480px', height: '620px', resizable: false, isModal: true, autoOpen: false, title: 'Create Rental Agreement' });

    // Initialize DateTime Inputs
	 $("#jqxDateOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     $("#jqxTimeOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false });
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

    // Initialize Search Popups
	 $('#vehinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#vehinfowindow').jqxWindow('close');
	 $('#Rentalagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#Rentalagentinfowindow').jqxWindow('close');
	 $('#Checkoutinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Checkout Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#Checkoutinfowindow').jqxWindow('close');
	 $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
	 $('#chauffeurinfowindow').jqxWindow('close');
     $('#driverinfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#driverinfowindow').jqxWindow('close'); 	 	
	
	 $("#fromdate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $("#date").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 
	 $('#todate').on('change', function (event) {
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		   var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		   if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		       return false;
		  }   
	 });
	 
	 $('#ratariff_checkout').dblclick(function(){
	     $('#Checkoutinfowindow').jqxWindow('open');
	     $('#Checkoutinfowindow').jqxWindow('focus');
	     checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow')); 
     });

	 $('#rarenral_Agent').dblclick(function(){
	     $('#Rentalagentinfowindow').jqxWindow('open');
	     $('#Rentalagentinfowindow').jqxWindow('focus');
	     rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow')); 
     });
	 $('#txtfleetno').dblclick(function(){
	     $('#vehinfowindow').jqxWindow('open');
         $('#vehinfowindow').jqxWindow('focus');
         vehinfoSearchContent('vehinfo.jsp?groupid='+$('#grpid').val()+'&branchids='+$('#branchids').val()); 
     });
	 $('#radriverlist').dblclick(function(){
		 $('#chauffeurinfowindow').jqxWindow('open');
	     chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow')); 
	 });
	 $('#clientdrv').dblclick(function(){
		 $('#driverinfowindow').jqxWindow('open');
		 driverinfoSearchContent('clientDriverSearch.jsp?clientval='+$('#clientid').val()); 
	 });
});

function getcldrv(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#driverinfowindow').jqxWindow('open');
	  driverinfoSearchContent('clientDriverSearch.jsp?clientval='+$('#clientid').val());  }
}

function driverinfoSearchContent(url) {
     $.get(url).done(function (data) {
     	 $('#driverinfowindow').jqxWindow('open');
     	 $('#driverinfowindow').jqxWindow('setContent', data);
     }); 
} 

function getcheckout(event){
    var x= event.keyCode;
    if(x==114){
    	$('#Checkoutinfowindow').jqxWindow('open');
        checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow'));   
    }
}

function checkoutSearchContent(url) {
    $.get(url).done(function (data) {
        $('#Checkoutinfowindow').jqxWindow('setContent', data);
    }); 
}
	       
function getrentalAgent(event){
    var x= event.keyCode;
    if(x==114){
        $('#Rentalagentinfowindow').jqxWindow('open');
        rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow'));  
    }
}

function rentalagentSearchContent(url) {
    $.get(url).done(function (data) {
        $('#Rentalagentinfowindow').jqxWindow('setContent', data);
    }); 
}
      
function getvehinfo(event){
    var x= event.keyCode;
    if(x==114){
        $('#vehinfowindow').jqxWindow('open');
        vehinfoSearchContent('vehinfo.jsp?groupid='+$('#grpid').val()+'&branchids='+$('#branchids').val());   
    }
}
        
function vehinfoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#vehinfowindow').jqxWindow('setContent', data);
    }); 
}
	        
function getchauffeur(event){
    var x= event.keyCode;
    if(x==114){
        $('#chauffeurinfowindow').jqxWindow('open');
        chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow'));  	 
    }
}

function chauffeurSearchContent(url) {
    $.get(url).done(function (data) {
        $('#chauffeurinfowindow').jqxWindow('setContent', data);
    }); 
}       

function funreload(event) {
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		 
	if(fromdates>todates){
		$.messager.alert('Message','To Date Less Than From Date  ','warning');   
	    return false;
	} else {
	    var barchval = document.getElementById("cmbbranch").value;
        var fromdate= $("#fromdate").val();
	    var todate= $("#todate").val();
	    $("#overlay, #PleaseWait").show();
		$("#duedetailsgrid").jqxGrid('clear');
	    $("#bookfollowdiv").load("bookingfollowGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
    }
}
	
function getinfo() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">' + process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
}

function funupdate() {
	if(document.getElementById("cmbinfo").value=="") {
		 $.messager.alert('Message','Select Process ','warning');   
		 return 0;
	}
	if($('#remarks').val()=="") {
		 $.messager.alert('Message','Enter Remarks ','warning');   
		 return 0;
	}
	
	var remarkss = document.getElementById("remarks").value;
	var nmax = remarkss.length;
    if(nmax>99) {
   	    $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
		return false; 
   	} 
      
    var rdocno = document.getElementById("rdocno").value;
 	var branchids = document.getElementById("branchids").value;
 	var remarks = document.getElementById("remarks").value;
 	var cmbinfo = document.getElementById("cmbinfo").value;
 	var clname=document.getElementById("clname").value;
 	var reftype=document.getElementById("reftype").value;
 	var folldate =  $('#date').val();

    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r==false) {
	     	return false; 
	    } else {
	     	savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,reftype);	
            $('#updateActionWindow').jqxWindow('close');
	    }
    });
}

function savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,reftype) {
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200) {
			var items=x.responseText;
			 document.getElementById("rdocno").value="";
			 document.getElementById("branchids").value="";
			 document.getElementById("remarks").value="";
			 document.getElementById("cmbinfo").value="";
			 document.getElementById("clname").value="";
			 document.getElementById("reftype").value=""; 
			 $('#date').val(new Date());
			 $.messager.alert('Message', '  Record Successfully Updated ', function(r){});
			 funreload(event); 
			 $("#duedetailsgrid").jqxGrid('clear');
			 disitems();
		}
	}
    x.open("GET","booksavedata.jsp?rdocno="+rdocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate+"&clname="+clname+"&reftype="+reftype,true);
    x.send();
}

function disitems() {
	 $('#date').jqxDateTimeInput({ disabled: true});
	 $('#jqxDateOut').jqxDateTimeInput({ disabled: true});
	 $('#jqxTimeOut').jqxDateTimeInput({ disabled: true});
	 $("#delcharge").prop("disabled", true);
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	 $('#txtfleetno').attr("disabled",true);
	 $('#delivery_chk').attr("disabled",true);
	 $('#radrivercheck').attr("disabled",true);
	 $('#radriverlist').attr("disabled",true);
	 $('#clientdrv').attr("disabled",true);
	 $('#rarenral_Agent').attr("disabled",true);
	 $('#ratariff_checkout').attr("disabled",true);
	 $('#rentalcreate').attr("disabled",true);
}

function funchangeinfo() {
	 $('#date').jqxDateTimeInput( 'focus');
}
	
function funExportBtn(){
	$("#bookfollowdiv").excelexportjs({
		containerid: "bookfollowdiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "qutfollowgrid", 
		columns: getColumns("qutfollowgrid") ,   
		worksheetName:"Booking Follow Up"
	});
}

function fundriverdisable(){
   if (document.getElementById('delivery_chk').checked) {
	   document.getElementById("radriverlist").value="";
	   $("#radriverlist").prop("disabled", false);
	   document.getElementById("radrivercheck").checked = false;
	   $("#radrivercheck").prop("disabled", true);
	   document.getElementById("del_chaufferid").value="";
       document.getElementById("delivery").value=1; 
       $("#delcharge").prop("disabled", false);
   } else {   
	   $("#radriverlist").prop("disabled", true);
	   $("#delcharge").prop("disabled", true);
	   $("#radrivercheck").prop("disabled", false);
	   document.getElementById('radriverlist').value="";
	   document.getElementById("del_chaufferid").value="";
	   document.getElementById("delcharge").value="";
       document.getElementById("delivery").value=0;
   } 
}

function funShaffurdisable(){
    if (document.getElementById('radrivercheck').checked) {
    	document.getElementById("radriverlist").value="";
        $("#radriverlist").prop("disabled", false);
        document.getElementById("delivery_chk").checked = false;
        $("#delivery_chk").prop("disabled", true);
        document.getElementById("clientdrvid").value="";
        document.getElementById("clientdrv").value="";
        document.getElementById("del_chaufferid").value="";
        $("#clientdrv").prop("disabled", true);
        $("#delcharge").prop("disabled", true);
        document.getElementById("chuef").value=1;
        document.getElementById("delcharge").value="";
    } else {
        $("#radriverlist").prop("disabled", true);
        $("#delivery_chk").prop("disabled", false);
        document.getElementById('radriverlist').value="";
        document.getElementById('delcharge').value="";
        $("#delcharge").prop("disabled", true);
        document.getElementById("del_chaufferid").value="";
        $("#delivery_chk").prop("clientdrv", false);
        document.getElementById("clientdrvid").value="";
        document.getElementById("clientdrv").value="";
        document.getElementById("del_chaufferid").value="";
        $("#clientdrv").prop("disabled", false);
        document.getElementById("chuef").value=0; 
    }
}

function chkavailable(valfleet,dateout,timeout) {
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200) {
		var items=x.responseText;
	    var chkfleet=items.trim();
   
        if(chkfleet==1) {
            $.messager.alert('Message','Fleet Is Not Available ','warning');   
            return 0;
        } else {
            var fleetnos = document.getElementById("txtfleetno").value;
            var rdocno = document.getElementById("rdocno").value;
            var deldrvss = document.getElementById("del_chaufferid").value;
            var clientdrs = document.getElementById("clientdrvid").value;
            var rantalagt = document.getElementById("tariffrenral_Agentid").value;
            var chkout = document.getElementById("ratariff_checkoutid").value;
            var delivery = document.getElementById("delivery").value;
            var chuef = document.getElementById("chuef").value;
            var delcharge = document.getElementById("delcharge").value;
            var mrano=document.getElementById("mrano").value;
            var branchids = document.getElementById("branchids").value;
            
            if(delcharge==""|| typeof(delcharge)=="undefined" ||typeof(delcharge)=="NaN") {
                delcharge=0; 
            }
            
            $.messager.confirm('Message', 'Do you want to Create A Rental Agreement?', function(r){
                if(r==false) {
                    return false; 
                } else {
                    creategriddata(rdocno,deldrvss,clientdrs,rantalagt,chkout,delivery,chuef,fleetnos,branchids,dateout,timeout,delcharge,mrano);	
                }
            });
        }
    }
}
x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout,true);
x.send();
}

function funrentalcreate() {
	var fleetnos = document.getElementById("txtfleetno").value;
	var rdocno = document.getElementById("rdocno").value;
    var deldrvss = document.getElementById("del_chaufferid").value;
 	var clientdrs = document.getElementById("clientdrvid").value;
 	var rantalagt = document.getElementById("tariffrenral_Agentid").value;
 	var chkout = document.getElementById("ratariff_checkoutid").value;
 	var delivery = document.getElementById("delivery").value;
 	var chuef = document.getElementById("chuef").value;
 	var mrano=document.getElementById("mrano").value;
	var branchids=document.getElementById("branchids").value;
 	 
 	if($('#txtfleetno').val()=="") {
		 $.messager.alert('Message','Select Fleet','warning');   
		 return 0;
	}
 	 
    if ((document.getElementById('delivery_chk').checked)) {
        var delchrg=document.getElementById("delcharge").value;
        if(delchrg=="") {
            $.messager.alert('Message','Enter Delivery Charge ','warning');   
            return 0;
        }
    }
    
    if ((document.getElementById('delivery_chk').checked)||(document.getElementById('radrivercheck').checked)) {
        var drvname=document.getElementById("radriverlist").value;
        if(drvname=="") {
            $.messager.alert('Message','Select Driver ','warning');   
            return 0;
        }
    }
 	 
 	if(rantalagt=="") {
		 $.messager.alert('Message','Select Rental Agent ','warning');   
		 return 0;
	}
	
	if(chkout=="") {
		 $.messager.alert('Message','Select Checkout','warning');   
		 return 0;
	}
 	 
    var valfleetno=document.getElementById("txtfleetno").value;
    var dateout=$('#jqxDateOut').val();
    var timeout=$('#jqxTimeOut').val();
    var maindate = $('#jqxDateOut').jqxDateTimeInput('getDate');
    var currentDate = new Date(new Date());
     
    if(maindate>currentDate){
        $.messager.alert('Message','Future Date, Transaction Restricted.','warning');   
        return 0;
    } 
    chkavailable(valfleetno,dateout,timeout);
}

function creategriddata(rdocno,deldrvss,clientdrs,rantalagt,chkout,delivery,chuef,fleetnos,branchids,dateout,timeout,delcharge,mrano) {
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200) {
        var items=x.responseText.trim();
        if(items=='NO') {
            $.messager.alert('Message', 'Not Create ', function(r){});
        } else {
            document.getElementById("rdocno").value="";
            document.getElementById("txtfleetno").value="";
            document.getElementById("del_chaufferid").value="";
            document.getElementById("clientdrvid").value="";
            document.getElementById("tariffrenral_Agentid").value="";
            document.getElementById("ratariff_checkoutid").value="";
            document.getElementById("delivery").value="";
            document.getElementById("chuef").value="";
            document.getElementById("radriverlist").value="";
            document.getElementById("delcharge").value="";
            document.getElementById("mrano").value="";
            document.getElementById("clientdrv").value="";
            document.getElementById("rarenral_Agent").value="";
            document.getElementById("ratariff_checkout").value="";
            document.getElementById("delivery_chk").checked=false; 
            document.getElementById("radrivercheck").checked=false; 
            $('#jqxDateOut').val(new Date());
            $('#jqxTimeOut').val(new Date());

            $.messager.alert('Message', ' Successfully Created '+'RA NO Is '+items);
            $('#rentalActionWindow').jqxWindow('close');
            funreload(event); 
            disitems();
        }
    }
}
x.open("GET","rentalagmtsavedata.jsp?docno="+rdocno+"&deldrvss="+deldrvss+"&clientdrs="+clientdrs+"&rantalagt="+rantalagt+"&chkout="+chkout+"&delivery="+delivery+"&chuef="+chuef+'&fleetnos='+fleetnos+'&branchids='+branchids+'&dateout='+dateout+'&timeout='+timeout+'&delcharge='+delcharge+"&mrano="+mrano,true);
x.send();
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
  	    $.messager.alert('Message', 'Enter Numbers Only');
        return false;
    }
    return true;
}
</script>
</head>
<body onload="getBranch();getinfo();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="layout-container hidden-scrollbar">
        
        <div class="top-bar">
            
            <div class="heading-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="horizontal-filters">
                <div class="filter-group">
                    <label>From:</label>
                    <div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                </div>
                <div class="filter-group">
                    <label>To:</label>
                    <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                </div>
            </div>

            <div class="action-logos">
                <button class="logo-btn" onclick="$('#updateActionWindow').jqxWindow('open');" title="Update Follow-up Process">
                    <span class="icon">&#x1F4DD;</span> Update Info
                </button>
                
                <button class="logo-btn" onclick="$('#rentalActionWindow').jqxWindow('open');" title="Create a new Rental Agreement">
                    <span class="icon">&#x1F697;</span> Create RA
                </button>
            </div>
        </div>

        <div class="grids-container">
            <div class="grid-card" id="bookfollowdiv"><jsp:include page="bookingfollowGrid.jsp"></jsp:include></div>
            <div class="grid-card" id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div>
        </div>

    </div>

    <div id="updateActionWindow" style="display:none;">
        <div>Update Follow-up Information</div>
        <div class="popup-window-content">
            <div class="input-row">
                <label>Process</label>
                <select id="cmbinfo" name="cmbinfo" onchange="funchangeinfo()"></select>
            </div>

            <div class="input-row">
                <label>Date</label>
                <div id='date' name='date' value='<s:property value="date"/>'></div>
            </div>

            <div class="input-row">
                <label>Remarks</label>
                <input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'>
            </div>

            <input type="button" name="driverUpdate" id="driverUpdate" class="myButton" value="Update" onclick="funupdate()">
        </div>
    </div>

    <div id="rentalActionWindow" style="display:none;">
        <div>Rental Agreement Create</div>
        <div class="popup-window-content">
            <div class="input-row">
                <label>Fleet</label>
                <input type="text" id="txtfleetno" name="txtfleetno" readonly placeholder="Press F3 To Search" value='<s:property value="txtfleetno"/>' onKeyDown="getvehinfo(event);" onfocus="this.placeholder = ''" />
            </div>

            <div class="checkbox-group">
                <label><input type="checkbox" id="delivery_chk" name="delivery_chk" value="0" onchange="fundriverdisable()" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Delivery</label>
                <label><input type="checkbox" id="radrivercheck" name="radrivercheck" value="0" onchange="funShaffurdisable()" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Chauffeur</label>
            </div>

            <div class="input-row">
                <label>Del Charge</label>
                <input type="text" id="delcharge" name="delcharge" value='<s:property value="delcharge"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber(event);"/>
            </div>

            <div class="input-row">
                <label>Driver</label>
                <input type="text" readonly id="radriverlist" name="radriverlist" placeholder="Press F3 To Search" value='<s:property value="radriverlist"/>' onKeyDown="getchauffeur(event);" />
                <input type="hidden" id="del_chaufferid" name="del_chaufferid" value='<s:property value="del_chaufferid"/>'/>
            </div>

            <div class="input-row">
                <label>Client Driver</label>
                <input type="text" id="clientdrv" readonly name="clientdrv" placeholder="Press F3 To Search" value='<s:property value="clientdrv"/>' onKeyDown="getcldrv(event);" />
                <input type="hidden" id="clientdrvid" name="clientdrvid" value='<s:property value="clientdrvid"/>'/>
            </div>

            <div class="input-row">
                <label>Rental Agent</label>
                <input type="text" id="rarenral_Agent" name="rarenral_Agent" readonly placeholder="Press F3 To Search" value='<s:property value="rarenral_Agent"/>' onKeyDown="getrentalAgent(event);" onfocus="this.placeholder = ''"/>
                <input type="hidden" id="tariffrenral_Agentid" name="tariffrenral_Agentid" value='<s:property value="tariffrenral_Agentid"/>'/>
            </div>

            <div class="input-row">
                <label>Checkout</label>
                <input type="text" id="ratariff_checkout" placeholder="Press F3 To Search" readonly name="ratariff_checkout" value='<s:property value="ratariff_checkout"/>' onKeyDown="getcheckout(event);" onfocus="this.placeholder = ''"/>
                <input type="hidden" id="ratariff_checkoutid" name="ratariff_checkoutid" value='<s:property value="ratariff_checkoutid"/>'/>
            </div>

            <div class="input-row">
                <label>DateOut</label>
                <div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
            </div>

            <div class="input-row">
                <label>TimeOut</label>
                <div id='jqxTimeOut' name='jqxTimeOut' value='<s:property value="jqxTimeOut"/>'></div>
            </div>

            <div class="input-row">
                <label>MRA No</label>
                <input type="text" id="mrano" name="mrano" value='<s:property value="mrano"/>'/>
            </div>

            <input type="button" name="rentalcreate" id="rentalcreate" class="myButton" value="Create" onclick="funrentalcreate()">
        </div>
    </div>

    <input type="hidden" name="branchids" id="branchids" value='<s:property value="branchids"/>' >
    <input type="hidden" name="rdocno" id="rdocno" value='<s:property value="rdocno"/>' >
    <input type="hidden" name="clname" id="clname" value='<s:property value="clname"/>' >
    <input type="hidden" name="reftype" id="reftype" value='<s:property value="reftype"/>' >
    <input type="hidden" name="clientid" id="clientid" value='<s:property value="clientid"/>' >
    <input type="hidden" name="delivery" id="delivery" value='<s:property value="delivery"/>' >
    <input type="hidden" name="chuef" id="chuef" value='<s:property value="chuef"/>' >
    <input type="hidden" name="grpid" id="grpid" value='<s:property value="grpid"/>' >

    <div id="vehinfowindow"><div></div></div> 
    <div id="Rentalagentinfowindow"><div></div></div>
    <div id="Checkoutinfowindow"><div></div></div>
    <div id="chauffeurinfowindow"><div></div></div>
    <div id="driverinfowindow"><div></div></div>
</div>
</body>
</html>