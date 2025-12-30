<%@page import="com.controlcentre.masters.vehiclemaster.project.ClsProjectDAO" %>
<%ClsProjectDAO cpd=new ClsProjectDAO(); %>
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
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
    COMMON UI ELEMENTS
------------------------------ */
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
    font: 16px Segoe UI;
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
    padding: 0px 8px 0px 0px; 
}

/* ------------------------------
    CARD ROWS LAYOUT
------------------------------ */
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

/* Grid for the Project Details */
.project-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr; 
    gap: 12px 25px;
    align-items: center;
}

.hidden-scrollbar {
    overflow-y: visible !important; 
    max-height: none !important; 
    min-height: 1px; 
    padding: 10px; 
}

/* ------------------------------
    TABLES & DYNAMIC GRIDS (Preserved)
------------------------------ */
#jqxProjectSearch1 {
    width: 100%;
    margin-top: 10px;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	 $("#projectDate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	
	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $("#btnExcel").click(function() {
			$("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
		});
	 
	    document.getElementById("formdet").innerText="Project(PRJ)";
		document.getElementById("formdetail").value="Project";
		document.getElementById("formdetailcode").value="PRJ";
	 	window.parent.formCode.value="PRJ";
			window.parent.formName.value="Project";
	 var data= '<%=cpd.projectDetailsLoading() %>';
	           
	 var source =
	            {
	                datatype: "json",
	                datafields: [
	                          	{name : 'doc_no' , type: 'number' },
	                          	{name : 'date', type: 'date'  },
	                          	{name : 'refname', type: 'String'  },
	                          	{name : 'project_name', type: 'String'  }
	                 ],
	               localdata: data,
	                
	                pager: function (pagenum, pagesize, oldpagenum) {
	                    // callback called when a page or page size is changed.
	                }
	            };
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
		                    }
			            }		
	            );
	    
	            $("#jqxProjectSearch1").jqxGrid(
	                    {
	                    	width: 1450,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'multiplecellsextended',
	                        //Add row method
	                        columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Client Name',columntype: 'textbox', filtertype: 'input', datafield: 'refname', width: '30%' },
	        					{ text: 'Project Name',columntype: 'textbox', filtertype: 'input', datafield: 'project_name', width: '40%' }
	        	              ]
	                    });
	            $('#jqxProjectSearch1').on('rowdoubleclick', function (event) {
	                var rowindex1=event.args.rowindex;
	                document.getElementById("docno").value= $('#jqxProjectSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	                document.getElementById("txtprojectname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "project_name");
	                $("#projectDate").jqxDateTimeInput('val', $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
	                document.getElementById("txtclientname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "refname");
	            }); 
	            
	            
	            
	            $('#txtclientname').dblclick(function(){
	            	clientSearchContent('clientDetailsGrid.jsp');
	       		});
          });

function clientSearchContent(url) {
    $('#clientDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientDetailsWindow').jqxWindow('setContent', data);
	$('#clientDetailsWindow').jqxWindow('bringToFront');
}); 
}

function funReadOnly(){
	$('#frmProject input').attr('readonly', true );
	$('#projectDate').jqxDateTimeInput({disabled: true});
}

function funRemoveReadOnly(){
	$('#frmProject input').attr('readonly', false );
	$('#projectDate').jqxDateTimeInput({disabled: false});
	$('#txtclientname').prop('readonly', true);
	$('#docno').prop('readonly', true);
}

function setValues(){	
   
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

}

function funFocus(){
	$('#projectDate').jqxDateTimeInput('focus'); 
}
   
    /* Validations */
	   $(function(){
	        $('#frmProject').validate({
	                rules: {
	                txtclientname:"required",
	                txtprojectname:"required"
	                 },
	                 messages: {
	                 txtclientname:" *",
	                 txtprojectname:" *"
	                 }
	        });});
     
function funNotify(){
   return 1;
} 

function funSearchLoad(){
    changeContent('projectSearch.jsp');
}
     
function getClient(event){
  var x= event.keyCode;
  if(x==114){
	  clientSearchContent('clientDetailsGrid.jsp');
  }
  else{
   }
}
function funExcelBtn(){
	  $("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
}
</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br>

    <form id="frmProject" action="saveActionProject" autocomplete="off" method="post">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>Project Details</h2>
                <div class="project-info-grid">
                    <label>Date</label>
                    <div id="projectDate" name="projectDate" value='<s:property value="projectDate"/>'></div>
                    
                    <label>Doc No</label>
                    <input type="text" id="docno" name="txtprojectdocno" value='<s:property value="txtprojectdocno"/>' tabindex="-1" readonly/>

                    <label>Client</label>
                    <input type="text" name="txtclientname" id="txtclientname" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);">
                    
                    <label>Project Name</label>
                    <input type="text" name="txtprojectname" id="txtprojectname" value='<s:property value="txtprojectname"/>'>
                </div>
            </div>

            <div id="jqxProjectSearch1"></div> 

            <input type="hidden" id="hidprojectDate" name="hidprojectDate" value='<s:property value="hidprojectDate"/>'/>
            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            
        </div>
    </form>

    <div id="clientDetailsWindow">
        <div></div><div></div>
    </div>
</div>

</body>
</html>