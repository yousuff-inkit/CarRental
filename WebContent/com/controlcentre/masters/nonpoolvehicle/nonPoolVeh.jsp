<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link href="../../../../css/body.css" rel="stylesheet" type="text/css">
<style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT (From Master)
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
        max-width: 1450px;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important;
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons) (From Master)
    ------------------------------ */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }

    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

    /* ------------------------------
       GRID SYSTEM (FORM LAYOUT) (From Master)
    ------------------------------ */
    .receipt-header {
        display: block; /* Header block container */
        padding: 0 0 0 5px;
    }

    .form-group {
        display: grid;
        grid-template-columns: 120px 1fr;
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }

    .form-group.dual-input {
        grid-template-columns: 120px 1fr 120px 1fr;
    }

    .form-group.single-label-dual-input {
        grid-template-columns: 120px 1fr 1fr;
    }

    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }

    .section-block {
        flex: 1;
        background: #f6f8fa; /* Uniform background color */
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        min-width: 45%;
    }

    .full-width-block {
        flex: 1 1 100%;
    }

    .section-block h2, .section-block h3 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
        display: block;
    }

    /* ------------------------------
       INPUTS & CONTROLS (From Master)
    ------------------------------ */
    input[type="text"], input[type="email"], select, textarea {
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

    input[type="text"]:focus, input[type="email"]:focus, select:focus, textarea:focus {
        border-color: #007bff;
        outline: none;
    }

    input[readonly], textarea[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font : Tahoma;
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 16px;
    }

    /* ------------------------------
       TABLES & UTILS (From Master)
    ------------------------------ */
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
    }
    .myButton:hover { background: #0056b3; }

    /* SCROLLBAR FIX - Added for this specific file */
    .hidden-scrollbar { 
        overflow: auto; 
        height: 600px;
    }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }

    /* ERROR STYLES */
    form label.error {
        color:red;
        font-weight:bold;
    }
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("#nonpooldate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	
/* 	 $("#closetime").jqxDateTimeInput({ width: '125px', height: '15px', formatString: 'HH:mm', showCalendarButton: false });
	 $("#timein").jqxDateTimeInput({ width: '125px', height: '15px', formatString: 'HH:mm', showCalendarButton: false });
	 $("#timedue").jqxDateTimeInput({ width: '125px', height: '15px', formatString: 'HH:mm', showCalendarButton: false });
$("#closedate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	$("#datein").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	
	$("#datedue").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	}); */
$("#regexpiry").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});  
	$("#insurexpiry").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	$("#lstsrvcdate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	
	 getTestPlateCode();

	    getTestModel();
	  
	   getTestLocation(); 
});

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
			$("select#cmbplatecode").html(optionsplate);
			if ($('#hidcmbplatecode').val() != null) {
				$('#cmbplatecode').val($('#hidcmbplatecode').val());
			}
		 	
		} else {
		}
	}
	x.open("GET", "../vehiclemaster/getTestPlateCode.jsp", true);
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
			}
		} else {
		}
	}
	x.open("GET", "../vehiclemaster/getTestModel.jsp", true);
	x.send();
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
		       $("select#cmbavailloc").html(optionslocation);
			   //	$('#accno').val($('#accnohidden').val()) ;
			    if ($('#hidcmbavailloc').val() != null) {
				$('#cmbavailloc').val($('#hidcmbavailloc').val()); 
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

function checkRegNo(){
	/* alert("here"); */
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
	x.open("GET", "../vehicle/checkRegNo.jsp?regno="+document.getElementById("regno").value+"&plate="+document.getElementById("cmbplatecode").value+"&mode="+mode+"&docno="+docno, true);
	x.send();
}
/* 
function accountSearchContent(url) {
	  $('#accountWindow').jqxWindow('open');
		 $.get(url).done(function (data) {
			// alert(data);
		$('#accountWindow').jqxWindow('setContent', data);
	}); 
	}
function funSearchdblclick(){
	var url=document.URL;
    var reurl=url.split("com");
    accountSearchContent(reurl[0]+'com/controlcentre/masters/nonpoolvehicle/nonPoolAccSearch.jsp');
	  
		
}
function getAcc(event){
	
   var x= event.keyCode;
   if(x==114){
 	 //alert("here");
	   var url=document.URL;
	    var reurl=url.split("com");
	    accountSearchContent(reurl[0]+'com/controlcentre/masters/nonpoolvehicle/nonPoolAccSearch.jsp');
		  
   }
   else{
    }
   }
 */  </script>
  <script type="text/javascript">
function funReset(){

}
function funReadOnly(){
	$('#frmNonpoolvehicle input').attr('readonly', true);
	// $('#frmNonpoolvehicle input').attr('disabled', true );
	$('#frmNonpoolvehicle select').attr('disabled', true );
	$('#frmNonpoolvehicle textarea').attr('disabled', true );
	$('#nonpooldate').jqxDateTimeInput({ disabled: true});
	/* $('#closetime').jqxDateTimeInput({ disabled: true});
	$('#timein').jqxDateTimeInput({ disabled: true});
	$('#timedue').jqxDateTimeInput({ disabled: true});
	$('#closedate').jqxDateTimeInput({ disabled: true});
	$('#datein').jqxDateTimeInput({ disabled: true});
	$('#datedue').jqxDateTimeInput({ disabled: true}); */
	$('#regexpiry').jqxDateTimeInput({ disabled: true});
	$('#insurexpiry').jqxDateTimeInput({ disabled: true});
	$('#lstsrvcdate').jqxDateTimeInput({ disabled: true}); 
	
	//getFleet();
}
function funRemoveReadOnly(){
	$('#frmNonpoolvehicle input').attr('readonly', false);

	// $('#frmNonpoolvehicle input').attr('disabled', false );
	$('#frmNonpoolvehicle select').attr('disabled', false );
	$('#frmNonpoolvehicle textarea').attr('disabled', false );
	$('#nonpooldate').jqxDateTimeInput({ disabled: false});
	/* $('#closetime').jqxDateTimeInput({ disabled: false});
	$('#timein').jqxDateTimeInput({ disabled: false});
	$('#timedue').jqxDateTimeInput({ disabled: false});
	$('#closedate').jqxDateTimeInput({ disabled: false});
	$('#datein').jqxDateTimeInput({ disabled: false});
	$('#datedue').jqxDateTimeInput({ disabled: false}) */;
	$('#regexpiry').jqxDateTimeInput({ disabled: false});
	$('#insurexpiry').jqxDateTimeInput({ disabled: false});
	$('#lstsrvcdate').jqxDateTimeInput({ disabled: false}); 
	$('#docno').attr('readonly', true);
}
function getAuthority()
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			
			 	items=items.split('####');
		        var authItems=items[0].split(",");
		        var authidItems=items[1].split(",");
		        	var optionsauth = '<option value="">--Select--</option>';
		        	for ( var i = 0; i < authItems.length; i++) {
		    	   optionsauth += '<option value="' + authidItems[i] + '">' + authItems[i] + '</option>';
		        }
		       $("select#cmbauthority").html(optionsauth);
			   //	$('#cmbaccno').val($('#cmbhidaccno').val()) ;
			   if ($('#hidcmbauthority').val() != null) {
			$('#cmbauthority').val($('#hidcmbauthority').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","../vehiclemaster/getAuthority.jsp",true);
	x.send();
}
function getPlatecode(value)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var plateItems=items[0].split(",");
		        var plateidItems=items[1].split(",");
		        	var optionsplate = '<option value="">--Select--</option>';
		       for ( var i = 0; i < plateItems.length; i++) {
		    	   optionsplate += '<option value="' + plateidItems[i] + '">' + plateItems[i] + '</option>';
		        }
		       $("select#cmbplatecode").html(optionsplate);
			   if ($('#hidcmbplatecode').val() != null) {
			$('#cmbplatecode').val($('#hidcmbplatecode').val());
			
		}
			   
			}
		else
			{
			}
	}
	x.open("GET","getPlatecode.jsp?id="+value,true);
	x.send();
}
function getBrand()
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var brandItems=items[0].split(",");
		        var brandidItems=items[1].split(",");
		        	var optionsbrand = '<option value="">--Select--</option>';
		       for ( var i = 0; i < brandItems.length; i++) {
		    	   optionsbrand += '<option value="' + brandidItems[i] + '">' + brandItems[i] + '</option>';
		        }
		       $("select#cmbbrand").html(optionsbrand);
			   //	$('#cmbaccno').val($('#cmbhidaccno').val()) ;
			   if ($('#hidcmbbrand').val() != null) {
			$('#cmbbrand').val($('#hidcmbbrand').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","../vehiclemaster/getBrand.jsp",true);
	x.send();
}
function getGroup()
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var groupItems=items[0].split(",");
		        var groupidItems=items[1].split(",");
		        	var optionsgroup = '<option value="">--Select--</option>';
		       for ( var i = 0; i < groupItems.length; i++) {
		    	   optionsgroup += '<option value="' + groupidItems[i] + '">' + groupItems[i] + '</option>';
		        }
		       $("select#cmbgroup").html(optionsgroup);
			   //	$('#cmbaccno').val($('#cmbhidaccno').val()) ;
			   if ($('#hidcmbgroup').val() != null) {
			$('#cmbgroup').val($('#hidcmbgroup').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","getGroup.jsp",true);
	x.send();
}
function getModel(value)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var modelItems=items[0].split(",");
		        var modelidItems=items[1].split(",");
		        	var optionsmodel = '<option value="">--Select--</option>';
		       for ( var i = 0; i < modelItems.length; i++) {
		    	   optionsmodel += '<option value="' + modelidItems[i] + '">' + modelItems[i] + '</option>';
		        }
		       $("select#cmbmodel").html(optionsmodel);
			   //	$('#cmbaccno').val($('#cmbhidaccno').val()) ;
			   if ($('#hidcmbmodel').val() != null) {
			$('#cmbmodel').val($('#hidcmbmodel').val());
			
		}
			   
			}
		else
			{
			}
	}
	x.open("GET","getModel.jsp?id="+value,true);
	x.send();
}
function getYom()
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var yomItems=items[0].split(",");
		        var yomidItems=items[1].split(",");
		        	var optionsyom = '<option value="">--Select--</option>';
		       for ( var i = 0; i < yomItems.length; i++) {
		    	   optionsyom += '<option value="' + yomidItems[i] + '">' + yomItems[i] + '</option>';
		        }
		       $("select#cmbyom").html(optionsyom);
			   //	$('#cmbaccno').val($('#cmbhidaccno').val()) ;
			   if ($('#hidcmbyom').val() != null) {
			$('#cmbyom').val($('#hidcmbyom').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","getYom.jsp",true);
	x.send();
}
function getBranch() {
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
			$("select#cmbavailbranch").html(optionsbrch);
			if ($('#hidcmbavailbranch').val() != null) {
				$('#cmbavailbranch').val($('#hidcmbavailbranch').val());
			}
			
		} else {
		}
	}
	x.open("GET", "../vehiclemaster/getBranch.jsp", true);
	x.send();
}

function getLocation(value)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var locationItems=items[0].split(",");
		        var locationidItems=items[1].split(",");
		        	var optionslocation = '<option value="">--Select--</option>';
		       for ( var i = 0; i < locationItems.length; i++) {
		    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
		        }
		       $("select#cmbavailloc").html(optionslocation);
			   //	$('#accno').val($('#accnohidden').val()) ;
			   	if ($('#hidcmbavailloc').val() != null) {
			$('#cmbavailloc').val($('#hidcmbavailloc').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","getLocation.jsp?id="+value,true);
	x.send();
//document.write(document.getElementById("authname").value);

}
/* function getLocationName(value)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	//alert(items);
			 	//items=items.split('***');
		        //var locationItems=items[0].split(",");
		        //var locationidItems=items[1].split(",");
		       	document.getElementById("availlocname").value=items;
		     
			}
		else
			{
			}
	}
	x.open("GET","getLocationName.jsp?id="+value,true);
	x.send();
//document.write(document.getElementById("authname").value);

} */
/* function getCloseBranch()
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('####');
		        var branchItems=items[1].split(",");
		        var branchidItems=items[0].split(",");
		        	var optionsbranch = '<option value="">--Select--</option>';
		       for ( var i = 0; i < branchItems.length; i++) {
		    	   optionsbranch += '<option value="' + branchidItems[i] + '">' + branchItems[i] + '</option>';
		        }
		       $("select#cmbbranch").html(optionsbranch);
			   //	$('#accno').val($('#accnohidden').val()) ;
			   if ($('#hidcmbbranch').val() != null) {
			$('#cmbbranch').val($('#hidcmbbranch').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","../vehiclemaster/getBranch.jsp",true);
	x.send();

} */
function getColor()
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var colorItems=items[0].split(",");
		        var coloridItems=items[1].split(",");
		        	var optionscolor = '<option value="">--Select--</option>';
		       for ( var i = 0; i < colorItems.length; i++) {
		    	   optionscolor += '<option value="' + coloridItems[i] + '">' + colorItems[i] + '</option>';
		        }
		       $("select#cmbcolor").html(optionscolor);
			   //	$('#cmbaccno').val($('#cmbhidaccno').val()) ;
			   if ($('#hidcmbcolor').val() != null) {
			$('#cmbcolor').val($('#hidcmbcolor').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","getColor.jsp",true);
	x.send();
}
<%-- function getCheckin()
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var checkinItems=items[0].split(",");
		        var checkinidItems=items[1].split(",");
		        	var optionscheckin = '<option value="">--Select--</option>';
		        	for ( var i = 0; i < checkinItems.length; i++) {
		    	   optionscheckin += '<option value="' + checkinidItems[i] + '">' + checkinItems[i] + '</option>';
		        }
		       $("select#cmbcheckin").html(optionscheckin);
		       $("select#cmbcheckout").html(optionscheckin);
		       var temp='';'<%=session.getAttribute("USERNAME").toString()%>';
		      document.getElementById("user").value=temp;
		      document.getElementById("closeuser").value=temp;
		      if ($('#hidcmbcheckin').val() != null) {
					$('#cmbcheckin').val($('#hidcmbcheckin').val());
				}
			   //	$('#cmbaccno').val($('#cmbhidaccno').val()) ;
			   if ($('#hidcmbcheckout').val() != null) {
			$('#cmbcheckout').val($('#hidcmbcheckout').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","getCheckin.jsp",true);
	x.send();
} --%>

/* function getUtype(value)
{
		
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			items=x.responseText;
			document.getElementById("utype").value=items;
		}
		else
			{
			}
	}
	x.open("GET","getUtype.jsp?id="+value,true);
	x.send();
	} */
	
	function getFleetname()
	{
		document.getElementById("fleetname").value="";
    	
        var r=$("#cmbbrand option:selected").text();
        var r1=$("#cmbmodel option:selected").text();
        document.getElementById("fleetname").value = r+" "+r1;
	}
	
	function funNotify(){
	/* 	if(document.getElementById("fleetno").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Fleet is Mandatory";
			document.getElementById("fleetno").focus();
			return 0;
		} */
		
		return 1;
	}
	
	
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		getAuthority();
		getBrand();
		//getModel( $("select#cmbbrand").val(this.value));
		getGroup();
		//getModel();
		//getPlatecode();
		getYom();
		
		
		
		getBranch();
		getColor();
		//getCheckin();
		//getCloseBranch();
		/* if($('#hidnonpooldate').val()){
			$("#nonpooldate").jqxDateTimeInput('val', $('#hidnonpooldate').val());
		}
		 if($('#hidclosetime').val()){
			$("#closetime").jqxDateTimeInput('val', $('#hidclosetime').val());
		}
		if($('#hidtimein').val()){
			$("#timein").jqxDateTimeInput('val', $('#hidtimein').val());
		}
		if($('#hidtimedue').val()){
			$("#timedue").jqxDateTimeInput('val', $('#hidtimedue').val());
		}
		if($('#hidclosedate').val()){
			$("#closedate").jqxDateTimeInput('val', $('#hidclosedate').val());
		}
		if($('#hiddatein').val()){
			$("#datein").jqxDateTimeInput('val', $('#hiddatein').val());
		}
		if($('#hiddatedue').val()){
			$("#datedue").jqxDateTimeInput('val', $('#hiddatedue').val());
		} 
		if($('#hidregexpiry').val()){
			$("#regexpiry").jqxDateTimeInput('val', $('#hidregexpiry').val());
		}
		if($('#hidinsurexpiry').val()){
			$("#insurexpiry").jqxDateTimeInput('val', $('#hidinsurexpiry').val());
		}
		if($('#hidlstsrvcdate').val()){
			$("#lstsrvcdate").jqxDateTimeInput('val', $('#hidlstsrvcdate').val());
		}
		*/

		if ($('#hidcmbfuel').val() != null) {
			$('#cmbfuel').val($('#hidcmbfuel').val());
		}
		if ($('#hidcmbfueltype').val() != null) {
			$('#cmbfueltype').val($('#hidcmbfueltype').val());
		}
		if ($('#hidcmbavailbranch').val() != null) {
			$('#cmbavailbranch').val($('#hidcmbavailbranch').val());
		}
		if ($('#hidcmbavailloc').val() != null) {
			$('#cmbavailloc').val($('#hidcmbavailloc').val());
		}
	/* 
		if ($('#hidcmbperiodno').val() != null) {
			$('#cmbperiodno').val($('#hidcmbperiodno').val());
		}
		if ($('#hidcmbperiodtype').val() != null) {
			$('#cmbperiodtype').val($('#hidcmbperiodtype').val());
		}
		
		
		if ($('#hidcmbclosefuel').val() != null) {
			$('#cmbclosefuel').val($('#cmbclosefuel').val());
		} */
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	 function funFocus()
	    {
	    	document.getElementById("cmbauthority").focus();
	    		
	    }
	     $(function(){
	        $('#frmNonpoolvehicle').validate({
	                   rules: {
	                cmbauthority:"required",
	                  cmbplatecode:"required",
	                cmbgroup:"required",
	                regno:"required",
	                cmbbrand:"required",
	                cmbmodel:"required",
	                cmbyom:"required",
	               saliktag:"required",
	               cmbfuel:"required",
	               cmbcolor:"required",
	               cmbavailbranch:"required",
	               cmbavailloc:"required",
	               fuelcapacity:"required",
	                cmbfueltype:"required",
	               
	                 
	                 }, 
	        messages:{
	        	cmbauthority:" *", 
	         	cmbplatecode:" *",
	        	cmbgroup:" *",
	        	regno:" *",
	        	cmbbrand:" *",
	        	cmbmodel:" *",
	        	cmbyom:" *",
	        	saliktag:" *",
	            cmbfuel:" *",
	            cmbcolor:" *",
	            cmbavailbranch:" *",
	            cmbavailloc:" *",
	            cmbfueltype:" *",
		        fuelcapacity:" *",
	        
	        }
	        });
	        });  
	     function funSearchLoad(){
			changeContent('masterSearch.jsp', $('#window')); 
		 }
	
</script>
</head>
<body onLoad="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmNonpoolvehicle" action="saveActionNonpoolvehicle" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="hidden-scrollbar receipt-header">

    <div class="section-block full-width-block">
        <h3>Vehicle Info</h3>

        <div class="form-group dual-input">
            <label>Date</label>
            <div>
                <div id="nonpooldate" name="nonpooldate" value='<s:property value="nonpooldate"/>'></div>
            </div>

            <label>Doc No</label>
            <input name="docno" type="text" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly>
        </div>

        <div class="form-group dual-input">
            <label>Fleet No</label>
            <div style="display:flex; gap:10px;">
                <input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' style="width:25%;" tabindex="-1" readonly>
                <input type="text" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' style="width:70%;" readonly tabindex="-1">
            </div>
            
            <label>Ast Status</label>
            <input type="text" name="aststatus" id="aststatus" value='<s:property value="aststatus"/>' readonly tabindex="-1">
        </div>
        
        <div class="form-group dual-input">
            <label>CostTran No</label>
            <input type="text" name="costtranno" id="costtranno" value='<s:property value="costtranno"/>' readonly tabindex="-1">

            <label>Authority</label>
            <select name="cmbauthority" id="cmbauthority" value='<s:property value="cmbauthority"/>' onchange="getPlatecode(this.value);" >
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbauthority" id="hidcmbauthority" value='<s:property value="hidcmbauthority"/>'>
        </div>

        <div class="form-group dual-input">
            <label>Plate Code</label>
            <select name="cmbplatecode" id="cmbplatecode" value='<s:property value="cmbplatecode"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbplatecode" id="hidcmbplatecode" value='<s:property value="hidcmbplatecode"/>'>

            <label>Reg No</label>
            <input type="text" name="regno" id="regno" value='<s:property value="regno"/>' onblur="checkRegNo();">
        </div>

        <div class="form-group dual-input">
            <label>Group</label>
            <select name="cmbgroup" id="cmbgroup" value='<s:property value="cmbgroup"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbgroup" name="hidcmbgroup" value='<s:property value="hidcmbgroup"/>'>
            
            <label>Op Status</label>
            <input type="text" name="opstatus" id="opstatus" value='<s:property value="opstatus"/>' readonly tabindex="-1">
        </div>
        
        <div class="form-group dual-input">
            <label>Brand</label>
            <select name="cmbbrand" id="cmbbrand" value='<s:property value="cmbbrand"/>' onchange="getModel(this.value);">
                <option value="" >--Select--</option>
            </select>
            <input type="hidden" name="hidcmbbrand" id="hidcmbbrand" value='<s:property value="hidcmbbrand"/>'>

            <label>Model</label>
            <select name="cmbmodel" id="cmbmodel" value='<s:property value="cmbmodel"/>' onchange="getFleetname();">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbmodel" id="hidcmbmodel" value='<s:property value="hidcmbmodel"/>'>
        </div>
        
        <div class="form-group dual-input">
            <label>YoM</label>
            <select name="cmbyom" id="cmbyom" value='<s:property value="cmbyom"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbyom" id="hidcmbyom" value='<s:property value="hidcmbyom"/>'>
            
            <label>Salik Tag</label>
            <input type="text" name="saliktag" id="saliktag" value='<s:property value="saliktag"/>'>
        </div>
        
        <div class="form-group dual-input">
            <label>Veh Color</label>
            <select name="cmbcolor" id="cmbcolor" value='<s:property value="cmbcolor"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbcolor" id="hidcmbcolor" value='<s:property value="hidcmbcolor"/>'>

            <label>Reg Expiry</label>
            <div id="regexpiry" name="regexpiry" value='<s:property value="regexpiry"/>'></div>
        </div>
        
        <div class="form-group dual-input">
            <label>Ins Expiry</label>
            <div id="insurexpiry" name="insurexpiry" value='<s:property value="insurexpiry"/>'></div>
            <input type="hidden" name="hidinsurexpiry" id="hidinsurexpiry" value='<s:property value="hidinsurexpiry"/>'>
            <input type="hidden" name="hidregexpiry" id="hidregexpiry" value='<s:property value="hidregexpiry"/>'>
            
            <label>Avail Branch</label>
            <select name="cmbavailbranch" id="cmbavailbranch" value='<s:property value="cmbavailbranch"/>' onchange="getLocation(this.value);">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbavailbranch" id="hidcmbavailbranch" value='<s:property value="hidcmbavailbranch"/>'>
        </div>
        
        <div class="form-group">
            <label>Location</label>
            <select name="cmbavailloc" id="cmbavailloc" value='<s:property value="cmbavailloc"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbavailloc" id="hidcmbavailloc" value='<s:property value="hidcmbavailloc"/>'>
        </div>
    </div>
    
    <input type="hidden" name="hidnonpooldate" id="hidnonpooldate" value='<s:property value="hidnonpooldate"/>'>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
    <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
    <input type="hidden" name="vehdocno" id="vehdocno" value='<s:property value="vehdocno"/>'>


    <div class="section-block full-width-block">
        <h3>Other Info</h3>
        
        <div class="form-group dual-input">
            <label>Engine No</label>
            <input type="text" name="engineno" id="engineno" value='<s:property value="engineno"/>' style="text-transform:uppercase;">

            <label>Chassis No</label>
            <input type="text" name="chasisno" id="chasisno" value='<s:property value="chasisno"/>' style="text-transform:uppercase;">
        </div>

        <div class="form-group dual-input">
            <label>VIN</label>
            <input type="text" name="vin" id="vin" value='<s:property value="vin"/>' >

            <label>Fuel Type</label>
            <select id="cmbfueltype" name="cmbfueltype" value='<s:property value="cmbfueltype"/>' >
                <option value="">--Select--</option>
                <option value="P">Petrol</option>
                <option value="D">Diesel</option>
            </select>
            <input type="hidden" name="hidcmbfueltype" id="hidcmbfueltype" value='<s:property value="hidcmbfueltype"/>' />
        </div>

        <div class="form-group dual-input">
            <label>Fuel Tank Capacity</label>
            <input type="text" name="fuelcapacity" id="fuelcapacity" value='<s:property value="fuelcapacity"/>' />
            
            <label>Fuel</label>
            <select name="cmbfuel" id="cmbfuel" value='<s:property value="cmbfuel"/>'>
                <option value="">--Select--</option>
                <option value=0.000>Level 0/8</option>
                <option value=0.125 >Level 1/8</option>
                <option value=0.250>Level 2/8</option>
                <option value=0.375>Level 3/8</option>
                <option value=0.500>Level 4/8</option>
                <option value=0.625>Level 5/8</option>
                <option value=0.750>Level 6/8</option>
                <option value=0.875>Level 7/8</option>
                <option value=1.000>Level 8/8</option>
            </select>
            <input type="hidden" id="hidcmbfuel" name="hidcmbfuel" value='<s:property value="hidcmbfuel"/>'>
        </div>
    </div>

    <div class="section-block full-width-block">
        <h3>Service Info</h3>

        <div class="form-group dual-input">
            <label>Service KM</label>
            <input type="text" name="servicekm" id="servicekm" value='<s:property value="servicekm"/>' >

            <label>Last Service KM</label>
            <input type="text" name="lastservicekm" id="lastservicekm" value='<s:property value="lastservicekm"/>'>
        </div>

        <div class="form-group dual-input">
            <label>Last srvc.Date</label>
            <div id="lstsrvcdate" name="lstsrvcdate" value='<s:property value="lstsrvcdate"/>' ></div>
            
            <label>Current KM</label>
            <input type="text" name="currentkm" id="currentkm" value='<s:property value="currentkm"/>' >
        </div>
    </div>


</div>
</form>
</div>
</body>
</html>