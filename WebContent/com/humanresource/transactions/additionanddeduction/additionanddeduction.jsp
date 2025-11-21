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
/* Global Scroll Fix */
html, body {
    height: auto !important;
    overflow-y: auto !important;
}

/* Remove scroll blocking */
.homeContent {
    overflow: visible !important;
    min-height: auto !important;
}

/* Error Label */
form label.error {
    color:red;
    font-weight:bold;
}

/* Background */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
}

/* Main Container */
#mainBG {
    background: #ffffff;
    border-radius: 18px;
    padding: 22px;
    max-width: 1250px;
    margin: 0 auto;
    box-shadow: 0 8px 28px rgba(120,140,200,0.18);
    overflow: visible !important;
}

/* HEADER INPUT BOX */
.top-box {
    background: #f0f4ff;
    border: 1px solid #d7e3ff;
    padding: 20px 24px;
    margin-bottom: 26px;
    border-radius: 14px;
    box-shadow: 0 4px 14px rgba(80,120,255,0.12);
}

.top-box table td {
    padding: 10px 8px;
    font-size: 14px;
    font-weight: 600;
    color: #2f3f86;
}

.top-box input[type="text"] {
    width: 90%;
    height: 34px;
    border-radius: 10px;
    border: 1px solid #c4d3ff;
    padding: 6px 10px;
    font-size: 14px;
    background: #ffffff;
    box-shadow: 0 2px 6px rgba(140,160,250,0.18);
}

/* EFFECT IN SECTION */
.effect-section {
    background: #f8faff;
    border: 1px solid #d2ddff;
    border-radius: 16px;
    padding: 26px 24px;
    margin-bottom: 30px;
    box-shadow: 0 6px 20px rgba(80,120,255,0.18);
}

.effect-section h3 {
    margin: 0 0 16px 0;
    font-size: 17px;
    font-weight: 700;
    color: #1d2f6f;
    border-left: 5px solid #6f9bff;
    padding-left: 12px;
}

/* Inputs & Selects */
.effect-section table td {
    padding: 12px 10px !important;
    font-size: 14px;
    font-weight: 600;
    color: #2f3f86;
}

.effect-section select,
.effect-section input[type="text"],
.effect-section input[type="file"] {
    width: 95% !important;
    height: 38px !important;
    padding: 8px 12px;
    border-radius: 12px;
    border: 1px solid #c4d3ff;
    background: #ffffff;
    font-size: 14px;
    color: #001a4d;
    box-shadow: 0 2px 7px rgba(120,140,250,0.20);
}

.myButton {
    background: linear-gradient(90deg,#4a90ff,#0059e8);
    border: none;
    color: white;
    padding: 9px 22px;
    font-size: 14px;
    border-radius: 10px;
    cursor: pointer;
}

/* GRID WRAPPER */
.grid-wrapper {
    background: #ffffff;
    border-radius: 14px;
    padding: 18px 20px;
    margin-top: 10px;
    margin-bottom: 60px;
    box-shadow: 0 4px 16px rgba(90,120,200,0.15);
    border: 1px solid #e6ebff;
}

/* Grid header */
.grid-wrapper h3 {
    font-size: 15px;
    font-weight: 600;
    color: #334488;
    margin: 0 0 10px 0;
    padding-bottom: 6px;
    border-bottom: 1px solid #dce3ff;
}

/* jqxGrid container */
#desdet {
    border-radius: 12px !important;
    background: #ffffff;
    border: 1px solid #dce3ff;
    height: 450px !important;
    overflow-y: scroll !important;
    overflow-x: hidden !important;
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
<jsp:include page="../../../../header.jsp"></jsp:include><br/>


<!-- TOP BOX -->
<div class="top-box">
<table width="100%">
<tr>
 <td width="10%" align="right">Date</td>
 <td width="20%">
     <div id='masterdate'></div>
     <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/>
 </td>

 <td width="10%" align="right">Ref No</td>
 <td width="20%">
     <input type="text" id="refno" name="refno" value='<s:property value="refno"/>'/>
 </td>

 <td width="10%"></td>

 <td width="10%" align="right">Doc No</td>
 <td width="20%">
     <input type="text" id="docno" name="docno" value='<s:property value="docno"/>'/>
 </td>
</tr>
</table>
</div>


<!-- EFFECT SECTION -->
<div class="effect-section">
<h3><b><i>Effect In</i></b></h3>

<table class="cr-table" width="100%">
<tr>
 <td align="right">Year</td>
 <td>
     <select id="cmbyear" name="cmbyear">
         <option value="">--Select--</option>
     </select>
     <input type="hidden" id="hidcmbyear" name="hidcmbyear" />
 </td>

 <td align="right">Month</td>
 <td>
     <select id="cmbmonth" name="cmbmonth">
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
     <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" />
 </td>

 <td>
     <input type="file" id="fileexcelimport" name="file">
 </td>

 <td align="right">
     <button class="myButton" type="button" onclick="excelimport();">Excel Import</button>
 </td>

 <td></td>
</tr>

<tr>
 <td align="right">Description</td>
 <td colspan="4">
      <input type="text" id="desc" name="desc" style="width:90%;" value='<s:property value="desc"/>'/>
 </td>
 <td></td>
 <td></td>
</tr>

</table>
</div>


<!-- GRID AREA -->
<div class="grid-wrapper">
    <h3>Employee Details</h3>

    <div id="desdet">
        <jsp:include page="empdetails.jsp"></jsp:include>
    </div>
</div>


<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted"/>
<input type="hidden" id="msg" name="msg"/>
<input type="hidden" id="descdetailsGridlenght" name="descdetailsGridlenght"/>

</form>

<!-- Windows -->
<div id="empsearchwndow"><div></div></div>
<div id="accountDetailsWindow"><div></div></div>
<div id="costTypeSearchGridWindow"><div></div></div>
<div id="costCodeSearchWindow"><div></div></div>

</div>
</body>



</html>