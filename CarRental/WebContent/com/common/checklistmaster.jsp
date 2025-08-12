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
<script type="text/javascript" src="<%=contextPath+"/"%>/js/ajaxfileupload.js"></script> 
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); 
 String formcode = request.getParameter("formCode")==null?"NA":request.getParameter("formCode"); 
 String brchid = request.getParameter("brchid")==null?"0":request.getParameter("brchid"); 
 String frmname = request.getParameter("frmname")==null?"":request.getParameter("frmname"); 
 %>
<script type="text/javascript">
var formcode='<%=formcode%>';      
var formname='<%=frmname%>';      
var docNo='<%=docNo%>';      
var brhid='<%=brchid%>';      
	$(document).ready(function() {
		document.getElementById("frmnames").innerHTML=("Checklist - "+formname); 
		$("#checkDataGrid").load("checklistgrid.jsp?dtype="+formcode+"&docno="+docNo+"&check=1&brhid="+brhid);
		
	});
	
function openAttachmaster(){
	$.messager.confirm('Confirm', 'Do you want to attach other files?', function(r){
		if (r){
			window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+formcode
					 +"&docno="+docNo+"&brchid="+brhid+"&frmname="+formname, "_self");
		}
	});
}
	
function handleSave(){
	 var gridarray=new Array();
	 var rows=$('#jqxchecklistgrid').jqxGrid('getrows');
	 var val=0,checksrno=0;
	 for(var i=0;i<rows.length;i++){
	    var chk=$('#jqxchecklistgrid').jqxGrid('getcellvalue',i,'chk');
	    var mandatory=$('#jqxchecklistgrid').jqxGrid('getcellvalue',i,'mandatory');  
		if(chk){  
			 gridarray.push(rows[i].checksrno+" :: "+rows[i].remarks+" :: "+rows[i].path+" :: "+rows[i].upload+" :: ");            
			 val++;
		}else{
			if(mandatory=="1"){      
				checksrno=1;  
			}
		}
	}
	if(val==0){
		$.messager.alert('Warning','Please select a checklist!');
	    return false;
	}
	

		processid="Checklist";       
		$.messager.confirm('Confirm', 'Do you want to save ?', function(r){
			if (r){
				var qottrno = docNo;
				funchecklistchanges(docNo,brhid,gridarray,checksrno,formcode);  
			}
		});
	}
	
	function funchecklistchanges(qottrno,brhid,checklist,checksrno,dtype){      
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items.trim())==1){  	  
						$('#checkDataGrid').load('checklistgrid.jsp?check=1&docno='+qottrno+'&brhid='+brhid+'&dtype='+dtype);        
						$.messager.alert('Success','Successfully Updated file');
					 }else{
						$.messager.alert('Warning','Please select a checklist!');
					} 
			}
		}    
		x.open("GET","checklistsavedata.jsp?qottrno="+qottrno+"&dtype="+dtype+"&brhid="+brhid+"&checklist="+encodeURIComponent(checklist),true);      
		x.send();
	}
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body>
<div id="mainBG" class="homeContent" data-type="background" >
<form autocomplete="off">
<fieldset style="display:flex; justify-content: center; align-items: center; margin-bottom:10px;">
	<label id="frmnames" name="frmnames" style="color:blue;font-weight:bold;font-size:14px;"></label>
</fieldset>
<div>
 	<div id="checkDataGrid"><jsp:include page="checklistgrid.jsp"></jsp:include></div>
</div>
<div style="margin-top:10px; display:flex; justify-content: flex-end;">
	<button type="button" id="btnopenattachmaster" onclick="openAttachmaster()" style="margin-right:10px;">Attach Other Files</button>
	<button type="button" id="btnchecklistsaveattach" onclick="handleSave()">Save Changes</button>
</div>
 <input type="hidden" id="formData" />
<input type="hidden" id="formName" />
<input type="hidden" id="formCode" />
</form>
</div>
</body>
</html>