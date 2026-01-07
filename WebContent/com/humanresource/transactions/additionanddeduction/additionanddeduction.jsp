<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include> 

<script type="text/javascript" src="../../../../js/ajaxfileupload.js"></script> 
<style>

form label.error {
    color: red;
    font-weight: 600;
}


.hidden-scrollbar {
    overflow-y: auto;
    height: 550px;
    padding: 10px;
}


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

/* ------------------------------
   MAIN CARD
------------------------------ */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
   RECEIPT HEADER
------------------------------ */
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

/* ------------------------------
   SECTION LAYOUT
------------------------------ */
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

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}

/* ------------------------------
   TABLE SECTION
------------------------------ */
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

/* ------------------------------
   TABLE GRID
------------------------------ */
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
}

.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ------------------------------
   TABLE INPUTS & DROPDOWNS
------------------------------ */
.cr-table input[type="text"],
.cr-table select {
    width: 100%;
    height: 32px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 14px;
    background: #fff;
}

.cr-table input[type="text"]:focus,
.cr-table select:focus {
    border-color: #007bff;
    outline: none;
}

/* ------------------------------
   DROPDOWN OPTIONS
------------------------------ */
select option {
    padding: 8px 12px;
    font-size: 14px;
    line-height: 1.6;
}

</style>
<script type="text/javascript">

 $(document).ready(function () {
	 
   	  $("#masterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	  
   	  /* Searching Window */
   	  $('#empsearchwndow').jqxWindow({width: '60%', height: '59%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Employee Search',position: { x: 300, y: 80 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
      $('#empsearchwndow').jqxWindow('close'); 
      
      $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#accountDetailsWindow').jqxWindow('close');
	  
	  $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#costTypeSearchGridWindow').jqxWindow('close');
	 
	  $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#costCodeSearchWindow').jqxWindow('close');
	  
  }); 
    
    function empSearchContent(url) {
		 $.get(url).done(function (data) {
		 $('#empsearchwndow').jqxWindow('open');
		 $('#empsearchwndow').jqxWindow('setContent', data);
		}); 
	} 

    function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
    
    function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
    
    function funReset(){}
    
	function funReadOnly(){
		 $('#frmalw input').prop('readonly', true );
		 $('#frmalw select').prop('disabled', true );
		 $('#masterdate').jqxDateTimeInput({ disabled: true});
		 $("#descdetailsGrid").jqxGrid({ disabled: true});
	}
	
	function funRemoveReadOnly(){
		 $('#frmalw input').prop('readonly', false );
		 $('#frmalw select').prop('disabled', false );
		 $('#masterdate').jqxDateTimeInput({ disabled: false});
		 $('#docno').attr("readonly", true);
		 $("#descdetailsGrid").jqxGrid({ disabled: false});
		   
		 if ($("#mode").val() == "A") {
			   $('#masterdate').val(new Date());
			   $("#descdetailsGrid").jqxGrid('clear');
			   $("#descdetailsGrid").jqxGrid('addrow', null, {}); 
		 }
		   
		 if ($("#mode").val() == "E") {
			   $("#descdetailsGrid").jqxGrid('addrow', null, {});
		 }
	}
	       
	function funNotify(){
	 
		   if(document.getElementById("cmbyear").value=="") {
			   document.getElementById("errormsg").innerText="Select Year";
			   document.getElementById("cmbyear").focus();
			   return 0;
		   }
		   
		   if(document.getElementById("cmbmonth").value=="") {
			   document.getElementById("errormsg").innerText="Select Month";
			   document.getElementById("cmbmonth").focus();
			   return 0;
		   }
		   
		   /* Addition and Deduction Grid  Saving*/
	  		  var rows = $("#descdetailsGrid").jqxGrid('getrows');
	  		  var length=0;
			  for(var i=0 ; i < rows.length ; i++){
				    var chk=rows[i].empdoc;
				    var errorstat=rows[i].errorstat;
				    if(errorstat==1) {
			    		document.getElementById("errormsg").innerText="Please fill the Grid data";
			    		return 0;
			    	}
				    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				    	var chks=rows[i].acno;
				    	if(typeof(chks) == "undefined" || typeof(chks) == "NaN" || chks == "") {
				    		document.getElementById("errormsg").innerText="Invalid Account for "+rows[i].empname;
				    		return 0;
				    	}
	  					newTextBox = $(document.createElement("input"))
	  				    .attr("type", "dil")
	  				    .attr("id", "test"+length)
	  				    .attr("name", "test"+length)
	  				    .attr("hidden", "true");
	  					length=length+1;
	  					
	  				newTextBox.val(rows[i].empdoc+":: "+rows[i].addition+":: "+rows[i].deduction+":: "+rows[i].remarks+":: "+rows[i].atype+":: "+rows[i].acno+":: "+rows[i].costtype+":: "+rows[i].costcode);
	  				newTextBox.appendTo('form');
	  			  }
			   }
			   $('#descdetailsGridlenght').val(length);
	  	   /* Addition and Deduction Grid  Saving Ends*/
	  	 	
	  	   document.getElementById("errormsg").innerText="";
	  	   
		return 1;
	} 

	function funChkButton() {}

	function funSearchLoad(){
		 changeContent('alwMainSearch.jsp'); 
	}
		
	function funFocus(){
		$('#masterdate').jqxDateTimeInput('focus'); 
	}
	 
	 function getYear() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(",");
					var optionsyear = '<option value="">--Select--</option>';
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
					$("select#cmbyear").html(optionsyear);
					if ($('#hidcmbyear').val() != null) {
						$('#cmbyear').val($('#hidcmbyear').val());
					}
				} else {
				}
			}
			x.open("GET", "getYear.jsp", true);
			x.send();
		}
 
	function setValues() {
		   
	  	    if($('#hidmasterdate').val()!="") {
	 		  $('#masterdate').val($('#hidmasterdate').val());
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
		    
		    if($('#msg').val()!=""){
		 		$.messager.alert('Message',$('#msg').val());
		 	}

		 	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 	funSetlabel();
		 	
		 	 var docVal1 = document.getElementById("docno").value;
	      	 if(docVal1>0) {
	      		  $("#desdet").load("empdetails.jsp?docno="+docVal1+"&id=1");
	      	 }
	}
	
	function clearmsg() {   
		document.getElementById("errormsg").innerText="";
	}
	
function funPrintBtn() {
		
		if (($("#mode").val() == "view") && $("#docno").val()!="") {

			 $("#docno").prop("disabled", false);
			 $("#formdetailcode").prop("disabled", false);
			 
			var docno=$('#docno').val();
	  		var dtype=$('#formdetailcode').val();
	     	var brhid=<%= session.getAttribute("BRANCHID").toString()%>
	  		var url=document.URL;
	  		var reurl=url.split("com/"); 
	     
	  		
	  		 var win= window.open(reurl[0]+"printAddDeduct?docno="+docno+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				  win.focus(); 
	  			 
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		} 
}

function getAttachDocumentNo(){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText.trim();
			
			if(items>0){
				
				var path=document.getElementById("fileexcelimport").value;
				var fsize = $('#fileexcelimport')[0].files[0].size;
				var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
				
				if((extn=='xls') || (extn=='csv')){ 
			        	ajaxFileUpload(items);	
			     }else{
			        	 $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
	                         style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                     }); 
				            return;
			     } 
			}
			
	  }
	}
		
x.open("GET","getAttachDocumentNo.jsp",true);
x.send();
}
function excelimport()
{
	//alert("hi");
	
	 if(document.getElementById("cmbyear").value=="") {
			   document.getElementById("errormsg").innerText="Select Year";
			   document.getElementById("cmbyear").focus();
			   return 0;
		   }
		   
		   if(document.getElementById("cmbmonth").value=="") {
			   document.getElementById("errormsg").innerText="Select Month";
			   document.getElementById("cmbmonth").focus();
			   return 0;
		   }
	getAttachDocumentNo();
	}
function ajaxFileUpload(docNo) {  
	
	 /*  var jvtdate = $("#jqxJournalVouchersDate").val();
	      var newDate = jvtdate.split('.');
	      jvtdate = newDate[0] + "-" + newDate[1] + "-" + newDate[2];
	   */
	    if (window.File && window.FileReader && window.FileList && window.Blob)
	    {
	        var fsize = $('#fileexcelimport')[0].files[0].size;
	        
	        if(fsize>1048576) {
	            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                 style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             }); 
	            return;
	        }
	    }else{
	    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
                       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                   }); 
	        return;
	    }
	
     $.ajaxFileUpload  
     (  
         {  
             url:'fileAttachAction.action?formCode=ALW&doc_no='+docNo+'&descpt=Excel Import' ,
             secureuri:false,  
             fileElementId:'fileexcelimport',    
             dataType: 'json', 
             success: function (data, status)   
             {  
                
                if(status=='success'){
                    saveExcelDataData(docNo);
                    $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
                       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                   }); 
                 }
                
                 if(typeof(data.error) != 'undefined')  
                 {  
                     if(data.error != '')  
                     {  
                         $.messager.show({title:'Message',msg: data.error,showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
                     }else  
                     {  
                         $.messager.show({title:'Message',msg: data.message,showType:'show',
 	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
 	              	          }); 
                     }  
                 }  
             },  
             error: function (data, status, e){  
                 $.messager.alert('Message',e);
             }  
         });  
     return false;  
 }
function saveExcelDataData(docNo){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText.trim();
			
			if(items==1){
			 	 var docVal1 = document.getElementById("docno").value;

	      		  $("#desdet").load("empdetails.jsp?docno="+docVal1+"&id=2");
	      		//  alert("empdetails.jsp?docno="+docVal1+"&id=2");
				$.messager.alert('Message', ' Successfully Imported.', function(r){
			});
			}
			
	  }
	}
		
x.open("GET","saveData.jsp?docNo="+docNo,true);
x.send();
}
	
	
</script>
</head>
<body onload="setValues();getYear();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmalw" action="saveAddDeduct" autocomplete="OFF">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <!-- ===============================
         SCROLLABLE CONTENT AREA
    ================================ -->
    <div class="hidden-scrollbar">

        <!-- ===============================
             RECEIPT HEADER (TOP STRIP)
        ================================ -->
        <div class="receipt-header">
            <!-- (Keep empty or status items here if needed later) -->
        </div>

        <!-- ===============================
             ADD / DEDUCT DETAILS
        ================================ -->
        <div class="table-section">
            <h3>Add / Deduct Details</h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Date</td>
                    <td>
                        <div id="masterdate" name="masterdate"
                             value='<s:property value="masterdate"/>'></div>
                        <input type="hidden" id="hidmasterdate" name="hidmasterdate"
                               value='<s:property value="hidmasterdate"/>' />
                    </td>

                    <td align="right">Ref No</td>
                    <td>
                        <input type="text" id="refno" name="refno"
                               placeholder="Ref No"
                               value='<s:property value="refno"/>' />
                    </td>

                    <td></td>

                    <td align="right">Doc No</td>
                    <td>
                        <input type="text" id="docno" name="docno"
                               tabindex="-1"
                               value='<s:property value="docno"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             EFFECT IN
        ================================ -->
        <div class="table-section">
            <h3>Effect In</h3>

            <table class="cr-table">
                <tr>
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

                    <td>
                        <input type="file" id="fileexcelimport" name="file" />
                    </td>

                    <td>
                        <button type="button" id="btnimport"
                                onclick="excelimport();">
                            Excel Import
                        </button>
                    </td>

                    <td></td>
                </tr>

                <tr>
                    <td align="right">Description</td>
                    <td colspan="4">
                        <input type="text" id="desc" name="desc"
                               placeholder="Description"
                               value='<s:property value="desc"/>' />
                    </td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             EMPLOYEE DETAILS
        ================================ -->
        <div class="table-section">
            <h3>Employee Details</h3>

            <div class="cr-table" id="desdet">
                <jsp:include page="empdetails.jsp"></jsp:include>
            </div>
        </div>

        <!-- ===============================
             HIDDEN FIELDS
        ================================ -->
        <input type="hidden" id="mode" name="mode"
               value='<s:property value="mode"/>' />
        <input type="hidden" id="deleted" name="deleted"
               value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>' />
        <input type="hidden" id="descdetailsGridlenght"
               name="descdetailsGridlenght"
               value='<s:property value="descdetailsGridlenght"/>' />

    </div><!-- /.hidden-scrollbar -->

</form>

<!-- ===============================
     POPUP / SEARCH WINDOWS
=============================== -->
<div id="empsearchwndow"><div></div></div>
<div id="accountDetailsWindow"><div></div></div>
<div id="costTypeSearchGridWindow"><div></div></div>
<div id="costCodeSearchWindow"><div></div></div>

</div><!-- /#mainBG -->

</body>

</html>