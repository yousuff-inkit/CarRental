<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Bulletproof Table Layout (Does NOT affect header.jsp)
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 10px 20px;
    box-sizing: border-box;
}

.modern-ui .erp-form-area {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    min-width: 1050px; 
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
.modern-ui input:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<%@page import="com.humanresource.setup.hrsetup.companysetup.ClsCompanysetupDAO"%>
<% ClsCompanysetupDAO DAO = new ClsCompanysetupDAO(); %>

<script type="text/javascript"> 

	$(document).ready(function () {   
		
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Company Setup(CMS)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Company Setup";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="CMS";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="CMS";
		if(window.parent && window.parent.formName) window.parent.formName.value="Company Setup";
			
        /* FIXED DATE WIDTHS & HEIGHTS (Changed from 100% to 120px) */
		$("#compdate").jqxDateTimeInput({ width: '120px', height: '24px' ,formatString : "dd.MM.yyyy" });
		
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
		   
		$('#compWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '27%' , title: 'Company Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 	$('#compWindow').jqxWindow('close');
	 		
		$('#establishedCodeDetailsWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Establishment Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 	$('#establishedCodeDetailsWindow').jqxWindow('close');
	 		
	 	$('#company').dblclick(function(){
	 		compSearchContent("companydetailsGrid.jsp");
		});
	 		
		$('#estcode').dblclick(function(){
		    establishedCodeSearchContent("establishmentCodeDetailsSearchGrid.jsp");
		});

		var deptdata= '<%=DAO.loadgrid() %>'; 
	    var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'estcode', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'company', type: 'String'  },
                        	{name : 'remarks', type: 'String'  }
                 ],
               	 localdata: deptdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
	   
	    var dataAdapter = new $.jqx.dataAdapter(source);
    
        $("#companygrid").jqxGrid(
                 {
                 	width: "100%",
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                        
                    columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'EST Code',columntype: 'textbox', filtertype: 'input', datafield: 'estcode', width: '15%' },
	        					{ text: 'Company',columntype: 'textbox', filtertype: 'input', datafield: 'company',width:'30%' },
	        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks' },
	        					]
                    });
	}); 

    function getEstablishmentCode(event){
         var x= event.keyCode;
	     if(x==114){
	        	establishedCodeSearchContent("establishmentCodeDetailsSearchGrid.jsp");
	     }
	     else{}
	}
	   
	function establishedCodeSearchContent(url) {
		$('#establishedCodeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#establishedCodeDetailsWindow').jqxWindow('setContent', data);
			$('#establishedCodeDetailsWindow').jqxWindow('bringToFront');
		}); 
	}
	  
	function getcomp(event){
	      var x= event.keyCode;
	      if(x==114){
	        	compSearchContent("companydetailsGrid.jsp");
	      }
	      else{}
	}
	   
	function compSearchContent(url) {
		$('#compWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#compWindow').jqxWindow('setContent', data);
			$('#compWindow').jqxWindow('bringToFront');
		}); 
	}
	    
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
		    $('#frmcompanysetup input[type="text"]').attr('readonly', true);
		    $('#compdate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
		    $('#frmcompanysetup input[type="text"]').attr('readonly', false);
		    $('#compdate').jqxDateTimeInput({ disabled: false});
		    $('#docno').attr('readonly', true);
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
	
    /* SAFE SET VALUES FUNCTION */
	function setValues(){
	    try {
			if($('#datehidden').length && $('#datehidden').val()){
				$("#compdate").jqxDateTimeInput('val', $('#datehidden').val());
			}
			
			if($('#msg').length && $('#msg').val()!=""){
				  $.messager.alert('Message',$('#msg').val());
			}
			
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                 var detailVal = $('#formdetail').val() || "";
                 var codeVal = $('#formdetailcode').val() || "";
                 document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
	    } catch(e) { console.error("Error in setValues: ", e); }
	}
	
	function funNotify(){
        	if(document.getElementById("company").value=="") {
        		
        		document.getElementById("errormsg").innerText=" Enter Company";
        		document.getElementById("company").focus();
        		return 0;
        	}
    		return 1;
	}
	 function funFocus(){
		
	 }
	 
	 function funSearchLoad(){
		 changeContent('loadsearchGrid.jsp'); 
	 }
</script>

</head>
<body onLoad="setValues();" >

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmcompanysetup" action="saveCompanysetup" method="post" autocomplete="off">
    <jsp:include page="../../../../../header.jsp" />

    <div class="modern-ui">

        <div class="erp-form-area">
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="5%">Date</td>
                    <td width="15%">
                        <div id="compdate" name="compdate" value='<s:property value="compdate"/>'> </div>
                    </td>
                    <td class="lbl-right" width="8%">Company</td>
                    <td width="30%">
                        <input type="text" name="company" id="company" placeholder="Press F3 to Search" value='<s:property value="company"/>' onkeydown="getcomp(event);">
                    </td>
                    <td class="lbl-right" width="8%">Doc No</td>
                    <td width="34%">
                        <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1" style="width: 150px;">
                    </td>
                </tr>

                <tr>
                    <td class="lbl-right">Est Code</td>
                    <td>
                        <input type="text" name="estcode" id="estcode" placeholder="Press F3 to Search" value='<s:property value="estcode"/>' onkeydown="getEstablishmentCode(event);">
                    </td>
                    <td class="lbl-right">Remarks</td>
                    <td colspan="3">
                        <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' >
                    </td>
                </tr>
            </table>
        </div>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

    </div>
</form>

<div class="modern-ui" style="padding-top: 0;">
    <div class="grid-container">
        <div id="companygrid"></div>
    </div>
</div>

<div id="establishedCodeDetailsWindow"><div></div></div>  
<div id="compWindow"><div></div></div>

</div>
</body>
</html>