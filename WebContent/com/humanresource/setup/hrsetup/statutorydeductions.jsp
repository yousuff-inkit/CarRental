<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
    /* --- GLOBAL LAYOUT --- */
    html { overflow-y: scroll; }
    body {
        background-color: #f0f4f8;
        font-family: 'Segoe UI', 'Roboto', Helvetica, Arial, sans-serif;
        margin: 0; padding: 0;
        color: #334155;
    }

    /* --- BACKGROUND WIDTH FIX --- */
    #mainBG, .homeContent {
        width: 100%;
        min-width: 1300px !important; /* Increased min-width for dense fields */
        height: auto;
        min-height: 100vh;
        box-sizing: border-box;
        padding-bottom: 80px;
    }

    #frmstatudeduction {
        width: 98%;
        margin: 20px auto;
        padding: 0 15px;
        box-sizing: border-box;
    }

    /* --- BLUE HEADER CARD SECTION --- */
    .header-card-section {
        background: linear-gradient(to bottom right, #dbeafe, #eff6ff); 
        border-radius: 16px;
        padding: 20px;
        box-shadow: 0 4px 15px rgba(59, 130, 246, 0.15);
        border: 1px solid #bfdbfe;
        margin-bottom: 20px;
    }

    /* --- GRID CARD SECTION --- */
    .grid-card-section {
        background: #ffffff;
        border-radius: 16px;
        padding: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        border: 1px solid #e2e8f0;
        margin-bottom: 20px;
        height: 100%;
    }

    /* --- SECTION TITLES --- */
    h3 {
        color: #1e3a8a; 
        font-weight: 700;
        font-size: 1.2rem;
        margin: 0 0 15px 0;
        border-bottom: 2px solid #e2e8f0;
        padding-bottom: 5px;
    }

    /* --- TABLE LAYOUT --- */
    .header-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 10px; 
        table-layout: fixed; 
    }

    /* Labels */
    .header-table td.label-cell {
        text-align: right;
        color: #1e3a8a;
        font-weight: 700;
        font-size: 15px; 
        white-space: nowrap;
        vertical-align: middle;
        padding-right: 15px; 
    }

    /* Inputs */
    .header-table td.input-cell {
        vertical-align: middle;
        text-align: left;
    }

    /* --- PILL INPUT STYLING --- */
    input[type="text"], select, .jqxDateTimeInput {
        background-color: #ffffff !important;
        border: 1px solid #94a3b8 !important;
        border-radius: 8px !important; 
        height: 38px !important;
        padding: 0 12px !important;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05) !important;
        color: #334155;
        font-size: 14px;
        font-weight: 500;
        width: 100% !important;
        box-sizing: border-box; 
    }

    /* Focus State */
    input[type="text"]:focus {
        border-color: #2563eb !important;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2) !important;
        outline: none;
    }

    /* JQX Override */
    .jqx-widget-content {
        border-radius: 8px !important;
        border-color: #94a3b8 !important;
    }
    
    form label.error {
        color: red;
        font-weight: bold;
    }
    
    fieldset { border: none; padding: 0; margin: 0; }
    legend { display: none; } 
</style>

<%@page import="com.humanresource.setup.hrsetup.statutorydeductions.ClsStatutorydeductionsDAO"%>
<% ClsStatutorydeductionsDAO showDAO = new ClsStatutorydeductionsDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {    
		document.getElementById("formdet").innerText="Statutory Deductions(STD)";
		document.getElementById("formdetail").value="Statutory Deductions";
		document.getElementById("formdetailcode").value="STD";
		window.parent.formCode.value="STD";
		window.parent.formName.value="Statutory Deductions";
	   
		// UPDATED SIZE
		$("#statudate").jqxDateTimeInput({ width: '100%', height: '38px' ,formatString : "dd.MM.yyyy" });
	    
	    $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		   
		$('#acno').dblclick(function(){
		    	if($('#mode').val()!= "view") {
			  	    $('#accountSearchwindow').jqxWindow('open');
			  	    accountSearchContent('accountsDetailsSearch.jsp?');
		    	}
		  });   
		   
      		var alcdata='<%=showDAO.searchstatu()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'date'  },
                          	{name : 'satudeduction', type: 'String'  },
                          	{name : 'acno', type: 'String'  },
                         	{name : 'accname', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                         	{name : 'accdocno', type: 'String'  },
                        	{name : 'chktype', type: 'String'  },
                         	
                 ],
                  localdata: alcdata,
                 
                pager: function (pagenum, pagesize, oldpagenum) {
                    
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#deductiongrid").jqxGrid(
                    {
                    	width: "100%",
                    	height:375,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Statutory Deductions',columntype: 'textbox', filtertype: 'input', datafield: 'satudeduction', width: '20%' },
        					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
        					{ text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '26%' },
        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '30%' },
        					{ text: 'accdocno',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
        					{ text: 'chktype',columntype: 'textbox', filtertype: 'input', datafield: 'chktype', width: '10%' ,hidden: true},
        	              ]
                    });

            $('#deductiongrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#deductiongrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("satudeduction").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "satudeduction");
                $("#statudate").jqxDateTimeInput('val', $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("acno").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("accname").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "accname");
                document.getElementById("accdocno").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
                $('#frmstatudeduction select').attr('disabled', false);
                document.getElementById("type").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "chktype");
                
                if ($("#mode").val() == "view") {
	            	$('#frmstatudeduction select').attr('disabled', true);
                }
            });   
        });
	
	function funSearchLoad(){
		 changeContent('statutorydeductionsearch.jsp'); 
	 }
	 
     function accountSearchContent(url) {
            $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('setContent', data);
  		}); 
     }
  	  
	function funReadOnly() {
		$('#frmstatudeduction input').attr('readonly', true);
		$('#frmstatudeduction select').attr('disabled', true);
		$('#statudate').jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly() {
		$('#frmstatudeduction input').attr('readonly', false);
		$('#frmstatudeduction select').attr('disabled', false);
		$('#docno').attr('readonly', true);
		$('#acno').attr('readonly', true);
		$('#accname').attr('readonly', true);
		$('#statudate').jqxDateTimeInput({ disabled: false});

		if ($("#mode").val() == "A") {
			 $('#statudate').val(new Date());
		   }
	}
 
	function setValues() {
		
		if($('#datehidden').val()){
			$("#statudate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		 
		 if($('#hidtype').val()=="1") {
			 $('#type').val("1");
		 } else {
			 $('#type').val("0");
		 }
		 
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	 	 if($('#mode').val()!="view") {
	 	 if(x==114){
	 	  	$('#accountSearchwindow').jqxWindow('open');
	 	    accountSearchContent('accountsDetailsSearch.jsp?');    }
	 	 else{}
	 		}
	 	 }
	     
	     function funNotify(){
	         	if(document.getElementById("satudeduction").value=="") {
		       		document.getElementById("errormsg").innerText=" Enter Statutory Deductions	";
		       		document.getElementById("satudeduction").focus();
		       		return 0;
        		}
	        	
	        	if(document.getElementById("acno").value=="") {
	        		document.getElementById("errormsg").innerText=" Search Account";
	        		document.getElementById("acno").focus();
	        		return 0;
        		}
	    		return 1;
		} 
	     
	    function funFocus(){
	    	 $('#statudate').jqxDateTimeInput('focus');
	    }
	  
</script>   
 
</head>
<body onLoad="setValues();" > 

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmstatudeduction" action="savestatuDeduction" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<div class="header-card-section">
	<h3>Statutory Deductions Details</h3>
	<table class="header-table">
		<colgroup>
			<col style="width: 10%;"> <col style="width: 15%;"> 
			<col style="width: 12%;"> <col style="width: 34%;"> 
			<col style="width: 10%;"> <col style="width: 10%;"> 
			<col style="width: auto;">
		</colgroup>
		<tr>
			<td class="label-cell">Date</td> 
			<td class="input-cell">
				<div id="statudate" name="statudate" value='<s:property value="statudate"/>'> </div>
			</td>
			  	
			<td class="label-cell">Deduction</td>
			<td class="input-cell">
				<input type="text" name="satudeduction" id="satudeduction" style="width:100%;" placeholder="Statutory Deductions" value='<s:property value="satudeduction"/>'>
			</td>
			
			<td class="label-cell">Doc No</td>
			<td class="input-cell">
				<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
			</td>
			
			<td></td>
		</tr> 
		<tr>
			<td class="label-cell">Account</td> 
			<td class="input-cell">
				<input type="text" name="acno" id="acno" readonly="readonly"   placeholder="Press F3 To Search"  onKeyDown="getaccountdetails(event);"   value='<s:property value="acno"/>' > 
			</td>
			<td class="label-cell">Account Name</td>
			<td class="input-cell">
				<input type="text" name="accname" id="accname" readonly="readonly" value='<s:property value="accname"/>' >
			</td>
			<td class="label-cell">Type</td>
			<td class="input-cell">
				<select name="type" id="type"  value='<s:property value="type"/>'  >
					<option value="0">Amount</option><option value="1">Percentage</option>
				</select>
			</td>
			<td></td>
		</tr>
		<tr>
			<td class="label-cell">Remarks</td>
			<td class="input-cell" colspan="5">
				<input type="text" name="remarks" id="remarks"  placeholder="Remarks" value='<s:property value="remarks"/>' >
			</td>
			<td></td>
		</tr>
	</table>
	 
	<div id="errormsg"></div>
	
	<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
	<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
	<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
	<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
	<input type="hidden" name="accdocno" id="accdocno" value='<s:property value="accdocno"/>' >
	<input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>' >
	
</div> 
</form>

<div class="grid-card-section">
	<div id="deductiongrid"></div>
</div>
		 
<div id="accountSearchwindow">
	   <div></div>
</div>	

</div>
</body>
</html>