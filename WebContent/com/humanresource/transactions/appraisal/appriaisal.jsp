<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include> 
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">

 $(document).ready(function () {
	 
   	 $("#masterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $("#leastpaydate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $("#joindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $("#prevappdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	  
   	/* Searching Window */
   	 $('#empsearchwndow').jqxWindow({ width: '60%', height: '59%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Employee Search' ,position: { x: 300, y: 80 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#empsearchwndow').jqxWindow('close'); 
 
     $('#empid').dblclick(function(){
	  	    $('#empsearchwndow').jqxWindow('open');
	  	    empSearchContent('employeeDetailsSearch.jsp'); 
     }); 
     
     
     $('#leastpaydate').on('change', function (event) {
		   
		 if ($("#mode").val() == "A" || $("#mode").val() == "E") {  
			 
			 if(document.getElementById("cmbyear").value==""|| document.getElementById("cmbmonth").value=="") {
				 return 0;
			  }
			 
		      var payrolldate=new Date($('#leastpaydate').jqxDateTimeInput('getDate'));     
		      payrolldate.setHours(0,0,0,0);
              var year1=payrolldate.getFullYear();  
		      var cmbyear=document.getElementById("cmbyear").value;
		  
			  if(year1>cmbyear) {
			     document.getElementById("errormsg").innerText="Year Cannot be Less than Last Payroll Created On	";
			     return false; 
		      }
 
		      if(year1<cmbyear) {
	    		 var mounth1=payrolldate.getMonth()+1;
			     var cmbmonth=document.getElementById("cmbmonth").value;  
			     if(mounth1>=cmbmonth) {
				   document.getElementById("errormsg").innerText="Month Cannot be Less than Last Payroll Created On	";
			       return false; 
			     } else {   
				   document.getElementById("errormsg").innerText="";  
				 } 
			  } else {
		   		   document.getElementById("errormsg").innerText="";  
			  } 
		 }
   });
		
 });
		
   function empSearchContent(url) {
		 $.get(url).done(function (data) {
		 $('#empsearchwndow').jqxWindow('open');
		 $('#empsearchwndow').jqxWindow('setContent', data);
	}); 
	} 
	   
	function getEmployee(event){
       var x= event.keyCode;
       if(x==114){
    	   empSearchContent('employeeDetailsSearch.jsp');
       }
       else{}
       }
	   
    function funReset(){}
    
	function funReadOnly(){
		  $('#frmappraisal input').prop('readonly', true );
		  $('#change').attr('disabled', true);
		  $('#masterdate').jqxDateTimeInput({ disabled: true});
		  $('#leastpaydate').jqxDateTimeInput({ disabled: true});
		  $('#joindate').jqxDateTimeInput({ disabled: true});
		  $('#prevappdate').jqxDateTimeInput({ disabled: true});
		  $("#compensationGridID").jqxGrid({ disabled: true});
		 
		  $('#cmbdept').attr("disabled", true);
		  $('#cmbdesignation').attr("disabled", true);
		  $('#cmbcategory').attr("disabled", true);
		  $('#cmbdept').attr("disabled", true);
		  $('#cmbyear').attr("disabled", true);
		  $('#cmbmonth').attr("disabled", true);
	}

	function funRemoveReadOnly(){
		  $('#frmappraisal input').prop('readonly', true );
		  $('#masterdate').jqxDateTimeInput({ disabled: false});
		  $('#leastpaydate').jqxDateTimeInput({ disabled: false});
		  $('#joindate').jqxDateTimeInput({ disabled: true});
		  $('#prevappdate').jqxDateTimeInput({ disabled: false});
		  $('#desc').attr("readonly", false);
		  $('#change').attr('disabled', false);
		  $('#cmbdept').attr("disabled", true);
		  $('#cmbdesignation').attr("disabled", true);
		  $('#cmbcategory').attr("disabled", true);
		  $('#cmbyear').attr("disabled", false);
		  $('#cmbmonth').attr("disabled", false);
	   
		 if($("#mode").val() == "A") {
			  $("#compensationGridID").jqxGrid('clear');
		      $("#compensationGridID").jqxGrid('addrow', null, {});
		      $("#compensationGridID").jqxGrid('disabled', false);
		  	  $('#masterdate').val(new Date());
			  $('#leastpaydate').val(new Date());
			  $('#joindate').val(new Date());
			  $('#prevappdate').val(new Date());
		  }
		 
		 if($("#mode").val() == "E") {
			 
		      var docVal1=document.getElementById("docno").value; 
			  $("#comdiv").load("compensationGrid.jsp?docno="+docVal1+"&mode="+$("#mode").val()+"&check="+1); 
			 
			  if(document.getElementById("change").checked==true) {
					 $('#cmbdept').attr("disabled", false);
					 $('#cmbdesignation').attr("disabled", false);
					 $('#cmbcategory').attr("disabled", false);
			  }
		 }
	} 
	
	
	function checkchange() {
		if(document.getElementById("change").checked==true) {
			$('#cmbdept').attr("disabled", false);
		 	$('#cmbdesignation').attr("disabled", false);
		 	$('#cmbcategory').attr("disabled", false);
		 	$('#cmbdept').attr("disabled", false);
		} else {
			$('#cmbdept').attr("disabled", true);
			$('#cmbdesignation').attr("disabled", true);
			$('#cmbcategory').attr("disabled", true);
			$('#cmbdept').attr("disabled", true);
		}
	}
	       
	function getDesignation() {
	      var x = new XMLHttpRequest();
	      x.onreadystatechange = function() {
	       if (x.readyState == 4 && x.status == 200) {
	        var items = x.responseText;
	        items = items.split('####');
	        var designationItems = items[0].split(",");
	        var designationIdItems = items[1].split(",");
	        var optionsdesignation = '<option value="">--Select--</option>';
	        for (var i = 0; i < designationItems.length; i++) {
	         optionsdesignation += '<option value="' + designationIdItems[i] + '">'
	           + designationItems[i] + '</option>';
	        }
	        $("select#cmbdesignation").html(optionsdesignation);
	        if ($('#hidcmbdesignation').val() != null) {
	         $('#cmbdesignation').val($('#hidcmbdesignation').val());
	        }
	       } else {
	       }
	      }
	      x.open("GET", "getDesignation.jsp", true);
	      x.send();
	     }
	 
	function getDepartment() {  
	      var x = new XMLHttpRequest();
	      x.onreadystatechange = function() {
	       if (x.readyState == 4 && x.status == 200) {
	        var items = x.responseText;
	        items = items.split('####');
	        var departmentItems = items[0].split(",");
	        var departmentIdItems = items[1].split(",");
	        var optionsdepartment = '<option value="">--Select--</option>';
	        for (var i = 0; i < departmentItems.length; i++) {
	         optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
	           + departmentItems[i] + '</option>';
	        }
	        $("select#cmbdept").html(optionsdepartment);
	        if ($('#hidcmbdept').val() != null) {
	         $('#cmbdept').val($('#hidcmbdept').val());
	        }
	       } else {
	       }
	      }
	      x.open("GET", "getDepartment.jsp", true);
	      x.send();
	     }
	      
	function getPayrollCategory() {
	    var x = new XMLHttpRequest();
	    x.onreadystatechange = function() {
	     if (x.readyState == 4 && x.status == 200) {
	      var items = x.responseText;
	      items = items.split('####');
	      var payrollcategoryItems = items[0].split(",");
	      var payrollcategoryIdItems = items[1].split(",");
	      var optionspayrollcategory = '<option value="">--Select--</option>';
	      for (var i = 0; i < payrollcategoryItems.length; i++) {
	       optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
	         + payrollcategoryItems[i] + '</option>';
	      }
	      $("select#cmbcategory").html(optionspayrollcategory);
	      if ($('#hidcmbcategory').val() != null) {
	       $('#cmbcategory').val($('#hidcmbcategory').val());
	      }
	     } else {
	     }
	    }
	    x.open("GET", "getPayrollCategory.jsp", true);
	    x.send();
	   }     
		
	function funPrintBtn() {
		
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			
			 var url=document.URL;
		     var reurl=url.split("saveAppraisal");
		     $("#docno").prop("disabled", false);
				   
			 var win= window.open(reurl[0]+"printAppraisal?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		     win.focus();
					
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
	
	function funNotify() { 
		
		  var payrolldate=new Date($('#leastpaydate').jqxDateTimeInput('getDate'));     
		  payrolldate.setHours(0,0,0,0);
          var year1=payrolldate.getFullYear();  
		  var cmbyear=document.getElementById("cmbyear").value;
		  
		   if(year1>cmbyear) {
			    document.getElementById("errormsg").innerText="Year Cannot be Less than Last Payroll Created On Date";
			    return false; 
		   }
		   
		   if(year1<cmbyear) {
		        var mounth1=payrolldate.getMonth()+1;
	    	    var cmbmonth=document.getElementById("cmbmonth").value;  
			   
			    if(mounth1>=cmbmonth) {
				   document.getElementById("errormsg").innerText="Month Cannot be Less than Last Payroll Created On	Date";
			       return false; 
			    } else {   
				   document.getElementById("errormsg").innerText="";  
				} 
			} else {
		   			document.getElementById("errormsg").innerText="";  
			} 
		
		   var rows = $("#compensationGridID").jqxGrid('getrows');
		   $('#compensationGridlength').val(rows.length);
		   for(var i=0 ; i < rows.length ; i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test"+i)
		       .attr("name", "test"+i)
		       .attr("hidden", "true");   
		   
		       newTextBox.val(rows[i].allowanceid+"::"+((rows[i].addition==" "||rows[i].addition=="")&&(rows[i].deduction!=" "||rows[i].deduction!=""||rows[i].statutorydeduction!=" "||rows[i].statutorydeduction!=""||rows[i].revadd!=" "||rows[i].revadd!=""||rows[i].revded!=" "||rows[i].revded!=""||rows[i].revstatded!=" "||rows[i].revstatded!="")?0:rows[i].addition)+" :: "+rows[i].deduction+" :: "+rows[i].statutorydeduction+" :: "+rows[i].remarks+" :: "+rows[i].refdtype+" :: "+rows[i].revadd+" :: "+rows[i].revded+" :: "+rows[i].revstatded+" :: ");
		       newTextBox.appendTo('form');
		   }   
		   $('#joindate').jqxDateTimeInput({ disabled: false});
		   return 1;
	  } 

	function funChkButton() {}

	function funSearchLoad(){
		 changeContent('masterSearch.jsp'); 
	}
		
	function funFocus(){
		$('#masterdate').jqxDateTimeInput('focus'); 	
	}
	 
	function getYear() {
	    var x = new XMLHttpRequest();
	    x.onreadystatechange = function () {
	        if (x.readyState === 4 && x.status === 200) {
	            console.log(x.responseText); // DEBUG

	            var items = x.responseText.trim().split('####');
	            if (items.length < 2) return;

	            var yearItems = items[0].split(",");
	            var yearIdItems = items[1].split(",");

	            var optionsyear = '<option value="">--Select--</option>';
	            for (var i = 0; i < yearItems.length; i++) {
	                optionsyear += '<option value="' + yearIdItems[i] + '">' +
	                                yearItems[i] + '</option>';
	            }

	            $('#cmbyear').html(optionsyear);

	            var hidVal = $('#hidcmbyear').val();
	            if (hidVal) {
	                $('#cmbyear').val(hidVal);
	            }
	        }
	    };
	    x.open("GET", "getYear.jsp", true);
	    x.send();
	}

	$(document).ready(function () {
	    getYear();
	});

	function setValues() {
		  if(document.getElementById("hidchange").value==1) {
    		  document.getElementById("change").checked = true;
    		  document.getElementById("change").value = 1;
    		  editstatus();        
    		  if($('#hidcmbdept').val()=="1") {
	     		  $('#cmbdept').val($('#hidcmbdept').val());
     		  } else if($('#hidcmbdept').val()=="0") {
    			   $('#hidcmbdept').val('');
    		  }
    		   
    		  if($('#hidcmbdesignation').val()=="1") {
	     		  $('#cmbdesignation').val($('#hidcmbdesignation').val());
     		  } else if($('#hidcmbdesignation').val()=="0") {
    			   $('#hidcmbdesignation').val(''); 
    		  }
    		   
    		  if($('#hidcmbcategory').val()=="1") {
	     		  $('#cmbcategory').val($('#hidcmbcategory').val());
     		  } else if($('#hidcmbcategory').val()=="0") {
    			   $('#hidcmbcategory').val("");
    		  }
    	 } else {
			   $('#hidcmbcategory').val("");
			   $('#hidcmbdesignation').val(''); 
			   $('#hidcmbdept').val('');
		 }
		  
    	  
		 if($('#hidcmbyear').val()!="") {
	  		   $('#cmbyear').val($('#hidcmbyear').val());
  		 } else {
			   $('#cmbyear').val('');
		 }
 		  
		 if($('#hidcmbmonth').val()!="") {
  		  		$('#cmbmonth').val($('#hidcmbmonth').val());
  		 } else {
			    $('#cmbmonth').val('');
		 }
		
		 var docVal1 = document.getElementById("docno").value;
	        if(docVal1>0) {
	        	 $("#comdiv").load("compensationGrid.jsp?docno="+docVal1+"&check="+1);
	        }
		   
 	   if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 	   }
 	   
 	   if($('#hidmasterdate').val()!="") {
		  $('#masterdate').val($('#hidmasterdate').val());
	   }
 	  
 	   if($('#hidleastpaydate').val()!="") {
		  $('#leastpaydate').val($('#hidleastpaydate').val());
	   }
 	  
 	   if($('#hidjoindate').val()!="") {
		  $('#joindate').val($('#hidjoindate').val());
	   }
 	  
 	   if($('#hidprevappdate').val()!="") {
		  $('#prevappdate').val($('#hidprevappdate').val());
	   }
 
 	   document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}

	
	
	function clearmsg() {  
		document.getElementById("errormsg").innerText="";
	}
	function editstatus(){                 
		var date=$('#masterdate').jqxDateTimeInput('val');
		var empdocno=$('#empdocno').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				
				if(parseInt(items)>0)
					{
					 $("#btnEdit").attr('disabled', false );
					 //$('#btnDelete').attr('disabled', false );   
					}
				else
					{   
					$("#btnEdit").attr('disabled', true );   
					 //$('#btnDelete').attr('disabled', true );
					}
				
			} else {  
			}  
		}
		x.open("GET", "getEditStat.jsp?masterdoc="+empdocno+"&date="+date, true);      
		x.send();
	}
</script>
<style>
/* ==============================
   MASTER SCROLL AREA
============================== */
.hidden-scrollbar {
    height: 550px;
    overflow-y: auto;
    overflow-x: hidden;
    padding: 10px;
}

/* ==============================
   MASTER BACKGROUND
============================== */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
    font-size: 14px;
}

/* ==============================
   MAIN CARD
============================== */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ==============================
   RECEIPT HEADER
============================== */
.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 12px;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0 24px;
}

.receipt-header label {
    font-weight: 500;
    color: #333;
}

.receipt-header input[type="text"] {
    height: 32px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 14px;
    width: 120px;
    background: #fff;
}

.receipt-header input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

.receipt-header button {
    height: 32px;
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 0 16px;
    font-weight: 500;
    cursor: pointer;
}

.receipt-header button:hover {
    background: #0056b3;
}

#txtStatus {
    font-size: 14px;
    font-weight: 600;
    color: #e67e22;
}

/* ==============================
   SECTION BLOCKS
============================== */
.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}

.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 16px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
}

.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 500;
    color: #253858;
}

.section-block input[type="text"],
.section-block select {
    flex: 1;
    height: 32px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
}

.section-block input:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}

/* ==============================
   TABLE SECTION
============================== */
.table-section {
    margin-bottom: 20px;
    padding: 20px;
    border-radius: 12px;
    background: #f6f8fa;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.table-section h3 {
    margin: 0 0 16px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    font-size: 15px;
    font-weight: 600;
}

/* ==============================
   TABLE GRID
============================== */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}

.cr-table th,
.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 13px;
    vertical-align: middle;
    white-space: nowrap;
    font-weight: 500;
}

.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ==============================
   TABLE INPUTS & DROPDOWNS
============================== */
.cr-table input[type="text"],
.cr-table select {
    width: 100%;
    height: 32px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 14px;
    background: #fff;
    box-sizing: border-box;
}

.cr-table input:focus,
.cr-table select:focus {
    border-color: #007bff;
    outline: none;
}

/* ==============================
   DROPDOWN OPTIONS
============================== */
select option {
    padding: 8px 12px;
    font-size: 14px;
    line-height: 1.6;
}

/* ==============================
   CHROME AUTOFILL FIX
============================== */
input:-webkit-autofill,
textarea:-webkit-autofill,
select:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px #fff inset !important;
    box-shadow: 0 0 0 1000px #fff inset !important;
    -webkit-text-fill-color: #222 !important;
}

</style>  
</head>
<body onload="setValues();getYear();getDepartment();getDesignation();getPayrollCategory();"
      onmouseover="editstatus();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmappraisal" action="saveAppraisal" autocomplete="OFF">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <!-- ===============================
         SCROLLABLE CONTENT
    ================================ -->
    <div class="hidden-scrollbar">

        <!-- ===============================
             HEADER DETAILS
        ================================ -->
        <div class="table-section">
            <h3>Appraisal Details</h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Date</td>
                    <td>
                        <div id="masterdate" name="masterdate"
                             value='<s:property value="masterdate"/>'></div>
                        <input type="hidden" id="hidmasterdate" name="hidmasterdate"
                               value='<s:property value="hidmasterdate"/>' />
                    </td>

                    <td align="right">Year</td>
                    <td>
                        <select id="cmbyear" name="cmbyear"
                                value='<s:property value="cmbyear"/>'
                                onchange="clearmsg();">
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbyear" name="hidcmbyear"
                               value='<s:property value="hidcmbyear"/>' />
                    </td>

                    <td align="right">Month</td>
                    <td>
                        <select id="cmbmonth" name="cmbmonth"
                                value='<s:property value="cmbmonth"/>'
                                onchange="clearmsg();">
                            <option value="">--Select--</option>
                            <option value="1">January</option>
                            <option value="2">February</option>
                            <option value="3">March</option>
                            <option value="4">April</option>
                            <option value="5">May</option>
                            <option value="6">June</option>
                            <option value="7">July</option>
                            <option value="8">August</option>
                            <option value="9">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>
                        <input type="hidden" id="hidcmbmonth" name="hidcmbmonth"
                               value='<s:property value="hidcmbmonth"/>' />
                    </td>

                    <td align="right">Last Payroll</td>
                    <td>
                        <div id="leastpaydate" name="leastpaydate"
                             value='<s:property value="leastpaydate"/>'></div>
                        <input type="hidden" id="hidleastpaydate" name="hidleastpaydate"
                               value='<s:property value="hidleastpaydate"/>' />
                    </td>

                    <td align="right">Doc No</td>
                    <td>
                        <input type="text" id="docno" name="docno" tabindex="-1"
                               value='<s:property value="docno"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             EMPLOYEE DETAILS
        ================================ -->
        <div class="table-section">
            <h3>Employee Details</h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Employee ID</td>
                    <td>
                        <input type="text" id="empid" name="empid"
                               placeholder="Press F3 to Search"
                               onkeydown="getEmployee(event);"
                               value='<s:property value="empid"/>' />
                        <input type="hidden" id="empdocno" name="empdocno"
                               value='<s:property value="empdocno"/>' />
                    </td>

                    <td align="right">Name</td>
                    <td colspan="3">
                        <input type="text" id="empname" name="empname"
                               value='<s:property value="empname"/>' />
                    </td>
                </tr>

                <tr>
                    <td align="right">Date of Join</td>
                    <td>
                        <div id="joindate" name="joindate"
                             value='<s:property value="joindate"/>'></div>
                        <input type="hidden" id="hidjoindate" name="hidjoindate"
                               value='<s:property value="hidjoindate"/>' />
                    </td>

                    <td align="right">Prev. Appraisal</td>
                    <td>
                        <div id="prevappdate" name="prevappdate"
                             value='<s:property value="prevappdate"/>'></div>
                        <input type="hidden" id="hidprevappdate" name="hidprevappdate"
                               value='<s:property value="hidprevappdate"/>' />
                    </td>
                </tr>

                <tr>
                    <td align="right">Department</td>
                    <td>
                        <input type="text" id="deprtment" name="deprtment"
                               value='<s:property value="deprtment"/>' />
                        <input type="hidden" id="hiddeprtment" name="hiddeprtment"
                               value='<s:property value="hiddeprtment"/>' />
                    </td>

                    <td align="right">Designation</td>
                    <td>
                        <input type="text" id="designation" name="designation"
                               value='<s:property value="designation"/>' />
                        <input type="hidden" id="hiddesignation" name="hiddesignation"
                               value='<s:property value="hiddesignation"/>' />
                    </td>
                </tr>

                <tr>
                    <td align="right">Payroll Category</td>
                    <td>
                        <input type="text" id="category" name="category"
                               value='<s:property value="category"/>' />
                        <input type="hidden" id="hidcategory" name="hidcategory"
                               value='<s:property value="hidcategory"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             CHANGES SECTION
        ================================ -->
        <div class="table-section">
            <h3>
                <input type="checkbox" id="change" name="change"
                       value="0"
                       onclick="$(this).attr('value', this.checked ? 1 : 0)"
                       onchange="checkchange();" />
                Changes in Employee Details
            </h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Department</td>
                    <td>
                        <select id="cmbdept" name="cmbdept">
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbdept" name="hidcmbdept"
                               value='<s:property value="hidcmbdept"/>' />
                    </td>

                    <td align="right">Designation</td>
                    <td>
                        <select id="cmbdesignation" name="cmbdesignation">
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbdesignation"
                               name="hidcmbdesignation"
                               value='<s:property value="hidcmbdesignation"/>' />
                    </td>
                </tr>

                <tr>
                    <td align="right">Payroll Category</td>
                    <td>
                        <select id="cmbcategory" name="cmbcategory">
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbcategory"
                               name="hidcmbcategory"
                               value='<s:property value="hidcmbcategory"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             DESCRIPTION
        ================================ -->
        <div class="table-section">
            <h3>Description</h3>
            <input type="text" id="desc" name="desc"
                   value='<s:property value="desc"/>' />
        </div>

        <!-- ===============================
             MONTHLY SALARY
        ================================ -->
        <div class="table-section">
            <h3>Monthly Salary</h3>
            <div class="cr-table" id="comdiv">
                <jsp:include page="compensationGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- ===============================
             HIDDEN FIELDS
        ================================ -->
        <input type="hidden" id="compensationGridlength"
               name="compensationGridlength"
               value='<s:property value="compensationGridlength"/>' />
        <input type="hidden" id="mode" name="mode"
               value='<s:property value="mode"/>' />
        <input type="hidden" id="deleted" name="deleted"
               value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>' />
        <input type="hidden" id="txtvalidation" name="txtvalidation"
               value='<s:property value="txtvalidation"/>' />

    </div><!-- /.hidden-scrollbar -->

</form>

<div id="empsearchwndow"><div></div></div>

</div><!-- /#mainBG -->

</body>

</html>