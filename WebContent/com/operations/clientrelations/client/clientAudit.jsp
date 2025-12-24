<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <include page="<%=contextPath%>/includes.jsp" /> --%>
<style type="text/css">
 #frmClientAudit {
    background-color: #E0ECF8;
     font-size: 9px; 
    /* font: 10px Tahoma; */
}

.formfont {
	font: 10px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow:hidden;
}

</style>

<script type="text/javascript">
      $(document).ready(function (){
    	  $("#jqxClientDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
 		funReadOnly();getGroup();getSalesman();getCategory();getNationality();funCurrency();setValues();
 		 
        $("#jqxDriver1").load("<%=contextPath+"/"%>com/operations/clientrelations/client/driver.jsp?txtclientdocno1="+document.getElementById("docno").value);
        $("#jqxReferenceDetails1").load("<%=contextPath+"/"%>com/operations/clientrelations/client/referenceDetails.jsp?txtclientdocno3="+document.getElementById("docno").value);
		 
      });  
     
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
  				$("select#cmbgroup1").html(optionsgroup);
  				if ($('#hidcmbgroup1').val() != null) {
  					$('#cmbgroup1').val($('#hidcmbgroup1').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getGroup.jsp", true);
  		x.send();
  	}  
     
      function getSalesman() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var salesagentItems = items[0].split(",");
    				var salesagentIdItems = items[1].split(",");
    				var optionssalesagent = '<option value="">--Select--</option>';
    				for (var i = 0; i < salesagentItems.length; i++) {
    					optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
    							+ salesagentItems[i] + '</option>';
    				}
    				$("select#cmbsalesman").html(optionssalesagent);
    				if ($('#hidcmbsalesman').val() != null) {
    					$('#cmbsalesman').val($('#hidcmbsalesman').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getSalesagent.jsp", true);
    		x.send();
    	} 
      
      function getCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var categoryItems = items[0].split(",");
  				var categoryIdItems = items[1].split(",");
  				var optionscategory = '<option value="">--Select--</option>';
  				for (var i = 0; i < categoryItems.length; i++) {
  					optionscategory += '<option value="' + categoryIdItems[i] + '">'
  							+ categoryItems[i] + '</option>';
  				}
  				$("select#cmbcategory").html(optionscategory);
  				if ($('#hidcmbcategory').val() != null) {
  					$('#cmbcategory').val($('#hidcmbcategory').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getCategory.jsp", true);
  		x.send();
  	} 
      
       function getCurrencyId(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var curidItems=items[0];
			        var curcodeItems=items[1];
			        var currateItems=items[2];
			       
			        var optionscurr = '';
			        if(curcodeItems.indexOf(",")>=0){
			        	curidItems.split(",");
			        	curcodeItems.split(",");
			        	currateItems.split(",");
			        	for ( var i = 0; i < curcodeItems.length; i++) {
			    	   optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
			        }
			         $("select#cmbcurrency").html(optionscurr);
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			         $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         } 
				   
				    }
			
			       else
				  {
			    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
			    	   $("select#cmbcurrency").html(optionscurr);
			    	   if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			    	   		$('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			    	   } 
				  }
				}
		     }
		      x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getCurrencyId.jsp",true);
		     x.send();
		    
	       } 
     
      function getNationality() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var nationItems = items[0].split(",");
    				var nationIdItems = items[1].split(",");
    				var optionsnation = '<option value="">--Select--</option>';
    				for (var i = 0; i < nationItems.length; i++) {
    					optionsnation += '<option value="' + nationIdItems[i] + '">'
    							+ nationItems[i] + '</option>';
    				}
    				$("select#cmbnationality").html(optionsnation);
    				if ($('#hidcmbnationality').val() != null) {
    					$('#cmbnationality').val($('#hidcmbnationality').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getNationality.jsp", true);
    		x.send();
    	}  
      
     function defaultcheck(){
 		 if(document.getElementById("chckdefault").checked){
 			 document.getElementById("hidchckdefault").value = 1;
 			 $('#txtsalik').attr('readonly', true );
 			 $('#txtsalik').val("0.0");
 			 $('#txttraffic').attr('readonly', true );
 			 $('#txttraffic').val("0.0");
 		 }
 		 else{
 			 document.getElementById("hidchckdefault").value = 0;
 			 $('#txtsalik').attr('readonly', false );
 			 $('#txtsalik').val("0.0");
 			 $('#txttraffic').attr('readonly', false );
 			 $('#txttraffic').val("0.0");
 		 }
 	 }
     
	 function funReadOnly(){
			$('#frmClientAudit input').attr('readonly', true );
			$('#frmClientAudit select').attr('disabled', true);
			$('#jqxClientDate').jqxDateTimeInput({disabled: true});
			$("#jqxDriver").jqxGrid({ disabled: true});
			$("#jqxReferenceDetails").jqxGrid({ disabled: true});
	 }
	 function funRemoveReadOnly(){
		
			$('#frmClientAudit input').attr('readonly', false );
			$('#frmClientAudit select').attr('disabled', false);
			$('#chckdefault').attr('disabled', false);
			$('#jqxClientDate').jqxDateTimeInput({disabled: false});
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#docno').attr('readonly', true);
			$("#jqxDriver").jqxGrid({ disabled: false});
			$("#jqxReferenceDetails").jqxGrid({ disabled: false});
		
	 }
	 function funNotify(){	
		 
		 document.getElementById("errormsg").innerText="";		 
		 
		 var rows = $("#jqxDriver").jqxGrid('getrows');
		 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].name;
				if(typeof(chk) != "undefined"){
					length=length+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
				    .attr("hidden", "true");
			
			newTextBox.val(rows[i].name+"::"+rows[i].hiddob+"::"+rows[i].nation1+"::"+rows[i].mobno+"::"+rows[i].passport_no+"::"+rows[i].hidpassexp+"::"+rows[i].dlno+"::"+rows[i].hidissdate+"::"+rows[i].issfrm+"::"+rows[i].hidled+"::"+rows[i].ltype+"::"+rows[i].visano+"::"+rows[i].hidvisaexp);
			newTextBox.appendTo('form');
			 }
			}
 		 $('#gridlength').val(length);
 		
 		 var rows = $("#jqxReferenceDetails").jqxGrid('getrows');
 		 var referencelength=0;
 		 for(var i=0 ; i < rows.length ; i++){
 				var chkd=rows[i].cperson;
				if(typeof(chkd) != "undefined"){
				referencelength=referencelength+1;
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "txtreference"+i)
			    .attr("name", "txtreference"+i)
			    .attr("hidden", "true");
		
			newTextBox.val(rows[i].cperson+" :: "+rows[i].desig+" :: "+rows[i].mob+" :: "+rows[i].email+" ::");
			newTextBox.appendTo('form');
			}
	      }
	      $('#referencelength').val(referencelength);

	      return 1;
	    	
		} 
	 
	 function funSearchLoad(){
			/* changeContent('crmMainSearch.jsp'); */ 
		 }
	 
	 function funFocus(){
	    	$('#jqxClientDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function funCurrency(){
		 if($('#hidcmbcurrency').val()!=""){
			 getCurrencyId();
			 $('#cmbcurrency').val($('#hidcmbcurrency').val());
		 }
	 }
	 
	 function setValues(){
		   
			 if($('#hidjqxClientDate').val()){
				 $("#jqxClientDate").jqxDateTimeInput('val', $('#hidjqxClientDate').val());
			  }
			
			 if(document.getElementById("hidchckdefault").value==1){
	 			 document.getElementById("chckdefault").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckdefault").value==0){
	 			document.getElementById("chckdefault").checked = false;
	 		 }
			 
			document.getElementById("cmbgroup").value=document.getElementById("hidcmbgroup").value;
			document.getElementById("cmbinvoicing_method").value=document.getElementById("hidcmbinvoicing_method").value;
			$('#cmbdel_charges').val($('#hidcmbdel_charges').val());  
			
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 
  </script>
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
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

input[type="text"], select {
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
    font: 14px 'Segoe UI';
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
}

.section-block {
    flex: 1;
    min-width: 0;
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
    display: flex;
    align-items: center;
    gap: 10px;
}

.section-row {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
}

.trans-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr auto 1fr auto 1fr;
    gap: 12px 15px;
    align-items: center;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr;
    gap: 12px 20px;
    align-items: center;
}

.hidden-scrollbar {
    overflow-y: visible !important;
    max-height: none !important;
    padding: 10px;
}

/* Communication Table Styles */
.table1 {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
}

.table1 th, .table1 td {
    padding: 8px;
    border-bottom: 1px solid #eee;
    border-right: 1px solid #eee;
}

.table1 thead th {
    background: #f1f3f5;
    font-weight: 600;
}
</style>

<body id="search" onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br>

    <form id="frmClientAudit" action="saveClientMaster" method="post" autocomplete="off">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>General Information</h2>
                <div class="trans-info-grid">
                    <label>Date</label>
                    <div id="jqxClientDate" name="jqxClientDate" value='<s:property value="jqxClientDate"/>'></div>
                    
                    <label>Code</label>
                    <input type="text" id="txtcode" name="txtcode" tabindex="-1" value='<s:property value="txtcode"/>'/>

                    <label>Name</label>
                    <input type="text" id="txtclient_name" name="txtclient_name" onfocus="getCurrencyId();" value='<s:property value="txtclient_name"/>'/>

                    <label>Currency</label>
                    <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>'>
                        <option value="">--Select--</option>
                    </select>
                    
                    <label>Doc No.</label>
                    <input type="text" id="docno" name="txtclientdocno" tabindex="-1" value='<s:property value="txtclientdocno"/>'/>

                    <label>Group</label>
                    <select id="cmbgroup" name="cmbgroup" value='<s:property value="cmbgroup"/>'>
                        <option value="">----</option>
                        <option value="A">A</option><option value="B">B</option><option value="C">C</option>
                        <option value="D">D</option><option value="E">E</option><option value="N">N</option>
                    </select>

                    <label>Category</label>
                    <select id="cmbcategory" name="cmbcategory" value='<s:property value="cmbcategory"/>'>
                        <option value="">--Select--</option>
                    </select>

                    <label>Salesman</label>
                    <select id="cmbsalesman" name="cmbsalesman" value='<s:property value="cmbsalesman"/>'>
                        <option value="">--Select--</option>
                    </select>

                    <label>Invoicing</label>
                    <select id="cmbinvoicing_method" name="cmbinvoicing_method" value='<s:property value="cmbinvoicing_method"/>'>
                        <option value="">--Select--</option>
                        <option value="1">Advance</option>
                        <option value="2">Month End</option>
                        <option value="3">Period</option>
                    </select>

                    <label>Del. Charges</label>
                    <select id="cmbdel_charges" name="cmbdel_charges" value='<s:property value="cmbdel_charges"/>'>
                        <option value="">--Select--</option>
                        <option value=1>Yes</option>
                        <option value=0>No</option>
                    </select>
                </div>
            </div>

            <div class="section-row">
                <div class="section-block">
                    <h2>Account Info</h2>
                    <div class="agmt-info-grid">
                        <label>Account Group</label>
                        <select id="cmbgroup1" name="cmbgroup1" value='<s:property value="cmbgroup1"/>'>
                            <option value="">--Select--</option>
                        </select>

                        <label>Account</label>
                        <input type="text" id="txtaccount" name="txtaccount" tabindex="-1" value='<s:property value="txtaccount"/>'/>

                        <label>Credit Min (Days)</label>
                        <input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="text-align: right;" value='<s:property value="txtcredit_period_min"/>'/>

                        <label>Max (Days)</label>
                        <input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="text-align: right;" value='<s:property value="txtcredit_period_max"/>'/>

                        <label>Credit Limit</label>
                        <input type="text" id="txtcredit_limit" name="txtcredit_limit" style="text-align: right;" value='<s:property value="txtcredit_limit"/>'/>
                    </div>
                </div>

                <div class="section-block">
                    <h2>Service Charge</h2>
                    <div class="agmt-info-grid">
                        <div style="grid-column: span 2; display: flex; align-items: center; gap: 8px;">
                            <input type="checkbox" id="chckdefault" name="chckdefault" onchange="defaultcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label>Default</label>
                        </div>
                        
                        <label>Salik</label>
                        <input type="text" id="txtsalik" name="txtsalik" style="text-align: right;" value='<s:property value="txtsalik"/>'/>
                        
                        <label>Traffic</label>
                        <input type="text" id="txttraffic" name="txttraffic" style="text-align: right;" value='<s:property value="txttraffic"/>'/>
                    </div>
                </div>
            </div>

            <div class="section-block">
                <h2>Driver Details</h2>
                <div id="jqxDriver1"><jsp:include page="driver.jsp"></jsp:include></div>
            </div>

            <div class="section-block">
                <h2>Know Your Customer</h2>
                <table class="table1">
                    <thead>
                        <tr>
                            <th>Field</th>
                            <th>Personal Details</th>
                            <th>Office Details</th>
                            <th>Residence Details</th>
                            <th>Home Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Address 1</strong></td>
                            <td><input type="text" id="txtpersonal_add1" name="txtpersonal_add1" value='<s:property value="txtpersonal_add1"/>'/></td>
                            <td><input type="text" id="txtoffice_add1" name="txtoffice_add1" value='<s:property value="txtoffice_add1"/>'/></td>
                            <td><input type="text" id="txtresidence_add1" name="txtresidence_add1" value='<s:property value="txtresidence_add1"/>'/></td>
                            <td><input type="text" id="txthome_add1" name="txthome_add1" value='<s:property value="txthome_add1"/>'/></td>
                        </tr>
                        <tr>
                            <td><strong>Address 2</strong></td>
                            <td><input type="text" id="txtpersonal_add2" name="txtpersonal_add2" value='<s:property value="txtpersonal_add2"/>'/></td>
                            <td><input type="text" id="txtoffice_add2" name="txtoffice_add2" value='<s:property value="txtoffice_add2"/>'/></td>
                            <td><input type="text" id="txtresidence_add2" name="txtresidence_add2" value='<s:property value="txtresidence_add2"/>'/></td>
                            <td><input type="text" id="txthome_add2" name="txthome_add2" value='<s:property value="txthome_add2"/>'/></td>
                        </tr>
                        <tr>
                            <td><strong>Telephone</strong></td>
                            <td><input type="text" id="txtpersonal_tel1" name="txtpersonal_tel1" value='<s:property value="txtpersonal_tel1"/>'/></td>
                            <td><input type="text" id="txtoffice_tel1" name="txtoffice_tel1" value='<s:property value="txtoffice_tel1"/>'/></td>
                            <td><input type="text" id="txtresidence_tel1" name="txtresidence_tel1" value='<s:property value="txtresidence_tel1"/>'/></td>
                            <td><input type="text" id="txthome_tel1" name="txthome_tel1" value='<s:property value="txthome_tel1"/>'/></td>
                        </tr>
                        <tr>
                            <td><strong>Mobile</strong></td>
                            <td><input type="text" id="personal_tel2" name="personal_tel2" onblur="mobileValid(this.value);" value='<s:property value="personal_tel2"/>'/></td>
                            <td><input type="text" id="office_tel2" name="office_tel2" onblur="mobileValid(this.value);" value='<s:property value="office_tel2"/>'/></td>
                            <td><input type="text" id="residence_tel2" name="residence_tel2" onblur="mobileValid(this.value);" value='<s:property value="residence_tel2"/>'/></td>
                            <td><input type="text" id="home_tel2" name="home_tel2" onblur="mobileValid(this.value);" value='<s:property value="home_tel2"/>'/></td>
                        </tr>
                        <tr>
                            <td><strong>Email</strong></td>
                            <td><input type="text" id="txtpersonal_email" name="txtpersonal_email" placeholder="someone@example.com" value='<s:property value="txtpersonal_email"/>'/></td>
                            <td><input type="text" id="txtoffice_email" name="txtoffice_email" placeholder="someone@example.com" value='<s:property value="txtoffice_email"/>'/></td>
                            <td><input type="text" id="txtresidence_email" name="txtresidence_email" placeholder="someone@example.com" value='<s:property value="txtresidence_email"/>'/></td>
                            <td><input type="text" id="txthome_email" name="txthome_email" placeholder="someone@example.com" value='<s:property value="txthome_email"/>'/></td>
                        </tr>
                        <tr>
                            <td><strong>Extn. No.</strong></td>
                            <td><input type="text" id="txtpersonal_extn_no" name="txtpersonal_extn_no" value='<s:property value="txtpersonal_extn_no"/>'/></td>
                            <td><input type="text" id="txtoffice_extn_no" name="txtoffice_extn_no" value='<s:property value="txtoffice_extn_no"/>'/></td>
                            <td><input type="text" id="txtresidence_extn_no" name="txtresidence_extn_no" value='<s:property value="txtresidence_extn_no"/>'/></td>
                            <td><input type="text" id="txthome_extn_no" name="txthome_extn_no" value='<s:property value="txthome_extn_no"/>'/></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="section-row">
                <div class="section-block">
                    <h2>Reference Details</h2>
                    <div id="jqxReferenceDetails1"><jsp:include page="referenceDetails.jsp"></jsp:include></div>
                </div>

                <div class="section-block">
                    <h2>Sponsor Details</h2>
                    <div class="agmt-info-grid">
                        <label>Name</label>
                        <input type="text" id="txtname" name="txtname" value='<s:property value="txtname"/>'/>

                        <label>Address</label>
                        <input type="text" id="txtaddress" name="txtaddress" value='<s:property value="txtaddress"/>'/>

                        <label>Telephone</label>
                        <input type="text" id="txttelephone" name="txttelephone" value='<s:property value="txttelephone"/>'/>

                        <label>ID.</label>
                        <input type="text" id="txtid" name="txtid" value='<s:property value="txtid"/>'/>

                        <label>Nationality</label>
                        <select id="cmbnationality" name="cmbnationality" value='<s:property value="cmbnationality"/>'>
                            <option value="">--Select--</option>
                        </select>

                        <label>Security</label>
                        <div style="display: flex; gap: 8px;">
                            <input type="text" id="txtsecurity" name="txtsecurity" value='<s:property value="txtsecurity"/>'/>
                            <input type="text" id="txtsecurity1" name="txtsecurity1" value='<s:property value="txtsecurity1"/>'/>
                        </div>
                    </div>
                </div>
            </div>

            <input type="hidden" id="hidjqxClientDate" name="hidjqxClientDate" value='<s:property value="hidjqxClientDate"/>'/>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
            <input type="hidden" id="hidcmbgroup" name="hidcmbgroup" value='<s:property value="hidcmbgroup"/>'/>
            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
            <input type="hidden" id="hidcmbsalesman" name="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'/>
            <input type="hidden" id="hidcmbinvoicing_method" name="hidcmbinvoicing_method" value='<s:property value="hidcmbinvoicing_method"/>'/>
            <input type="hidden" id="hidcmbdel_charges" name="hidcmbdel_charges" value='<s:property value="hidcmbdel_charges"/>'/>
            <input type="hidden" id="hidcmbgroup1" name="hidcmbgroup1" value='<s:property value="hidcmbgroup1"/>'/>
            <input type="hidden" id="hidchckdefault" name="hidchckdefault" value='<s:property value="hidchckdefault"/>'/>
            <input type="hidden" id="hidcmbnationality" name="hidcmbnationality" value='<s:property value="hidcmbnationality"/>'/>
            
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
            <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
            <input type="hidden" id="referencelength" name="referencelength"/>
            <input type="hidden" id="attachlength" name="attachlength"/>
        </div>
    </form>
</div>

</body>
</html>