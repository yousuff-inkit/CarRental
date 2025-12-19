<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* background */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    min-height: 100vh;
    box-sizing: border-box;
    font-size: 14px;
}

/* main card */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 18px 28px;
    max-width: 1500px;
    margin: 0 auto;
}

/* section wrapper */
.table-section {
    margin-bottom: 20px;
    padding-inline: 14px;
    padding-block: 14px;
    border-radius: 10px;
    background: #f6f8fa;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}
.table-section h3 {
    margin: 0 0 12px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    font-size: 15px;
    font-weight: 600;
}

/* table layout */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
    table-layout: fixed;
}
.cr-table td {
    padding: 6px 8px;
    font-size: 13px;
    vertical-align: middle;
}
.cr-table td[align="right"] {
    white-space: nowrap;
    font-weight: 500;
    color: #333;
}

/* unified inputs */
.cr-table input[type="text"] {
    width: 100%;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 4px 8px;
    height: 30px;
    font-size: 13px;
    box-sizing: border-box;
    background: #fff;
}
.cr-table input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* date cell */
#allowancedate {
    width: 100%;
}

/* grid under form */
#allowancegrid {
    margin-top: 10px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 0 0 1px #eef0f6;
}
</style>


<%@page import="com.humanresource.setup.hrsetup.allowances.ClsAllowancesDAO"%>
<% ClsAllowancesDAO showDAO = new ClsAllowancesDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Allowance(ALC)";
		document.getElementById("formdetail").value="Allowance";
		document.getElementById("formdetailcode").value="ALC";
		window.parent.formCode.value="ALC";
		window.parent.formName.value="Allowance";
		
	    $("#allowancedate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
	    $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		   
		$('#acno').dblclick(function(){
		    	
		if($('#mode').val()!= "view") {
			  	 $('#accountSearchwindow').jqxWindow('open');
			  	  accountSearchContent('accountsDetailsSearch.jsp');
		    	 }
		  });   
		   
            var alcdata='<%=showDAO.searchAllowance()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'code', type: 'String'  },
     						{name : 'allowance', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'acno', type: 'String'  },
                         	{name : 'accname', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                         	{name : 'accdocno', type: 'String'  },
                          	
                 ],
               		localdata: alcdata,

               	 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
                                         
             };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            	$("#allowancegrid").jqxGrid(
                    {
                    	width: '100%',
                        height: 375,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			columnsresize: true,
             			showfilterrow: true,
                        filterable: true,
                        
                        columns: [
									{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
									{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
									{ text: 'Allowance Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '8%' },
									{ text: 'Allowance Name',columntype: 'textbox', filtertype: 'input', datafield: 'allowance', width: '15%' },
									{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
									{ text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '25%' },
									{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '28%' },
									{ text: 'Account Doc No',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
            					]
                    });
            	
         $('#allowancegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#allowancegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("allowancecode").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("allowance").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "allowance");
                $("#allowancedate").jqxDateTimeInput('val', $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("acno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("accname").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accname");
                document.getElementById("accdocno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
                
            });   
        });

	function funSearchLoad(){
		 changeContent('allowancessearch.jsp'); 
	 }
 
     function accountSearchContent(url) {
        
          $.get(url).done(function (data) {
          	$('#accountSearchwindow').jqxWindow('setContent', data);
  	      }); 
      	}
  	  
	function funReadOnly() {
		$('#frmallowance input').attr('readonly', true);
		$('#allowancedate').jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly() {
		$('#frmallowance input').attr('readonly', false);
		$('#docno').attr('readonly', true);
		$('#acno').attr('readonly', true);
		$('#accname').attr('readonly', true);
		$('#allowancedate').jqxDateTimeInput({ disabled: false});
		
		if ($("#mode").val() == "A") {
			 $('#allowancedate').val(new Date());
		}
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#allowancedate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	   	
	     if($('#mode').val()!="view") {
	 	 if(x==114){
	 	  	$('#accountSearchwindow').jqxWindow('open');
	 	 	accountSearchContent('accountsDetailsSearch.jsp');    
	 	 }
	 	 else{}
	 		}
	 	 }
 
	     function funNotify(){
	        	if(document.getElementById("allowance").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Enter Allowance";
        		document.getElementById("allowance").focus();
        		return 0;
        		}
	        	
	        	
	        	if(document.getElementById("acno").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Search Account";
        		document.getElementById("acno").focus();
        		return 0;
        		}
	    		return 1;
		} 
	     
	     function funFocus(){
	    		$('#allowancedate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmallowance" action="saveAllowance" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>

<div class="table-section" style="width:100%;">
    <h3>Allowance Details</h3>

    <table class="cr-table">
        <tr>
            <td align="right" style="width:8%;">Date</td>
            <td style="width:16%;">
                <div id="allowancedate" name="allowancedate"
                     value='<s:property value="allowancedate"/>'></div>
            </td>

            <td align="right" style="width:10%;">Allowance</td>
            <td style="width:20%;">
                <input type="text" name="allowancecode" id="allowancecode"
                       placeholder="Allowance Code"
                       value='<s:property value="allowancecode"/>'>
            </td>

            <td align="right" style="width:8%;">Name</td>
            <td style="width:24%;">
                <input type="text" name="allowance" id="allowance"
                       placeholder="Allowance Name"
                       value='<s:property value="allowance"/>'>
            </td>

            <td align="right" style="width:8%;">Doc No</td>
            <td style="width:16%;">
                <input type="text" name="docno" id="docno"
                       value='<s:property value="docno"/>'
                       readonly tabindex="-1">
            </td>
        </tr>

        <tr>
            <td align="right">Account</td>
            <td colspan="7">
                <input type="text" name="acno" id="acno"
                       placeholder="Press F3 To Search"
                       readonly
                       onkeydown="getaccountdetails(event);"
                       value='<s:property value="acno"/>'>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="text" name="accname" id="accname"
                       style="width:61%;"
                       readonly
                       value='<s:property value="accname"/>'>
            </td>
        </tr>

        <tr>
            <td align="right">Remarks</td>
            <td colspan="7">
                <input type="text" name="remarks" id="remarks"
                       placeholder="Remarks"
                       value='<s:property value="remarks"/>'>
            </td>
        </tr>
    </table>

    <input type="hidden" id="mode" name="mode"
           value='<s:property value="mode"/>' />
    <input type="hidden" id="msg" name="msg"
           value='<s:property value="msg"/>'/> 
    <input type="hidden" name="deleted" id="deleted"
           value='<s:property value="deleted"/>'/> 
    <input type="hidden" id="datehidden" name="datehidden"
           value='<s:property value="datehidden"/>'/> 
    <input type="hidden" name="accdocno" id="accdocno"
           value='<s:property value="accdocno"/>' >
</div>
</form>

<div id="allowancegrid"></div><br/>

<div id="accountSearchwindow">
    <div></div>
</div>

</div>
</body>

</html>