<%@page import="com.controlcentre.masters.vehiclemaster.securitypass.ClsSecurityPassDAO" %>
<%ClsSecurityPassDAO DAO1=new ClsSecurityPassDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>


<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	     $("#startdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	      $("#enddate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    document.getElementById("formdet").innerText="Security Pass(SPA)";
		document.getElementById("formdetail").value="Security Pass";
		document.getElementById("formdetailcode").value="SPA";
		window.parent.formCode.value="SPA";
		window.parent.formName.value="Security Pass";
 		
		
		/* Grid starts */
			var spdata='<%=DAO1.searchDetails()%>'; 
            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'startdate', type: 'date'  },
                          	{name : 'enddate', type: 'date'  },
							{name : 'description',type:'string'},
							{name : 'qty',type:'string'},
                 ],
               localdata: spdata,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#jqxSecpassSearch1").jqxGrid(
                    {
                    	width: '100%',
                    	height:350,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        //Add row method
                        columns: [
        					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
							{ text: 'Description',datafield:'description',width:'50%',columntype: 'textbox', filtertype: 'input'},
							{ text: 'StartDate',columntype: 'textbox', filtertype: 'input', datafield: 'startdate', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'EndDate',columntype: 'textbox', filtertype: 'input', datafield: 'enddate', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Qty',columntype: 'textbox', filtertype: 'input', datafield: 'qty', width: '10%' },
        	              ]
                    });
            $('#jqxSecpassSearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxSecpassSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("name").value = $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "name");
				document.getElementById("description").value = $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "description");
                $("#date").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
				 var sdate=$("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "startdate");
				 var edate=$("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "enddate");
                if(sdate==null ||sdate==""){
                 $("#startdate").val(new Date());
                }else{
                $("#startdate").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "startdate"));
                
                }
                  if(edate==null ||edate==""){
                 $("#enddate").val(new Date());
                }else{
                 $("#enddate").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "enddate"));
                
                }
                 
                  document.getElementById("qty").value= $('#jqxSecpassSearch1').jqxGrid('getcellvalue', rowindex1, "qty");
                $('#window').jqxWindow('close');
                // 
            });  
            
            /* Grid Ends */
        });
	
	
	
	function funSearchLoad(){
		changeContent('securityPassSearch.jsp', $('#window')); 
	 }
	function funReadOnly() {
		$('#frmSecpass input').attr('readonly', true);
		$('#date').jqxDateTimeInput({
			readonly : true
		});
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmSecpass input').attr('readonly', false);
		$('#date').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
		 if(document.getElementById("mode").value=='A'){
		  $("#startdate").jqxDateTimeInput('setDate', new Date());
	    	 $("#enddate").jqxDateTimeInput('setDate', new Date());
	    	  $("#date").jqxDateTimeInput('setDate', new Date());
		 
		 
		 }
	}
	function setValues() {
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	 $(function(){
	        $('#frmSecpass').validate({
	                 rules: {
	                 name: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  name: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("name").focus();
	     }
	  function funExcelBtn(){
		  $("#jqxSecpassSearch1").jqxGrid('exportdata', 'xls', 'Brand');
	  }
</script>  
 <style> 
 body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
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
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

.receipt-header {
    display: flex;
    flex-direction: column;
    margin-bottom: 16px;
    padding: 0 10px 10px;
}

.receipt-header table {
    width: 100%;
}

.receipt-header td {
    padding: 6px 4px;
    vertical-align: middle;
}

.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    text-align: right;
    padding-right: 8px;
    font-size: 1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 30px;
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
}

.pdc-cheque-row {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
    flex-wrap: nowrap;
}

.pdc-cheque-row input[type="checkbox"] {
    width: auto;
    margin: 0 4px 0 0;
}

.pdc-cheque-row label {
    text-align: right;
    padding-right: 8px;
    white-space: nowrap;
    margin: 0;
    font-weight: 600;
}

.myButton {
    background-color: #007BFF;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 500;
    transition: background-color 0.3s ease, transform 0.1s ease, box-shadow 0.3s ease;
}

input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important;
    -webkit-text-fill-color: #253858 !important;
}

.jqx-datetimeinput {
    height: 34px !important;
    box-sizing: border-box;
}
</style>
</head>
<body onLoad="setValues();" class="hidden-scrollbar" >
<form id="frmSecpass" action="saveSecurityPass" method="get" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<div id="mainBG">
    <div class='receipt-header'>
        <table width="100%">
            <tr>
                <td width="5%" align="right"><label>Date</label></td>
                <td width="15%">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </td>
                <td width="40%"></td>
                <td width="10%" align="right"><label>Doc No.</label></td>
                <td width="30%">
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
                </td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Security Pass Details</h2>
        
        <div class="form-group pdc-cheque-row">
            <label style="width:120px;">StartDate</label>
            <div id="startdate" name="startdate" value='<s:property value="startdate"/>'></div>
            <label>EndDate</label>
            <div id="enddate" name="enddate" value='<s:property value="enddate"/>'></div>
        </div>

        <div class="form-group dual-input">
            <label>Name</label>
            <input type="text" name="name" id="name" value='<s:property value="name"/>'>
            <label>Qty</label>
            <input type="text" name="qty" id="qty" value='<s:property value="qty"/>'>
        </div>

        <div class="form-group">
            <label>Description</label>
            <input type="text" name="description" id="description" value='<s:property value="description"/>'>
        </div>
    </div>

    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
</div>
    	
	</form>
<table width="100%">
      <tr>
        <td align="center"><div id="jqxSecpassSearch1"></div>  </td>
      </tr>
    </table>
<br/>
		
	

</body>
</html>