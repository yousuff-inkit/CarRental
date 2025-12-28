<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="tab.css" />
<jsp:include page="tab.jsp" />
<script type="text/javascript">
	
	$(document).ready(function() {
document.getElementById("lbllastsrvkm").style.display="none";			//Hiding Last Service Km Label
		document.getElementById("last_srvc_km").style.display="none";			//Hiding Last Service Km
	document.getElementById("fleetwarning").style.display="none";
		document.getElementById("releasesave").style.display="none";
		$("#releasefleet").attr("disabled", true); 
		$("#cmbrlsbranch").attr("disabled", true); 
		$("#cmbrlsloc").attr("disabled", true); 
		$("#cmbrentalstatus").attr("disabled", true); 
		//$('#releasedate').jqxDateTimeInput({ disabled: true}); 
			 $("#releasetime").jqxDateTimeInput({ width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });

  	  $("#jqxDate1").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  

		$("#jqxPurchaseDate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxFinRegDate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxFinRelDate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxOtherRegExp").jqxDateTimeInput({	width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxOtherInsExp").jqxDateTimeInput({	width : '125px',height : '15px',formatString : "dd.MM.yyyy"	,value:null});
		$("#jqxWrntyFrmDate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxWrntyToDate").jqxDateTimeInput({width : '125px',	height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxLstSrvcDate").jqxDateTimeInput({	width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#releasedate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		
		//$('#jqxFinRelDate').jqxDateTimeInput('hideCalendar'); 
		   $('#dealerWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#dealerWindow').jqxWindow('close');
		   $('#financierWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#financierWindow').jqxWindow('close');
		   $('#insuranceWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#insuranceWindow').jqxWindow('close');
		   $('#specwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#specwindow').jqxWindow('close'); 
		   $('#tcnowindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'TC No Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#tcnowindow').jqxWindow('close');
		   
		   if(document.getElementById("mode").value=="A"){
			   changeDate();   
		   }
		   
		   $('#jqxFinRegDate').on('change', function (event) 
			   		 {  
			   		   
			   		     changeDate();
			   		 });
		   $('#jqxPurchaseDate').on('change', function (event) 
			   		 {  
			   		    var purdate= $('#jqxPurchaseDate').jqxDateTimeInput('getDate');
			   		 $('#jqxWrntyFrmDate ').jqxDateTimeInput('setDate', new Date(purdate));
			   		 });
		 /*   $('#jqxWrntyToDate').on('change', function (event) 
			   		 {  
			   		
			   			 var fromdate= new Date($('#jqxWrntyFrmDate ').jqxDateTimeInput('getDate')).getMonth();
			   			 var todate= new Date($('#jqxWrntyToDate ').jqxDateTimeInput('getDate')).getMonth();
			   		 var diff=todate-fromdate;
			   		 var diff1=$('#jqxWrntyToDate ').jqxDateTimeInput('getDate')-$('#jqxWrntyFrmDate ').jqxDateTimeInput('getDate');
			   		alert(diff1);
			   		 if(new Date($('#jqxWrntyToDate ').jqxDateTimeInput('getDate'))<new Date($('#jqxWrntyFrmDate ').jqxDateTimeInput('getDate'))){
			   			 document.getElementById("errormsg").innerText="To Date cannot be Less than From Date";
			   			// document.getElementById("warranty_period").value="";
			   			 return false;
			   		 }
			   		 document.getElementById("errormsg").innerText="";
			   		 document.getElementById("warranty_period").value=diff;x`
			   		 
			   		 }); */
		  //getAuth();
			 getTestPlateCode();

		    getTestModel();
		   
		   getTestLocation(); 

		    $('#mortgaged').dblclick(function(){
				
			    $('#financierWindow').jqxWindow('open');
			$('#financierWindow').jqxWindow('focus');
			financierSearchContent('mortgagedGrid.jsp?', $('#financierWindow'));
				 
				 });
		    
			$('#tcno').dblclick(function(){
				$('#tcnowindow').jqxWindow('open');
				$('#tcnowindow').jqxWindow('focus');
				tcnoSearchContent('tcnoSearchGrid.jsp?id=1');
			});
				 
	});
	
	function getTcno(event){
    	var x= event.keyCode;
        if(x==114){
        	$('#tcnowindow').jqxWindow('open');
			$('#tcnowindow').jqxWindow('focus');
			tcnoSearchContent('tcnoSearchGrid.jsp?id=1');
        }
	}
	
	function tcnoSearchContent(url) {
		$.get(url).done(function (data) {
			$('#tcnowindow').jqxWindow('setContent', data);
		}); 
	}
	
	function getMortgaged(event){
       	
        var x= event.keyCode;
        if(x==114){
      	 //alert("here");
       	/*  var url=document.URL;
		     var reurl=url.split("com/"); */
		     financierSearchContent('mortgagedGrid.jsp');
        }
        else{
         }
        }
	  
	function changeDate(){
		  var finregdate= $('#jqxFinRegDate').jqxDateTimeInput('getDate');
 		     var finaldate=new Date(new Date(finregdate).setMonth(finregdate.getMonth()+12));
 		     var finaldate2=new Date(new Date(finaldate).setDate(finaldate.getDate()-1));
 		     $('#jqxOtherRegExp ').jqxDateTimeInput('setDate', new Date(finaldate2));
 		     var insexp1=new Date(new Date(new Date(finregdate).setMonth(finregdate.getMonth()+13)));
 		     var insexp2=new Date(new Date(insexp1).setDate(insexp1.getDate()-1));
 		    $('#jqxOtherInsExp ').jqxDateTimeInput('setDate', new Date(insexp2));
	  }
	 function funSearchLoad(){
			changeContent('masterSearch.jsp', $('#window')); 
		 }
	  function dealerSearchContent(url) {
		  $('#dealerWindow').jqxWindow('open');
			 $.get(url).done(function (data) {
				// alert(data);
			$('#dealerWindow').jqxWindow('setContent', data);
		}); 
		}
	
     function funSearchdblclick(){
       	 //alert("here");

		//  $('#txtaccname').dblclick(function(){
			var url=document.URL;
			     var reurl=url.split("com/");
			  dealerSearchContent(reurl[0]+'com/search/masterssearch/dealerMSearch.jsp');
			//  });  
	}
    function getDealer(event){
   	
         var x= event.keyCode;
         if(x==114){
       	 //alert("here");
        	 var url=document.URL;
		     var reurl=url.split("com/");
		  dealerSearchContent(reurl[0]+'com/search/masterssearch/dealerMSearch.jsp');
         }
         else{
          }
         }
    function financierSearchContent(url) {
		   $('#financierWindow').jqxWindow('open');

			 $.get(url).done(function (data) {
				// alert(data);
				
			$('#financierWindow').jqxWindow('setContent', data);
		}); 
		}
     function specSearchContent(url) {
		   $('#specwindow').jqxWindow('open');

			 $.get(url).done(function (data) {
				// alert(data);
				
			$('#specwindow').jqxWindow('setContent', data);
		}); 
		}
  function funFinSearchdblclick(){
    	// alert("here");

		//  $('#txtaccname').dblclick(function(){
			 var url=document.URL;
		     var reurl=url.split("com/");
			  financierSearchContent(reurl[0]+'com/search/masterssearch/financierMSearch.jsp');
			//  });  
	}
 function getFin(event){
	
      var x= event.keyCode;
      if(x==114){
    	 //alert("here"); 
    	 var url=document.URL;
		     var reurl=url.split("com/");
			  financierSearchContent(reurl[0]+'com/search/masterssearch/financierMSearch.jsp');
      }
      else{
       }
      }
 function insuranceSearchContent(url) {
	   $('#insuranceWindow').jqxWindow('open');

		 $.get(url).done(function (data) {
			// alert(data);
		$('#insuranceWindow').jqxWindow('setContent', data);
	}); 
	}
function funInsurSearchdblclick(){
	// alert("here");

	//  $('#txtaccname').dblclick(function(){
		 var url=document.URL;
		     var reurl=url.split("com/");
		  insuranceSearchContent(reurl[0]+'com/search/masterssearch/insuranceMSearch.jsp');
		//  });  
}
function getInsurance(event){

var x= event.keyCode;
if(x==114){
	 //alert("here");
	  var url=document.URL;
		     var reurl=url.split("com/");
	 insuranceSearchContent(reurl[0]+'com/search/masterssearch/insuranceMSearch.jsp');
}
else{
 }
}



/* 	function getDealer(event){
			 var x= event.keyCode;
			 if(x==114){
			  $('#accountWindow').jqxWindow('open');
	  	    $('#accountWindow').jqxWindow('focus');
			 }
			 else{
				 }
			 }  */
		
	
	function funReadOnly() {
		 $('#frmVehicle input').attr('readonly', true);
		 $('#frmVehicle select').attr('disabled', true);
		 $('#jqxDate1').jqxDateTimeInput({ disabled: true}); 
		 $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: true});
		 $('#jqxFinRegDate').jqxDateTimeInput({ disabled: true});
		 $('#jqxFinRelDate').jqxDateTimeInput({ disabled: true});
		 $('#jqxOtherRegExp').jqxDateTimeInput({ disabled: true});
		 $('#jqxOtherInsExp').jqxDateTimeInput({ disabled: true});
		 $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: true});
		 $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: true}); 
		 $('#jqxLstSrvcDate').jqxDateTimeInput({ disabled: true}); 
		 $('#releasedate').jqxDateTimeInput({ disabled: true}); 
		 $('#releasetime').jqxDateTimeInput({ disabled: true}); 
		 getAuth();
		getBrand();
		//getPlateCode();
		getGroup();
		//getModel();
		getYOM();
		getColor();
		getFinancier();
		getBrch();
		showRelease(); 
		getStatus();
		//getLocation();
/* 		document.getElementById("frmVehicle").disabled=true;
		document.getElementById("btnrelease").disabled=false; */
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function showRelease(){
		//$("#aststatus").attr("disabled", false); 
		 var temp=$("#aststatus").val();
		if(temp=="INDUCTED"){
			//document.getElementById("releaseid").style.display="block";
			/* var temp=document.getElementById("fleetno").value;
			$('#releasefleet').val(temp); */
			document.getElementById("btnrelease").value="To Be Released";
			/* document.getElementById("releasfuel").value=$("#cmbfuel option:selected").text();
			document.getElementById("releasekm").value=document.getElementById("current_km").value; */
		}
		else if(temp=="LIVE"){
			/* document.getElementById("btnrelease").value="Released Fleet";
			document.getElementById("btnrelease").disabled=true; */
			document.getElementById("btnrelease").style.display="none";
			document.getElementById("releasesave").style.display="none";
		}
		else{
			document.getElementById("btnrelease").disabled=true;
		}
			//document.getElementById("releaseid").style.display="none";
		//$("#aststatus").attr("disabled", true);
	}
	function funRelease(){
		
		$('#mode').val("R");
		$("#cmbrlsbranch").attr("disabled", false); 
		var testfleet=document.getElementById("releasefleet").value;
		var testbranch=document.getElementById("cmbrlsbranch").value;
		var testloc=document.getElementById("cmbrlsloc").value;
		var testkm=document.getElementById("releasekm").value;
		var testfuel=document.getElementById("releasefuel").value;
		
		if((testfleet=='')||(testbranch=='')||(testloc=='')||(testkm=='')||(testfuel=='')){
			document.getElementById("fleetwarning").style.display="block";
			return false;
		}
		else{
			document.getElementById("fleetwarning").style.display="none";
			 $('#cmbfuel').attr('disabled', false); 
			 if(document.getElementById("releasefleet").value<=0){
				 return false;
			 }
			 $('#jqxDate1').jqxDateTimeInput({disabled:false});
			$('#jqxPurchaseDate').jqxDateTimeInput({disabled:false});
			$('#jqxFinRegDate').jqxDateTimeInput({disabled:false});
			$('#jqxFinRelDate').jqxDateTimeInput({disabled:false});
			$('#jqxOtherRegExp').jqxDateTimeInput({disabled:false});
			$('#jqxOtherInsExp').jqxDateTimeInput({disabled:false});
			$('#jqxWrntyFrmDate').jqxDateTimeInput({disabled:false});
			$('#jqxWrntyToDate').jqxDateTimeInput({disabled:false});
			$('#jqxLstSrvcDate').jqxDateTimeInput({disabled:false});
			document.getElementById("frmVehicle").submit();
			$("#cmbrlsbranch").attr("disabled", true); 
			 $('#cmbfuel').attr('disabled', true); 
			
		}
		
	}
	function funEnable(){
		document.getElementById("btnrelease").style.display="none";
		document.getElementById("releasesave").style.display="block";
		$("#releasefleet").attr("disabled", false); 
		$("#cmbrlsbranch").attr("disabled", false); 
		$("#cmbrlsloc").attr("disabled", false); 
		$("#cmbrentalstatus").attr("disabled", false); 
		$("#cmbrentalstatus").val("R");
		$('#releasedate').jqxDateTimeInput({ disabled: false});
		$('#releasetime').jqxDateTimeInput({ disabled: false});
		 $("#releasekm").prop("readonly", true);
		$("#releasefuel").prop("readonly", true); 
		$("#cmbrlsbranch").attr("disabled", true); 
		if(document.getElementById("aststatus").value=='INDUCTED'){
			//alert("INSIDE");
			document.getElementById("releasekm").value=document.getElementById("current_km").value;
			document.getElementById("releasefuel").value=$("#cmbfuel option:selected").text();
			$('#cmbrlsbranch').val($('#cmbavail_br1').val());
			getLocation($('#cmbrlsbranch').val());
		}
		
	}
	function getTestPlateCode(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var plateItems = items[0].split(",");
				var plateIdItems = items[1].split(",");
				var optionsplate = '<option value="">--Select--</option>';
				for (var i = 0; i < plateItems.length; i++) {
					optionsplate += '<option value="' + plateIdItems[i] + '">'
							+ plateItems[i] + '</option>';
				}
				$("select#cmbplate").html(optionsplate);
			 	 if ($('#hidcmbplate').val() != null) {
					$('#cmbplate').val($('#hidcmbplate').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getTestPlateCode.jsp", true);
		x.send();
	}
	
	function funRemoveReadOnly() {
		$('#frmVehicle input').attr('readonly', false);
		$('#frmVehicle select').attr('disabled', false);
		//$('#jqxDateTimeInput').jqxDateTimeInput({		disabled : false		});
		$('#docno').attr('readonly', true);
		$('#dealer').attr('readonly', true);
		$('#financier').attr('readonly', true);
		$('#insurance_comp').attr('readonly', true);
		$('#mortgaged').attr('readonly', true);
		 $('#jqxDate1').jqxDateTimeInput({ disabled: false}); 
		 $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: false});
		 $('#jqxFinRegDate').jqxDateTimeInput({ disabled: false});
		 $('#jqxFinRelDate').jqxDateTimeInput({ disabled: false});
		 $('#jqxOtherRegExp').jqxDateTimeInput({ disabled: false});
		 $('#jqxOtherInsExp').jqxDateTimeInput({ disabled: false});
		// $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: false});
		// $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: false}); 
		 $('#jqxLstSrvcDate').jqxDateTimeInput({ disabled: false}); 
		 $("#releasefleet").attr("disabled", true); 
			$("#cmbrlsbranch").attr("disabled", true); 
			$("#cmbrlsloc").attr("disabled", true); 
			$("#cmbrentalstatus").attr("disabled", true); 
			$('#releasedate').jqxDateTimeInput({ disabled: true});
			$('#releasetime').jqxDateTimeInput({ disabled: true});
			$("#releasekm").attr("readonly",true);
			$("#releasefuel").attr("readonly", true);
		/*  $('#releasedate').jqxDateTimeInput({ disabled: false}); 
		 $('#releasetime').jqxDateTimeInput({ disabled: false});  */
		 if(document.getElementById("mode").value=='A'){
			 $("#jqxSpecification").jqxGrid("clear");
	    	 $("#jqxSpecification").jqxGrid("addrow", null, {});
	    	 $("#jqxFinRegDate,#jqxDate1").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxPurchaseDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxFinRelDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#releasedate").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxWrntyFrmDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxWrntyToDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxLstSrvcDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#releasetime").jqxDateTimeInput('setDate', new Date());
	    	 changeDate(); 
			 document.getElementById("accu_dep").value="0";
		 }
		if(document.getElementById("cmbbrand").value!=""){
    		getModel(document.getElementById("cmbbrand").value);
   		}
		$('#fleetno').attr('readonly', true);
		
		funGetConfigs();
	}
	function getAuth() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var authItems = items[0].split(",");
				var authIdItems = items[1].split(",");
				var optionsauth = '<option value="">--Select--</option>';
				for (var i = 0; i < authItems.length; i++) {
					optionsauth += '<option value="' + authIdItems[i] + '">'
							+ authItems[i] + '</option>';
				}
				$("select#cmbauthority").html(optionsauth);
				if ($('#hidcmbauthority').val() != null) {
					$('#cmbauthority').val($('#hidcmbauthority').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getAuthority.jsp", true);
		x.send();
	}
	function getColor() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var colorItems = items[0].split(",");
				var colorIdItems = items[1].split(",");
				var optionscolor = '<option value="">--Select--</option>';
				for (var i = 0; i < colorItems.length; i++) {
					optionscolor += '<option value="' + colorIdItems[i] + '">'
							+ colorItems[i] + '</option>';
				}
				$("select#cmbveh_color").html(optionscolor);
				if ($('#hidcmbveh_color').val() != null) {
					$('#cmbveh_color').val($('#hidcmbveh_color').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getColor.jsp", true);
		x.send();
	}
	function getPlateCode(value) {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var plateItems = items[0].split(",");
				var plateIdItems = items[1].split(",");
				var optionsplate = '<option value="">--Select--</option>';
				if(plateItems!=''){
				for (var i = 0; i < plateItems.length; i++) {
					optionsplate += '<option value="' + plateIdItems[i] + '">'
							+ plateItems[i] + '</option>';
				}
				}
				$("select#cmbplate").html(optionsplate);
			 	/* if ($('#hidcmbplate').val() != null) {
					$('#cmbplate').val($('#hidcmbplate').val());
				} */ 
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getPlateCode.jsp?id="+value, true);
		x.send();
	}
	function getGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var groupItems = items[0].split(",");
				var groupIdItems = items[1].split(",");
			
				var optionsgroup = '<option value="">--Select--</option>';
				for (var i = 0; i < groupItems.length; i++) {
					optionsgroup += '<option value="' + groupIdItems[i] + '">'
							+ groupItems[i] + '</option>';
				}
		
				$("select#cmbgroup").html(optionsgroup);
				
				if ($('#hidcmbgroup').val() != null) {
					$('#cmbgroup').val($('#hidcmbgroup').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getGroup.jsp", true);
		x.send();
	}
	function getLevel(value) {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				//alert(items);
				$('#group_name').val(items);
				
			} else {
			}
			
		}
		x.open("GET", "../vehiclemaster/getLevel.jsp?id="+value, true);
		x.send();
	}
	function getBrand() {
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#cmbbrand").html(optionsbrand);
				if ($('#hidcmbbrand').val() != null) {
					$('#cmbbrand').val($('#hidcmbbrand').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getBrand.jsp", true);
		x.send();
	}
	function getTestModel(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var modelItems = items[0].split(",");
				var modelidItems = items[1].split(",");
				var optionsmodel = '<option value="">--Select--</option>';
				for (var i = 0; i < modelItems.length; i++) {
					optionsmodel += '<option value="' + modelidItems[i] + '">'
							+ modelItems[i] + '</option>';
				}
				$("select#cmbmodel").html(optionsmodel);
				if ($('#hidcmbmodel').val() != null) {
					$('#cmbmodel').val($('#hidcmbmodel').val());
					// alert($('#hidcmbmodel').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getTestModel.jsp", true);
		x.send();
	}
	function getModel(value) {
		//document.getElementById("fleetname").value="";
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				//alert("Response"+x.responseText);
				items = items.split('####');
				var modelItems = items[0].split(",");
				//alert("=="+modelItems+"==");
				var modelidItems = items[1].split(",");
				//alert("=="+modelidItems+"==");
				var optionsmodel = '<option value="">--Select--</option>';
				if(modelItems!=''){
				for (var i = 0; i < modelItems.length; i++) {
					optionsmodel += '<option value="' + modelidItems[i] + '">'
							+ modelItems[i] + '</option>';
				}
				}
				$("select#cmbmodel").html(optionsmodel);
				if ($('#hidcmbmodel').val() != null) {
					$('#cmbmodel').val($('#hidcmbmodel').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getModel.jsp?id="+value, true);
		x.send();
	}
	function getYOM() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var yomItems = items[0].split(",");
				var yomidItems = items[1].split(",");
				var optionsyom = '<option value="">--Select--</option>';
				for (var i = 0; i < yomItems.length; i++) {
					optionsyom += '<option value="' + yomidItems[i] + '">'
							+ yomItems[i] + '</option>';
				}
				$("select#cmbyom").html(optionsyom);
				if ($('#hidcmbyom').val() != null) {
					$('#cmbyom').val($('#hidcmbyom').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getYOM.jsp", true);
		x.send();
	}
	function getFinancier() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var finItems = items[0].split(",");
				var finidItems = items[1].split(",");
				var optionsfin = '<option value="">--Select--</option>';
				for (var i = 0; i < finItems.length; i++) {
					optionsfin += '<option value="' + finidItems[i] + '">'
							+ finItems[i] + '</option>';
				}
				$("select#cmbfinancer").html(optionsfin);
				if ($('#hidcmbfinancer').val() != null) {
					$('#cmbfinancer').val($('#hidcmbfinancer').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getFinancier.jsp", true);
		x.send();
	}
	function getBrch() {
		var x = new XMLHttpRequest();
		var items, brchItems, currItems;
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				brchIdItems = items[0].split(",");
				brchItems = items[1].split(",");
				var optionsbrch = '<option value="">--Select--</option>';
				for (var i = 0; i < brchItems.length; i++) {
					optionsbrch += '<option value="' + brchIdItems[i] + '">'
							+ brchItems[i] + '</option>';
				}
				$("select#cmbavail_br1").html(optionsbrch);
				$("select#cmbrlsbranch").html(optionsbrch);
				if ($('#hidcmbavail_br1').val() != null) {
					$('#cmbavail_br1').val($('#hidcmbavail_br1').val());
				}
				if ($('#hidcmbrlsbranch').val() != null) {
					$('#cmbrlsbranch').val($('#hidcmbrlsbranch').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getBranch.jsp", true);
		x.send();
	}
	function getLocation(value)
	{
		//alert(here);
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
						//alert(items);
				 	items=items.split('***');
			        var locationItems=items[0].split(",");
			        var locationidItems=items[1].split(",");
			        	var optionslocation = '<option value="">--Select--</option>';
			       for ( var i = 0; i < locationItems.length; i++) {
			    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
			        }
			       $("select#cmbrlsloc").html(optionslocation);
				   //	$('#accno').val($('#accnohidden').val()) ;
				   	if ($('#hidcmbrlsloc').val() != null) {
				$('#cmbrlsloc').val($('#hidcmbrlsloc').val());
			}
				}
			else
				{
				}
		}
		x.open("GET","../vehiclemaster/getLocation.jsp?id="+value,true);
		x.send();
	//document.write(document.getElementById("authname").value);

	}
	function getTestLocation(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
						//alert(items);
				 	items=items.split('***');
			        var locationItems=items[0].split(",");
			        var locationidItems=items[1].split(",");
			        	var optionslocation = '<option value="">--Select--</option>';
			       for ( var i = 0; i < locationItems.length; i++) {
			    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
			        }
			       $("select#cmbrlsloc").html(optionslocation);
				   //	$('#accno').val($('#accnohidden').val()) ;
				   	if ($('#hidcmbrlsloc').val() != null) {
				$('#cmbrlsloc').val($('#hidcmbrlsloc').val());
			}
				}
			else
				{
				}
		}
		x.open("GET","../vehiclemaster/getTestLocation.jsp",true);
		x.send();
	//document.write(document.getElementById("authname").value);

	}

	function getStatus()
	{
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var status=items[0].split(",");
			        var stdesc=items[1].split(",");
			        	var optionsstatus = '<option value="">--Select--</option>';
			       for ( var i = 0; i < stdesc.length; i++) {
			    	   optionsstatus += '<option value="' + status[i] + '">' + stdesc[i] + '</option>';
			        }
			       
			       $("select#cmbstatus").html(optionsstatus);
			       
				   //	$('#accno').val($('#accnohidden').val()) ;
				   	if ($('#hidcmbstatus').val() != null) {
				$('#cmbstatus').val($('#hidcmbstatus').val());
			}
				}
			else
				{
				}
		}
		x.open("GET","../vehiclemaster/getStatus.jsp",true);
		x.send();
	//document.write(document.getElementById("authname").value);

	}
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		/* if($('#hidreleasedate').val()){
			$("#releasedate").jqxDateTimeInput('val', $('#hidreleasedate').val());
		}
 */
		if($('#hidreleasetime').val()){
			$("#releasetime").jqxDateTimeInput('val', $('#hidreleasetime').val());
		}
//alert($('#hidcmbfueltype').val())
		if ($('#hidcmbfueltype').val() != null) {
			$('#cmbfueltype').val($('#hidcmbfueltype').val());
		}
	/* 	if($('#hidjqxDate1').val()){
			$("#jqxDate1").jqxDateTimeInput('val', $('#hidjqxDate1').val());
		}
		if($('#hidjqxPurchaseDate').val()){
			$("#jqxPurchaseDate").jqxDateTimeInput('val', $('#hidjqxPurchaseDate').val());
		}
		if($('#hidjqxFinRegDate').val()){
			$("#jqxFinRegDate").jqxDateTimeInput('val', $('#hidjqxFinRegDate').val());
		}
		if($('#hidjqxFinRelDate').val()){
			$("#jqxFinRelDate").jqxDateTimeInput('val', $('#hidjqxFinRelDate').val());
		}
		if($('#hidjqxOtherRegExp').val()){
			$("#jqxOtherRegExp").jqxDateTimeInput('val', $('#hidjqxOtherRegExp').val());
		}
		if($('#hidjqxOtherInsExp').val()){
			$("#jqxOtherInsExp").jqxDateTimeInput('val', $('#hidjqxOtherInsExp').val());
		}
		if($('#hidjqxWrntyFrmDate').val()){
			$("#jqxWrntyFrmDate").jqxDateTimeInput('val', $('#hidjqxWrntyFrmDate').val());
		}
		if($('#hidjqxWrntyToDate').val()){
			$("#jqxWrntyToDate").jqxDateTimeInput('val', $('#hidjqxWrntyToDate').val());
		}
		if($('#hidjqxLstSrvcDate').val()){
			$("#jqxLstSrvcDate").jqxDateTimeInput('val', $('#hidjqxLstSrvcDate').val());
		}
	 */	if ($('#hidpurchase').val() != null) {
			$('#purchase').val($('#hidpurchase').val());
		}
	 	if ($('#hidcmbplate').val() != null) {
			$('#cmbplate').val($('#hidcmbplate').val());
		} 
		/*if ($('#hidcmbmodel').val() != null) {
			$('#cmbmodel').val($('#hidcmbmodel').val());
		}
		if ($('#hidcmbrlsloc').val() != null) {
			$('#cmbrlsloc').val($('#hidcmbrlsloc').val());
		}   */
		if ($('#hidcmbinsurance_type').val() != null) {
			$('#cmbinsurance_type').val($('#hidcmbinsurance_type').val());
		}
		if ($('#hidcmbfuel').val() != null) {
			$('#cmbfuel').val($('#hidcmbfuel').val());
		}
		/* if ($('#hidcmbrentalstatus').val() != null) {
			$('#cmbrentalstatus').val($('#hidcmbrentalstatus').val());
			
		} */
		 if ($('#hidcmbrentalstatus').val() != null) {
			$('#cmbrentalstatus').val($('#hidcmbrentalstatus').val());
			
		} 
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 // document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		// alert(document.getElementById("docno").value);
		 
		 if(document.getElementById("docno").value!=''){
			 var docno1=document.getElementById("docno").value.trim();
			 $("#specdiv").load("specificationGrid.jsp?aaa=aaa&docno1="+docno1);
			 //$("#invoiceDiv").load("invoiceGrid.jsp?docno="+docno1);
			}
	}

	 function funFocus()
	    {
	    	document.getElementById("cmbauthority").focus();
	    		
	    }
	    $(function(){
	        $('#frmVehicle').validate({
	                 rules: {
	                cmbauthority:"required",
	                cmbplate:"required",
	                cmbgroup:"required",
	                regno:"required",
	                cmbbrand:"required",
	                cmbmodel:"required",
	                cmbyom:"required",
	                purchase_cost:"required",
	                cmbavail_br1:"required",
	                purchase:"required",
	                cmbfueltype:"required",
	                fuelcapacity:"required",
	                cmbfuel:"required",
	                purchase_cost:"number",
	                additions:"number",
	                current_km:"required",
	                accu_dep:"required"
	               
	                 
	                 }, 
	        messages:{
	        	cmbauthority:" *",
	        	cmbplate:" *",
	        	cmbgroup:" *",
	        	regno:" *",
	        	cmbbrand:" *",
	        	cmbmodel:" *",
	        	cmbyom:" *",
	        	purchase_cost:" *",
	        	cmbavail_br1:" *",
	        	purchase:" *",
	        	cmbfueltype:" *",
	        	fuelcapacity:" *",
	        	cmbfuel:" *",
	        	purchase_cost:"Digits",
	        	additions:"Digits",
	        	current_km:"*",
	        	accu_dep:"*"
	        
	        }
	                 //alert("here");
	        });
	        });
	     function funNotify(){
	    	 if($("#defaultdeprconfig").val()!="1"){  
	    		 if(document.getElementById("purchase_cost").value==""){
		    		 document.getElementById("errormsg").innerText="";
		    		 document.getElementById("errormsg").innerText="Purchase Cost is Mandatory";
		    		 $('#inductiontab').trigger('click');
		    		 document.getElementById("purchase_cost").focus();
		    		 return 0;
		    	 }
	    	 }
		/*  if($("#trackid").val()==""){
			 document.getElementById("errormsg").innerText="";
    		 document.getElementById("errormsg").innerText="Tracking id is Mandatory";
				return 0;
		 } */
		/*  if($("#dealer").val()==""){
			 document.getElementById("errormsg").innerText="";
    		 document.getElementById("errormsg").innerText="Dealer id is Mandatory";
return 0;
		 } */
	    	 if(document.getElementById("cmbfueltype").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Fuel Type is Mandatory";
	    		 $('#servtab').trigger('click');
	    		 document.getElementById("cmbfueltype").focus();
	    		 return 0;
	    	 }
	    	 if(document.getElementById("fuelcapacity").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 $('#servtab').trigger('click');
	    		 document.getElementById("errormsg").innerText="Fuel Capacity is Mandatory";
	    		 document.getElementById("fuelcapacity").focus();
	    		 return 0;
	    	 }
	    	
	    	 if(document.getElementById("cmbfuel").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 $('#servtab').trigger('click');
	    		 document.getElementById("errormsg").innerText="Fuel is Mandatory";
	    		 document.getElementById("cmbfuel").focus();
	    		 return 0;
	    	 }
	    	 if(document.getElementById("cmbavail_br1").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 $('#servtab').trigger('click');
	    		 document.getElementById("errormsg").innerText="Available Branch is Mandatory";
	    		 document.getElementById("cmbavail_br1").focus();
	    		 return 0;
	    	 }
		 
	    	/*  if(parseFloat(document.getElementById("current_km").value)<parseFloat(document.getElementById("last_srvc_km").value)){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Current KM cannot be less than Last Service KM";
	    		 document.getElementById("current_km").focus();
	    		 return 0;
	    	 } */
	    	 var rows = $("#jqxSpecification").jqxGrid('getrows');
	 		if(!((rows[0].doc_no=="undefined") || (rows[0].doc_no==null) || (rows[0].doc_no==""))){
	     	$('#gridlength').val(rows.length);
	     		//alert($('#gridlength').val());
	     		for(var i=0 ; i < rows.length ; i++){
	 			//	var myvar = rows[i].tarif; 
	 				newTextBox = $(document.createElement("input"))
	 			    .attr("type", "dil")
	 			    .attr("id", "test"+i)
	 			    .attr("name", "test"+i)
	 			    .attr("hidden", "true");
	 				
	 			newTextBox.val(rows[i].doc_no+"::");
	 			
	 			newTextBox.appendTo('form');
	 			
	 				//alert("ddddd"+$("#test"+i).val());
	 			}
	     	}
	 		//alert($('#gridlength').val());
	 		$('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: false});
	 		$('#jqxWrntyToDate').jqxDateTimeInput({ disabled: false});
	 		 $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: false});
    		
	 		var regnostatus=checkRegNo();
	 		if(regnostatus==false){
	 			return 0;
	 		}
	 		if(document.getElementById("errormsg").innerText!=""){
	 			return 0;	
	 		}else {
	 			document.getElementById("errormsg").innerText="";
	 			return 1;
	 		}
	    		$('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: true});
	    		$('#jqxWrntyToDate').jqxDateTimeInput({ disabled: true});
	    				
	     } 
	    function getTotal(){
	    	 var pcost = document.getElementById('purchase_cost').value;
	         var addit = document.getElementById('additions').value;
	         if (pcost == "")
	             pcost = 0;
	         if (addit == "")
	             addit = 0;

	         var result = parseFloat(pcost) + parseFloat(addit);
	         if (!isNaN(result)) {
	             document.getElementById('total').value = result;
	         }	   
	         }
	    function getFleetName(){
	    	//alert("here");
	    	document.getElementById("fleetname").value="";
	    	/* var x = document.getElementById("cmbbrand");
	        var i = x.selectedIndex;
	        var x1=document.getElementById("cmbmodel");
	        var i1=x1.selectedindex;
	        var r=x.options[i].text;
	        var r1=x1.options[i].text; */
	        //alert("***"+r+"***"+r1);
	        var r=$("#cmbbrand option:selected").text();
	        var r1=$("#cmbmodel option:selected").text();
	        document.getElementById("fleetname").value = r+" "+r1;
	    }
function depr_percent(value){
	if(value>100){
		document.getElementById("errormsg").innerText="Depr.Percent Must be less than 100%";
		document.getElementById("depr_perc").focus();
	}else{
		document.getElementById("errormsg").innerText="";	
	}
}
function getWarrantyDate(value){
	
	
	if(value!=''){
	var fvalue=parseInt(value);
		var tempdate= $('#jqxWrntyFrmDate').jqxDateTimeInput('getDate');
		     var finaldate=new Date(new Date(tempdate).setMonth(tempdate.getMonth()+fvalue));
		    // alert(finaldate);
		     $('#jqxWrntyToDate ').jqxDateTimeInput('setDate', new Date(finaldate));
	}
	
}
function getservtab(){
	
	$('#servtab').trigger('click');
	
}
function getspectab(){
	$('#spectab').trigger('click');
}
function checkRegNo(){
	var mode=document.getElementById("mode").value;
	var docno=document.getElementById("docno").value;
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(parseInt(items)>0){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Reg No Already Exists";
				document.getElementById("regno").focus();
				return false;
			}
			document.getElementById("errormsg").innerText="";
		} else {
		}
	}
	x.open("GET", "checkRegNo.jsp?regno="+document.getElementById("regno").value+"&plate="+document.getElementById("cmbplate").value+"&mode="+mode+"&docno="+docno, false);
	x.send();
}

function funGetConfigs(){
	  
	 $.get('getConfigs.jsp',function(data){
		data=JSON.parse(data);
		$('#defaultdeprconfig').val(data.defaultdeprconfig);
		$('#defaultdeprpercent').val(data.defaultdeprpercent);
		if($('#defaultdeprconfig').val()=="1"){
			//alert($('#mode').val()+"-----"+$('#depr_perc').val())
			if($('#mode').val()=="A"){
				$('#depr_perc').val($('#defaultdeprpercent').val());
				 $('#purchase_cost').attr('readonly', true);
				 $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: true});
						
			}
			else if($('#mode').val()=="E"){
				if($('#depr_perc').val()=="" || parseFloat($('#depr_perc').val())==0.0){
					$('#depr_perc').val($('#defaultdeprpercent').val());
							
				}
				 $('#purchase_cost').attr('readonly', true);
				 $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: true});
		
			}
		}
	});
	   
}
/* 	function funsavefocus(){
		document.getElementById("releasesave").focus();
	} */
</script>
 <link href="../../../../css/body.css" rel="stylesheet" type="text/css">
 <jsp:include page="../../../../includes.jsp"></jsp:include>
 </head>
<style>
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%; /* As requested */
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    text-align: left !important;
}

.section-block {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #333;
    display: block;
}

input[type="text"], select, textarea {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
    width: 100%;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    font-size: 14px;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: 530px;
    overflow-x: hidden;
}

.myButton {
    background: #007bff;
    border: none;
    padding: 6px 16px;
    color: #fff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
}

.myButton:hover { background: #0056b3; }

form label.error { color:red; font-weight:bold; }

/* Standardize the tab navigation */
#tabs {
    list-style: none;
    display: flex;
    gap: 10px;
    padding: 0;
    margin: 20px 0 0 0;
    border-bottom: 2px solid #007bff;
}
#tabs li a {
    display: block;
    padding: 10px 20px;
    background: #eef2f7;
    text-decoration: none;
    color: #253858;
    border-radius: 8px 8px 0 0;
    font-weight: 600;
}
</style>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmVehicle" action="saveVehicle" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />
        <br/>

        <div class='hidden-scrollbar'>
            <div class="section-block">
                <h2>Vehicle Details</h2>
                <table width="100%" cellspacing="10">
                    <tr>
                        <td width="8%" align="right"><label>Fleet No</label></td>
                        <td width="40%">
                            <div style="display: flex; gap: 8px;">
                                <input type="text" name="fleetno" id="fleetno" readonly tabindex="-1" style="width: 25%;" value='<s:property value="fleetno"/>'> 
                                <input type="text" name="fleetname" id="fleetname" readonly tabindex="-1" value='<s:property value="fleetname"/>'>
                            </div>
                        </td>
                        <td width="5%" align="right"><label>Date</label></td>
                        <td width="15%">
                            <div id='jqxDate1' name='jqxDate1' value='<s:property value="jqxDate1"/>'></div>
                            <input type="hidden" id="hidjqxDate1" name="hidjqxDate1" value='<s:property value="hidjqxDate1"/>' />
                        </td>
                        <td width="8%" align="right"><label>Doc No</label></td>
                        <td width="15%">
                            <input type="text" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1">
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><label>Authority</label></td>
                        <td>
                            <div style="display: flex; gap: 8px; align-items: center;">
                                <select name="cmbauthority" id="cmbauthority" onchange="getPlateCode(this.value);" style="width:40%;">
                                    <option value="">--Select--</option>
                                </select>
                                <label>Plate Code</label>
                                <select name="cmbplate" id="cmbplate" style="width:40%;">
                                    <option>--select--</option>
                                </select>
                            </div>
                        </td>
                        <td align="right"><label>Reg No</label></td>
                        <td><input type="text" name="regno" id="regno" value='<s:property value="regno"/>'></td>
                        <td align="right"><label>Group</label></td>
                        <td><select name="cmbgroup" id="cmbgroup" onchange="getLevel(this.value);"><option>--Select--</option></select></td>
                    </tr>
                    <tr>
                        <td align="right"><label>Brand</label></td>
                        <td>
                            <div style="display: flex; gap: 8px; align-items: center;">
                                <select name="cmbbrand" id="cmbbrand" onchange="getModel(this.value);" style="width:40%;"><option>--Select--</option></select>
                                <label>Model</label>
                                <select name="cmbmodel" id="cmbmodel" onchange="getFleetName();" style="width:40%;"><option>--Select--</option></select>
                            </div>
                        </td>
                        <td align="right"><label>YoM</label></td>
                        <td><select name="cmbyom" id="cmbyom"><option>--Select--</option></select></td>
                        <td align="right"><label>Salik Tag</label></td>
                        <td><input type="text" id="salik_tag" name="salik_tag" value='<s:property value="salik_tag"/>' /></td>
                    </tr>
                    <tr>
                        <td align="right"><label>Level</label></td>
                        <td><input type="text" name="group_name" id="group_name" value='<s:property value="group_name"/>' readonly tabindex="-1"></td>
                        <td align="right"><label>TC No</label></td>
                        <td><input type="text" id="tcno" name="tcno" value='<s:property value="tcno"/>' onkeydown="getTcno(event);"/></td>
                        <td colspan="2"></td>
                    </tr>
                </table>
            </div>

            <ul id="tabs">
                <li><a href="#" name="tab1" id="inductiontab">Induction</a></li>
                <li><a href="#" name="tab2" id="servtab">Services & Others</a></li>
                <li><a href="#" name="tab3" id="spectab">Specifications</a></li>
            </ul>

            <div id="content">
                <div id="tab1">
                    <div style="display: flex; gap: 20px; margin-top: 15px;">
                        <div class="section-block" style="flex: 1;">
                            <h2>Purchase Info</h2>
                            <table width="100%" cellspacing="8">
                                <tr><td align="right">Registered Date</td><td><div id='jqxFinRegDate'></div></td></tr>
                                <tr><td align="right">Reg. Expiry</td><td><div id='jqxOtherRegExp'></div></td></tr>
                                <tr><td align="right">Insurance Expiry</td><td><div id='jqxOtherInsExp'></div></td></tr>
                                <tr><td align="right">Purchase Cost</td><td><input type="text" name="purchase_cost" id="purchase_cost" style="text-align:right;" onblur="getTotal();" value='<s:property value="purchase_cost"/>'/></td></tr>
                                <tr><td align="right">Additions</td><td><input type="text" id="additions" name="additions" style="text-align:right;" onblur="getTotal();" value='<s:property value="additions"/>'/></td></tr>
                                <tr><td align="right">Total</td><td><input type="text" id="total" name="total" style="text-align:right;" readonly value='<s:property value="total"/>'/></td></tr>
                                <tr><td align="right">Depr %</td><td><input type="text" id="depr_perc" name="depr_perc" style="text-align:right;" onblur="depr_percent(this.value);" value='<s:property value="depr_perc"/>'/></td></tr>
                                <tr><td align="right">Accu. Dep.</td><td><input type="text" id="accu_dep" name="accu_dep" style="text-align:right;" value='<s:property value="accu_dep"/>'/></td></tr>
                                <tr><td align="right">CostTran No</td><td><input type="text" id="tran_no" readonly tabindex="-1" value='<s:property value="tran_no"/>'/></td></tr>
                            </table>
                        </div>

                        <div class="section-block" style="flex: 1;">
                            <h2>Registration & Insurance</h2>
                            <table width="100%" cellspacing="8">
                                <tr><td align="right">Dealer</td><td><input type="text" name="dealer" id="dealer" placeholder="F3 Search" onKeyDown="getDealer(event);" value='<s:property value="dealer"/>'></td></tr>
                                <tr><td align="right">LPO No</td><td><input type="text" id="lpo_no" name="lpo_no" value='<s:property value="lpo_no"/>'/></td></tr>
                                <tr><td align="right">Invoice No</td><td><input type="text" id="purchase_invoice" name="purchase_invoice" value='<s:property value="purchase_invoice"/>'/></td></tr>
                                <tr><td align="right">Purchase Date</td><td><div id='jqxPurchaseDate'></div></td></tr>
                                <tr><td align="right">Financer</td><td><input type="text" name="financier" id="financier" placeholder="F3 Search" onkeydown="getFin(event);" value='<s:property value="financier"/>'></td></tr>
                                <tr><td align="right">Release Date</td><td><div id='jqxFinRelDate'></div></td></tr>
                                <tr><td align="right">Insurance Type</td><td><select name="cmbinsurance_type" id="cmbinsurance_type"><option value="">--Select--</option><option value="Comprehensive">Comprehensive</option><option value="3rdParty">3rd Party</option></select></td></tr>
                                <tr><td align="right">Insurance Comp</td><td><input type="text" id="insurance_comp" placeholder="F3 Search" onkeydown="getInsurance(event);" value='<s:property value="insurance_comp"/>'/></td></tr>
                                <tr><td align="right">Policy No</td><td><input type="text" id="policy_no" name="policy_no" onblur="getservtab();" value='<s:property value="policy_no"/>'/></td></tr>
                                <tr><td align="right">Mortgaged To</td><td><input type="text" name="mortgaged" id="mortgaged" placeholder="F3 Search" readonly onkeydown="getMortgaged(event);" value='<s:property value="mortgaged"/>'/></td></tr>
                            </table>
                        </div>

                        <div class="section-block" style="flex: 1;" id="releaseid">
                            <h2>Fleet Release Info</h2>
                            <div style="text-align: center; margin-bottom: 15px; display: flex; gap: 5px; justify-content: center;">
                                <input type="button" class="myButton" value="Save" onClick="funRelease();">
                                <input type="button" class="myButton" value="Release" onClick="funEnable();">
                            </div>
                            <table width="100%" cellspacing="5">
                                <tr><td align="right">Fleet No</td><td><input type="text" name="releasefleet" id="releasefleet" value='<s:property value="releasefleet"/>'></td></tr>
                                <tr><td align="right">Branch</td><td><select name="cmbrlsbranch" id="cmbrlsbranch" onChange="getLocation(this.value);"><option value="">--Select--</option></select></td></tr>
                                <tr><td align="right">Location</td><td><select name="cmbrlsloc" id="cmbrlsloc"><option value="">--Select--</option></select></td></tr>
                                <tr><td align="right">KM / Fuel</td>
                                    <td>
                                        <div style="display: flex; gap: 4px;">
                                            <input type="text" name="releasekm" id="releasekm" readonly value='<s:property value="releasekm"/>'>
                                            <input type="text" name="releasefuel" id="releasefuel" readonly value='<s:property value="releasefuel"/>'>
                                        </div>
                                    </td>
                                </tr>
                                <tr><td align="right">Op Status</td><td><input type="text" value="IN" disabled></td></tr>
                                <tr><td align="right">Ast Status</td><td><input type="text" name="aststatus" id="aststatus" value='<s:property value="aststatus"/>'></td></tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div id="tab2">
                    <div class="section-block" style="margin-top: 15px;">
                        <h2>Technical Specifications</h2>
                        <table width="100%" cellspacing="10">
                            <tr>
                                <td align="right">Engine No</td><td><input type="text" id="engine_no" name="engine_no" value='<s:property value="engine_no"/>'/></td>
                                <td align="right">Chasis No</td><td><input type="text" id="chasis_no" name="chasis_no" value='<s:property value="chasis_no"/>'/></td>
                                <td align="right">Fuel Type</td><td><select name="cmbfueltype" id="cmbfueltype"><option value="">--Select--</option><option value="P">Petrol</option></select></td>
                                <td align="right">Color</td><td><select name="cmbveh_color" id="cmbveh_color"><option>--Select--</option></select></td>
                            </tr>
                        </table>
                    </div>
                    
                    <div style="display: flex; gap: 20px;">
                        <div class="section-block" style="flex: 1;">
                            <h2>Warranty & Service</h2>
                            <table width="100%" cellspacing="8">
                                <tr><td align="right">Warranty Period</td><td><input type="text" id="warranty_period" onblur="getWarrantyDate(this.value);" value='<s:property value="warranty_period"/>'/></td></tr>
                                <tr><td align="right">Service KM</td><td><input type="text" id="service_km" style="text-align:right;" value='<s:property value="service_km"/>'/></td></tr>
                                <tr><td align="right">Last Srvc Date</td><td><div id='jqxLstSrvcDate'></div></td></tr>
                                <tr><td align="right">Last Srvc KM</td><td><input type="text" id="last_srvc_km" style="text-align:right;" value='<s:property value="last_srvc_km"/>'/></td></tr>
                            </table>
                        </div>
                        <div class="section-block" style="flex: 1;">
                            <h2>Current Status</h2>
                            <table width="100%" cellspacing="8">
                                <tr><td align="right">Current KM</td><td><input type="text" id="current_km" style="text-align:right;" value='<s:property value="current_km"/>'/></td></tr>
                                <tr><td align="right">Fuel Level</td><td><select name="cmbfuel" id="cmbfuel"><option value=1.000>Level 8/8</option></select></td></tr>
                                <tr><td align="right">Available Br.</td><td><select name="cmbavail_br1" id="cmbavail_br1"></select></td></tr>
                                <tr><td align="right">Calibration Km</td><td><input type="text" id="calibrationkm" onblur="getspectab();" value='<s:property value="calibrationkm"/>'/></td></tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div id="tab3">
                    <div class="section-block" style="margin-top: 15px;">
                        <h2>Vehicle Specifications</h2>
                        <div id="specdiv">
                            <center><jsp:include page="specificationGrid.jsp"></jsp:include></center>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" id="hidcmbauthority" name="hidcmbauthority" value='<s:property value="hidcmbauthority"/>' />
            <input type="hidden" id="hidcmbplate" name="hidcmbplate" value='<s:property value="hidcmbplate"/>' />
            <input type="hidden" id="hidcmbgroup" name="hidcmbgroup" value='<s:property value="hidcmbgroup"/>' />
            <input type="hidden" id="hidcmbbrand" name="hidcmbbrand" value='<s:property value="hidcmbbrand"/>'/>
            <input type="hidden" id="hidcmbmodel" name="hidcmbmodel" value='<s:property value="hidcmbmodel"/>' />
            <input type="hidden" id="hidcmbyom" name="hidcmbyom" value='<s:property value="hidcmbyom"/>' />
            <input type="hidden" id="hidjqxWrntyFrmDate" name="hidjqxWrntyFrmDate" value='<s:property value="hidjqxWrntyFrmDate"/>' />
            <input type="hidden" id="hidjqxWrntyToDate" name="hidjqxWrntyToDate" value='<s:property value="hidjqxWrntyToDate"/>' />
            <input type="hidden" id="hidjqxLstSrvcDate" name="hidjqxLstSrvcDate" value='<s:property value="hidjqxLstSrvcDate"/>' />
            <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        </div>
    </form>

    <div id="dealerWindow"><div></div><div></div></div>
    <div id="tcnowindow"><div></div><div></div></div>
    <div id="financierWindow"><div></div><div></div></div>
    <div id="insuranceWindow"><div></div><div></div></div>
    <div id="specwindow"><div></div></div>
    <div id="releaseWindow"><div></div><div style="background-color:#E0ECF8;"></div></div>
</div>
</body></html>