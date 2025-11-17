<%@page import="com.controlcentre.masters.vehiclemaster.dealer.ClsDealerAction" %>
<%ClsDealerAction cda=new ClsDealerAction(); %>


<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>

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

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}
#validrate{
    color:red;
}
#validrate1{
    color:red;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
}
#mainBG {
    background: #fff;
    border-radius: 16px;
    /*box-shadow: 0 4px 24px rgba(0,0,0,0.08);*/
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
}

.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0px 24px;
    font-size: 2vh;
}
.receipt-header label {
    font-weight: 500;
    color: #333;
    margin-right: 8px;
}
.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 1rem;
    width: 120px;
    background: #fff;
    transition: border-color 0.2s;
}
.receipt-header input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}
.receipt-header button {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
}
.receipt-header button:hover {
    background: #0056b3;
}
#txtStatus {
    font-size: 1rem;
    font-weight: 600;
    color: #e67e22;
    margin-left: 12px;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}
.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}

.section-block h2 {
    font-size: 1.09em;
    font-weight: 500;
    margin: 0 0 16px 0;
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
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}


.table-section {
    margin-bottom: 18px;
}
.table-section h3 {
    color: #253858;
    font-size: 1.04em;
    font-weight: 600;
}
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}
.cr-table th, .cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 1em;
}
.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}
.cr-table tr:last-child td {
    border-bottom: none;
}
</style>
<script type="text/javascript">
      $(document).ready(function () {          
    	  $("#dealerdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
    	  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#accountWindow').jqxWindow('close');
		  
		  document.getElementById("formdet").innerText="Dealer(VDR)";
		  document.getElementById("formdetail").value="Dealer";
		  document.getElementById("formdetailcode").value="VDR";
		  window.parent.formCode.value="VDR";
		  window.parent.formName.value="Dealer";
 		 var data1= '<%=cda.searchDetails() %>';
             
             var num = 0; 
             var source =
             {
                 datatype: "json",
                 datafields: [
                           	{name : 'DOC_NO' , type: 'int' },
      						{name : 'name', type: 'String'  },
                           	{name : 'acc_no', type: 'String'  },
                           	{name : 'date',type:'date'},
                           	{name : 'description',type:'string'}
                           	
                  ],
                  localdata: data1,
                 
                 
                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
             };
             
             var dataAdapter = new $.jqx.dataAdapter(source,
             		 {
                 		loadError: function (xhr, status, error) {
 	                    alert(error);    
 	                    }
 		            }		
             );
           
             $("#jqxDealerSearch1").jqxGrid(
                     {
                     	width: '100%',
                         height: 315,
                         source: dataAdapter,
                         showfilterrow: true,
                         filterable: true,
                         selectionmode: 'singlerow',
                       //  pagermode: 'default',
                         sortable: true,
                         //pageable: true,
                         altrows:true,
                         //Add row method
                         columns: [
         					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
         					{ text: 'Dealer',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
         					{ text: 'Acc No',columntype: 'textbox', filtertype: 'input', datafield: 'acc_no', width: '20%',hidden:true },
         					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
         					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '40%' },
         					]
                     });

             $('#jqxDealerSearch1').on('rowdoubleclick', function (event) 
             		{ 
 		            	var rowindex1=event.args.rowindex;
 		                document.getElementById("docno").value= $('#jqxDealerSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
 		                document.getElementById("dealername").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "name");
 		                $("#dealerdate").jqxDateTimeInput('val',$("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
 		                document.getElementById("txtaccname").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "description");
 		                document.getElementById("txtaccno").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "acc_no");
             		 });           		 
           		 });
      function accountSearchContent(url) {
		  $('#accountWindow').jqxWindow('open');
			 $.get(url).done(function (data) {
				// alert(data);
			$('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
     function funSearchdblclick(){
       	 var dtype="VDR";
			  var url=document.URL;
			     var reurl=url.split("/com/");
				  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
			//  });  
	}
    function getAcc(event){
     	 var dtype="VDR";
         var x= event.keyCode;
         if(x==114){
       	 //alert("here");
        	 var url=document.URL;
		     var reurl=url.split("/com/");
			  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
         }
         else{
          }
         }
      function funSearchLoad(){
			changeContent('dealerSearch.jsp', $('#window')); 
		 }
         /*  function getAcc(event){
           			 var x= event.keyCode;
           			 if(x==114){
           			  $('#accountWindow').jqxWindow('open');
       		  	    $('#accountWindow').jqxWindow('focus');
           			 }
           			 else{
           				 }
           			 }  */
           		
	function funReadOnly() {
		$('#frmDealer input').attr('readonly', true);
		 $('#dealerdate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmDealer input').attr('readonly', false);
		 $('#dealerdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
		$('#dealername').attr('readonly', true);
	}


	/* function getAccount() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var accItems = items[0].split(",");
				var accnoItems = items[1].split(",");
				var optionsacc = '<option value="">--Select--</option>';
				for (var i = 0; i < accItems.length; i++) {
					optionsacc += '<option value="' + accnoItems[i] + '">'
							+ accItems[i] + '</option>';
				}
				$("select#accno").html(optionsacc);
				$('#accno').val($('#accnohidden').val());

			} else {
			}
		}
		x.open("GET", "getAccount.jsp", true);
		x.send();
		//document.write(document.getElementById("authname").value);

	} */
	 function setValues(){	
		    if($('#dealerdatehidden').val()){
				$("#dealerdate").jqxDateTimeInput('val', $('#dealerdatehidden').val());
			}
			
		    if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }

			}
		    function funFocus()
		    {
		    	document.getElementById("dealername").focus();
		    		
		    }
		    $(function(){
		    
		        $('#frmDealer').validate({
		                 rules: {
		                 dealername:{
		                	 required:true,
		                	 maxlength:45
		                 } 
		             
		                
		                 },
		                 messages: {
		                  dealername:{
		                	  required:" *",
		                	  maxlength:"max 45 chars"
		                  }
		              
		                 }
		        });
		        });
		     function funNotify(){
		    		//alert($('#txtaccname').val());	 
		    		if(document.getElementById("txtaccname").value==''){
		    			document.getElementById("errormsg").innerText="A/c is Mandatory";
		    		/* 	//document.getElementById("txtaccname").focus;
		    			$('#txtaccname').focus();
 */		    		return 0;
		    		}
		    		else{
		    			document.getElementById("errormsg").innerText="";
		    		}
		    		return 1;
			} 
		     function funExcelBtn(){
				  $("#jqxDealerSearch1").jqxGrid('exportdata', 'xls', 'Dealer');
			  }
</script>
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmDealer" action="saveActionDealer" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/>

    <div class='hidden-scrollbar receipt-header'>
<div class="table-section" style="width: 100%;"><h3>Dealer Details</h3>
<table class="cr-table" width="100%">
  <tr>
    <td width="103" align="right">Date</td>
    <td width="196"><div id="dealerdate" name="dealerdate" value='<s:property value="dealerdate"/>'></div></td>
    <td width="102">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
    <td width="99"><div align="right">Doc No</div></td>
    <td colspan="2"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly></td>
  </tr>
  <tr>
    <td><div align="right">Acc. No.</div></td>
    <td colspan="2"><input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' style="width:99%;" ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" readonly placeholder="Press F3 to Search" required ></td>
    <td width="96">&nbsp;</td>
    <td width="400"></td>
    <td><div align="right">Dealer</div></td>
    <td width="240"><!--   -->
      <input type="text" name="dealername"  id="dealername"  value='<s:property value="dealername"/>'></td>
    <td width="43">&nbsp;</td>
  </tr>
</table>
<input type="hidden" id="txtaccno" name="txtaccno" value='<s:property value="txtaccno"/>'>
<input type="hidden" id="dealerdatehidden" name="dealerdatehidden" value='<s:property value="dealerdatehidden"/>'>
<input type="hidden" id="mode" name="mode"/>
				        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
</div>
        <div id="jqxDealerSearch1"></div>
        <div id="accountWindow">
            <div></div><div></div>
        </div>
    </div>
</form>
<br/>

<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="dealerSearch.jsp"></jsp:include>
	</div></div> --%>
</div>

 </body>
</html>