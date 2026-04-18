<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout 
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* FIXED: Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 /* Formatted jqxDateTimeInput height to match modern UI 24px */
		 $("#jqxIpglDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 
		 /* force internal alignment AFTER render */
		 setTimeout(function () {
		     $("#jqxIpglDate").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#jqxIpglDate").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		 }, 0);

		 $("#btnEdit").attr('disabled', true );
		 $("#btnPrint").attr('disabled', true );
		 $("#btnExcel").attr('disabled', true );
		 $("#btnDelete").attr('disabled', true );
		 $("#btnCancel").attr('disabled', true );
		 $("#btnSearch").attr('disabled', true );
		 $("#btnClose").attr('disabled', true );
    });
	
	function funReadOnly(){
   		$('#frmGuideLine input').attr('disabled', true );
   		$('#frmGuideLine textarea').attr('disabled', true );
   		$('#frmGuideLine select').attr('disabled', true);
   		$('#jqxgthree').jqxGrid({ disabled: true});
   		$('#jqxgDesc').jqxGrid({ disabled: true});
   		$('#jqxgtwo').jqxGrid({ disabled: true});
   		$('#jqxMenuGrid').jqxGrid({ disabled: true});
   		$('#mode').attr('disabled', false);
   		$('#formdetailcode').attr('disabled', false);
   	}
     
    function funSearchLoad(){
   		changeContent('masterSearch.jsp', $('#window'));
   	}
     
    function funRemoveReadOnly(){
    	$('#frmGuideLine input').attr('disabled', false );
    	$('#frmGuideLine textarea').attr('disabled', false );
    	$('#frmGuideLine select').attr('disabled', false);
    	$('#jqxgthree').jqxGrid({ disabled: false});
    	$('#jqxgDesc').jqxGrid({ disabled: false});
    	$('#jqxgtwo').jqxGrid({ disabled: false});
    	$('#jqxMenuGrid').jqxGrid({ disabled: false});
		$('#descGrid').load("descGrid.jsp?doctype=0");
        $('#gtwoGrid').load("gtwoGrid.jsp?doctype=0");
        $('#gthreeGrid').load("gthreeGrid.jsp?doctype=0");
    }
	
	function funUpdate(){
	      if(document.getElementById("btnUpdate").value=="Update") {
	         document.getElementById("btnUpdate").value="Save";
	         return 0;
	       } else if(document.getElementById("btnUpdate").value=="Save"){
	    	     $('#btnSave').mousedown();
	       }
	  }

	function funFocus(){
		 document.getElementById("txtrefno").focus();  
	 }
	
	function funAdd(){
		var jobtype=document.getElementById("txtjobtype").value;
		var jobstatus=document.getElementById("txtjobstatus").value;
		var statusid=document.getElementById("jobstatusid").value;
		var description=document.getElementById("txtdescription").value;
		var mandatory=document.getElementById("chckmandatory").value;
		var date=document.getElementById("jqxIpglDate").value;
		
		if(jobstatus==""){
			document.getElementById("errormsg").innerText="Select a job Status";
			return 0;
		}
		
		if(description==""){
			document.getElementById("errormsg").innerText="Enter Description For selected for process";
			return 0;
		}
		
		  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		   if (x.readyState == 4 && x.status == 200) {
		    var item=x.responseText.trim();
		    
		    if(item>0) {
	    	$.messager.alert('Message',"Added Successfully");
	    	$('#descGrid').load("descGrid.jsp?statusid="+document.getElementById("jobstatusid").value+"&jobtype="+document.getElementById("txtjobtype").value);
			document.getElementById("txtdescription").value="";
			document.getElementById("errormsg").innerText="";
			$('#chckmandatory').attr('checked', false);
			return  true;
	    	} else {
		    $.messager.alert('Message',"Failed");
		    return  false;
		    }
		   } else {
		   }
		  }
		  x.open("GET","guidlineinsert.jsp?jobtype="+jobtype+"&jobstatus="+jobstatus+"&statusid="+statusid+"&description="+description+"&mandatory="+mandatory+"&date="+date, true);
		  x.send();  
	}
	
    function funUpdate(){
		var jobstatus=document.getElementById("txtjobstatus").value;
		var statusid=document.getElementById("jobstatusid").value;
		var srno=document.getElementById("is_pglinesrno").value;
		var description=document.getElementById("txtdescription").value;
		var mandatory=document.getElementById("chckmandatory").value;
		
		if(jobstatus==""){
			document.getElementById("errormsg").innerText="Select a job Status";
			return 0;
		}
		
		if(description==""){
			document.getElementById("errormsg").innerText="Enter Description For selected for process";
			return 0;
		}
		  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		   if (x.readyState == 4 && x.status == 200) {
		    var item=x.responseText.trim();
		    
		    if(item>0) {
	    	$.messager.alert('Message',"Updated Successfully");
	    	$('#descGrid').load("descGrid.jsp?statusid="+document.getElementById("jobstatusid").value+"&jobtype="+document.getElementById("txtjobtype").value);
			document.getElementById("jobstatusid").value="";
			document.getElementById("txtdescription").value="";
			document.getElementById("errormsg").innerText="";
			$('#chckmandatory').attr('checked', false);
			return  true;
	    	} else {
		    $.messager.alert('Message',"Failed");
		    return  false;
		    }
		   } else {
		   }
		  }
		  x.open("GET","guidlineupdate.jsp?statusid="+statusid+"&description='"+description+"'&srno="+srno+"&mandatory="+mandatory, true);
		  x.send();  
	}


    function funDelete(){
        var jobstatus=document.getElementById("txtjobstatus").value;
        var statusid=document.getElementById("jobstatusid").value;
        var srno=document.getElementById("is_pglinesrno").value;
        var description=document.getElementById("txtdescription").value;
        
        if(jobstatus==""){
            document.getElementById("errormsg").innerText="Select a job Status";
            return 0;
        }
        
        if(description==""){
            document.getElementById("errormsg").innerText="Select a description to delete";
            return 0;
        }
        
          var x = new XMLHttpRequest();
          x.onreadystatechange = function() {
           if (x.readyState == 4 && x.status == 200) {
            var item=x.responseText.trim();
            
            if(item>0) {
            $.messager.alert('Message',"Deleted Successfully");
            $('#descGrid').load("descGrid.jsp?statusid="+document.getElementById("jobstatusid").value+"&jobtype="+document.getElementById("txtjobtype").value);
            document.getElementById("jobstatusid").value="";
            document.getElementById("txtdescription").value="";
            document.getElementById("errormsg").innerText="";
            $('#chckmandatory').attr('checked', false);
                return  true;
            } else {
            $.messager.alert('Message',"Failed");
            return  false;
            }
           } else {
           }
          }
          x.open("GET","guidlinedelete.jsp?statusid="+statusid+"&srno="+srno, true);
          x.send();  
    }
	
function funNotify(){	
	 var rows = $("#jqxgDesc").jqxGrid('getrows');
	 var len=0;
	 for(var i=0;i<rows.length;i++){
	    var description= $.trim(rows[i].description);
		if(description.trim()!="" && typeof(description)!="undefined" && typeof(description)!="NaN" ) {
			newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test"+len)
		       .attr("name", "test"+len)
		       .attr("hidden", "true");
	       newTextBox.val(rows[i].description);
	       newTextBox.appendTo('form'); 
	       len=len+1;
		}
	 }
	 $('#descgridlen').val(len);
	   
	 var rows = $("#jqxgtwo").jqxGrid('getrows');
	 var len=0;
	 for(var i=0;i<rows.length;i++){
	    var fieldname= $.trim(rows[i].fieldname);
		if(fieldname.trim()!="" && typeof(fieldname)!="undefined" && typeof(fieldname)!="NaN" ) {
			newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test2"+len)
		       .attr("name", "test2"+len)
		       .attr("hidden", "true");
	       newTextBox.val(rows[i].fieldname+" :: "+rows[i].description+"");
	       newTextBox.appendTo('form'); 
	       len=len+1;
		}
	 }
	 $('#fieldgridlen').val(len);
	   
	 var rows = $("#jqxgthree").jqxGrid('getrows');
	 var len=0;
	 for(var i=0;i<rows.length;i++){
	    var notes= $.trim(rows[i].notes);
		if(notes.trim()!="" && typeof(notes)!="undefined" && typeof(notes)!="NaN" ) {
			newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test3"+len)
		       .attr("name", "test3"+len)
		       .attr("hidden", "true");
	       newTextBox.val(rows[i].notes);
	       newTextBox.appendTo('form'); 
	       len=len+1;
		}
	 }
	 $('#notegridlen').val(len);
	   
	 return 1;
}

function setValues() {
	  var doctype=document.getElementById("txtdoctype").value;
	  if(doctype!="") {
          var indexVal1 = document.getElementById("txtdoctype").value;
          var rdoc_type=indexVal1.replace(/ /g, "%20");
          $('#descGrid').load("descGrid.jsp?doctype="+rdoc_type);
          $('#gtwoGrid').load("gtwoGrid.jsp?doctype="+rdoc_type);
          $('#gthreeGrid').load("gthreeGrid.jsp?doctype="+rdoc_type);
	  }
	  
	  // main
	  if($('#hidjqxIpglDate').val()){
	      $("#jqxIpglDate").jqxDateTimeInput('val', $('#hidjqxIpglDate').val());
	  } 

	  if($('#msg').val()!=""){
	      $.messager.alert('Message',$('#msg').val());
	  }
}
</script>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmGuideLine" action="guideline" autocomplete="off">

<jsp:include page="../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxIpglDate" name="jqxIpglDate" value='<s:property value="jqxIpglDate"/>'></div>
                <input type="hidden" id="hidjqxIpglDate" name="hidjqxIpglDate" value='<s:property value="hidjqxIpglDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" style="width:120px;" value='<s:property value="txtrefno"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="docno" readonly style="width:120px;" value='<s:property value="docno"/>' tabindex="-1"/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Menu Type</label>
            <input type="text" id="txtdoctype" name="txtdoctype" readonly style="width:120px;" value='<s:property value="txtdoctype"/>'/>
            
            <label class="lbl-right" style="width:80px;">Menu Name</label>
            <input type="text" id="txtmenuname" name="txtmenuname" readonly style="flex:1; max-width:300px;" value='<s:property value="txtmenuname"/>' tabindex="-1"/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Video Path</label>
            <input type="text" id="txtvideopath" name="txtvideopath" style="flex:1;" value='<s:property value="txtvideopath"/>'/>
            
            <label class="lbl-right" style="width:80px;">PDF Path</label>
            <input type="text" id="txtpdfpath" name="txtpdfpath" style="flex:1;" value='<s:property value="txtpdfpath"/>'/>
        </div>

        <%-- Commented out logic from original code, refactored for modern UI if ever needed 
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
            
            <input type="checkbox" id="chckmandatory" name="chckmandatory" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin-left:15px;"> 
            <label>Flag</label>
            <input type="hidden" id="hidchckmandatory" name="hidchckmandatory" value='<s:property value="hidchckmandatory"/>'/>
            
            <button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funAdd();" style="margin-left:15px;">Add</button>
            <input type="button" name="btnUpdate" id="btnUpdate" class="myButton" value="Update" onclick="funUpdate();">
            <input type="button" name="btnDelete" id="btnDelete" class="myButton" value="Delete" onclick="funDelete();">
        </div> 
        --%>
    </div>

    <div style="display: flex; gap: 15px; margin-bottom: 15px;">
        
        <div class="middle-panel" style="flex: 0 0 30%; margin-bottom: 0;">
            <span class="middle-panel-title">Status / Menu</span>
            <div id="menuGrid" class="grid-container" style="height: 100%;">
                <jsp:include page="menuGrid.jsp"></jsp:include>
            </div>
        </div>

        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Details</span>
            
            <div id="descGrid" class="grid-container" style="margin-bottom: 15px;">
                <jsp:include page="descGrid.jsp"></jsp:include>
            </div>
            
            <div id="gtwoGrid" class="grid-container" style="display:none; margin-bottom: 15px;">
                <jsp:include page="gtwoGrid.jsp"></jsp:include>
            </div>
            
            <div id="gthreeGrid" class="grid-container">
                <jsp:include page="gthreeGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

    <div style="display:none;">
        <input type="hidden" id="descgridlen" name="descgridlen" value='<s:property value="descgridlen"/>'/>
        <input type="hidden" id="fieldgridlen" name="fieldgridlen" value='<s:property value="fieldgridlen"/>'/>
        <input type="hidden" id="notegridlen" name="notegridlen" value='<s:property value="notegridlen"/>'/>
        <input type="hidden" id="txtmenuid" name="txtmenuid" value='<s:property value="txtmenuid"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <%-- Commented hidden fields from original
        <input type="hidden" id="jobstatusid" name="jobstatusid" value='<s:property value="jobstatusid"/>'/>
        <input type="hidden" id="is_pglinesrno" name="is_pglinesrno" value='<s:property value="is_pglinesrno"/>'/> 
        --%>
    </div>

</div>
</form>
</div>
</body>
</html>