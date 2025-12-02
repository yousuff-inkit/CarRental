<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">

<script type="text/javascript">
     
	$(document).ready(function () {
	  	 /* Date */
	 	 $("#jqxVendorDate").jqxDateTimeInput({ width: '80%', height: '15px', formatString:"dd.MM.yyyy"});
	  
		 getCurrencyIds();getCategory();getGroup();getTypeAllowed();getType();
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
  				$("select#cmbaccgroup").html(optionsgroup);
  				if ($('#hidcmbaccgroup').val() != null) {
  					$('#cmbaccgroup').val($('#hidcmbaccgroup').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getGroup.jsp", true);
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
  		x.open("GET", "getCategory.jsp", true);
  		x.send();
  	}
	
	function getType() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var typeItems = items[0].split(",");
  				var typeIdItems = items[1].split(",");
  				var optionstype ;
  				for (var i = 0; i < typeItems.length; i++) {
  					optionstype += '<option value="' + typeIdItems[i] + '">'
  							+ typeItems[i] + '</option>';
  				}
  				$("select#cmbtype").html(optionstype);
  				if ($('#hidcmbtype').val() != null) {
  					$('#cmbtype').val($('#hidcmbtype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getType.jsp", true);
  		x.send();
  	}
	
	function getTypeAllowed(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    if(parseInt(items)==1) {
  			    	$('#typeallowed').val(1);
  			    	document.getElementById("lbltypeentity").style.display = 'inline-block';
  			    	document.getElementById("lbltrnnoentity").style.display = 'inline-block';
  			    	$('#cmbtype').attr('hidden', false);
  			    	$('#txtregisteredtrnno').attr('hidden', false);
  			    } else {
  			    	$('#typeallowed').val(0);
  			    	document.getElementById("lbltypeentity").style.display = 'none';
  			    	document.getElementById("lbltrnnoentity").style.display = 'none';
  			    	$('#cmbtype').attr('hidden', true);
  			    	$('#txtregisteredtrnno').attr('hidden', true);
  			    }
  			    
  		}
  		}
  		x.open("GET", "getTypeAllowed.jsp", true);
  		x.send();
 }
	
	function getCategoryAccountGroup(a) {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    $('#hidcmbaccgroup').val(items);
  				
  				if ($('#hidcmbaccgroup').val() != null || $('#hidcmbaccgroup').val() != "") {
  					$('#cmbaccgroup').val($('#hidcmbaccgroup').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
  		x.send();
  	} 
      
	function getCurrencyIds(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('####');
		        var curidItems=items[0];
		        var curcodeItems=items[1];
		        var multiItems=items[2];
		        var optionscurr = '';
		        
		     if(curcodeItems.indexOf(",")>=0){
		        	var currencyid=curidItems.split(",");
		        	var currencycode=curcodeItems.split(",");
		        	multiItems.split(",");
		       
		       for ( var i = 0; i < currencycode.length; i++) {
		    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
		        }
		      
		         $("select#cmbcurrency").html(optionscurr);
		         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
		       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
		         } 
				     
			   }
		
		       else{
		    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
		    	   
			    	 $("select#cmbcurrency").html(optionscurr);
			       
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         }
			      }
			}
	     }
	      x.open("GET", "getCurrencyId.jsp",true);
	     x.send();
	    
	   }
	   
	   function getVendorAlreadyExists(vendorname,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					 document.getElementById("errormsg").innerText="Vendor Already Exists.";
  					 return 0;
  				 }else{
  					$('#cmbaccgroup').attr('disabled', false);
  					$("#frmVendorDetails").submit();
  				 }
  			   
  		}
	}
	x.open("GET", "getVendorAlreadyExists.jsp?vendorname="+vendorname+"&docno="+docno+"&mode="+mode, true);
	x.send();
    }
	
	function getMobileNoAlreadyExists(mobileno,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					 $.messager.alert('Message','Mobile No. Already Exists.','warning');
  					 return 0;
  				 }
  		}
	}
	x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
	x.send();
	}
      
	 function funReadOnly(){
			$('#frmVendorDetails input').attr('readonly', true );
		    $('#frmVendorDetails select').attr('disabled', true); 
			$('#jqxVendorDate').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		    getCurrencyIds();getTypeAllowed();
		    
			$('#frmVendorDetails input').attr('readonly', false );
			$('#frmVendorDetails select').attr('disabled', false); 
			$('#jqxVendorDate').jqxDateTimeInput({disabled: false});
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#cmbaccgroup').attr('disabled', true);
			$('#docno').attr('readonly', true);
			$('#cmbtype').val("1");		$('#hidcmbtype').val("1");		

			if ($("#mode").val() == "A") {
				$('#jqxVendorDate').val(new Date());
			}
	 }
	 function funNotify(){	
		 
		 if(parseInt($('#typeallowed').val())==1) {
			 var taxtype=document.getElementById("cmbtype").value;
			 if(taxtype.trim()==''){
				 document.getElementById("errormsg").innerText="Type is Mandatory.";
				 return 0;
			 }
			 
			 if($('#cmbtype').find('option:selected').text()=='Registered'){
				 var registeredtrnno=document.getElementById("txtregisteredtrnno").value;
				 if(registeredtrnno.trim()==''){
					 document.getElementById("errormsg").innerText="TRN No. is Mandatory for Registered.";
					 return 0;
				 } 
			 }
		 }
		 var account=document.getElementById("cmbaccgroup").value;
		 if(account=="")
			{
			document.getElementById("errormsg").innerText=" Enter Account Group";
			document.getElementById("cmbaccgroup").focus();  
			return 0;
			}
		 
		 vendorname=document.getElementById("txtvendorname").value;
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		 getVendorAlreadyExists(vendorname,docno,mode);
		} 
	 
	 function funSearchLoad(){
			changeContent('vndMainSearch.jsp'); 
		 }
	 
	 function funFocus()
	    {
	    	$('#jqxVendorDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 getCurrencyIds();
		 
		 if($('#hidjqxVendorDate').val()){
			 $("#jqxVendorDate").jqxDateTimeInput('val', $('#hidjqxVendorDate').val());
		  }
		 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 /* Validations */
	 $(function(){
	        $('#frmVendorDetails').validate({
	                rules: {
	                txtvendorname:"required",
	                cmbcurrency:"required",
	                cmbcategory:"required",
	                cmbaccgroup:"required",
	                //txtmob: {"required":true,digits:true,maxlength:12,minlength:12},
	                 
	                 },
	                 messages: {
	                 txtvendorname:" *",
	                 cmbcurrency:" *",
	                 cmbcategory:" *",
	                 cmbaccgroup:" *",
	                 //txtmob: {required:" *",digits:" Invalid Mobile Number",maxlength:" Maximum 12 Digits",minlength:" Please Enter 12 Digits"},
	                 }
	        });});
	 
	 function funExcelBtn(){
		    var url=document.URL;
		    var reurl=url.split("suppliers");
		    top.addTab("VendorList",reurl[0]+"suppliers/vendorList.jsp");
		}
	 
</script>

<style>
/* UNIVERSAL GRID ROW */
.form-grid {
    display: grid;
    grid-template-columns: 150px 1fr 150px 1fr 150px 1fr;
    gap: 22px 28px;
    align-items: center;
    width: 100%;
    margin-bottom: 25px;
}

/* ROW WITH FEWER ITEMS (3-column layout) */
.form-grid-3 {
    display: grid;
    grid-template-columns: 180px 1fr 180px 1fr 180px 1fr;
    gap: 22px 28px;
    align-items: center;
    width: 100%;
    margin-bottom: 25px;
}

/* LABELS */
.form-label {
    font-size: 15px;
    font-weight: 600;
    color: #2f3b52;
    margin-bottom: 4px;
}

/* INPUT + SELECT */
.form-input {
    width: 100%;
    height: 38px !important;
    border: 1px solid #ccd4e0;
    border-radius: 8px;
    padding: 6px 10px;
    font-size: 15px !important;
    background: white;
}

/* jqx Date controls */
.jqx-datetimeinput {
    width: 100% !important;
    height: 38px !important;
    border-radius: 8px !important;
}

/* SECTION CARD */
.section-card {
    background: #f7f9ff;
    padding: 24px 28px;
    border-radius: 14px;
    box-shadow: 0 2px 7px rgba(0,0,0,0.07);
    margin-bottom: 26px;
}

/* Autofill fix for ALL inputs and selects */
input:-webkit-autofill,
select:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px white inset !important;
    -webkit-text-fill-color: #000 !important;
}

/* Make selects look modern */
select.form-input {
    appearance: none;
    background-image: url("data:image/svg+xml;utf8,<svg fill='gray' height='20' viewBox='0 0 20 20' width='20' xmlns='http://www.w3.org/2000/svg'><path d='M7 7l3 3 3-3z'/></svg>");
    background-position: right 12px center;
    background-repeat: no-repeat;
    padding-right: 35px;
}
/* Uniform modern input size for all fields */
.form-input, 
#jqxVendorDate, 
#postingDate, 
#jqxUnclearedChequeProcessFromDate,
#jqxUnclearedChequeProcessToDate,
#jqxUnclearedChequeProcessingDate {
    width: 220px !important;     /* 👈 Same width as Currency, slight extra */
    height: 38px !important;
    border: 1px solid #cdd6e2;
    border-radius: 8px;
    padding: 6px 10px;
    background: #fff !important;
    box-sizing: border-box;
    font-size: 15px;
}

/* Label directly above input, aligned clean */
.form-label {
    font-size: 14px;
    font-weight: 600;
    margin-bottom: 4px;
    color: #2f3b52;
}

/* 3-column grid for perfect ERP alignment */
.form-grid,
.form-grid-3 {
    display: grid;
    grid-template-columns: auto 220px auto 220px auto 220px; /* label + input pairs */
    column-gap: 28px;
    row-gap: 18px;
    align-items: center;
}

/* Section card container */
.section-card {
    background: #f7f9ff;
    border-radius: 12px;
    padding: 22px 28px;
    margin-bottom: 22px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}
/* Uniform modern input size */
.form-input,
#jqxVendorDate,
#jqxUnclearedChequeProcessFromDate,
#jqxUnclearedChequeProcessToDate,
#jqxUnclearedChequeProcessingDate,
#postingDate,
input[type="text"],
input[type="email"],
select {
    width: 210px !important;     /* SAME width for all input fields */
    height: 36px !important;
    padding: 6px 10px;
    border-radius: 8px;
    border: 1px solid #cbd3df;
    background: #fff !important;
    font-size: 15px;
    box-sizing: border-box;
}

/* Labels */
.form-label {
    font-weight: 600;
    font-size: 14px;
    margin-bottom: 3px;
    color: #2f3b52;
}

/* Very tight label-input pairing */
.pair {
    display: flex;
    flex-direction: column;
    gap: 3px;            /* minimal spacing between label and input */
}

/* Tight horizontal grid: Label+Input repeated */
.form-row {
    display: grid;
    grid-template-columns: repeat(4, auto 210px);  
    /* auto = label width, 210px = input width */
    gap: 14px 32px;      /* minimal row gap, small column spacing */
    align-items: center;
    margin-bottom: 14px;
}

/* Section wrapper */
.section-card {
    background: #f7f9ff;
    padding: 18px 24px;
    border-radius: 12px;
    margin-bottom: 22px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

</style>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent">

<form id="frmVendorDetails" action="saveVendorDetails" method="post" autocomplete="off">

    <!-- HEADER -->
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br/>

    <!-- ============================
         SECTION 1: DATE / CODE / NAME / DOC NO
       ============================ -->
    <div class="section-card">
        <div class="form-grid">

            <label class="form-label">Date</label>
            <div id="jqxVendorDate"></div>
            <input type="hidden" id="hidjqxVendorDate" name="hidjqxVendorDate"
                   value='<s:property value="hidjqxVendorDate"/>'/>

            <label class="form-label">Code</label>
            <input type="text" id="txtcode" name="txtcode" class="form-input"
                   value='<s:property value="txtcode"/>' tabindex="-1"/>

            <label class="form-label">Name</label>
            <input type="text" id="txtvendorname" name="txtvendorname" class="form-input"
                   value='<s:property value="txtvendorname"/>'/>

            <label class="form-label">Doc No</label>
            <input type="text" id="docno" name="txtvendordocno" class="form-input"
                   value='<s:property value="txtvendordocno"/>' tabindex="-1"/>

        </div>
    </div>


    <!-- ============================
         SECTION 2: CURRENCY / CATEGORY / TYPE / TRN
       ============================ -->
    <div class="section-card">
        <div class="form-grid">

            <label class="form-label">Currency</label>
            <select id="cmbcurrency" name="cmbcurrency" class="form-input">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency"
                   value='<s:property value="hidcmbcurrency"/>'/>

            <label class="form-label">Category</label>
            <select id="cmbcategory" name="cmbcategory" class="form-input"
                    onchange="getCategoryAccountGroup(this.value);">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory"
                   value='<s:property value="hidcmbcategory"/>'/>

            <label class="form-label" id="lbltypeentity">Type</label>
            <select id="cmbtype" name="cmbtype" class="form-input"></select>
            <input type="hidden" id="hidcmbtype" name="hidcmbtype"
                   value='<s:property value="hidcmbtype"/>'/>

            <label class="form-label" id="lbltrnnoentity">TRN No.</label>
            <input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno"
                   class="form-input" value='<s:property value="txtregisteredtrnno"/>'/>

        </div>
    </div>


    <!-- ============================
         SECTION 3: ACCOUNT GROUP / CREDIT
       ============================ -->
    <div class="section-card">
        <div class="form-grid-3">

            <label class="form-label">Account Group</label>
            <select id="cmbaccgroup" name="cmbaccgroup" class="form-input">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbaccgroup" name="hidcmbaccgroup"
                   value='<s:property value="hidcmbaccgroup"/>'/>

            <label class="form-label">Account</label>
            <input type="text" id="txtaccount" name="txtaccount" class="form-input"
                   value='<s:property value="txtaccount"/>' tabindex="-1"/>

            <label class="form-label">Credit Min (Days)</label>
            <input type="text" id="txtcredit_period_min" name="txtcredit_period_min"
                   class="form-input" style="text-align:right;"
                   value='<s:property value="txtcredit_period_min"/>'/>

            <label class="form-label">Max (Days)</label>
            <input type="text" id="txtcredit_period_max" name="txtcredit_period_max"
                   class="form-input" style="text-align:right;"
                   value='<s:property value="txtcredit_period_max"/>'/>

            <label class="form-label">Credit Limit</label>
            <input type="text" id="txtcredit_limit" name="txtcredit_limit"
                   class="form-input" style="text-align:right;"
                   value='<s:property value="txtcredit_limit"/>'/>

        </div>
    </div>


    <!-- ============================
         SECTION 4: ADDRESS / TEL / MOB / ETC
       ============================ -->
    <div class="section-card">

        <div class="form-grid">
            <label class="form-label">Address</label>
            <input type="text" id="txtaddress" name="txtaddress" class="form-input"
                   value='<s:property value="txtaddress"/>'/>

            <label class="form-label">Address 2</label>
            <input type="text" id="txtaddress1" name="txtaddress1" class="form-input"
                   value='<s:property value="txtaddress1"/>'/>

            <label class="form-label">Tel</label>
            <input type="text" id="txttel" name="txttel" class="form-input"
                   value='<s:property value="txttel"/>'/>
        </div>

        <div class="form-grid">
            <label class="form-label">Mob</label>
            <input type="text" id="txtmob" name="txtmob" class="form-input"
                   onblur="getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());"
                   value='<s:property value="txtmob"/>'/>

            <label class="form-label">Office No.</label>
            <input type="text" id="txtoffice" name="txtoffice" class="form-input"
                   value='<s:property value="txtoffice"/>'/>

            <label class="form-label">Fax</label>
            <input type="text" id="txtfax" name="txtfax" class="form-input"
                   value='<s:property value="txtfax"/>'/>
        </div>

        <div class="form-grid">
            <label class="form-label">Email</label>
            <input type="email" id="txtemail" name="txtemail" class="form-input"
                   placeholder="someone@example.com"
                   value='<s:property value="txtemail"/>'/>

            <label class="form-label">Contact Person</label>
            <input type="text" id="txtcontact" name="txtcontact" class="form-input"
                   value='<s:property value="txtcontact"/>'/>

            <label class="form-label">Extn. No.</label>
            <input type="text" id="txtextno" name="txtextno" class="form-input"
                   value='<s:property value="txtextno"/>'/>
        </div>

    </div>

    <!-- ========== REQUIRED HIDDEN FIELDS ========== -->
    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation"
           value='<s:property value="txtmobilevalidation"/>'/>
    <input type="hidden" id="typeallowed" name="typeallowed"
           value='<s:property value="typeallowed"/>'/>

</form>

</div>

</body>

</html>