<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   1. YOUR ORIGINAL PAGE & WRAPPER STYLES (UNTOUCHED)
========================================================= */
form label.error {
    color:red;
    font-weight:bold;
}

.style1 {
	color: #FF0000;
	font-weight: bold;
}

.hidden-scrollbar {
    overflow: visible;
    height: auto;
}

html, body {
    background: #ffffff;                
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 12px;                     
    color: #333;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.windowCont,
#mainBG.homeContent {
    background: #ffffff !important;
}

#mainBG {
    background: #ffffff;
    border-radius: 8px;
    padding: 16px 18px;
    max-width: 1400px;
    margin: 0 auto;
    box-shadow: none;                    
}

/* =========================================================
   2. CASH RECEIPTS UI ELEMENTS (TYPOGRAPHY FIXED)
========================================================= */
.middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 15px 15px 15px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 6px; 
    margin-bottom: 25px;
    margin-top: 25px; 
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 15px; 
    background: #ffffff; 
    padding: 0 10px; 
    color: #0056b3;
    font-weight: 700; 
    font-size: 15px; 
    border-left: 4px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Flexbox Layout for Rows & Columns */
.field-row { 
    display: flex;
    align-items: center; 
    margin-bottom: 12px; 
    width: 100%;
    flex-wrap: wrap;
    gap: 15px;
}

/* FIXED TYPOGRAPHY TO MATCH OPN IMAGE */
.lbl-right { 
    color: #1e293b;
    font-size: 13px; /* Slightly larger for clarity */
    font-weight: 600; /* Softer bold, matching OPN image */
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    white-space: nowrap; 
    text-align: right;
    min-width: 100px; 
}

/* Scoped 26px Inputs with Softer Borders */
input[type="text"],
input[type="email"],
select { 
    height: 26px !important; 
    border: 1px solid #d1d5db; /* Softer border color matching OPN */
    border-radius: 4px; 
    padding: 4px 8px;
    font-size: 13px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

input[type="text"]:focus,
input[type="email"]:focus,
select:focus { 
    border-color: #3b82f6; 
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

input[readonly],
input:disabled,
select:disabled { 
    background-color: #f8f9fa; /* Lighter disabled background */
    color: #6b7280;
}
</style>

<script type="text/javascript">
      $(document).ready(function () {  
          $("#compaccdate1").jqxDateTimeInput({ width: '125px', height: 26, formatString:"dd.MM.yyyy", theme: 'energyblue'}); 
          $("#compaccdate2").jqxDateTimeInput({ width: '125px', height: 26, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          
          /* force internal alignment AFTER render */
          setTimeout(function () {
              $("#compaccdate1, #compaccdate2").find("input").css({
                  "margin-top": "0px",
                  "line-height": "26px",
                  "font-size": "13px", 
                  "font-family": "Arial, sans-serif", 
                  "padding": "0 8px", 
                  "box-sizing":"border-box"
              });
              $("#compaccdate1, #compaccdate2").find(".jqx-action-button").css({
                  "top": "0px",
                  "height": "26px"
              });
          }, 0);

          document.getElementById("datediv").style.display="none";
          document.getElementById("formdet").innerText="Company(COM)";
          document.getElementById("formdetail").value="Company";
          document.getElementById("formdetailcode").value="COM";
          window.parent.formCode.value="COM";
          window.parent.formName.value="Company";
          getTimezone();
      });
  
  function funFocus()
  {
  	document.getElementById("txtcompid").focus();
  		
  }
  
  $(function(){
      $('#frmCompany').validate({
               rules: {
               txtcompid:{
            	 required:true,
            	 maxlength:5
               } ,
              txtcompname:"required",
              cmbcurr:"required"
               },
               messages: {
            	   txtcompid:{
            		   required:" *",
            		   maxlength:"max 5 chars"
            	   },
            	   txtcompname:" *",
            	   cmbcurr:" *"
               }
      });});
      
   function funNotify(){
  	    var date1 = $('#compaccdate1').jqxDateTimeInput('getDate');
		var date2 = $('#compaccdate2').jqxDateTimeInput('getDate');
  		if(date1>date2){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Accounting To Date cannot be less than From Date"
					$('#compaccdate1').jqxDateTimeInput('focus');
  			return 0;
  		}   
  		document.getElementById("errormsg").innerText="";
  		return 1;
	} 
   
  function funSearchLoad(){
		changeContent('companySearch.jsp', $('#window')); 
	 }
     
     function getCurrency()
	 {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var currItems=items[0].split(",");
		        var curridItems=items[1].split(",");
		        	var optionscurr = '<option value="">--Select--</option>';
		        for ( var i = 0; i < currItems.length; i++) {
		    	   optionscurr += '<option value="' + curridItems[i] + '">' + currItems[i] + '</option>';
		        }
		         $("select#cmbcurr").html(optionscurr);
			     $('#cmbcurr').val($('#hidcmbcurr').val()) ;
			    }
	     }
	      x.open("GET","getCurrency.jsp",true);
	     x.send();
	    
        }
     
     function getTimezone()
	 {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var zoneItems=items[0].split(":::");
		        var zoneidItems=items[1].split(":::");
		        	var optionszone = '<option value="">--Select--</option>';
		        for ( var i = 0; i < zoneItems.length; i++) {
		    	   optionszone += '<option value="' + zoneidItems[i] + '">' + zoneItems[i] + '</option>';
		        }
		         $("select#cmbtimezone").html(optionszone);
		        if($('#hidcmbtimezone').val()!=""){
		        	$('#cmbtimezone').val($('#hidcmbtimezone').val()) ;	
		        }
			    }
	     }
	      x.open("GET","getTimezone.jsp",true);
	     x.send();
	    
        }
     
     //Ajax Method for checking Company Id Duplication
function checkcompid(value){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items=x.responseText;
		 	if(items.trim()!='undefine'){
		 		document.getElementById("txtcompid").focus();
		 		document.getElementById("errormsg").innerText="Company ID Already Exists";
		 	}
		 	else{
		 		
		 		document.getElementById("errormsg").innerText="";
		 		
		 	}
		    }
     }
      x.open("GET","checkCompid.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
     x.send();
    
}
 
	function funReadOnly(){
		$('#frmCompany input').attr('readonly', true );
		$('#frmCompany select').attr('disabled', true );
		 $('#compaccdate1').jqxDateTimeInput({ disabled: true}); 
		 $('#compaccdate2').jqxDateTimeInput({ disabled: true});
	}
	function funRemoveReadOnly(){
		$('#frmCompany input').attr('readonly', false );
		$('#frmCompany select').attr('disabled', false );
		$('#compaccdate1').jqxDateTimeInput({ disabled: false}); 
		 $('#compaccdate2').jqxDateTimeInput({ disabled: false});
	}
	
    function setValues(){
    	
    		 if($('#msg').val()!=""){
        		   $.messager.alert('Message',$('#msg').val());
        		  }
    		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    			funSetlabel();
    	
    }
 </script> 
</head>
<body onload="getCurrency();setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCompany" action="saveActionCompany" autocomplete="off">

    <jsp:include page="../../../../header.jsp" />
    <br/> 
  
    <div class="hidden-scrollbar">

        <div class="middle-panel" style="max-width: 1000px; margin-top: 30px;">
            <span class="middle-panel-title">Company Info</span>
            
            <div class="field-row">
                <label class="lbl-right">Company</label>
                <div style="display: flex; flex: 1; gap: 10px;">
                    <input type="text" id="txtcompid" name="txtcompid" value='<s:property value="txtcompid"/>' onblur="checkcompid(this.value);" style="width: 100px; flex: none;">
                    <input type="text" id="txtcompname" name="txtcompname" value='<s:property value="txtcompname"/>' style="flex: 1; max-width: 400px;">
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right">Address</label>
                <input type="text" id="txtaddress" name="txtaddress" value='<s:property value="txtaddress"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div class="field-row">
                <label class="lbl-right">P.B.No</label>
                <input type="text" id="txtpbno" name="txtpbno" value='<s:property value="txtpbno"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div class="field-row">
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Tel</label>
                    <input type="text" id="txttel1" name="txttel1" value='<s:property value="txttel1"/>' style="flex: 1; margin-left: 15px;">
                </div>
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Tel</label>
                    <input type="text" id="txttel2" name="txttel2" value='<s:property value="txttel2"/>' style="flex: 1; margin-left: 15px;">
                </div>
            </div>

            <div class="field-row">
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Fax</label>
                    <input type="text" id="txtfax1"  name="txtfax1" value='<s:property value="txtfax1"/>' style="flex: 1; margin-left: 15px;">
                </div>
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Fax</label>
                    <input type="text" id="txtfax2" name="txtfax2" value='<s:property value="txtfax2"/>' style="flex: 1; margin-left: 15px;">
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right">Email</label>
                <input type="email" id="txtemail1" name="txtemail1" value='<s:property value="txtemail1"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div class="field-row">
                <label class="lbl-right">Website</label>
                <input type="text" id="txtwebsite" name="txtwebsite" value='<s:property value="txtwebsite"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div style="border-top: 1px solid #e5e7eb; margin-top: 15px; padding-top: 15px;">
                <div class="field-row">
                    <label class="lbl-right">Account Period</label>
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <div id="compaccdate1" name="compaccdate1" value='<s:property value="compaccdate1"/>'></div>
                        <input type="hidden" id="hidcompaccdate1" name="hidcompaccdate1" value='<s:property value="hidcompaccdate1"/>'/>
                        
                        <span style="font-weight: 600; color: #444;">To</span>
                        
                        <div id="compaccdate2" name="compaccdate2" value='<s:property value="compaccdate2"/>'></div>
                        <input type="hidden" id="hidcompaccdate2" name="hidcompaccdate2" value='<s:property value="hidcompaccdate2"/>'/>
                    </div>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <div style="display: flex; align-items: center; flex: 1; max-width: 300px;">
                        <label class="lbl-right">Currency</label>
                        <select name="cmbcurr" id="cmbcurr" value='<s:property value="cmbcurr"/>' style="flex: 1; margin-left: 15px;">
                            <option value="">--Select--</option>
                        </select>
                    </div>
                    <div style="display: flex; align-items: center; flex: 1; max-width: 400px;">
                        <label class="lbl-right">Time Zone</label>
                        <select name="cmbtimezone" id="cmbtimezone" style="flex: 1; margin-left: 15px;">
                            <option value="">--Select--</option>
                        </select>
                    </div>
                </div>
            </div>

        </div>

        <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/>
        <div class="style1" id="datediv" style="display: none;">
            <div align="right">Please select a valid Date</div>
        </div>

        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
        <input type="hidden" name="hidcmbtimezone" id="hidcmbtimezone" value='<s:property value="hidcmbtimezone"/>' hidden="true"/>
        <input type="hidden" id="mode" name="mode"/>

    </div>
</form>
 </div>                                   
</body>
</html>