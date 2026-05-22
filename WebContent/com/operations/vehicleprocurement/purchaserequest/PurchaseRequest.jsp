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

<style>
/* =========================================================
   SCOPED UI: Segoe UI Font & Clean White Master Layout
========================================================= */
body, .homeContent {
    background-color: #fff !important; /* Pure White Background */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    color: #333 !important;
    font-size: 12px !important;
    margin: 0;
    padding: 15px; 
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 8px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    border: 1px solid #e5e7eb; 
}

.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
    color: #333;
    font-size: 12px; 
    padding-top: 10px;
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
.modern-ui input[type="text"],
.modern-ui select,
.modern-ui textarea { 
    height: 24px !important; 
    border: 1px solid #BDBDBD !important; 
    border-radius: 3px !important; 
    padding: 2px 6px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    box-sizing: border-box; 
    background-color: #fff !important; 
    color: #333 !important;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff !important; 
    background-color: #FFD6FF !important; /* Client Master Focus Color */
    outline: none !important;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f4f5f7 !important; 
    color: #5e6c84 !important;
    border-color: #e1e4e8 !important;
}

/* ROW LAYOUT */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    margin-bottom: 12px; 
    flex-wrap: nowrap;
}

.modern-ui .input-group {
    display: flex;
    align-items: center;
    margin-right: 25px; 
}

/* Labels */
.modern-ui .lbl-right { 
    text-align: right; 
    color: #222 !important;
    font-size: 12px !important; 
    font-weight: 600 !important;
    white-space: nowrap; 
    width: 80px; 
    padding-right: 8px;
    flex-shrink: 0;
}

/* Exact Panel Styling - CLEAN WHITE */
.modern-ui .bordered-panel { 
    border: 1px solid #BDBDBD !important; 
    padding: 15px; 
    background: #fff !important; /* NO BLUE BACKGROUND */
    border-radius: 4px; 
    margin-bottom: 15px;
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 15px;
}

/* Magnifier Icon Styling */
.input-search-container {
    position: relative;
    display: inline-block;
}
.input-search-container input {
    padding-right: 25px !important;
}
.magnifier-icon {
    position: absolute;
    right: 4px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.magnifier-icon:hover { color: #2563eb; }

/* Action Buttons */
.modern-ui .myButton {
    height: 24px !important;
    padding: 0 15px !important;
    background-color: #0056b3 !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 3px !important;
    cursor: pointer !important;
    font-size: 12px !important;
    font-weight: bold !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
}
.modern-ui .myButton:hover { background-color: #004494 !important; }

/* Table adjustments for compact text */
table td {
    padding: 4px 6px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    color: #222 !important;
    font-weight: 600 !important;
    vertical-align: middle;
}

/* Validation Error override */
.modern-ui label.error, #errormsg {
    color: red;
    font-weight: bold;
    font-size: 11px;
    margin-left: 5px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
	$(document).ready(function () {
        /* CLEAN JQX DATE SETUP */
		$("#vehpurreqDate").jqxDateTimeInput({ width: '130px', height: '24px', formatString:"dd.MM.yyyy"});   
   		$("#vehexpDate").jqxDateTimeInput({ width: '130px', height: '24px', formatString:"dd.MM.yyyy"});   
        
	 	$('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 350, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     	$('#brandsearchwndow').jqxWindow('close'); 

     	$('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     	$('#modelsearchwndow').jqxWindow('close');
     	
     	$('#colorsearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: {x: 600, y: 60  }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     	$('#colorsearchwndow').jqxWindow('close');
		
     	$('#groupwindow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: {x: 600, y: 60  }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#groupwindow').jqxWindow('close');
	});
    
    function brandinfoSearchContent(url) {
  		 $.get(url).done(function (data) {
  			 $('#brandsearchwndow').jqxWindow('open');
  		     $('#brandsearchwndow').jqxWindow('setContent', data);
  	    }); 
  	} 
        
	function groupSearchContent(url) {
    	$.get(url).done(function (data) {
        	$('#groupwindow').jqxWindow('open');
           	$('#groupwindow').jqxWindow('setContent', data);
        }); 
	} 

    function modelinfoSearchContent(url) {
   		 $.get(url).done(function (data) {
   			 $('#modelsearchwndow').jqxWindow('open');
   		     $('#modelsearchwndow').jqxWindow('setContent', data);
   	    }); 
   	} 
    
    function colorinfoSearchContent(url) {
   		 $.get(url).done(function (data) {
   			 $('#colorsearchwndow').jqxWindow('open');
   		     $('#colorsearchwndow').jqxWindow('setContent', data);
   	    }); 
   	}  
         
    function funReset(){
		//$('#frmvehpurReq')[0].reset(); 
	}
	
	function funReadOnly(){
		$('#frmvehpurReq input').attr('readonly', true );
		$('#frmvehpurReq textarea').attr('readonly', true );
		$('#frmvehpurReq select').attr('disabled', true);

		$('#vehpurreqDate').jqxDateTimeInput({ disabled: true});
		$('#vehexpDate').jqxDateTimeInput({ disabled: true});
		if($("#purchasedetails").length) $("#purchasedetails").jqxGrid({ disabled: true});
	}
	
	/*function funRemoveReadOnly(){
		$('#frmvehpurReq input').attr('readonly', false );
		$('#frmvehpurReq textarea').attr('readonly', false );
		$('#frmvehpurReq select').attr('disabled', false);
	
		$('#vehpurreqDate').jqxDateTimeInput({ disabled: false});
		$('#vehexpDate').jqxDateTimeInput({ disabled: false});
		if($("#purchasedetails").length) $("#purchasedetails").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			$('#vehpurreqDate').val(new Date());
			$('#vehexpDate').val(new Date());
			if($("#purchasedetails").length) {
			    $("#purchasedetails").jqxGrid('clear');
			    $("#purchasedetails").jqxGrid('addrow', null, {});
			}
		   }
	}
	
	function funchkforedit() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0) {
					 $("#btnEdit").attr('disabled', true );
					 $("#btnDelete").attr('disabled', true ); 
				} else {
					 $("#btnEdit").attr('disabled', false);
					 $("#btnDelete").attr('disabled', false);
				}
			}
		}
		x.open("GET", "reqlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();
	}
	*/
	
	function funRemoveReadOnly(){
	    $('#frmvehpurReq input').attr('readonly', false );
	    $('#frmvehpurReq textarea').attr('readonly', false );
	    $('#frmvehpurReq select').attr('disabled', false);

	    $('#vehpurreqDate').jqxDateTimeInput({ disabled: false});
	    $('#vehexpDate').jqxDateTimeInput({ disabled: false});
	    if($("#purchasedetails").length) $("#purchasedetails").jqxGrid({ disabled: false});
	    $('#docno').attr('readonly', true);
	    
	    if ($("#mode").val() == "A") {
	        // FIX: Corrected jqWidgets syntax
	        $('#vehpurreqDate').jqxDateTimeInput('setDate', new Date());
	        $('#vehexpDate').jqxDateTimeInput('setDate', new Date());
	        
	        if($("#purchasedetails").length) {
	            $("#purchasedetails").jqxGrid('clear');
	            $("#purchasedetails").jqxGrid('addrow', null, {});
	        }
	    }
	}

	function funchkforedit() {
	    var x = new XMLHttpRequest();
	    x.onreadystatechange = function() {
	        if (x.readyState == 4 && x.status == 200) {
	            var items = x.responseText.trim();	
	            if(parseInt(items) > 0) {
	                 $("#btnEdit").attr('disabled', true );
	                 $("#btnDelete").attr('disabled', true ); 
	                 // FIX: Added Attach button to the lock logic
	                 $("#btnAttach").attr('disabled', true ); 
	            } else {
	                 $("#btnEdit").attr('disabled', false);
	                 $("#btnDelete").attr('disabled', false);
	                 // FIX: Re-enable Attach button if document is unlocked
	                 $("#btnAttach").attr('disabled', false); 
	            }
	        }
	    }
	    x.open("GET", "reqlinkchk.jsp?masterdoc_no=" + document.getElementById("masterdoc_no").value, true);
	    x.send();
	}
	
	
	function funNotify(){	
		if ($("#mode").val() == "A") {
			var gridval= document.getElementById("gridvalidate").value;	
			if(gridval==""){
				document.getElementById("errormsg").innerText="Brand is empty";
				return 0;
			} else {
				document.getElementById("errormsg").innerText="";
			}
		}
		
		if($("#purchasedetails").length) {
    		var rows = $("#purchasedetails").jqxGrid('getrows');
    		$('#vehreqgridlenght').val(rows.length);
    		for(var i=0 ; i < rows.length ; i++){
        		newTextBox = $(document.createElement("input"))
        		   .attr("type", "dil")
        		   .attr("id", "vehreqtest"+i)
        		   .attr("name", "vehreqtest"+i)
        		   .attr("hidden", "true"); 
        		
        		newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
        				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].qty+" :: "+rows[i].remarks+" :: "+rows[i].vehgroupid);
        		
        		newTextBox.appendTo('form');
    		}   
		}
		return 1;
	} 

	function funChkButton() {
		frmvehpurReq.submit();
	}

	function funSearchLoad(){
		 changeContent('vehreqMastersearch.jsp?'); 
	}
	
   $(function(){
        $('#frmvehpurReq').validate({
                rules: { 
                	purdesc:{maxlength:200}
                 },
                 messages: {
                	 purdesc: {maxlength:" Max 200 chars"}
                 }
        });});
    
	function funFocus(){
	   	$('#vehpurreqDate').jqxDateTimeInput('focus'); 	    		
	}
	
    function combochange() {
	   if($('#cmbreftypeval').val()!="") {
	       $('#cmbreftype').val($('#cmbreftypeval').val());
	   }
    }
	
	function setValues() {
		if($('#hidvehpurreqDate').length && $('#hidvehpurreqDate').val()){
			$("#vehpurreqDate").jqxDateTimeInput('val', $('#hidvehpurreqDate').val());
		}
		if($('#hidvehexpDate').length && $('#hidvehexpDate').val()){
			$("#vehexpDate").jqxDateTimeInput('val', $('#hidvehexpDate').val());
		}
		  
   	    var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0) {
      		funchkforedit();
		    var indexVal2 = document.getElementById("masterdoc_no").value;
      	  
            if($("#vehpurcgasereq").length) $("#vehpurcgasereq").load("purreqDetails.jsp?vehreqdoc="+indexVal2);
      	}
      	if($('#msg').length && $('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		}
	
      	combochange();  
      	if(document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
      	    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
      	}
	}
	
    function funPrintBtn(){
  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
  	   var url=document.URL;
         var reurl=url.split("savepurreq");
         $("#docno").prop("disabled", false);                
         
         var win= window.open(reurl[0]+"printPurreq?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
         win.focus();
  	   } 
  	   else {
	  	      $.messager.alert('Message','Select a Document....!','warning');
	  	      return false;
	  	     }
  	}
</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmvehpurReq" action="savepurreq" autocomplete="OFF" >
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui">
    <span id="errormsg" style="display:block; margin-bottom:10px;"></span>

    <div class="bordered-panel">
        <div class="field-row">
            <div class="input-group">
                <label class="lbl-right" style="width: 50px;">Date</label>
                <div id='vehpurreqDate' name='vehpurreqDate' value='<s:property value="vehpurreqDate"/>'></div>
                <input type="hidden" id="hidvehpurreqDate" name="hidvehpurreqDate" value='<s:property value="hidvehpurreqDate"/>'/>
            </div>

            <div class="input-group">
                <label class="lbl-right" style="width: 60px;">Type</label>
                <select id="cmbreftype" name="cmbreftype" style="width: 150px;" value='<s:property value="cmbreftype"/>' onchange="fundisrefno();">
                    <option value="Fleet">Fleet</option>
                    <option value="Lease">Lease</option>
                </select>
            </div>

            <div class="input-group">
                <label class="lbl-right" style="width: 60px;">Doc No</label>
                <input type="text" id="docno" name="docno" style="width: 150px; background-color:#f4f5f7;" tabindex="-1" value='<s:property value="docno"/>' readonly/>
            </div>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <div class="input-group">
                <label class="lbl-right" style="width: 50px;">Exp. Del.</label>
                <div id='vehexpDate' name='vehexpDate' value='<s:property value="vehexpDate"/>'></div>
                <input type="hidden" id="hidvehexpDate" name="hidvehexpDate" value='<s:property value="hidvehexpDate"/>'/>
            </div>

            <div class="input-group" style="flex-grow: 1;">
                <label class="lbl-right" style="width: 60px;">Desc.</label>
                <input type="text" id="purdesc" name="purdesc" style="width: 100%; max-width: 600px;" value='<s:property value="purdesc"/>'/>
            </div>
        </div>
    </div>

    <div class="grid-container" id="vehpurcgasereq">
        <jsp:include page="purreqDetails.jsp"></jsp:include>
    </div>

    <div style="display:none;">
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="cmbreftypeval" name="cmbreftypeval" value='<s:property value="cmbreftypeval"/>'/>
        <input type="hidden" name="brandval" id="brandval" value='<s:property value="brandval"/>' />  
        <input type="hidden" name="vehreqgridlenght" id="vehreqgridlenght" value='<s:property value="vehreqgridlenght"/>' />  
        <input type="hidden" name="gridvalidate" id="gridvalidate" value='<s:property value="gridvalidate"/>' /> 
        <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
        <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        <span id="formdet"></span>
    </div>

</div>
</form>

<div id="colorsearchwndow"><div></div></div>
<div id="modelsearchwndow"><div></div></div>
<div id="brandsearchwndow"><div></div></div>
<div id="groupwindow"><div></div></div>

</div>
</body>
</html>