<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
form label.error {
color:red;
  font-weight:bold;

}

.hidden-scrollbar {
    overflow: auto;
    height: 500px;
}

.text-alignment{
     text-align: left;
}


</style>

 <jsp:include page="../../../includes.jsp"></jsp:include>
 <%
 String detailmode=request.getParameter("detailmode")==null?"":request.getParameter("detailmode");
 String tempdocno=request.getParameter("tempdocno")==null?"":request.getParameter("tempdocno");
 %>
<script type="text/javascript">
var cmpltryCount=0;
var isTariffHidden=false;
var isTariffButtonHidden=false;
var isGroupBased=false;
var triptypelist=new Array();
var triptypedata={};
$(document).ready(function() {
	$("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	$("#pdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	$("#pckdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	$("#ptime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
	$("#ltime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
	$("#etime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
	
	$("#ptime").jqxDateTimeInput('setDate', new Date());
	$("#ltime").jqxDateTimeInput('setDate', new Date());
	$("#pdate").jqxDateTimeInput('setDate', new Date());
	$("#pckdate").jqxDateTimeInput('setDate', new Date());
	
	$('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Location Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#locationwindow').jqxWindow('close');
	
	// sayara
	$('#tarifdetailwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Tarif Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#tarifdetailwindow').jqxWindow('close');
	
	$('#srvctarifwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Other Service Tarif Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#srvctarifwindow').jqxWindow('close');
	$('#airportwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Airport Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#airportwindow').jqxWindow('close');
	$('#brandwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#brandwindow').jqxWindow('close');
	$('#groupwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#groupwindow').jqxWindow('close');
	$('#modelwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#modelwindow').jqxWindow('close');
	$('#guestwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '55%' ,maxWidth: '40%' , title: 'Guest Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#guestwindow').jqxWindow('close');
	$('#tarifwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '55%' ,maxWidth: '40%' , title: 'Tarif Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#tarifwindow').jqxWindow('close');
	$('#clientwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '55%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close');
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;margin-left:50%;margin-right:50%;margin-top:15%;top:200;right:600;'><img src='../../../icons/31load.gif'/></div>");    
	setNewGuest();
	$('.bookingbuttons').hide();
	$('.srvcbuttons').hide();
	
	$.get('getData.jsp',{'mode':1},function(data){
		data=JSON.parse(data);
		triptypedata=data.triptypedata;
		var optionsyearnw='<option value="">-- select --</option>'; 
		$.each(data.triptypedata,function(index,value){  
			triptypelist.push(value.triptype);
			optionsyearnw += '<option value="' + value.triptype + '">'+value.triptype+'</option>';    
		});	
		 document.querySelector('select#cmbttriptype').innerHTML = optionsyearnw;    
	});

   $.get('getlocation.jsp',function(data){
		var data=JSON.parse(data);
		var optionsyearnw="";
		$.each(data.locdata,function(index,value){
			optionsyearnw += '<option value="' + value.location + '" data-docno="'+value.docno+'"></option>';
		});	
		$("datalist#plocationid").html(optionsyearnw);
		$("datalist#Dofflocationid").html(optionsyearnw);
		$("datalist#lpcklocationid").html(optionsyearnw);
   });

    $.get('guestdetails.jsp',function(data){
		var data=JSON.parse(data);
		var optionsyearnw="";
		$.each(data.guestData,function(index,value){
			optionsyearnw += '<option value="' + value.guest + '" data-guestcontactno="'+value.guestcontactno+'" data-guestid="'+value.docno+'"></option>';
		});	
		$("datalist#tguestid").html(optionsyearnw);
		$("datalist#lguestid").html(optionsyearnw);
  }); 
    
    $('#tguest').on('input', function() {
	    var inputVal = $(this).val();
	    var selectedOption = $("#tguestid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
	    if (selectedOption.length > 0) {
	        var docno = selectedOption.data('guestid');
	    //    alert(docno+" - "+selectedOption.data('guestcontactno'))
	        $("#hidtguest").val(inputVal);
	        $("#hidtguestcontactno").val(selectedOption.data('guestcontactno'));
	        $("#hidtguestid").val(docno);
	    } 
	});
    
    $('#lguest').on('input', function() {
	    var inputVal = $(this).val();
	    var selectedOption = $("#lguestid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
	    if (selectedOption.length > 0) {
	        var docno = selectedOption.data('guestid');
	        $("#hidlguest").val(inputVal);
	        $("#hidlguestcontactno").val(selectedOption.data('guestcontactno'));
	        $("#hidlguestid").val(docno);
	    } 
	});
   
	$('#plocation').on('input', function() {
	    var inputVal = $(this).val();
	    var selectedOption = $("#plocationid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
	    if (selectedOption.length > 0) {
	        var docno = selectedOption.data('docno');
	        $("#hidplocation").val(inputVal);
	        $("#hidplocid").val(docno);
	        getTariffDocnoTransfer();
	    } 
	});  
	
	$('#Dofflocation').on('input', function() {
	    var inputVal = $(this).val();
	    var selectedOption = $("#Dofflocationid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
	    if (selectedOption.length > 0) {
	        var docno = selectedOption.data('docno');
	        $("#hiddofflocation").val(inputVal);
	        $("#hiddofflocationid").val(docno);
	        getTariffDocnoTransfer();
	    } 
	});
	
	$('#pcklocation').on('input', function() {
	    var inputVal = $(this).val();
	    var selectedOption = $("#lpcklocationid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
	    if (selectedOption.length > 0) {
	        var docno = selectedOption.data('docno');
	        $("#hidlpcklocation").val(inputVal);
	        $("#hidlpcklocationid").val(docno);
	        getTariffDocnoLimo();
	    } 
     });
	    
	$.get('getbrand.jsp',function(data){
		var data=JSON.parse(data);
		var optionsyearnw ;
		$.each(data.locdata,function(index,value){
			optionsyearnw += '<option value="' + value.brand + '" data-docno="'+value.docno+'"></option>';
		});	
		$("datalist#tbrandid").html(optionsyearnw);
		$("datalist#lbrandid").html(optionsyearnw);
	});
	
	$('#brand').on('input', function() {
	    var inputVal = $(this).val();
	    var selectedOption = $("#tbrandid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
	    if (selectedOption.length > 0) {
	        var docno = selectedOption.data('docno');
	        $("#hidtbrand").val(inputVal);
	        $("#hidtbrandid").val(docno);
	        getTariffDocnoTransfer();
	        getModel('getmodel.jsp?brand='+$("#hidtbrandid").val(), 'tmodelid');
	    } 
	});
	
	
	
	$('#lbrand').on('input', function() {
	    var inputVal = $(this).val();
	    var selectedOption = $("#lbrandid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
	    if (selectedOption.length > 0) {
	        var docno = selectedOption.data('docno');
	        $("#hidlbrand").val(inputVal);
	        $("#hidlbrandid").val(docno);
	        getTariffDocnoLimo();
	        getModel('getmodel.jsp?brand='+$("#hidlbrandid").val(), 'lmodelid');
	    } 
	});     

	$.get('getgroup.jsp',function(data){
		var data=JSON.parse(data);
		var optionsyearnw ;
		$.each(data.locdata,function(index,value){
			optionsyearnw += '<option value="' + value.group + '" data-docno="'+value.docno+'"></option>';
		});	
		$("datalist#tgroupid").html(optionsyearnw);
	});
	
	$('#tgroup').on('input', function(){
		var inputVal = $(this).val();
		var selectedOption = $("#tgroupid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
		if (selectedOption.length > 0) {
	        var docno = selectedOption.data('docno');
	        $("#hidtgroup").val(inputVal);
	        $("#hidtgroupid").val(docno);
	        getTariffDocnoLimo();
	    } 
	});
	
	$.get('getgroup.jsp',function(data){
		var data=JSON.parse(data);
		var optionsyearnw ;
		$.each(data.locdata,function(index,value){
			optionsyearnw += '<option value="' + value.group + '" data-docno="'+value.docno+'"></option>';
		});	
		$("datalist#lgroupid").html(optionsyearnw);
	});
	
	$('#lgroup').on('input', function(){
		var inputVal = $(this).val();
		var selectedOption = $("#lgroupid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
		if (selectedOption.length > 0) {
	        var docno = selectedOption.data('docno');
	        $("#hidlgroup").val(inputVal);
	        $("#hidlgroupid").val(docno);
	        getTariffDocnoLimo();
	        //getModel('getgroup.jsp', 'lgroupid');
	    } 
	});
	
/* $.get('getmodel.jsp?brand='+$("#hidtbrandid").val(),function(data){
	var data=JSON.parse(data);
	var optionsyearnw ;
	$.each(data.locdata,function(index,value){
		optionsyearnw += '<option value="' + value.model + '" data-docno="'+value.docno+'"></option>';
	});	
	$("datalist#tmodelid").html(optionsyearnw);  
}); */  

	$('#tmodel').on('input', function() {
		var inputVal = $(this).val();
	    var selectedOption = $("#tmodelid option").filter(function() {
	        return $(this).val() === inputVal;
	    });
	    if (selectedOption.length > 0) {
	        var docno = selectedOption.data('docno');
	        $("#hidtmodel").val(inputVal);
	        $("#hidtmodelid").val(docno);
	        getTariffDocnoTransfer();
	    } 
	});

/* $.get('getmodel.jsp?brand='+$("#hidlbrandid").val(),function(data){
	var data=JSON.parse(data);
	var optionsyearnw ;
	$.each(data.locdata,function(index,value){
		optionsyearnw += '<option value="' + value.model + '" data-docno="'+value.docno+'"></option>';
	});	
	$("datalist#lmodelid").html(optionsyearnw);
}); */

$('#lmodel').on('input', function() {
	var inputVal = $(this).val();
    var selectedOption = $("#lmodelid option").filter(function() {
        return $(this).val() === inputVal;
    });
    if (selectedOption.length > 0) {
        var docno = selectedOption.data('docno');
        $("#hidlmodel").val(inputVal);
        $("#hidlmodelid").val(docno);
        getTariffDocnoLimo();
    } 
});

$('#tdocno').on('input', function() {
	var inputVal = $(this).val();
    var selectedOption = $("#tdocnoid option").filter(function() {
        return $(this).val() === inputVal;
    });
    if (selectedOption.length > 0) {
    	$("#tdocno").val(selectedOption.data('doc_no'));
		$("#edistance").val(selectedOption.data('estdistance'));
		$("#etime").val(selectedOption.data('esttime'));
		$("#tariff").val(selectedOption.data('tarif'));
		$("#exdistancerate").val(selectedOption.data('exdistancerate'));
		$("#exdistancetime").val(selectedOption.data('extimerate'));
		$("#hidgid").val(selectedOption.data('gid'));
		$("#hidtariffdocno").val(selectedOption.data('tarifdetaildocno'));
    } 
});

$('#ltdocno').on('input', function() {
	var inputVal = $(this).val();
    var selectedOption = $("#ltdocnoid option").filter(function() {
        return $(this).val() === inputVal;
    });
    if (selectedOption.length > 0) {
    	$("#ltdocno").val(selectedOption.data('doc_no'));  
		$("#ltariff").val(selectedOption.data('tarif'));
		$("#hidlgid").val(selectedOption.data('gid'));
		$("#lexhourrate").val(selectedOption.data('exhrrate'));
		$("#lntariff").val(selectedOption.data('nighttarif'));
		$("#lnexhourrate").val(selectedOption.data('nightexhrrate'));
		$("#hidltariffdocno").val(selectedOption.data('tarifdetaildocno'));
    } 
});
/* $('#tdocno').on('input', function() {
	var inputVal = $(this).val();
    var selectedOption = $("#tdocnoid option").filter(function() {
        return $(this).val() === inputVal;
    });
    if (selectedOption.length > 0) {
        var docno = selectedOption.data('docno');
        $("#hidtdocno").val(inputVal);
        $("#hidtdocnoid").val(docno);
    } 
});

$('#ldocno').on('input', function() {
	var inputVal = $(this).val();
    var selectedOption = $("#ldocnoid option").filter(function() {
        return $(this).val() === inputVal;
    });
    if (selectedOption.length > 0) {
        var docno = selectedOption.data('docno');
        $("#hidldocno").val(inputVal);
        $("#hidldocnoid").val(docno);
    } 
});  */
	$( "#client" ).dblclick(function() {
		if(document.getElementById("mode").value=="view"){
			return false;
		}
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('masterClientSearch.jsp', $('#clientwindow'));
	});
	
	$( "#guest" ).dblclick(function() {
		if(document.getElementById("mode").value=="view"){
			return false;
		}
		if(document.getElementById("chknewguest").checked==false){
			
		
		$('#guestwindow').jqxWindow('open');
		$('#guestwindow').jqxWindow('focus');
		guestSearchContent('guestSearchGrid.jsp?clientid='+$('#hidclient').val(), $('#guestwindow'));
		}
	});


	/* 	
	$("#tdocno").dblclick(function() {
		var clientid = document.getElementById("hidclient").value;
		var brandid =  document.getElementById("hidtbrandid").value;
		var modelid =  document.getElementById("hidtmodelid").value;
		var pickuplocid = document.getElementById("hidplocid").value;
		var dropofflocid =  document.getElementById("hiddofflocationid").value;  
		var  transfertype=  document.getElementById("ttype").value;
		var type = "tariffline"; 
 
		if(clientid=="" || clientid=="undefined" || clientid==null || typeof(clientid)=="undefined"){
		    		document.getElementById("errormsg").innerText="Client is mandatory";
		    		return false;
		}else{
				   document.getElementById("errormsg").innerText="";
		}
		
		if(pickuplocid=="" || pickuplocid=="undefined" || pickuplocid==null || typeof(pickuplocid)=="undefined"){
		    		document.getElementById("errormsg").innerText="Pick up location is mandatory";
		    		return false;
		}else{
				   document.getElementById("errormsg").innerText="";
        }
		
	    if(dropofflocid=="" || dropofflocid=="undefined" || dropofflocid==null || typeof(dropofflocid)=="undefined"){
		    		document.getElementById("errormsg").innerText="Drop off location is mandatory";
		    		return false;
		}else{
				   document.getElementById("errormsg").innerText="";
		}
	    
		if(brandid=="" || brandid=="undefined" || brandid==null || typeof(brandid)=="undefined"){
	    		document.getElementById("errormsg").innerText="Please select a valid brand";
	    		return false;
	    }else{
			   document.getElementById("errormsg").innerText="";
		}
		
		if(modelid=="" || modelid=="undefined" || modelid==null || typeof(modelid)=="undefined"){
		    		document.getElementById("errormsg").innerText="Please select a valid model";
		    		return false;
		}else{
			   document.getElementById("errormsg").innerText="";
		}
		
		$('#tarifwindow').jqxWindow('open');
		$('#tarifwindow').jqxWindow('focus');
		tarifSearchContent('tarifSearchGrid.jsp?brandid='+brandid+'&gridname=transferGrid&type='+type+'&modelid='+modelid+'&pickuplocid='+pickuplocid+'&dropofflocid='+dropofflocid+'&client='+clientid+'&transfertype='+transfertype, $('#tarifwindow'));  
	});
	
	$("#ltdocno").dblclick(function() {
		var clientid = document.getElementById("hidclient").value
		var brandid =  document.getElementById("hidlbrandid").value;
		var modelid =  document.getElementById("hidlmodelid").value;
		var pickuplocid = document.getElementById("hidlpcklocationid").value;
		var ltptype =  document.getElementById("ltype").value;
		var blockhours = document.getElementById("bhours").value;
		var ltype = "limoline";  
		
		if(clientid=="" || clientid=="undefined" || clientid==null || typeof(clientid)=="undefined"){
		    		document.getElementById("errormsg").innerText="Client is mandatory";
		    		return false;
		}else{
				   document.getElementById("errormsg").innerText="";
		}
		
		if(blockhours=="" || blockhours=="undefined" || blockhours==null || typeof(blockhours)=="undefined"){   
		    		document.getElementById("errormsg").innerText="Block hours is mandatory";
		    		return false;
		}else{
				   document.getElementById("errormsg").innerText="";
		}
		
		if(pickuplocid=="" || pickuplocid=="undefined" || pickuplocid==null || typeof(pickuplocid)=="undefined"){
	    		document.getElementById("errormsg").innerText="Pick up location is mandatory";
	    		return false;
		}else{
				   document.getElementById("errormsg").innerText="";
		}
		
		if(brandid=="" || brandid=="undefined" || brandid==null || typeof(brandid)=="undefined"){
				document.getElementById("errormsg").innerText="Please select a valid brand";
				return false;
		}else{
			   document.getElementById("errormsg").innerText="";
		}
		
		if(modelid=="" || modelid=="undefined" || modelid==null || typeof(modelid)=="undefined"){
		    		document.getElementById("errormsg").innerText="Please select a valid model";
		    		return false;
		}else{
			   document.getElementById("errormsg").innerText="";
		}

		$('#tarifwindow').jqxWindow('open');
		$('#tarifwindow').jqxWindow('focus');
		tarifSearchContent('tarifSearchGrid.jsp?brandid='+brandid+'&gridname=hoursGrid&type='+ltype+'&modelid='+modelid+'&pickuplocid='+pickuplocid+'&client='+clientid+'&transfertype='+ltptype+'&blockhrs='+blockhours, $('#tarifwindow'));  
	}); */
});

function getModel(url, selectBoxId) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var data = JSON.parse(x.responseText);
            var options = '';

            $.each(data.locdata, function(index, value) {
                options += '<option value="' + value.model + '" data-docno="' + value.docno + '">' + value.model + '</option>';
            });

            $("datalist#" + selectBoxId).html(options);
        }
    };
    x.open("GET", url, true);
    x.send();
}

function getTariffDocnoTransfer() {   
	if(isTariffButtonHidden){
		return false;
	}
	var clientid = document.getElementById("hidclient").value;
	var brandid =  document.getElementById("hidtbrandid").value;
	var modelid =  document.getElementById("hidtmodelid").value;
	var groupid =  document.getElementById("hidtgroupid").value;
	var pickuplocid = document.getElementById("hidplocid").value;
	var dropofflocid =  document.getElementById("hiddofflocationid").value;  
	var  transfertype=  document.getElementById("ttype").value;
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var data = JSON.parse(x.responseText);
            var optionsyearnw="";
    		$.each(data.transferData,function(index,value){
    			optionsyearnw += '<option value="' + value.tarifdetail + '" data-estdistance="'+value.estdistance+'" data-esttime="'+value.esttime+'" data-tarif="'+value.tarif+'" data-exdistancerate="'+value.exdistancerate+'" data-extimerate="'+value.extimerate+'" data-gid="'+value.gid+'" data-doc_no="'+value.docno+'" data-tarifdetaildocno="'+value.tarifdetaildocno+'" data-allowance="'+value.allowance+'></option>';
    		});	
    		$("datalist#tdocnoid").html(optionsyearnw);  
        }
    };
    x.open("GET", 'gettariffdocno.jsp?groupid='+groupid+'&brandid='+brandid+'&tarifmode=transferGrid&modelid='+modelid+'&pickuplocid='+pickuplocid+'&dropofflocid='+dropofflocid+'&cldocno='+clientid+'&transfertype='+transfertype, true);
    x.send();
}

function getTariffDocnoLimo() { 
	if(isTariffButtonHidden){
		return false;
	}
	var clientid = document.getElementById("hidclient").value
	var brandid =  document.getElementById("hidlbrandid").value;
	var modelid =  document.getElementById("hidlmodelid").value;
	var pickuplocid = document.getElementById("hidlpcklocationid").value;
	var tptype =  document.getElementById("ltype").value;
	var blockhours = document.getElementById("bhours").value;
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var data = JSON.parse(x.responseText);
            var optionsyearnw="";
    		$.each(data.limoData,function(index,value){
    			optionsyearnw += '<option value="' + value.tarifdetail + '" data-exhrrate="'+value.exhrrate+'" data-nighttarif="'+value.nighttarif+'" data-doc_no="'+value.docno+'"  data-tarif="'+value.tarif+'" data-nightexhrrate="'+value.nightexhrrate+'" data-gid="'+value.gid+'" data-tarifdetaildocno="'+value.tarifdetaildocno+'" data-allowance="'+value.allowance+'></option>';
    			});	
    		$("datalist#ltdocnoid").html(optionsyearnw);  
        }
    };
    x.open("GET", 'gettariffdocno.jsp?brandid='+brandid+'&tarifmode=hoursGrid&modelid='+modelid+'&pickuplocid='+pickuplocid+'&cldocno='+clientid+'&transfertype='+tptype+'&blockhrs='+blockhours, true);
    x.send();
}

function getValues(value){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('::');
			document.getElementById("docno").value=items[1];
            document.getElementById("client").value=items[5];
            document.getElementById("hidclient").value=items[6];
            var details="Mobile: "+items[7]+" License: "+items[8];
            document.getElementById("clientdetails").value=details;
            document.getElementById("hidguest").value=items[3];
            document.getElementById("guest").value=items[9];
            document.getElementById("guestcontactno").value=items[10];
            $('#date').jqxDateTimeInput('val',items[2]);
            document.getElementById("hidchknewguest").value=items[4];
            document.getElementById("description").value=items[0];
            document.getElementById("vocno").value=items[13];
            document.getElementById("vesselname").value=items[12];
            document.getElementById("vesselno").value=items[11];
           // setValues();
		} else {
		}
	}
	x.open("GET", "getBookingData.jsp?docno="+value, true);
	x.send();
}
function setNewGuest(){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	if(document.getElementById("chknewguest").checked==true){
		document.getElementById("guest").readOnly=false;
		$("#guest").attr("placeholder", "Please type in");
		document.getElementById("guestcontactno").readOnly=false;
		document.getElementById("hidchknewguest").value="1";
	}
	else{
		document.getElementById("guest").readOnly=true;
		$("#guest").attr("placeholder", "Press F3 to search");
		document.getElementById("guestcontactno").readOnly=true;
		document.getElementById("hidchknewguest").value="0";
	}
}
function getClient(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#clientwindow').jqxWindow('open');
    	$('#clientwindow').jqxWindow('focus');
    	clientSearchContent('masterClientSearch.jsp', $('#clientwindow')); 
      }
}
function getGuest(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	if(document.getElementById("chknewguest").checked==false){
	var x= event.keyCode;
    if(x==114){
	$('#guestwindow').jqxWindow('open');
	$('#guestwindow').jqxWindow('focus');
	guestSearchContent('guestSearchGrid.jsp', $('#guestwindow'));
      }
	}
}
$(function(){
    $('#frmLimoBooking').validate({
    	rules: {
            client:"required"
        }, 
    	messages:{
    		client:" *"
    	}
    });
 }); 
 
 function locationSearchContent(url) {
      $.get(url).done(function (data) {
    $('#locationwindow').jqxWindow('setContent', data);
}); 
}
 function srvctarifSearchContent(url) {
     $.get(url).done(function (data) {
   $('#srvctarifwindow').jqxWindow('setContent', data);
}); 
}
 function airportSearchContent(url) {
     $.get(url).done(function (data) {
   $('#airportwindow').jqxWindow('setContent', data);
}); 
}
 function brandSearchContent(url) {
     $.get(url).done(function (data) {
   $('#brandwindow').jqxWindow('setContent', data);
}); 
}
 function groupSearchContent(url) {
     $.get(url).done(function (data) {
   $('#groupwindow').jqxWindow('setContent', data);
}); 
}
 function modelSearchContent(url) {
     $.get(url).done(function (data) {
   $('#modelwindow').jqxWindow('setContent', data);
}); 
}
 function clientSearchContent(url) {
     $.get(url).done(function (data) {
   $('#clientwindow').jqxWindow('setContent', data);
}); 
}
// sayara
 function tarifSearchdetailContent(url) {
     $.get(url).done(function (data) {
   $('#tarifdetailwindow').jqxWindow('setContent', data);
}); 
}
 
 function guestSearchContent(url) {
     $.get(url).done(function (data) {
   $('#guestwindow').jqxWindow('setContent', data);
}); 
}
 function tarifSearchContent(url) {
     $.get(url).done(function (data) {
   $('#tarifwindow').jqxWindow('setContent', data);
}); 
}

function funSearchLoad(){
	changeContent('mastersearch.jsp?branch='+$("#brchName").val(), $('#window'));
 }
function funReadOnly() {
	 $('#frmLimoBooking input').attr('readonly', true);
	 $('#frmLimoBooking select').attr('disabled', true);
	 $('#date').jqxDateTimeInput({ disabled: true}); 
	 var detailmode='<%=detailmode%>';
	 var tempdocno='<%=tempdocno%>';
	 if(detailmode=="1"){
		 window.parent.formName.value="Limousine Booking";
  		  window.parent.formCode.value="LBK"
	 	getValues(tempdocno);
	 }
}

function canEdit(){
	var docno = document.getElementById("docno").value;
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			 var data = JSON.parse(x.responseText);
			 if(data>=1){
			 		$("#btnBookEdit").hide();
			 		//$("#btnBookClone").hide();
			 	} else {
			 		$('#btnBookEdit').show();
			 		$('#btnBookClone').show();
					$('#btnSrvcEdit').show();
					$('#btnSrvcReload').show();
					$("#btnBookClone").show();
			 	}
		} else {
		}
	}
	x.open("GET",'chkedit.jsp?docno='+docno, true);
	x.send();
}

function funRemoveReadOnly() {  
	$('#frmLimoBooking input').attr('readonly', false);
	$('#docno').attr('readonly', true);
	$('#date').jqxDateTimeInput({ disabled: false}); 
	$('#frmLimoBooking select').attr('disabled', false);
	$('#client').attr('readonly', true);
	$('#guest').attr('readonly', true);
	$('#guestcontactno').attr('readonly', true);
	$('#clientdetails').attr('readonly', true);
    $('#cmbloctype').attr('readonly', false);
     
    $('#txtairport').attr('disabled', true);
    $('#txtflightno').attr('disabled', true);
    $('#txthotelname').attr('disabled', true);
    $('#txtroomno').attr('disabled', true);
    
   // $('#tdocno').attr('readonly', true);
    $('#edistance').attr('readonly', true);
    $('#tariff').attr('readonly', true);
    $('#exdistancerate').attr('readonly', true);
    $('#exdistancetime').attr('readonly', true);
     
   // $('#ltdocno').attr('readonly', true);
    $('#ltariff').attr('readonly', true);
    $('#lexhourrate').attr('readonly', true);
    $('#lntariff').attr('readonly', true);
    $('#lnexhourrate').attr('readonly', true);  
    
	setNewGuest();
	
	if(document.getElementById("mode").value=="A"){
		$("#btnBookEdit").hide();
		$("#btnBookClone").hide();
		 $("#btnBookCancel").hide();
		 $("#btnBookSave").hide();
		$('#date').jqxDateTimeInput('setDate',new Date());
		$("#transferGrid").jqxGrid({ disabled: false});
		$("#hoursGrid").jqxGrid({ disabled: false});
		$("#guestgrid").jqxGrid({ disabled: false});
		$("#billingGrid").jqxGrid({ disabled: false});
		$("#transferGrid").jqxGrid('clear');
		$("#guestgrid").jqxGrid('clear');
		$("#hoursGrid").jqxGrid('clear');
		$("#billingGrid").jqxGrid('clear');
		$("#otherSrvcGrid").jqxGrid('clear');
		$("#transferGrid").jqxGrid("addrow", null, {});
		$("#hoursGrid").jqxGrid("addrow", null, {});
		//$("#otherSrvcGrid").jqxGrid("addrow", null, {});
		$("#billingGrid").jqxGrid("addrow", null, {});
		var transferrows=$("#transferGrid").jqxGrid('getrows');
		var hoursrows=$("#hoursGrid").jqxGrid('getrows');
		if(transferrows.length==0){
			$("#transferGrid").jqxGrid('setcellvalue',0,'docname','T1');
			$("#transferGrid").jqxGrid('setcellvalue',0,'btnappend','Append');
		}
		else{
			$("#transferGrid").jqxGrid('setcellvalue',transferrows.length-1,'docname','T'+transferrows.length);
			$("#transferGrid").jqxGrid('setcellvalue',transferrows.length-1,'btnappend','Append');
		}
		if(hoursrows.length==0){
			$("#hoursGrid").jqxGrid('setcellvalue',0,'docname','L1');
			$("#hoursGrid").jqxGrid('setcellvalue',0,'btnappend','Append');
		}
		else{
			$("#hoursGrid").jqxGrid('setcellvalue',transferrows.length-1,'docname','L'+hoursrows.length);
			$("#hoursGrid").jqxGrid('setcellvalue',transferrows.length-1,'btnappend','Append');
		}
		
		//Setting Default value for billing grid
		$('#billingGrid').jqxGrid('setcellvalue',0,'billto','Client');
		$('#billingGrid').jqxGrid('setcellvalue',0,'billmode','On Account');
		$('#billingGrid').jqxGrid('setcellvalue',0,'billper',100);
	}
	if(document.getElementById("mode").value=="E"){
		$("#guestgrid").jqxGrid({ disabled: false});
	}
}
function setValues() {
	 document.getElementById("formdetail").value="Limousine Booking";
     document.getElementById("formdetailcode").value="LBK";
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	if($('#cmbloc').val()!="")
	  {
	  $('#cmbloctype').val($('#cmbloc').val());
	  }
	//funSetlabel();
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
	 }
	if(document.getElementById("hidchknewguest").value=="1"){
		document.getElementById("chknewguest").checked=true;
	}
	else{
		document.getElementById("chknewguest").checked=false;
	}
	if(document.getElementById("docno").value!=""){
			$('#btnBookEdit').show();
			$('#btnBookClone').show();
			$('#btnSrvcEdit').show();
			$('#btnSrvcReload').show();
	}
	if(document.getElementById("docno").value!=""){
		$('#guestdetdiv').load('guestgrid.jsp?clientid='+$('#hidclient').val()+'&docno='+document.getElementById("docno").value+'&id=1');
		$('#transferdiv').load('transferGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
		$('#hoursdiv').load('hoursGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
		$('#othersrvcdiv').load('otherSrvcGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
		$('#billingdiv').load('billingGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
	}
	$("#transferGrid").jqxGrid({ disabled: false});
	$("#guestgrid").jqxGrid({ disabled: true});
	$("#hoursGrid").jqxGrid({ disabled: false});
//	$("#guestgrid").jqxGrid({ disabled: false});
	var transferrows=$('#transferGrid').jqxGrid('getrows');
	var hoursrows=$('#hoursGrid').jqxGrid('getrows');
	
//	alert("Done");
//  $("#guestgrid").jqxGrid({ disabled: true }); // Disable the grid

// Correct way to check if jqxGrid is disabled
	setTimeout(function () {
        $("#guestgrid").jqxGrid({ disabled: true });
        console.log("Grid disabled:", $("#guestgrid").jqxGrid('disabled')); // Should print true
    }, 1500);
    
    
	$("#transferGrid").jqxGrid({ disabled: true});
	$("#hoursGrid").jqxGrid({ disabled: true});
	if(transferrows.length>0 || hoursrows.length>0){
		document.getElementById("savestatus").value="2";
	}
	
	
}

 function funFocus()
    {
    	 document.getElementById("client").focus(); 
    		
    }
    
     
     function funNotify(){
    	/* var dateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
 		if(dateval==0){
 			$('#date').jqxDateTimeInput('focus');
 			return false;
 		} */
 		var desc=$('#description').val();
 		if(desc.length>500){
 			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Only 500 chars allowed as description";
 			return 0;
 		}
    	 var transferrows=$('#transferGrid').jqxGrid('getrows');
 		document.getElementById("transfergridlength").value=transferrows.length;
 		for(var i=0;i<transferrows.length;i++){
 			newTextBox = $(document.createElement("input"))
 		    .attr("type", "dil")
 		    .attr("id", "transfer"+i)
 		    .attr("name", "transfer"+i)
 		    .attr("hidden", "true");
 			var pickuptime=new Date(transferrows[i].pickuptime);
 			var picktime=(pickuptime.getHours()<10?'0'+pickuptime.getHours():pickuptime.getHours())+":"+(pickuptime.getMinutes()<10?'0':'') + pickuptime.getMinutes();
 			var esttime="";
 			if(transferrows[i].esttime=="" || transferrows[i].esttime==null || transferrows[i].esttime=="undefined" || typeof(transferrows[i].esttime)=="undefined"){
 				esttime="00:00";
 			}
 			else{
 				var stresttime=new Date(transferrows[i].esttime);
 				esttime=(stresttime.getHours()<10?'0'+stresttime.getHours():stresttime.getHours())+":"+(stresttime.getMinutes()<10?'0':'') + stresttime.getMinutes();	
 			}
 			
 			var othersrvcstatus="0";
 			if(transferrows[i].chkothersrvc==true){
 				othersrvcstatus="1";
 			}
 			else{
 				othersrvcstatus="0";
 			}
 			
 			var brandidsave = transferrows[i].brandid;
 			var modelidsave = transferrows[i].modelid;
 			if(brandidsave=="undefined" || brandidsave=="" || brandidsave==null || typeof(brandidsave)=="undefined") brandidsave=0;
 			if(modelidsave=="undefined" || modelidsave=="" || modelidsave==null || typeof(modelidsave)=="undefined") modelidsave=0;
 			
 			let allownce =  (transferrows[i].allowance=="" ||  transferrows[i].allowance=="undefined" || typeof(transferrows[i].allowance)=="undefined" || transferrows[i].allowance==null) ? 0 : transferrows[i].allowance;  
 			let guestid =  (transferrows[i].guestid=="" ||  transferrows[i].guestid=="undefined" || typeof(transferrows[i].guestid)=="undefined" || transferrows[i].guestid==null) ? 0 : transferrows[i].guestid;  
 			let guestname =  (transferrows[i].guestname=="" ||  transferrows[i].guestname=="undefined" || typeof(transferrows[i].guestname)=="undefined" || transferrows[i].guestname==null) ? "" : transferrows[i].guestname;  
 			let guestcontact =  (transferrows[i].guestcontact=="" ||  transferrows[i].guestcontact=="undefined" || typeof(transferrows[i].guestcontact)=="undefined" || transferrows[i].guestcontact==null) ? "" : transferrows[i].guestcontact;  
 			let description =  (transferrows[i].description=="" ||  transferrows[i].description=="undefined" || typeof(transferrows[i].description)=="undefined" || transferrows[i].description==null) ? "" : transferrows[i].description;  
 			if((transferrows[i].tarifdocno=="undefined" || transferrows[i].tarifdocno=="" || transferrows[i].tarifdocno==null || typeof(transferrows[i].tarifdocno)=="undefined") && ( transferrows[i].brandid!="undefined" && transferrows[i].brandid!="" && transferrows[i].brandid!=null && typeof(transferrows[i].brandid)!="undefined")) cmpltryCount++;
 			newTextBox.val(transferrows[i].docname+"::"+transferrows[i].pickupdate+"::"+picktime+"::"+transferrows[i].pickuplocationid+":: "+transferrows[i].pickupaddress+" ::"+transferrows[i].dropofflocationid+"::"+transferrows[i].dropoffaddress+"::"+brandidsave+"::"+modelidsave+"::"+transferrows[i].nos+"::"+transferrows[i].tarifdocno+"::"+othersrvcstatus+"::"+transferrows[i].gid+"::"+transferrows[i].tarifdetaildocno+"::"+transferrows[i].transfertype+"::"+transferrows[i].estdistance+"::"+esttime+"::"+transferrows[i].tarif+"::"+transferrows[i].exdistancerate+"::"+transferrows[i].extimerate+"::"+transferrows[i].triptype+" :: "+transferrows[i].pax+" :: "+allownce+" :: "+guestid+" :: "+guestname+" :: "+guestcontact+" :: "+description);
 			newTextBox.appendTo('form');
 		}
 		 var hoursrows=$('#hoursGrid').jqxGrid('getrows');
 		document.getElementById("hoursgridlength").value=hoursrows.length;
 		for(var i=0;i<hoursrows.length;i++){
 			newTextBox = $(document.createElement("input"))
 		    .attr("type", "dil")
 		    .attr("id", "hours"+i)
 		    .attr("name", "hours"+i)
 		    .attr("hidden", "true");
 			
 			var pickuptime=new Date(hoursrows[i].pickuptime);
 			var picktime=(pickuptime.getHours()<10?'0'+pickuptime.getHours():pickuptime.getHours())+":"+(pickuptime.getMinutes()<10?'0':'') + pickuptime.getMinutes();
 			var othersrvcstatus="0";
 			if(hoursrows[i].chkothersrvc==true){
 				othersrvcstatus="1";
 			}
 			else{
 				othersrvcstatus="0";
 			}
 			
 			var brandidsave = hoursrows[i].brandid;
 			var modelidsave = hoursrows[i].modelid;
 			if(brandidsave=="undefined" || brandidsave=="" || brandidsave==null || typeof(brandidsave)=="undefined") brandidsave=0;
 			if(modelidsave=="undefined" || modelidsave=="" || modelidsave==null || typeof(modelidsave)=="undefined") modelidsave=0;
 			let allownce = (hoursrows[i].allowance=="" ||  hoursrows[i].allowance=="undefined" || typeof(hoursrows[i].allowance)=="undefined" || hoursrows[i].allowance==null) ? 0 : hoursrows[i].allowance;  
 			
 			let guestid =  (hoursrows[i].guestid=="" ||  hoursrows[i].guestid=="undefined" || typeof(hoursrows[i].guestid)=="undefined" || hoursrows[i].guestid==null) ? 0 : hoursrows[i].guestid;  
 			
 			let guestname =  (hoursrows[i].guestname=="" ||  hoursrows[i].guestname=="undefined" || typeof(hoursrows[i].guestname)=="undefined" || hoursrows[i].guestname==null) ? "" : hoursrows[i].guestname;  
 			let guestcontact =  (hoursrows[i].guestcontact=="" ||  hoursrows[i].guestcontact=="undefined" || typeof(hoursrows[i].guestcontact)=="undefined" || hoursrows[i].guestcontact==null) ? "" : hoursrows[i].guestcontact;  
 			let description =  (hoursrows[i].description=="" ||  hoursrows[i].description=="undefined" || typeof(hoursrows[i].description)=="undefined" || hoursrows[i].description==null) ? "" : hoursrows[i].description;  


 			
 			
 			if((hoursrows[i].tarifdocno=="undefined" || hoursrows[i].tarifdocno=="" || hoursrows[i].tarifdocno==null || typeof(hoursrows[i].tarifdocno)=="undefined") && (hoursrows[i].brandid!="undefined" && hoursrows[i].brandid!="" && hoursrows[i].brandid!=null && typeof(hoursrows[i].brandid)!="undefined") ) cmpltryCount++;
		//	newTextBox.val(hoursrows[i].docname+" :: "+hoursrows[i].pickupdate+" :: "+picktime+" :: "+hoursrows[i].pickuplocationid+" :: "+hoursrows[i].pickupaddress+" :: "+hoursrows[i].brandid+" :: "+hoursrows[i].modelid+" :: "+hoursrows[i].nos+" :: "+hoursrows[i].tarifdocno+" :: "+othersrvcstatus+" :: "+hoursrows[i].gid+" :: "+hoursrows[i].blockhrs+" :: "+hoursrows[i].tarifdetaildocno+" :: "+hoursrows[i].days+" :: "+hoursrows[i].transfertype+" :: "+hoursrows[i].tarif+" :: "+hoursrows[i].exhrrate+" :: "+hoursrows[i].nighttarif+" :: "+hoursrows[i].nightexhrrate+" :: "+allowance+" ::"+" :: "+guestid+" :: "+guestname+" :: "+guestcontact+" :: "+description );
 			newTextBox.val(hoursrows[i].docname+" :: "+hoursrows[i].pickupdate+" :: "+picktime+" :: "+hoursrows[i].pickuplocationid+" :: "+hoursrows[i].pickupaddress+" :: "+brandidsave+" :: "+modelidsave+" :: "+hoursrows[i].nos+" :: "+hoursrows[i].tarifdocno+" :: "+othersrvcstatus+" :: "+hoursrows[i].gid+" :: "+hoursrows[i].blockhrs+" :: "+hoursrows[i].tarifdetaildocno+" :: "+hoursrows[i].days+" :: "+hoursrows[i].transfertype+" :: "+hoursrows[i].tarif+" :: "+hoursrows[i].exhrrate+" :: "+hoursrows[i].nighttarif+" :: "+hoursrows[i].nightexhrrate+" :: "+allownce+" :: "+guestid+" :: "+guestname+" :: "+guestcontact+" :: "+description);
 		//	alert(hoursrows[i].docname+" :: "+hoursrows[i].pickupdate+" :: "+picktime+" :: "+hoursrows[i].pickuplocationid+" :: "+hoursrows[i].pickupaddress+" :: "+brandidsave+" :: "+modelidsave+" :: "+hoursrows[i].nos+" :: "+hoursrows[i].tarifdocno+" :: "+othersrvcstatus+" :: "+hoursrows[i].gid+" :: "+hoursrows[i].blockhrs+" :: "+hoursrows[i].tarifdetaildocno+" :: "+hoursrows[i].days+" :: "+hoursrows[i].transfertype+" :: "+hoursrows[i].tarif+" :: "+hoursrows[i].exhrrate+" :: "+hoursrows[i].nighttarif+" :: "+hoursrows[i].nightexhrrate+" :: "+allownce+" :: "+guestid+" :: "+guestname+" :: "+guestcontact+" :: "+description)
 			newTextBox.appendTo('form');
 		} 
 		

	 	var guestrows=$('#guestgrid').jqxGrid('getrows');
		document.getElementById("guestgridlength").value=guestrows.length;
		for(var i=0;i<guestrows.length;i++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "guest"+i)
		    .attr("name", "guest"+i)
		    .attr("hidden", "true");
			
 			let guestid =  (guestrows[i].doc_no=="" ||  guestrows[i].doc_no=="undefined" || typeof(guestrows[i].doc_no)=="undefined" || guestrows[i].doc_no==null) ? 0 : guestrows[i].doc_no;  
			//alert(hoursrows[i].guestid+" - "+guestid);
 			let guestname =  (guestrows[i].guest=="" ||  guestrows[i].guest=="undefined" || typeof(guestrows[i].guest)=="undefined" || guestrows[i].guest==null) ? "" : guestrows[i].guest;  
 			let guestcontact =  (guestrows[i].guestcontactno=="" ||  guestrows[i].guestcontactno=="undefined" || typeof(guestrows[i].guestcontactno)=="undefined" || guestrows[i].guestcontactno==null) ? "" : guestrows[i].guestcontactno;  

			newTextBox.val($('#hidclient').val()+" :: "+guestid+" :: "+guestname+" :: "+guestcontact);
			newTextBox.appendTo('form');
		}
 		
 		var billrows=$('#billingGrid').jqxGrid('getrows');
		document.getElementById("billinggridlength").value=billrows.length;
		if(billrows[0].billto=="" || billrows[0].billto=="undefined" || billrows[0].billto==null || typeof(billrows[0].billto)=="undefined" || billrows[0].billmode=="" || billrows[0].billmode=="undefined" || billrows[0].billmode==null || typeof(billrows[0].billmode)=="undefined" || billrows[0].billper=="" || billrows[0].billper=="undefined" || billrows[0].billper==null || typeof(billrows[0].billper)=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please enter valid data";
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		for(var j=0;j<billrows.length;j++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "bill"+j)
		    .attr("name", "bill"+j)
		    .attr("hidden",true); 
			
			newTextBox.val(billrows[j].billto+"::"+billrows[j].billmode+"::"+billrows[j].billper);
			newTextBox.appendTo('form');
		}
		if(cmpltryCount>0 && !isTariffHidden){
			$.messager.confirm('Confirm', ' Tariff has not been specified, Tariff has been set as Complimentary', function(r){
	    		if (r){
	    			var formId=$('form').attr('id');
	    			if($('#'+formId).valid()) {
	    				   funSetlabel();
	    				   $("#overlay, #PleaseWait").show();
	    				   $('#brchName').attr('disabled', false);$('#currency').attr('disabled', false);
	    				   $('#'+formId).submit();
	    			}
	    			
	    			return 0;
	     		}
			});
		}else{
        		return 1;
		}
     } 
     
    function funBookClone(){
    	$('#btnBookEdit').hide();
		$('#btnBookClone').hide();
		funRemoveReadOnly();
		$('#docno').val('');
		$('#vocno').val('');
		$('#date').jqxDateTimeInput('setDate',new Date());
		$("#transferGrid").jqxGrid({ disabled: false});
		$("#hoursGrid").jqxGrid({ disabled: false});
		$("#guestgrid").jqxGrid({ disabled: false});
		$("#billingGrid").jqxGrid({ disabled: false});
		document.getElementById("mode").value="A";
		$("#status").val(1);	 $("#btnSave").show();		 $("#btnCancel").show();
		$("#btnApproval").hide();	 $("#btnCreate").hide();	funFocus();
		$("#btnEdit").hide();	 $("#btnPrint").hide();	 $("#btnExcel").hide();		 $("#btnDelete").hide();
		$("#btnSearch").hide(); 		 $("#btnAttach").hide();  $("#btnCosting").hide(); $("#btnTerms").hide(); $("#btnGuideLine").hide();
		$("#brchName").hide();  $("#brchNames").show(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
		$("#currency").hide();  $("#currencys").show(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
		$('.delete-img-container').remove();
		
    }
     
     
	function funBookEdit(){
		$('#btnBookEdit').hide();
		$('#btnBookClone').hide();
		$('#btnBookSave').show();
		$('#btnBookCancel').show();
				
		$("#transferGrid").jqxGrid({ disabled: false});
		$("#hoursGrid").jqxGrid({ disabled: false});
		//$("#guestgrid").jqxGrid({ disabled: false});
		//$("#otherSrvcGrid").jqxGrid({ disabled: false});
		$("#billingGrid").jqxGrid({ disabled: false});
		$("#transferGrid").jqxGrid("addrow", null, {});
		$("#hoursGrid").jqxGrid("addrow", null, {});
		//$("#otherSrvcGrid").jqxGrid("addrow", null, {});
		$("#billingGrid").jqxGrid("addrow", null, {});
		var transferrows=$("#transferGrid").jqxGrid('getrows');
		var hoursrows=$("#hoursGrid").jqxGrid('getrows');
		if(transferrows.length==0){
			$("#transferGrid").jqxGrid('setcellvalue',0,'docname','T1');
			$("#transferGrid").jqxGrid('setcellvalue',0,'btnappend','Append');
		}
		else{
			$("#transferGrid").jqxGrid('setcellvalue',transferrows.length-1,'docname','T'+transferrows.length);
			$("#transferGrid").jqxGrid('setcellvalue',transferrows.length-1,'btnappend','Append');
		}
		if(hoursrows.length==0){
			$("#hoursGrid").jqxGrid('setcellvalue',0,'docname','L1');
			$("#hoursGrid").jqxGrid('setcellvalue',0,'btnappend','Append');
		}
		else{
			$("#hoursGrid").jqxGrid('setcellvalue',hoursrows.length-1,'docname','L'+hoursrows.length);
			$("#hoursGrid").jqxGrid('setcellvalue',hoursrows.length-1,'btnappend','Append');
		}
		
		
	}
	function funBookCancel(){
		$("#transferGrid").jqxGrid({ disabled: true});
		$("#hoursGrid").jqxGrid({ disabled: true});
		//$("#otherSrvcGrid").jqxGrid({ disabled: true});
		$("#billingGrid").jqxGrid({ disabled: true});
		$('#btnBookEdit').show();
		$('#btnBookClone').show();
		$('#btnBookSave').hide();
		$('#btnBookCancel').hide();
	}
	
	function funloctype()
{
	if( document.getElementById("cmbloctype").value=="flight")
		{
		$('#txtairport').attr('disabled', false);
		$('#txtflightno').attr('disabled', false);
		
			$('#txthotelname').attr('disabled', true);
		
		$('#txtroomno').attr('disabled', true);
		}
	else if( document.getElementById("cmbloctype").value=="hotel"){
		$('#txthotelname').attr('disabled', false);
		
		$('#txtroomno').attr('disabled', false);
		
		$('#txtairport').attr('disabled', true);
		
		$('#txtflightno').attr('disabled', true);
	}
	else{
		$('#txthotelname').attr('disabled', true);
		   
		$('#txtroomno').attr('disabled', true);
		
		$('#txtairport').attr('disabled', true);
		
		$('#txtflightno').attr('disabled', true);
	}
			
}
	
	function funBookSave(){
		var transferrows=$('#transferGrid').jqxGrid('getrows');
		document.getElementById("transfergridlength").value=transferrows.length;
		for(var i=0;i<transferrows.length;i++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "transfer"+i)
		    .attr("name", "transfer"+i)
		    .attr("hidden", "true");
			var pickuptime=new Date(transferrows[i].pickuptime);
 			var picktime=(pickuptime.getHours()<10?'0'+pickuptime.getHours():pickuptime.getHours())+":"+(pickuptime.getMinutes()<10?'0':'') + pickuptime.getMinutes();
 			var esttime="";
 			var allowance="0"
 			if(transferrows[i].esttime=="" || transferrows[i].esttime==null || transferrows[i].esttime=="undefined" || typeof(transferrows[i].esttime)=="undefined"){
 				esttime="00:00";
 			}
 			else{
 				var stresttime=new Date(transferrows[i].esttime);
 				esttime=(stresttime.getHours()<10?'0'+stresttime.getHours():stresttime.getHours())+":"+(stresttime.getMinutes()<10?'0':'') + stresttime.getMinutes();	
 			}
 			var othersrvcstatus="0";
			if(transferrows[i].chkothersrvc==true){
				othersrvcstatus="1";
			}
			else{
				othersrvcstatus="0";
			}
			
			if(transferrows[i].allowance=="" || transferrows[i].allowance==null || transferrows[i].allowance=="undefined" || typeof(transferrows[i].allowance)=="undefined"){
 				allowance="0";
 			} else {
 				allowance=transferrows[i].allowance;
 			}
			let allownce =  (transferrows[i].allowance=="" ||  transferrows[i].allowance=="undefined" || typeof(transferrows[i].allowance)=="undefined" || transferrows[i].allowance==null) ? 0 : transferrows[i].allowance;  
 			let guestid =  (transferrows[i].guestid=="" ||  transferrows[i].guestid=="undefined" || typeof(transferrows[i].guestid)=="undefined" || transferrows[i].guestid==null) ? 0 : transferrows[i].guestid;  
 			let guestname =  (transferrows[i].guestname=="" ||  transferrows[i].guestname=="undefined" || typeof(transferrows[i].guestname)=="undefined" || transferrows[i].guestname==null) ? "" : transferrows[i].guestname;  
 			let guestcontact =  (transferrows[i].guestcontact=="" ||  transferrows[i].guestcontact=="undefined" || typeof(transferrows[i].guestcontact)=="undefined" || transferrows[i].guestcontact==null) ? "" : transferrows[i].guestcontact;  
 			let description =  (transferrows[i].description=="" ||  transferrows[i].description=="undefined" || typeof(transferrows[i].description)=="undefined" || transferrows[i].description==null) ? "" : transferrows[i].description;  
			
			newTextBox.val(transferrows[i].docname+"::"+transferrows[i].pickupdate+"::"+picktime+"::"+transferrows[i].pickuplocationid+"::"+transferrows[i].pickupaddress+"::"+transferrows[i].dropofflocationid+"::"+transferrows[i].dropoffaddress+"::"+transferrows[i].brandid+"::"+transferrows[i].modelid+"::"+transferrows[i].nos+"::"+transferrows[i].tarifdocno+"::"+othersrvcstatus+"::"+transferrows[i].gid+"::"+transferrows[i].tarifdetaildocno+"::"+transferrows[i].transfertype+"::"+transferrows[i].estdistance+"::"+esttime+"::"+transferrows[i].tarif+"::"+transferrows[i].exdistancerate+"::"+transferrows[i].extimerate+"::"+transferrows[i].triptype+" :: "+transferrows[i].pax+" :: "+allowance+" :: "+guestid+" :: "+guestname+" :: "+guestcontact+" :: "+description);
			newTextBox.appendTo('form');
		}
		 var hoursrows=$('#hoursGrid').jqxGrid('getrows');
		document.getElementById("hoursgridlength").value=hoursrows.length;
		for(var i=0;i<hoursrows.length;i++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "hours"+i)
		    .attr("name", "hours"+i)
		    .attr("hidden", "true");
			
			var pickuptime=new Date(hoursrows[i].pickuptime);
			var picktime=(pickuptime.getHours()<10?'0'+pickuptime.getHours():pickuptime.getHours())+":"+(pickuptime.getMinutes()<10?'0':'') + pickuptime.getMinutes();
			var othersrvcstatus="0";
			if(hoursrows[i].chkothersrvc==true){
				othersrvcstatus="1";
			}
			else{
				othersrvcstatus="0";
			}
			if(hoursrows[i].allowance=="" || hoursrows[i].allowance==null || hoursrows[i].allowance=="undefined" || typeof(hoursrows[i].allowance)=="undefined"){
 				allowance="0";
 			} else {
 				allowance = hoursrows[i].allowance;
 			}
 			let guestid =  (hoursrows[i].guestid=="" ||  hoursrows[i].guestid=="undefined" || typeof(hoursrows[i].guestid)=="undefined" || hoursrows[i].guestid==null) ? 0 : hoursrows[i].guestid;  
			//alert(hoursrows[i].guestid+" - "+guestid);
 			let guestname =  (hoursrows[i].guestname=="" ||  hoursrows[i].guestname=="undefined" || typeof(hoursrows[i].guestname)=="undefined" || hoursrows[i].guestname==null) ? "" : hoursrows[i].guestname;  
 			let guestcontact =  (hoursrows[i].guestcontact=="" ||  hoursrows[i].guestcontact=="undefined" || typeof(hoursrows[i].guestcontact)=="undefined" || hoursrows[i].guestcontact==null) ? "" : hoursrows[i].guestcontact;  
 			let description =  (hoursrows[i].description=="" ||  hoursrows[i].description=="undefined" || typeof(hoursrows[i].description)=="undefined" || hoursrows[i].description==null) ? "" : hoursrows[i].description;  

			newTextBox.val(hoursrows[i].docname+" :: "+hoursrows[i].pickupdate+" :: "+picktime+" :: "+hoursrows[i].pickuplocationid+" :: "+hoursrows[i].pickupaddress+" :: "+hoursrows[i].brandid+" :: "+hoursrows[i].modelid+" :: "+hoursrows[i].nos+" :: "+hoursrows[i].tarifdocno+" :: "+othersrvcstatus+" :: "+hoursrows[i].gid+" :: "+hoursrows[i].blockhrs+" :: "+hoursrows[i].tarifdetaildocno+" :: "+hoursrows[i].days+" :: "+hoursrows[i].transfertype+" :: "+hoursrows[i].tarif+" :: "+hoursrows[i].exhrrate+" :: "+hoursrows[i].nighttarif+" :: "+hoursrows[i].nightexhrrate+" :: "+allowance+" ::"+guestid+" :: "+guestname+" :: "+guestcontact+" :: "+description );
			newTextBox.appendTo('form');
		} 
	
		
		$.messager.confirm('Confirm', 'Do you want to save?', function(r){
    		if (r){
    			$("#overlay, #PleaseWait").show();
    			 $('#date').jqxDateTimeInput({ disabled: false}); 
    			 
    				document.getElementById("mode").value="tarifinsert";
    				document.getElementById("frmLimoBooking").submit();
    				 $('#date').jqxDateTimeInput({ disabled: true}); 
				
    		}
     		});		
		
	}
	
	
	function funSrvcReload(){
		$('#othersrvcdiv').load('otherSrvcGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
	}
	function funSrvcEdit(){
		$("#otherSrvcGrid").jqxGrid({ disabled: false});
		$("#billingGrid").jqxGrid({ disabled: false});
		$("#billingGrid").jqxGrid("addrow", null, {});
		$("#billingGrid").jqxGrid("addrow", null, {});
		$('#btnSrvcEdit').hide();
		$('#btnSrvcCancel').show();
		$('#btnSrvcSave').show();
		
		//alert("Entered");
		// Get all rows from both grids
		var transferGridRows = $('#transferGrid').jqxGrid('getrows');  
		var hoursGridRows = $('#hoursGrid').jqxGrid('getrows');  
		var otherServiceGridRows = $('#otherSrvcGrid').jqxGrid('getrows');  

		// Loop through each row in the first grid
		for (var i = 0; i < transferGridRows.length; i++) {
		    var firstGridId = transferGridRows[i].docname; 
		    var firstGridDate = transferGridRows[i].pickupdate;
		    var firstGridTime = transferGridRows[i].pickuptime;

		    // Loop through the second grid to find a matching ID
		    for (var j = 0; j < otherServiceGridRows.length; j++) {
		        if (otherServiceGridRows[j].docname === firstGridId) { 
		            // Update date and time in the second grid
		            $('#otherSrvcGrid').jqxGrid('setcellvalue', j, 'boquedate', firstGridDate);
		            $('#otherSrvcGrid').jqxGrid('setcellvalue', j, 'boquetime', firstGridTime);
		        }
		    }
		}
		
		for (var i = 0; i < hoursGridRows.length; i++) {
		    var firstGridId = hoursGridRows[i].docname; 
		    var firstGridDate = hoursGridRows[i].pickupdate;
		    var firstGridTime = hoursGridRows[i].pickuptime;

		    // Loop through the second grid to find a matching ID
		    for (var j = 0; j < otherServiceGridRows.length; j++) {
		        if (otherServiceGridRows[j].docname === firstGridId) { 
		            // Update date and time in the second grid
		            $('#otherSrvcGrid').jqxGrid('setcellvalue', j, 'boquedate', firstGridDate);
		            $('#otherSrvcGrid').jqxGrid('setcellvalue', j, 'boquetime', firstGridTime);
		        }
		    }
		}
	}
	function funSrvcCancel(){
		$("#otherSrvcGrid").jqxGrid({ disabled: true});
		$('#btnSrvcEdit').show();
		$('#btnSrvcCancel').hide();
		$('#btnSrvcSave').hide();
	}
	function funSrvcSave(){
		
		
		var summaryData1= $("#billingGrid").jqxGrid('getcolumnaggregateddata', 'billper', ['sum'],true);
		var billsum=summaryData1.sum;
		if(parseFloat(billsum)<100){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Total Bill Percentage must be 100%";
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		var billrows=$('#billingGrid').jqxGrid('getrows');
		document.getElementById("billinggridlength").value=billrows.length;
		if(billrows[0].billto=="" || billrows[0].billto=="undefined" || billrows[0].billto==null || typeof(billrows[0].billto)=="undefined" || billrows[0].billmode=="" || billrows[0].billmode=="undefined" || billrows[0].billmode==null || typeof(billrows[0].billmode)=="undefined" || billrows[0].billper=="" || billrows[0].billper=="undefined" || billrows[0].billper==null || typeof(billrows[0].billper)=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please enter valid data";
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		for(var j=0;j<billrows.length;j++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "bill"+j)
		    .attr("name", "bill"+j)
		    .attr("hidden",true); 
			if(billrows[j].billto!="" || billrows[j].billto!="undefined" || billrows[j].billto!=null || typeof(billrows[j].billto)!="undefined" || billrows[j].billmode!="" 
				|| billrows[j].billmode!="undefined" || billrows[j].billmode!=null || typeof(billrows[j].billmode)!="undefined" || billrows[j].billper!="" || 
				billrows[j].billper!="undefined" || billrows[j].billper!=null || typeof(billrows[j].billper)!="undefined"){
				
				newTextBox.val(billrows[j].billto+" :: "+billrows[j].billmode+" :: "+billrows[j].billper+" :: ");
				newTextBox.appendTo('form');
			}
		}
		var srvcrows=$('#otherSrvcGrid').jqxGrid('getrows');
		document.getElementById("othersrvcgridlength").value=srvcrows.length;
		
		for(var i=0;i<srvcrows.length;i++){
			if(srvcrows[i].airport=="undefined" || srvcrows[i].airport=="" || typeof(srvcrows[i].airport)=="undefined"){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Must Complete all services";
				return false;
			}
			else{
				document.getElementById("errormsg").innerText="";
			}
			if((srvcrows[i].greetdate=="undefined" || srvcrows[i].greetdate=="" || typeof(srvcrows[i].greetdate)=="undefined") && (srvcrows[i].vipdate=="undefined" || srvcrows[i].vipdate=="" || typeof(srvcrows[i].vipdate)=="undefined") && (srvcrows[i].boquedate=="undefined" || srvcrows[i].boquedate=="" || typeof(srvcrows[i].boquedate)=="undefined")){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Must select minimum 1 service";
				return false;
			}
			else{
				document.getElementById("errormsg").innerText="";
			}
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "srvc"+i)
		    .attr("name", "srvc"+i)
		    .attr("hidden",true);
			var greettime1,viptime1,boquetime1;
			if(srvcrows[i].greettime!="undefined" && srvcrows[i].greettime!="" && srvcrows[i].greettime!=null && typeof(srvcrows[i].greettime)!="undefined"){
				var greettime=new Date(srvcrows[i].greettime);
				greettime1=(greettime.getHours()<10?'0'+greettime.getHours():greettime.getHours())+":"+(greettime.getMinutes()<10?'0':'') + greettime.getMinutes();
			}
			else{
				greettime1=null;
			}
			if(srvcrows[i].viptime!="undefined" && srvcrows[i].viptime!="" && srvcrows[i].viptime!=null && typeof(srvcrows[i].viptime)!="undefined"){
				var viptime=new Date(srvcrows[i].viptime);
				viptime1=(viptime.getHours()<10?'0'+viptime.getHours():viptime.getHours())+":"+(viptime.getMinutes()<10?'0':'') + viptime.getMinutes();
			}
			else{
				viptime1=null;
			}
			if(srvcrows[i].boquetime!="undefined" && srvcrows[i].boquetime!="" && srvcrows[i].boquetime!=null && typeof(srvcrows[i].boquetime)!="undefined"){
				var boquetime=new Date(srvcrows[i].boquetime);
				boquetime1=(boquetime.getHours()<10?'0'+boquetime.getHours():boquetime.getHours())+":"+(boquetime.getMinutes()<10?'0':'') + boquetime.getMinutes();
			}
			else{
				boquetime1=null;
			}
			
			
			if(srvcrows[i].boquetarifdocno==""){
				srvcrows[i].boquetarifdocno="1";
			}
			newTextBox.val(srvcrows[i].docname+" :: "+srvcrows[i].detaildocno+" :: "+srvcrows[i].airportid+" :: "+srvcrows[i].greetdate+" :: "+greettime1+" :: "+srvcrows[i].greettarifdocno+" :: "+srvcrows[i].vipdate+" :: "+viptime1+" :: "+srvcrows[i].viptarifdocno+" :: "+srvcrows[i].boquedate+" :: "+boquetime1+" :: "+srvcrows[i].boquetarifdocno+" :: ");
			newTextBox.appendTo('form');
		}
		
		$.messager.confirm('Confirm', 'Do you want to save?', function(r){
    		if (r){
    			$("#overlay, #PleaseWait").show();
    			$('#date').jqxDateTimeInput({ disabled: false}); 
    			document.getElementById("mode").value="srvcinsert";
    			document.getElementById("frmLimoBooking").submit();
    			$('#date').jqxDateTimeInput({ disabled: true});
    		}
     		});
		
		
	}
	
	function funBackDateChecking(date){
		var currentdate=new Date();
		var status=-1;
		date.setHours(0,0,0,0);
		currentdate.setHours(0,0,0,0);
		if(date<currentdate){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Back Date Not Allowed";
			status=0;
		}
		else{
			status=1;
		}
		return status;
	}
	
	function setTariffTransfer(){
		var clientid = document.getElementById("hidclient").value;
		var brandid =  document.getElementById("hidtbrandid").value;
		var modelid =  document.getElementById("hidtmodelid").value;
		var groupid =  document.getElementById("hidtgroupid").value;
		var pickuplocid = document.getElementById("hidplocid").value;
		var dropofflocid =  document.getElementById("hiddofflocationid").value;  
		var transfertype=  document.getElementById("ttype").value;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var data = JSON.parse(x.responseText);
				 if(data.tariffdata.length>=1){
				 	document.getElementById("edistance").value=data.tariffdata[0].estdistance;
				 	$("#etime").jqxDateTimeInput('setDate',data.tariffdata[0].esttime);
				 	document.getElementById("tariff").value=data.tariffdata[0].tarif;
				 	document.getElementById("allowance").value=data.tariffdata[0].tarif;
				 	document.getElementById("exdistancerate").value=data.tariffdata[0].exdistancerate;
				 	document.getElementById("exdistancetime").value=data.tariffdata[0].extimerate;
				 	document.getElementById("tdocno").value=data.tariffdata[0].docno;
				 	document.getElementById("hidtariffdocno").value=data.tariffdata[0].tarifdetaildocno;
				 }
				 setTransferGrid();
			} else {
			}
		}
		x.open("GET",'gettariffauto.jsp?groupid='+groupid+'&brandid='+brandid+'&tarifmode=transferGrid&modelid='+modelid+'&pickuplocid='+pickuplocid+'&dropofflocid='+dropofflocid+'&cldocno='+clientid+'&transfertype='+transfertype, true);
		x.send();
	}
	
	
	function setTariffTransferGridEdit(rowBoundIndex,brandId,modelId,pickUpLocid,dropOffLocId,transferType,groupId){
		var clientid = document.getElementById("hidclient").value;
		var brandid = brandId;
		var groupid = groupId;
		var modelid = modelId;
		var pickuplocid = pickUpLocid;
		var dropofflocid =  dropOffLocId;
		var transfertype = transferType;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var data = JSON.parse(x.responseText);
				 if(data.tariffdata.length>=1){
					 $('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'estdistance',data.tariffdata[0].estdistance);
					 $('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'esttime',data.tariffdata[0].esttime);
					 $('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif',data.tariffdata[0].tarif);
					 $('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'allowance',data.tariffdata[0].allowance);
					 $('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'exdistancerate',data.tariffdata[0].exdistancerate);
					 $('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'extimerate',data.tariffdata[0].extimerate);
					 $('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid',data.tariffdata[0].gid);
				 	 $('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno',data.tariffdata[0].tarifdetaildocno);
				 	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno',data.tariffdata[0].docno);
				 } else {
					$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno','');
     		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'estdistance','');
     		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'esttime','');
     		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif','');
     		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'allowance','');
     		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'exdistancerate','');
     		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'extimerate','');
     		    	if (!isGroupBased) $('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid','');
     		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno','');
				 }
			} else {
			}
		}
		x.open("GET",'gettariffauto.jsp?groupid='+groupid+'&brandid='+brandid+'&tarifmode=transferGrid&modelid='+modelid+'&pickuplocid='+pickuplocid+'&dropofflocid='+dropofflocid+'&cldocno='+clientid+'&transfertype='+transfertype, true);
		x.send();
	}
	
	
	function setTariffHourGridEdit(rowBoundIndex,brandId,modelId,pickUpLocid,blockHours,transferType,groupId){
		var clientid = document.getElementById("hidclient").value
		var brandid = brandId;
		var groupid = groupId;
		var modelid =  modelId;
		var pickuplocid = pickUpLocid;
		var transfertype =  transferType;
		var blockhours = blockHours;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var data = JSON.parse(x.responseText);
				 	if(data.tariffdata.length>=1){
				 		$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif',data.tariffdata[0].tarif);
				 		$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'allowance',data.tariffdata[0].allowance);
				 		$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nightexhrrate',data.tariffdata[0].nightexhrrate);
					 	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno',data.tariffdata[0].docno);
					 	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno',data.tariffdata[0].tarifdetaildocno);
					 	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nighttarif',data.tariffdata[0].nighttarif);
					 	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'exhrrate',data.tariffdata[0].exhrrate);
					 	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'allowance',data.tariffdata[0].allowance);
				 	} else {
				 		$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno','');
        		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif','');
        		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'allowance','');
        		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'exhrrate','');
        		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nighttarif','');
        		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nightexhrrate','');
        		    	if(!isGroupBased) $('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid','');
        		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno','');
				 	}
				 	
			} else {
			}
		}
		x.open("GET",'gettariffauto.jsp?groupid='+groupid+'&brandid='+brandid+'&tarifmode=hoursGrid&modelid='+modelid+'&pickuplocid='+pickuplocid+'&cldocno='+clientid+'&transfertype='+transfertype+'&blockhrs='+blockhours, true);
		x.send();
	}
	
	
	function setTariffHour(){
		var clientid = document.getElementById("hidclient").value
		var groupid = document.getElementById("hidlgroupid").value
		var brandid =  document.getElementById("hidlbrandid").value;
		var modelid =  document.getElementById("hidlmodelid").value;
		var pickuplocid = document.getElementById("hidlpcklocationid").value;
		var transfertype =  document.getElementById("ltype").value;
		var blockhours = document.getElementById("bhours").value;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var data = JSON.parse(x.responseText);
				 	if(data.tariffdata.length>=1){
					 	document.getElementById("ltariff").value=data.tariffdata[0].tarif;
					 	document.getElementById("lallowance").value=data.tariffdata[0].allowance;
					 	document.getElementById("lnexhourrate").value=data.tariffdata[0].nightexhrrate;
					 	document.getElementById("ltdocno").value=data.tariffdata[0].docno;
					 	document.getElementById("hidltariffdocno").value=data.tariffdata[0].tarifdetaildocno;
					 	document.getElementById("lntariff").value=data.tariffdata[0].nighttarif;
					 	document.getElementById("lexhourrate").value=data.tariffdata[0].exhrrate;
				 	}
				 	limosetgrid();
			} else {
			}
		}
		x.open("GET",'gettariffauto.jsp?groupid='+groupid+'&brandid='+brandid+'&tarifmode=hoursGrid&modelid='+modelid+'&pickuplocid='+pickuplocid+'&cldocno='+clientid+'&transfertype='+transfertype+'&blockhrs='+blockhours, true);
		x.send();
	}
	
	function getTariffButtonConfig(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var data = JSON.parse(x.responseText);
				 if((data==1)){
					isTariffButtonHidden=true; 
					$('.hidebutton').show();
				 } else {
					$('.hidebutton').hide();
					 isTariffButtonHidden=false;
				 }
				 
			} else {
			}
		}
		x.open("GET",'gettariffbuttonconfig.jsp', true);
		x.send();
	}
	
	function getGroupConfig(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var data = JSON.parse(x.responseText);
				 if((data==1)){
					 $("#transferGrid").jqxGrid('hidecolumn', 'brand');
					 $("#transferGrid").jqxGrid('hidecolumn', 'model');
					 $("#hoursGrid").jqxGrid('hidecolumn', 'brand');
					 $("#hoursGrid").jqxGrid('hidecolumn', 'model');
					 const tdsToHide = document.querySelectorAll('td.hidegroupbased');
						tdsToHide.forEach(td => {
						    td.style.display = 'none';
						});
						$('#transferGrid').jqxGrid('setcolumnproperty', 'pickuplocation', 'width', '12%');
						$('#transferGrid').jqxGrid('setcolumnproperty', 'pickupaddress', 'width', '12%');
						$('#transferGrid').jqxGrid('setcolumnproperty', 'dropofflocation', 'width', '12%');
						$('#transferGrid').jqxGrid('setcolumnproperty', 'dropoffaddress', 'width', '12%');
						$('#hoursGrid').jqxGrid('setcolumnproperty', 'pickuplocation', 'width', '20%');
						$('#hoursGrid').jqxGrid('setcolumnproperty', 'pickupaddress', 'width', '20%');	
						$('#hoursGrid').jqxGrid('setcolumnproperty', 'groupid', 'width', '16%');	
						$('#hoursGrid').jqxGrid('setcolumnproperty', 'days', 'width', '8%');	
						$('#hoursGrid').jqxGrid('setcolumnproperty', 'nos', 'width', '8%');	
					
					  isGroupBased=true;
				 } else {
					 $("#transferGrid").jqxGrid('hidecolumn', 'groupid');
					 const tdsToShow = document.querySelectorAll('td.showgroupbased');
					 tdsToShow.forEach(td => {
					 	td.style.display = 'none';
					});	
				 }
				 
			} else {
			}
		}
		x.open("GET",'gettariffconfig.jsp', true);
		x.send();
	}
	
	
	function getTariffConfig(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var data = JSON.parse(x.responseText);
				 if(data==1){
					 $("#transferGrid").jqxGrid('hidecolumn', 'tarif');
					 $("#transferGrid").jqxGrid('hidecolumn', 'allowance');
					 $("#transferGrid").jqxGrid('hidecolumn', 'tarifdocno');
					 $("#transferGrid").jqxGrid('hidecolumn', 'estdistance');
					 $("#transferGrid").jqxGrid('hidecolumn', 'esttime');
					 $("#transferGrid").jqxGrid('hidecolumn', 'exdistancerate');
					 $("#transferGrid").jqxGrid('hidecolumn', 'extimerate');
					  document.getElementById("edistance").style.display = 'none';
					  document.getElementById("etime").style.display = 'none';
					  document.getElementById("tariff").style.display = 'none';
					  document.getElementById("allowance").style.display = 'none';
					  document.getElementById("exdistancerate").style.display = 'none';
					  document.getElementById("exdistancetime").style.display = 'none';
					  document.getElementById("tdocno").style.display = 'none';
					  document.getElementById("hidtariffdocno").style.display = 'none';
					  
					  isTariffHidden=true;
					  
					 $("#hoursGrid").jqxGrid('hidecolumn', 'tarif');
					 $("#hoursGrid").jqxGrid('hidecolumn', 'allowance');
					 $("#hoursGrid").jqxGrid('hidecolumn', 'tarifdocno');
					 $("#hoursGrid").jqxGrid('hidecolumn', 'exhrrate');
					 $("#hoursGrid").jqxGrid('hidecolumn', 'nighttarif');
					 $("#hoursGrid").jqxGrid('hidecolumn', 'nightexhrrate');
					 
					 $('#hoursGrid').jqxGrid('setcolumnproperty', 'pickuplocation', 'width', '16%');
					 $('#hoursGrid').jqxGrid('setcolumnproperty', 'pickupaddress', 'width', '16%');
					 $('#hoursGrid').jqxGrid('setcolumnproperty', 'brand', 'width', '10%');
					 $('#hoursGrid').jqxGrid('setcolumnproperty', 'model', 'width', '10%');
					 $('#hoursGrid').jqxGrid('setcolumnproperty', 'pickuptime', 'width', '6%');
					 
					document.getElementById("lexhourrate").style.display = 'none';
					document.getElementById("lntariff").style.display = 'none';
					document.getElementById("ltdocno").style.display = 'none';
					document.getElementById("ltariff").style.display = 'none';
					document.getElementById("lallowance").style.display = 'none';
					document.getElementById("lnexhourrate").style.display = 'none';
					const tdsToHide = document.querySelectorAll('td.hidefortariff');

					tdsToHide.forEach(td => {
					    td.style.display = 'none';
					});
					//document.getElementsByClassName("hidefortariff").style.display = 'none';
				 } else {
					 document.getElementById("vesselno").style.display='none';
					 document.getElementById("vesselnolabel").style.display='none';
					 document.getElementById("vesselnamelabel").style.display='none';
					 document.getElementById("vesselname").style.display='none';
				 }
				 
			} else {
			}
		}
		x.open("GET",'gettariffconfig.jsp', true);
		x.send();
	}
	
	 function setTransferGrid()  {
	 		var rows = $("#transferGrid").jqxGrid('getrows');
	        var rowlength = rows.length;
		    
	        var plocid = document.getElementById("hidplocid").value;
		    var tpdate =  $('#pdate').jqxDateTimeInput('getDate');
		    var tptime =  document.getElementById("ptime").value; 
		    var tpaddress =  document.getElementById("pckaddress").value;
		    var tdofflocation =  document.getElementById("hiddofflocationid").value;
		    var tdoffaddress =  document.getElementById("Doffaddress").value; 
		    var tpbrandid =  document.getElementById("hidtbrandid").value;
		    var tpgroupid =  document.getElementById("hidtgroupid").value;
		    var tpmodelid =  document.getElementById("hidtmodelid").value;
		    var tptriptype =  document.getElementById("cmbttriptype").value;
		    var tpnos =  document.getElementById("nos").value;
		    var tppax =  document.getElementById("pax").value;
		    var tptype =  document.getElementById("ttype").value;
		    
		    var tpedistance =  document.getElementById("edistance").value;
		    var tpetime =  document.getElementById("etime").value;
		    var tptariff =  document.getElementById("tariff").value;
		    var tpallowance =  document.getElementById("allowance").value;
		    var tpexdistancerate =  document.getElementById("exdistancerate").value;
		    var tpexdistancetime =  document.getElementById("exdistancetime").value;
		    var tpotherservice =  document.getElementById("otherservice").checked;
		    var tguestid = document.getElementById("hidtguestid").value;
		    var tguestname = document.getElementById("tguest").value;
		    var tdescription = document.getElementById("tdescription").value;
		    var tguestcontact = document.getElementById("hidtguestcontactno").value;
		    
		    var tdocno =  document.getElementById("tdocno").value;
		    var tdetaildocno =  document.getElementById("hidtariffdocno").value;
			if(plocid=="" || plocid==null || typeof(plocid)=="undefined"|| typeof(plocid)=="NaN"){
				document.getElementById("errormsg").innerText="Pick up location is mandatory";
				return false;
			}else{
				document.getElementById("errormsg").innerText="";
			}
		   
			if(hiddofflocationid=="" || hiddofflocationid==null || typeof(hiddofflocationid)=="undefined"|| typeof(hiddofflocationid)=="NaN"){
				document.getElementById("errormsg").innerText="Drop location is mandatory";
				return false;
			}else{
				document.getElementById("errormsg").innerText="";
			}
			
			if(tdoffaddress=="" || tdoffaddress==null || typeof(tdoffaddress)=="undefined"|| typeof(tdoffaddress)=="NaN"){
				document.getElementById("errormsg").innerText="Drop Address is mandatory";
				return false;
			}else{
				document.getElementById("errormsg").innerText="";
			}
			
			if(isGroupBased){
				if(tpgroupid=="" || tpgroupid==null || typeof(tpgroupid)=="undefined"|| typeof(tpgroupid)=="NaN"){
					document.getElementById("errormsg").innerText="Group is mandatory";
					return false;
				}else{
					document.getElementById("errormsg").innerText="";
				}
				
			} else {
				if(tpbrandid=="" || tpbrandid==null || typeof(tpbrandid)=="undefined"|| typeof(tpbrandid)=="NaN"){
					document.getElementById("errormsg").innerText="Brand is mandatory";
					return false;
				}else{
					document.getElementById("errormsg").innerText="";
				}
				
				if(tpmodelid=="" || tpmodelid==null || typeof(tpmodelid)=="undefined"|| typeof(tpmodelid)=="NaN"){
					document.getElementById("errormsg").innerText="Model is mandatory";
					return false;
				}else{
					document.getElementById("errormsg").innerText="";
				}
			}
			
			
			
			if(tptype=="" || tptype==null || typeof(tptype)=="undefined"|| typeof(tptype)=="NaN"){
				document.getElementById("errormsg").innerText="Type is mandatory";
				return false;
			}else{
				document.getElementById("errormsg").innerText="";
			}
			
			 if(tptriptype=="" || tptriptype==null || typeof(tptriptype)=="undefined"|| typeof(tptriptype)=="NaN"){
				document.getElementById("errormsg").innerText="Trip Type is mandatory";
				return false;
			}
			
			 if((tdocno=="" || tdocno==null || typeof(tdocno)=="undefined"|| typeof(tdocno)=="NaN") && isTariffHidden==false){
				 	document.getElementById("errormsg").innerText="Tariff Doc No is mandatory";
					return false;
				}
		 
		     $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "pickuplocation", document.getElementById("hidplocation").value);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "pickuplocationid", document.getElementById("hidplocid").value);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "pickupdate", tpdate);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "pickuptime", tptime);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "pickupaddress", tpaddress);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "dropofflocation", document.getElementById("hiddofflocation").value);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "dropofflocationid", document.getElementById("hiddofflocationid").value);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "dropoffaddress", tdoffaddress);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "brand", document.getElementById("hidtbrand").value);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "brandid", document.getElementById("hidtbrandid").value);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "groupid", document.getElementById("hidtgroup").value);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "gid", document.getElementById("hidtgroupid").value);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "model", document.getElementById("hidtmodel").value);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "modelid", document.getElementById("hidtmodelid").value);  
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "nos", tpnos);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "pax", tppax);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "transfertype", tptype);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "triptype", tptriptype);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "tarifdocno", tdocno); 
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "tarifdetaildocno", tdetaildocno);   
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "estdistance", tpedistance);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "esttime", tpetime);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "tarif", tptariff);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "allowance", tpallowance);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "exdistancerate", tpexdistancerate);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "extimerate", tpexdistancetime);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "guestname", tguestname);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "guestcontact", tguestcontact);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "description", tdescription);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "chkothersrvc", tpotherservice);
			  $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "guestid", tguestid);
			  
	 
			  
			  document.getElementById("hidtguestid").value="";
			  document.getElementById("tguest").value="";
			  document.getElementById("hidtguestcontactno").value="";
			  document.getElementById("tdescription").value="";

			  document.getElementById("hidplocid").value="";
			  document.getElementById("pdate").value="";
			  document.getElementById("ptime").value=""; 
			  document.getElementById("pckaddress").value="";
			  document.getElementById("hiddofflocationid").value="";
			  document.getElementById("Doffaddress").value=""; 
			  document.getElementById("hidtbrandid").value="";
			  document.getElementById("hidtgroupid").value="";
			  document.getElementById("hidtmodelid").value="";
			  document.getElementById("cmbttriptype").value="";
			  document.getElementById("nos").value="";
			  document.getElementById("pax").value="";
			  document.getElementById("ttype").value="";
			  document.getElementById("edistance").value="";
			  document.getElementById("etime").value="";
			  document.getElementById("tariff").value="";
			  document.getElementById("allowance").value="";
			  document.getElementById("exdistancerate").value="";
			  document.getElementById("exdistancetime").value="";
			  document.getElementById("otherservice").value="";
			  document.getElementById("tdocno").value="";
			  document.getElementById("hidtariffdocno").value="";
			  document.getElementById("plocation").value="";
			  document.getElementById("Dofflocation").value="";
			  document.getElementById("brand").value="";
			  document.getElementById("tmodel").value="";
			  document.getElementById("tgroup").value="";
	 
			  $("#transferGrid").jqxGrid('addrow', null, {});  
		     document.getElementById("pdate").focus();
		 }
	 
	 function limosetgrid()  {
	 		var rows = $("#hoursGrid").jqxGrid('getrows');
	        var rowlength = rows.length;

	        var llocid = document.getElementById("hidlpcklocationid").value;
	        var location = document.getElementById("hidlpcklocation").value;
	      		    var lbhours = document.getElementById("bhours").value;
	      		    var lpckdate = $('#pckdate').jqxDateTimeInput('getDate');
	      		    var ltime = document.getElementById("ltime").value;
	      		    var lpckaddress = document.getElementById("lpckaddress").value;
	      		    var lbrandid = document.getElementById("hidlbrandid").value;
	      		    var lgroupid = document.getElementById("hidlgroup").value;
	      		    var lgid = document.getElementById("hidlgroupid").value;
	      		    var lmodelid = document.getElementById("hidlmodelid").value;
	      		    var lldayses = document.getElementById("ldays").value;
	      		    var lgnos = document.getElementById("lnos").value;
	      		    var lgtype = document.getElementById("ltype").value; 
	      		    
	      			var lgexhourrate = document.getElementById("lexhourrate").value;
	      		    var lglntariff = document.getElementById("lntariff").value;
	      		    var lglnexhourrate = document.getElementById("lnexhourrate").value;
	      		    var lgloservice = document.getElementById("loservice").checked;
	      		    var tariffdocno = document.getElementById("hidltariffdocno").value;
	      			
	      			var brand = document.getElementById("hidlbrand").value;
	      			var model = document.getElementById("hidlmodel").value;
	      			var ltdocno = document.getElementById("ltdocno").value;
	      			var ltariff = document.getElementById("ltariff").value;
	      			var lallowance = document.getElementById("lallowance").value;
	      			var lguestid = document.getElementById("hidlguestid").value;
	    		    var lguestname = document.getElementById("lguest").value;
	    		    var lguestcontact = document.getElementById("hidlguestcontactno").value;
	    		    var ldescription = document.getElementById("ldescription").value;
	      			//var lotherservice = document.getElementById("loservice").value;
	      			
			if(llocid=="" || llocid==null || typeof(llocid)=="undefined"|| typeof(llocid)=="NaN"){
				document.getElementById("errormsg").innerText="Pick up location is mandatory";
				return false;
			}
			
			if(lpckaddress=="" || lpckaddress==null || typeof(lpckaddress)=="undefined"|| typeof(lpckaddress)=="NaN"){
				document.getElementById("errormsg").innerText="Pickup Address is mandatory";
				return false;
			}else{
				document.getElementById("errormsg").innerText="";
			}
			
			
			if(isGroupBased){
				if(lgid=="" || lgid==null || typeof(lgid)=="undefined"|| typeof(lgid)=="NaN"){
					document.getElementById("errormsg").innerText="Group is mandatory";
					return false;
				}else{
					document.getElementById("errormsg").innerText="";
				}
				
			} else {
				if(lbrandid=="" || lbrandid==null || typeof(lbrandid)=="undefined"|| typeof(lbrandid)=="NaN"){
					document.getElementById("errormsg").innerText="Brand is mandatory";
					return false;
				}else{
					document.getElementById("errormsg").innerText="";
				}
				
				if(lmodelid=="" || lmodelid==null || typeof(lmodelid)=="undefined"|| typeof(lmodelid)=="NaN"){
					document.getElementById("errormsg").innerText="Model is mandatory";
					return false;
				}else{
					document.getElementById("errormsg").innerText="";
				}
			}
			
			
			
			
			
			if(lgtype=="" || lgtype==null || typeof(lgtype)=="undefined"|| typeof(lgtype)=="NaN"){
				document.getElementById("errormsg").innerText="Type is mandatory";
				return false;
			}else{
				document.getElementById("errormsg").innerText="";
			}
			
			if((ltdocno=="" || ltdocno==null || typeof(ltdocno)=="undefined"|| typeof(ltdocno)=="NaN")  && isTariffHidden==false){
				document.getElementById("errormsg").innerText="Tariff Doc No is mandatory";
				return false;
			} 

			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "pickuplocation", location);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "pickuplocationid", llocid);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "blockhrs",lbhours);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "pickupdate",lpckdate);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "pickuptime",ltime);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "pickupaddress",lpckaddress);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "brand", brand);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "brandid", lbrandid);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "groupid", lgroupid);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "gid", lgid);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "model", model);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "modelid", lmodelid);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "days", lldayses);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "nos", lgnos);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "transfertype", lgtype);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "tarifdocno", ltdocno);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "tarif", ltariff); 
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "allowance", lallowance); 
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "exhrrate", lgexhourrate);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "nighttarif", lglntariff);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "nightexhrrate", lglnexhourrate);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "chkothersrvc", lgloservice);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "tarifdetaildocno", tariffdocno);
			//  alert(lguestid);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "guestname", lguestname);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "guestcontact", lguestcontact);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "description", ldescription);
			  $('#hoursGrid').jqxGrid('setcellvalue',  rowlength-1, "guestid", lguestid);
			  
			  
			  document.getElementById("hidlguestid").value="";
			  document.getElementById("lguest").value="";
			  document.getElementById("hidlguestcontactno").value="";
			  document.getElementById("ldescription").value="";
			  
	 
			  document.getElementById("hidlpcklocationid").value="";
			  document.getElementById("hidlpcklocation").value="";
			  document.getElementById("bhours").value="";
			  document.getElementById("pckdate").value="";
			  document.getElementById("ltime").value="";
			  document.getElementById("lpckaddress").value="";
			  document.getElementById("hidlbrandid").value="";
			  document.getElementById("hidlmodelid").value="";
			  document.getElementById("ldays").value="";
			  document.getElementById("lnos").value="";
			  document.getElementById("ltype").value=""; 
			  document.getElementById("lexhourrate").value="";
			  document.getElementById("lntariff").value="";
			  document.getElementById("lnexhourrate").value="";
			  document.getElementById("loservice").value="";
			  document.getElementById("hidltariffdocno").value="";
			  document.getElementById("hidlbrand").value="";
			  document.getElementById("hidlmodel").value="";
			  document.getElementById("ltdocno").value="";
			  document.getElementById("ltariff").value="";
			  document.getElementById("lallowance").value="";
			  document.getElementById("pcklocation").value="";
			  document.getElementById("lbrand").value="";
			  document.getElementById("lgroup").value="";
			  document.getElementById("hidlgroup").value="";
			  document.getElementById("hidlgroupid").value="";
			  document.getElementById("lmodel").value="";
	 
			  $("#hoursGrid").jqxGrid('addrow', null, {});  
		      document.getElementById("pckdate").focus();
		 }
	 
	 function getTariffDetails(){
		 if(document.getElementById("mode").value=="view"){
				return false;
			}
		 	let date =  $('#date').val();
			var clientid = document.getElementById("hidclient").value;
			if(clientid=="" || clientid=="undefined" || clientid==null || typeof(clientid)=="undefined"){
				document.getElementById("errormsg").innerText="Client is mandatory";
				return false;
				}else{
			   		document.getElementById("errormsg").innerText="";
			 }
			
			$('#tarifdetailwindow').jqxWindow('open');
			$('#tarifdetailwindow').jqxWindow('focus');
			tarifSearchdetailContent('tariffsearchgridwin.jsp?date='+date+'&gridname=transferGrid&client='+clientid, $('#tarifdetailwindow'));
	 }
	 
	 function addGuestInGrid(){
		 let newRow = {doc_no: $('#hidguest').val(), guest:$('#guest').val(), guestcontactno:$('#guestcontactno').val()}
		 $("#guestgrid").jqxGrid("addrow", null, newRow);
		 $('#hidguest').val('');
		 $('#guest').val('');
		 $('#guestcontactno').val('');
	 }
	 
	 function guestViewGridconfig(){
		 var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					 var data = JSON.parse(x.responseText);
					 if((data==1)){
					 } else {
						 $(".guestgridconfig").css("display", "none");
						// $(".guestgridconfig").css("display", "none");
					 }
					 
				} else {
				}
			}
			x.open("GET",'getguestviewconfig.jsp', true);
			x.send();
	 }
	 
	 function getTariffDetailsl(){
		 if(document.getElementById("mode").value=="view"){
				return false;
			}
		 	let date =  $('#date').val();
			var clientid = document.getElementById("hidclient").value;
			if(clientid=="" || clientid=="undefined" || clientid==null || typeof(clientid)=="undefined"){
				document.getElementById("errormsg").innerText="Client is mandatory";
				return false;
				}else{
			   		document.getElementById("errormsg").innerText="";
			 }
			var blockhours = document.getElementById("bhours").value;
			$('#tarifdetailwindow').jqxWindow('open');
			$('#tarifdetailwindow').jqxWindow('focus');
			tarifSearchdetailContent('tariffsearchgridwin.jsp?date='+date+'&gridname=hoursGrid&blockhrs='+blockhours+'&client='+clientid, $('#tarifdetailwindow'));
	 }
</script>
</head>	
<body onLoad="getTariffButtonConfig();getGroupConfig();getTariffConfig();setValues();guestViewGridconfig();">
   <br/> 
   <div id="mainBG" class="homeContent" data-type="background">
   <form id="frmLimoBooking" action="saveLimoBooking" method="post" autocomplete="off">
      <jsp:include page="../../../header.jsp" />
      <br>
      <div class='hidden-scrollbar'>
         <table width="100%" border="0">
            <tr>
               <td width="13%" align="right">Date</td>
               <td width="16%">
                  <div id="date" name="date" value='<s:property value="date" />'></div>
               </td>
               <td width="15%" align="right">Ref No</td>
               <td width="11%"><input type="text" name="refno" id="refno" value='<s:property value="refno"/>'></td>
               
               <td width="23%">&nbsp;</td>
               <td width="8%" align="right">Doc No</td>
               <td width="14%">
                  <input type="hidden" name="docno" id="docno" value='<s:property value="docno" />'>
                  <input type="text" name="vocno" id="vocno" value='<s:property value="vocno" />'>
               </td>
            </tr>
            <tr>
               <td align="right">Client</td>
               <td><input type="text" name="client" id="client" value='<s:property value="client" />' style="width:99%;" readonly placeholder="Press F3 to Search" onkeydown="getClient(event);"></td>
               <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient" />'>
               <td colspan="2"><input type="text" name="clientdetails" id="clientdetails" value='<s:property value="clientdetails" />' style="width:94%;"></td>
              	<td>
               	<span id="vesselnolabel">V. No.</span>
        		<input type="text" name="vesselno" id="vesselno" value='<s:property value="vesselno" />'>
        		</td>
        		<td colspan="2">
        		<span id="vesselnamelabel">V. Name</span>
               	<input type="text" style="width:60%;" name="vesselname" id="vesselname" value='<s:property value="vesselname" />'>
               </td>
            </tr>
            <tr>
               <td align="right" rowspan="1"><label for="chknewguest">New Guest</label><input type="checkbox" name="chknewguest" id="chknewguest" onChange="setNewGuest();">&nbsp;&nbsp;&nbsp;&nbsp;Guest</td>
               <input type="hidden" name="hidchknewguest" id="hidchknewguest" value='<s:property value="hidchknewguest" />'>
               <td  rowspan="1"><input type="text" name="guest" id="guest" value='<s:property value="guest" />' style="width:100%;" ></td>
               <input type="hidden" name="hidguest" id="hidguest" value='<s:property value="hidguest" />'>
               <td align="right" rowspan="1"><span> Contact No</span>
               	<input type="text" name="guestcontactno" id="guestcontactno" value='<s:property value="guestcontactno" />'> 
               	</td>
               <td rowspan="1" class="guestgridconfig"><input type="button" id="gadd" onclick="addGuestInGrid()" value="Add Guest"></td>
                <td colspan="2" rowspan="3" class="guestgridconfig">
               <fieldset>
                     <legend>Guest Details</legend>
                     <div id="guestdetdiv">
                        <jsp:include page="guestgrid.jsp"></jsp:include>
                     </div>
                  </fieldset>
               </td>
               <td>&nbsp;</td>
               <td colspan="2" align="center">
               	  <button type="button"  id="btnBookClone" title="Booking Clone" style="border:none;background:none;" onclick="funBookClone();" class="bookingbuttons">
                  <img alt="Booking Clone" src="<%=contextPath%>/icons/clone.png" width="30" height="30">
                  </button>
                  <button type="button"  id="btnBookEdit" title="Booking Edit" style="border:none;background:none;" onclick="funBookEdit();" class="bookingbuttons">
                  <img alt="Booking Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
                  </button>
                  <button type="button" id="btnBookCancel" title="Booking Cancel"  style="border:none;background:none;" onclick="funBookCancel();" class="bookingbuttons">
                  <img alt="Book Cancel" src="<%=contextPath%>/icons/tarifcancel.png" width="30" height="30">
                  </button>
                  <button type="button" id="btnBookSave" title="Booking Save"  style="border:none;background:none;" onclick="funBookSave();" class="bookingbuttons">
                  <img alt="Book Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
                  </button>
               </td>
            </tr>
            <tr>
               <td align="right">Description</td>
               <td colspan="2"><input type="text" name="description" id="description" value='<s:property value="description" />' style="width:99%;"></td>
            </tr>
            <tr>
               <td align="right" width="10%">Location Type</td>
               <td>
                  <select id="cmbloctype" name="cmbloctype"  value='<s:property value="cmbloctype"/>' onchange="funloctype();">
                     <option value="">---select---</option>
                     <option value="flight">Flight</option>
                     <option value="hotel">Hotel</option>
                  </select>
               </td>
               <td colspan="2">Airport Name<input type="text" id="txtairport"  name="txtairport" style="width:40%;"   value='<s:property value="txtairport"/>' placeholder="Airport Name"  >
                  Flightno<input type="text" id="txtflightno"  name="txtflightno"   value='<s:property  value="txtflightno"/>' placeholder="Flight No" >
               </td>
            </tr>
            <tr>
               <td></td>
               <td></td>
               <td colspan="2">&nbsp;&nbsp;Hotel Name<input type="text" id="txthotelname"  name="txthotelname" style="width:40%;"    value='<s:property  value="txthotelname"/>' placeholder="Hotel Name" >
                  Roomno<input type="text" id="txtroomno"  name="txtroomno"   value='<s:property value="txtroomno"/>'  placeholder="Room No" >
               </td>
            </tr>
         </table>
         <fieldset id="psearch">
            <legend>Transfer Details</legend>
            <table width="100% " >
               <tr>
                  <td align="center">Pickup date</td>
                  <td align="center">Pickup Time</td>
                  <td align="center" class="hidebutton"></td>
                  <td align="center">Pickup location</td>
                  <td align="center">Pickup Address</td>
                  <td width="6%" align="center">Dropoff Location</td>
                  <td align="center" class="ff" id="focid">Dropoff Address</td>
                  <td align="center" class="hidegroupbased">Brand</td>
                  <td align="center"class="hidegroupbased">Model</td>
                  <td align="center" class="showgroupbased">Group</td>
                  <td align="center">Nos</td>
                  <td align="center">Pax</td>
               </tr>
               <tr>
                  <td width="16%" align="center">
                     <div id="pdate"></div>
                  </td>
                  <td align="center" width="15%" >
                     <div id="ptime"></div>
                  </td>
                  <td class="hidebutton"><input type="button" id="settariffbtn" class="btn hidebutton"
                        onclick="getTariffDetails();" value="TARIFF"></td>
                  <td align="center" class="text-alignment">
                     <input type="text"  id="plocation" list="plocationid" >
                     <datalist id="plocationid" style="visibility:none;"></datalist>
                  </td>
                  <td align="center" class="text-alignment"><input type="text" id="pckaddress" name="pckaddress" value='<s:property value="pckaddress"/>'></td>
                  <td align="center" class="text-alignment">
                     <input type="text" id="Dofflocation"
                        list="Dofflocationid">
                     <datalist id="Dofflocationid" style="visibility:none;"></datalist>
                  </td>
                  <td align="center" class="text-alignment"><input type="text" id="Doffaddress"
                     value='<s:property value="Doffaddress"/>'></td>
                  <td align="center" class="text-alignment hidegroupbased">
                     <input type="text" id="brand"
                        list="tbrandid">
                     <datalist id="tbrandid" style="visibility:none;"></datalist>
                  </td>
                  <td align="center" class="text-alignment hidegroupbased">
                     <input type="text" id="tmodel"
                        list="tmodelid">
                     <datalist id="tmodelid" style="visibility:none;"></datalist>
                  </td>
                  <td align="center" class="text-alignment showgroupbased">
                     <input type="text" id="tgroup"
                        list="tgroupid">
                     <datalist id="tgroupid" style="visibility:none;"></datalist>
                  </td>
                  <td align="center"><input type="text" id="nos"
                     style="text-align: right;"  value='<s:property value="nos"/>'></td>
                  <td align="center" class="text-alignment"><input type="text" id="pax"
                     value='<s:property value="pax"/>'></td>
               </tr>
               <tr>
                  <td align="center">Type</td>
                  <td align="center">Trip Type</td>
                  <td align="center" class="hidefortariff">Tariff Doc No</td>
                  <td align="center" class="hidefortariff">Est.Distance</td>
                  <td align="center" class="hidefortariff">Est.Time</td>
                  <td align="center" id="batchid" class="hidefortariff">
                     <div id="batchdiv" >Tariff</div>
                  </td>
                  <td align="center" id="batchid" class="hidefortariff">
                     <div id="batchdiv" >Allowance</div>
                  </td>
                  <td align="center" id="expdateid" class="hidefortariff">
                     <div id="expdatediv">Ex.Distance rate</div>
                  </td>
                  <td align="center" id="expdateid" class="hidefortariff">
                     <div id="expdatediv">Ex.time rate</div>
                  </td>
                   <td align="center" id="guestid" >
                     <div id="guestdiv">Guest</div>
                  </td>
                   <td align="center" id="descid" >
                     <div id="descdiv">Description</div>
                  </td>
                  <td align="center" id="expdateid">
                     <div id="expdatediv">Other Service</div>
                  </td>
                  <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
               </tr>
               <tr>
                  <td width="16%"  style="text-align: center;">
                     <select id="ttype" onchange=" getTariffDocnoTransfer();">
                        <option value="">-- select --</option>
                        <option value="Private">Private</option>
                        <option value="Sharing">Sharing</option>
                     </select>
                  </td>
                  <td align="center">
                     <select id="cmbttriptype" name="cmbttriptype">
                        <option value="">-- select --</option>
                     </select>
                  </td>
                  <td align="center" class="text-alignment hidefortariff"><input type="text" id="tdocno"
                     list="tdocnoid"/><datalist id="tdocnoid" style="visibility:none;"></datalist></td>
                  <%-- <td align="center" class="text-alignment"><input type="text" id="tdocno"
                     value='<s:property value="tdocno"/>'></td> --%>
                  <td align="center"  class="hidefortariff"><input type="text" id="edistance"
                     value='<s:property value="edistance"/>'   style="text-align: right;" ></td>
                  <td align="center" class="hidefortariff" >
                     <div id="etime" contenteditable="false"></div>
                  </td>
                  <td align="center" class="hidefortariff"  ><input type="text" id="tariff"
                     value='<s:property value="tariff"/>'  style="text-align: right;" ></td>
                  <td align="center" class="hidefortariff"  ><input type="text" id="allowance"
                     value='<s:property value="allowance"/>'  style="text-align: right;" ></td>
                  <td align="center" class="hidefortariff" ><input type="text" id="exdistancerate"
                     value='<s:property value="exdistancerate"/>'   style="text-align: right;" ></td>
                  <td align="center" class="hidefortariff"><input type="text" id="exdistancetime"
                     value='<s:property value="exdistancetime"/>'  style="text-align: right;" ></td>
                  <td align="center" class="text-alignment ">
                     <input type="text" id="tguest"
                        list="tguestid">
                     <datalist id="tguestid" style="visibility:none;"></datalist>
                  </td>
                  <td align="center" class="text-alignment ">
                     <input type="text" id="tdescription">
                  </td>
                  <td align="center"><input type="checkbox" id="otherservice"
                     value='<s:property value="otherservice"/>'></td>
                  <td align="center"><input type="hidden" id="cleardata">
                     &nbsp; <input type="button" id="setbtn" class="btn"
                        onclick="isTariffHidden?setTariffTransfer():setTransferGrid();" value="ADD">
                  </td>
               </tr>
            </table>
         </fieldset>
         <table width="100%">
            <tr>
               <td colspan="2">
                  <fieldset>
                     <legend>Transfer Details</legend>
                     <div id="transferdiv">
                        <jsp:include page="transferGrid.jsp"></jsp:include>
                     </div>
                  </fieldset>
               </td>
            </tr>
         </table>
         <table width="100%">
            <tr>
               <td colspan="2">
                  <fieldset id="psearch">
                     <legend>Limo Details</legend>
                     <table width="100% ">
                        <tr>
                           <td align="center">Block Hours</td>
                           <td align="center">Pickup Date</td>
                           <td align="center">Pickup Time</td>
                           <td align="center" class="hidebutton"></td>
                           <td width="6%" align="center">Pickup Location</td>
                           <td align="center" class="ff" id="focid">Pickup  Address</td>
                           <td align="center" class="hidegroupbased">Brand</td>
                           <td align="center" class="hidegroupbased">Model</td>
                           <td align="center" class="showgroupbased">Group</td>
                           <td align="center">Days</td>
                        </tr>
                        <tr>
                           <td  style="text-align: center;"><input type="text" id="bhours"
                              value='<s:property value="bhours"/>'></td>
                           <td  align="center">
                              <div id="pckdate" name="pckdate" value='<s:property value="pckdate" />'></div>
                           </td>
                           <td align="center" width="10% ">
                              <div id="ltime" name="ltime"></div>
                           </td>
                            <td class="hidebutton"><input type="button" id="settariffbtnl" class="btn hidebutton"
                        	onclick="getTariffDetailsl();" value="TARIFF"></td>
                           <td align="center" class="text-alignment"><input type="text" id="pcklocation"
                              list="lpcklocationid"><datalist id="lpcklocationid" style="visibility:none;"></datalist></td>
                           <td align="center"><input type="text" id="lpckaddress"
                              value='<s:property value="lpckaddress"/>'></td>
                           <td align="center" class="hidegroupbased" ><input type="text" id="lbrand"
                              list="lbrandid"><datalist id="lbrandid" style="visibility:none;"></datalist></td>
                           <td align="center" class="hidegroupbased" ><input type="text" id="lmodel"
                              list="lmodelid"><datalist id="lmodelid" style="visibility:none;"></datalist></td>
                           <td align="center" class="showgroupbased"><input type="text" id="lgroup"
                              list="lgroupid"><datalist id="lgroupid" style="visibility:none;"></datalist></td>
                           <td align="center" ><input type="text" id="ldays"
                              value='<s:property value="ldays"/>'></td>
                        </tr>
                        <tr>
                        <td align="center">Nos</td>
                        <td align="center">Type</td>
                        <td align="center"  class="hidefortariff">Tariff Doc NO</td>
                        <td align="center"  class="hidefortariff">Tariff</td>
                        <td align="center"  class="hidefortariff">Allowance</td>
                        <td align="center"  class="hidefortariff">Ex.Hour Rate</td>
                        <td align="center" id="batchid"  class="hidefortariff"><div id="batchdiv">Night Tariff</div></td>
                        <td align="center" id="expdateid"  class="hidefortariff"><div id="expdatediv">Night EX.Hour Rate</div></td>
                        <td align="center" id="guestid" >
                     		<div id="lguestdiv">Guest</div>
                  		</td>
                   		<td align="center" id="descid" >
                     		<div id="ldescdiv">Description</div>
                  		</td>
                        <td align="center" id="expdateid" ><div id="expdatediv">Other Service</div></td>
                        <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                        <td align="center"><input type="text" id="lnos"
                           style="text-align: right;" value='<s:property value="lnos"/>'></td>
                        <td align="center" style="text-align: center;"><select id="ltype"  onchange=" getTariffDocnoLimo();">  
                        <option value="">-- select --</option>
                        <option value="Private">Private</option>
                        <option value="Sharing">Sharing</option>
                        </select></td>
                        <td  class="hidefortariff" align="center" class="text-alignment"><input type="text" id="ltdocno"
                           list="ltdocnoid"/><datalist id="ltdocnoid" style="visibility:none;"></datalist></td>
                        <%-- <td align="center" class="text-alignment"><input type="text" id="ltdocno"
                           value='<s:property value="ltdocno"/>'></td> --%>
                        <td  class="hidefortariff" align="center"  ><input type="text" id="ltariff"
                           value='<s:property value="ltariff"/>'  style="text-align: right;" ></td>
                         <td  class="hidefortariff" align="center"  ><input type="text" id="lallowance"
                           value='<s:property value="lallowance"/>'  style="text-align: right;" ></td>
                        <td  class="hidefortariff" align="center" ><input type="text" id="lexhourrate"
                           value='<s:property value="lexhourrate"/>'  style="text-align: right;" ></td>
                        <td  class="hidefortariff" align="center"  ><input type="text" id="lntariff"
                           value='<s:property value="lntariff"/>'  style="text-align: right;" ></td>
                        <td  class="hidefortariff" align="center" ><input type="text" id="lnexhourrate"
                           value='<s:property value="lnexhourrate"/>'  style="text-align: right;" ></td>
                        <td align="center" class="text-alignment ">
                     		<input type="text" id="lguest"
                        	list="lguestid">
                     		<datalist id="lguestid" style="visibility:none;"></datalist>
                  		</td>
                  		<td align="center" class="text-alignment ">
                     		<input type="text" id="ldescription">
                  		</td>
                        <td align="center"><input type="checkbox" id="loservice"
                           value='<s:property value="loservice"/>'></td>   
                        <td align="center"><input type="hidden" id="cleardata">
                        &nbsp; <input type="button" id="limosetbtn" class="btn"
                           onclick="isTariffHidden?setTariffHour():limosetgrid()" value="ADD"></td>  
                        </tr>
                     </table>
                  </fieldset>
               </td>
            </tr>
            <tr>
            <td colspan="2"><fieldset><legend>Limo Details</legend><div id="hoursdiv"><jsp:include page="hoursGrid.jsp"></jsp:include></div></fieldset></td>
            </tr>
            <tr>
            <td colspan="2"><fieldset><legend>Other Services  <button type="button" id="btnSrvcReload" title="Booking Save"  style="border:none;background:none;" onclick="funSrvcReload();" class="srvcbuttons">
            <img alt="Other Srvc Reload" src="<%=contextPath%>/icons/btnbookreload.png" width="30" height="30">
            </button>
            <button type="button"  id="btnSrvcEdit" title="Other Srvc Edit" style="border:none;background:none;" onclick="funSrvcEdit();" class="srvcbuttons">
            <img alt="Other Srvc Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
            </button>
            <button type="button" id="btnSrvcCancel" title="Other Srvc Cancel"  style="border:none;background:none;" onclick="funSrvcCancel();" class="srvcbuttons">
            <img alt="Other Srvc Cancel" src="<%=contextPath%>/icons/tarifcancel.png" width="30" height="30">
            </button>
            <button type="button" id="btnSrvcSave" title="Other Srvc Save"  style="border:none;background:none;" onclick="funSrvcSave();" class="srvcbuttons">
            <img alt="Other Srvc Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
            </button>
            </legend><div id="othersrvcdiv"><jsp:include page="otherSrvcGrid.jsp"></jsp:include></div></fieldset></td>
            </tr>
            <tr>
            <td width="50%"><fieldset><legend>Billing Details</legend><div id="billingdiv"><jsp:include page="billingGrid.jsp"></jsp:include></div></fieldset></td>
            <td width="50%">&nbsp;</td>
            </tr> 
         </table>
         <input type="hidden" id="hidtdocno" name="hidtdocno" value='<s:property value="hidtdocno"/>'/>
         <input type="hidden" id="hidtdocnoid" name="hidtdocnoid" value='<s:property value="hidtdocnoid"/>'/>
         <input type="hidden" id="hidldocno" name="hidldocno" value='<s:property value="hidldocno"/>'/>
         <input type="hidden" id="hidldocnoid" name="hidldocnoid" value='<s:property value="hidldocnoid"/>'/>
         <input type="hidden" id="hidltariffdocno" name="hidltariffdocno" value='<s:property value="hidltariffdocno"/>'/>
         <input type="hidden" id="hidlgid" name="hidlgid" value='<s:property value="hidlgid"/>'/>
         <input type="hidden" id="hidtariffdocno" name="hidtariffdocno" value='<s:property value="hidtariffdocno"/>'/>
         <input type="hidden" id="hidgid" name="hidgid" value='<s:property value="hidgid"/>'/>
         <input type="hidden" id="hiderrorstatus" name="hiderrorstatus" value='<s:property value="hiderrorstatus"/>'/>
         <input type="hidden" id="hidlmodel" name="hidlmodel" value='<s:property value="hidlmodel"/>'/>
         <input type="hidden" id="hidlmodelid" name="hidlmodelid" value='<s:property value="hidlmodelid"/>'/>
         <input type="hidden" id="hidlbrand" name="hidlbrand" value='<s:property value="hidlbrand"/>'/>
         <input type="hidden" id="hidlbrandid" name="hidlbrandid" value='<s:property value="hidlbrandid"/>'/>
         <input type="hidden" id="hidlpcklocation" name="hidlpcklocation" value='<s:property value="hidlpcklocation"/>'/>
         <input type="hidden" id="hidlpcklocationid" name="hidlpcklocationid" value='<s:property value="hidlpcklocationid"/>'/>
         <input type="hidden" id="hidtmodel" name="hidtmodel" value='<s:property value="hidtmodel"/>'/>
         <input type="hidden" id="hidtmodelid" name="hidtmodelid" value='<s:property value="hidtmodelid"/>'/>
         <input type="hidden" id="hidtbrand" name="hidtbrand" value='<s:property value="hidtbrand"/>'/>
         <input type="hidden" id="hidtgroup" name="hidtgroup" value='<s:property value="hidtgroup"/>'/>
         <input type="hidden" id="hidtgroupid" name="hidtgroupid" value='<s:property value="hidtgroupid"/>'/>
         <input type="hidden" id="hidtguestid" name="hidtguestid" value='<s:property value="hidtguestid"/>'/>
         <input type="hidden" id="hidtguest" name="hidtguest" value='<s:property value="hidtguest"/>'/>
         <input type="hidden" id="hidtguestcontactno" name="hidtguestcontactno" value='<s:property value="hidtguestcontactno"/>'/>
         <input type="hidden" id="hidlguestid" name="hidlguestid" value='<s:property value="hidlguestid"/>'/>
         <input type="hidden" id="hidlguest" name="hidlguest" value='<s:property value="hidlguest"/>'/>
         <input type="hidden" id="hidlguestcontactno" name="hidlguestcontactno" value='<s:property value="hidlguestcontactno"/>'/>
         <input type="hidden" id="hidlgroup" name="hidlgroup" value='<s:property value="hidlgroup"/>'/>
         <input type="hidden" id="hidlgroupid" name="hidlgroupid" value='<s:property value="hidlgroupid"/>'/>
         <input type="hidden" id="hidtbrandid" name="hidtbrandid" value='<s:property value="hidtbrandid"/>'/>
         <input type="hidden" id="hiddofflocation" name="hiddofflocation" value='<s:property value="hiddofflocation"/>'/>
         <input type="hidden" id="hiddofflocationid" name="hiddofflocationid" value='<s:property value="hiddofflocationid"/>'/>
         <input type="hidden" id="hidplocid" name="hidplocid" value='<s:property value="hidplocid"/>'/>
         <input type="hidden" id="hidplocation" name="hidplocation" value='<s:property value="hidplocation"/>'/>
         <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
         <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
         <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
         <input type="hidden" name="transfergridlength" id="transfergridlength" value='<s:property value="transfergridlength"/>'/>
         <input type="hidden" name="hoursgridlength" id="hoursgridlength" value='<s:property value="hoursgridlength"/>'/>
         <input type="hidden" name="guestgridlength" id="guestgridlength" value='<s:property value="guestgridlength"/>'/>
         <input type="hidden" name="othersrvcgridlength" id="othersrvcgridlength" value='<s:property value="othersrvcgridlength"/>'/>
         <input type="hidden" name="billinggridlength" id="billinggridlength" value='<s:property value="billinggridlength"/>'/>
         <input type="hidden" name="savestatus" id="savestatus" value='<s:property value="savestatus"/>'/>
         <input type="hidden" name="cmbloc" id="cmbloc" value='<s:property value="cmbloc"/>'/>
         <div id="locationwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
         <div id="srvctarifwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
         <div id="airportwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
         <div id="clientwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
         <div id="guestwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
         <div id="modelwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
         <div id="brandwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
          <div id="groupwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
         <div id="tarifwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
          <div id="tarifdetailwindow">
         <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
         </div>
         </div>
   </form>
   </div>
</body>
</html>