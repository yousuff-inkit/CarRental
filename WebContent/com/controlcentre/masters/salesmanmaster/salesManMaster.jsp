<%@page import="com.controlcentre.masters.salesmanmaster.salesman.ClsSalesmanDAO" %>
<%ClsSalesmanDAO csd=new ClsSalesmanDAO(); %>
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
     /* ============================
   ⭐ PREMIUM BLUE UI THEME ⭐
   ============================*/

/* Scroll */
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* Background */
body {
    background: linear-gradient(135deg, #edf3ff 0%, #c7d7f9 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    margin: 0;
    padding: 32px 0;
    color: #1d2a4d;
}

/* Main container */
#mainBG {
    background: #ffffff;
    border-radius: 16px;
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
    box-shadow: 0 6px 28px rgba(58, 97, 171, 0.18);
}

/* Section blocks */
.section-block {
    background: #f2f6ff;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 3px 10px rgba(75, 125, 226, 0.10);
}

/* Section headings */
.section-block h2,
.table-section h3 {
    color: #1b4f9a;
    font-weight: 600;
    margin-bottom: 12px;
}

/* Form labels */
.section-block label {
    font-weight: 500;
    color: #1d2a4d;
    min-width: 110px;
    text-align: right;
}

/* Inputs */
.section-block input[type="text"],
.section-block input[type="email"],
.section-block select {
    border: 1px solid #b9c9e8;
    border-radius: 8px;
    padding: 8px 12px;
    background: #fff;
    transition: 0.25s ease;
    font-size: 14px;
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #3a78e0;
    box-shadow: 0 0 6px rgba(58, 120, 224, 0.35);
    outline: none;
}

/* Buttons */
.receipt-header button {
    background: linear-gradient(90deg, #1f6feb, #174dbf);
    color: #fff;
    padding: 7px 18px;
    border-radius: 8px;
    border: none;
    font-weight: 600;
    transition: 0.25s;
    cursor: pointer;
    box-shadow: 0 4px 10px rgba(37, 91, 179, 0.25);
}

.receipt-header button:hover {
    background: linear-gradient(90deg, #4687f1, #1f6feb);
    transform: translateY(-2px);
}

/* Table container */
.table-section {
    padding: 14px;
    background: #f4f8ff;
    border-radius: 10px;
}

/* Table UI */
.cr-table {
    width: 100%;
    background: #ffffff;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #d5e1f7;
}

.cr-table th {
    background: #e6efff;
    color: #1a3e7d;
    font-weight: 600;
    padding: 10px;
    border-bottom: 1px solid #d3def4;
}

.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #e3e9f5;
    font-size: 14px;
}

.cr-table tr:hover td {
    background: #f1f6ff;
}

/* Header row */
.receipt-header {
    background: #f0f5ff;
    padding: 16px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(107, 143, 219, 0.15);
}

 </style>
<script type="text/javascript">

$(document).ready(function () {     
	 $("#salesmandate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	
	 $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountWindow').jqxWindow('close');
	 document.getElementById("formdet").innerText="Sales Man(SLM)";
		document.getElementById("formdetail").value="Sales Man";
		document.getElementById("formdetailcode").value="SLM";
		window.parent.formCode.value="SLM";
		window.parent.formName.value="Sales Man";
      		 $('#txtaccno').dblclick(function(){
		  	    $('#accountWindow').jqxWindow('open');
			    var url=document.URL;
			    var reurl=url.split("com/");
				  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
      		 }); 
      		
    		var data='<%=csd.searchDetails()%>';
    		var source =
             {
                 datatype: "json",
                 datafields: [
                           	{name : 'doc_no' , type: 'int' },
      						{name : 'name', type: 'String'  },
                           	{name : 'mail', type: 'String'  },
                           	{name : 'acno',type:'string'},
                           	{name : 'description',type:'String'},
                           	{name : 'mobile',type:'string'},
                           	{name : 'code',type:'string'},
                           	{name :'date',type:'date'},
                           	{name : 'acdoc',type:'String'},
                  ],
                  localdata: data,
                 
                 
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
             $("#jqxSalesmanSearch1").jqxGrid(
                     {
                     	width: '100%',
                     	height:310,
                         source: dataAdapter,
                         showfilterrow: true,
                         filterable: true,
                         selectionmode: 'singlerow',
                         sortable: true,
                         altrows:true,
                         //Add row method
                         columns: [
         					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
         					{ text: 'Code',datafield: 'code', width: '10%',hidden:true },
         					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
         					{ text: 'Name', datafield: 'name', width: '20%' },
         					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '30%' },
         					{ text: 'Account No',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '50%' ,hidden:true},
         					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'mail', width: '15%' },
         					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
         					{ text: 'Ac Doc',columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%',hidden:true },

         	              ]
                     });

             $('#jqxSalesmanSearch1').on('rowdoubleclick', function (event) 
             		{ 
   		            	var rowindex1=event.args.rowindex;
   		                document.getElementById("docno").value= $('#jqxSalesmanSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
   		                document.getElementById("salesmanid").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "code");
   		                document.getElementById("salesmanname").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "name");
   		                document.getElementById("salesmanmail").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "mail");
   		                document.getElementById("telephone").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "mobile");
   		                $("#salesmandate").jqxDateTimeInput('val', $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
   		                document.getElementById("txtaccno").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "acno");
   		                document.getElementById("txtaccname").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "description");
   		                document.getElementById("hidacno").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
             		 }); 
  });
		 
	 function getAcc(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#accountWindow').jqxWindow('open');
		    var url=document.URL;
		     var reurl=url.split("com/");
			  	  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
		 }
		 else{}
		 }
	
	 function accountSearchContent(url) {
			 $.get(url).done(function (data) {
	    	 $('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function funFocus(){
		document.getElementById("salesmanid").focus();
	}
	
	function funReadOnly() {
		$('#frmSalesman input').attr('readonly', true);
		$('#salesmandate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmSalesman input').attr('readonly', false);
		$('#salesmandate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		$('#txtaccno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
	}
	
	function setValues() {
		if($('#hidsalesmandate').val()){
			$("#salesmandate").jqxDateTimeInput('val', $('#hidsalesmandate').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	
	$(function(){
	    $('#frmSalesman').validate({
	             rules: {
	             salesmanid: {required:true,maxlength:4},
	             salesmanname: {required:true,maxlength:40},
	             txtaccname:{required:true},
	             telephone:{required:true,digits:true,minlength:12,maxlength:12},
	             salesmanmail:{email:true}
	             },
	             messages: {
	              salesmanid:{required:" *",maxlength:"Max 4 Chars."},
	              salesmanname:{required:" *",maxlength:"Max 40 Chars."},
	              txtaccname:{required:" *"},
	              telephone:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
	              salesmanmail:{email:"Not a valid Email."}
	             }
	    });});
	    
	function funNotify(){
		if(document.getElementById("txtaccno").value==''){
			document.getElementById("errormsg").innerText="Account is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function funSearchLoad(){
		changeContent('salesmanSearch.jsp'); 
	 }
	function funExcelBtn(){
	   	 $("#jqxSalesmanSearch1").jqxGrid('exportdata', 'xls', 'Salesman');
	   }
 
</script>
<style>
.lbl {
    width: 12%;
    font-weight: 600;
    color: #1A3E7A;
    text-align: right;
    padding-right: 10px;
    padding-top: 6px;
}
.inp {
    width: 38%;
}
.txtbox {
    width: 95%;
    padding: 8px 10px;
    border: 1px solid #cfe0ff;
    background: #f9fbff;
    border-radius: 8px;
    font-size: 14px;
    transition: 0.2s;
}
.txtbox:focus {
    border-color: #1E88E5;
    box-shadow: 0 0 6px rgba(30,136,229,0.35);
    outline: none;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSalesman" action="saveSalesman" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/>
    <div class="hidden-scrollbar receipt-header">
<div class="table-section" style="width: 100%"><h3>Salesman Details</h3>
<table class="cr-table" width="100%" style="border-collapse:separate; border-spacing:0 10px;">

 <!-- Row 1 -->
<tr>
    <td class="lbl">Date</td>
    <td class="inp">
        <div id="salesmandate" name="salesmandate"></div>
    </td>

    <td class="lbl">Doc No.</td>
    <td class="inp">
        <input type="text" id="docno" name="docno"
               value='<s:property value="docno"/>'
               readonly tabindex="-1"
               class="txtbox">
    </td>
</tr>

<!-- Row 2 -->
<tr>
    <td class="lbl">Code</td>
    <td class="inp">
        <input type="text" id="salesmanid" name="salesmanid"
               value='<s:property value="salesmanid"/>'
               class="txtbox">
    </td>

    <td class="lbl">Name</td>
    <td class="inp">
        <input type="text" id="salesmanname" name="salesmanname"
               value='<s:property value="salesmanname"/>'
               class="txtbox">
    </td>
</tr>

<!-- Row 3 -->
<tr>
    <td class="lbl">Email</td>
    <td class="inp">
        <input type="email" id="salesmanmail" name="salesmanmail"
               value='<s:property value="salesmanmail"/>'
               class="txtbox">
    </td>

    <td class="lbl">Mobile</td>
    <td class="inp">
        <input type="text" id="telephone" name="telephone"
               value='<s:property value="telephone"/>'
               class="txtbox">
    </td>
</tr>

<!-- Row 4 -->
<tr>
    <td class="lbl">Account</td>
    <td class="inp">
        <input type="text" id="txtaccno" name="txtaccno"
               value='<s:property value="txtaccno"/>'
               readonly placeholder="Press F3 to Search"
               onkeydown="getAcc(event);"
               class="txtbox">
    </td>

    <td class="lbl">Account Name</td>
    <td class="inp">
        <input type="text" id="txtaccname" name="txtaccname"
               value='<s:property value="txtaccname"/>'
               readonly class="txtbox">
    </td>
</tr>
 

</table>

</div>

<input type="hidden" name="hidsalesmandate" id="hidsalesmandate" value='<s:property value="hidsalesmandate"/>'/>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="hidacno" name="hidacno"  value='<s:property value="hidacno"/>'/>
        <div id="jqxSalesmanSearch1"></div>

        <div id="accountWindow">
            <div >

    </div>
</form>
</div>
<br/>

	
	</div>
	<div>
	</div>
	 </div>  
	
</body>
</html>