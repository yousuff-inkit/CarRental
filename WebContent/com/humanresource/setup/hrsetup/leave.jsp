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

<%@page import="com.humanresource.setup.hrsetup.leave.ClsLeaveDAO"%>
<% ClsLeaveDAO showDAO = new ClsLeaveDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {   
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Leave(LEV)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Leave";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="LEV";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="LEV";
		if(window.parent && window.parent.formName) window.parent.formName.value="Leave";
		
        /* FIXED DATE WIDTHS & HEIGHTS */ 
	    $("#leavedate").jqxDateTimeInput({ width: '100%', height: '24px' ,formatString : "dd.MM.yyyy" });
 
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
 
	    $('#abbrevationDetailsWindow').jqxWindow({width: '31%', height: '38%',  maxHeight: '50%' ,maxWidth: '31%' , title: 'Abbreviation Search',position: { x: 600, y: 100 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#abbrevationDetailsWindow').jqxWindow('close'); 
		 
		$('#abbreviation').dblclick(function(){
			abbrevationSearchContent("leaveAbbreviationSearch.jsp");
		});
		
	        var leavedata='<%=showDAO.searchLeave()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'leave1', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  },
                        	{name : 'abbreviation', type: 'String'  }
                          	
                 ],
                 localdata: leavedata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // leavedata called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#leavegrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Leave',columntype: 'textbox', filtertype: 'input', datafield: 'leave1', width: '30%' },
		        					{ text: 'Abbreviation',columntype: 'textbox', filtertype: 'input', datafield: 'abbreviation', width: '10%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '38%' },
        	              ]
                    });
            
           $('#leavegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
           
                document.getElementById("docno").value= $('#leavegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("leave").value = $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "leave1");
                $("#leavedate").jqxDateTimeInput('val', $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("abbreviation").value=$("#leavegrid").jqxGrid('getcellvalue', rowindex1, "abbreviation"); 
            });   
        });
	
	
	function abbrevationSearchContent(url) {
	    $('#abbrevationDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#abbrevationDetailsWindow').jqxWindow('setContent', data);
		$('#abbrevationDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funSearchLoad(){
		 changeContent('leavesearch.jsp'); 
	 }
	
	 function getAbbrevation(event){
         var x= event.keyCode;
         if(x==114){
        	 abbrevationSearchContent("leaveAbbreviationSearch.jsp");
         }
         else{}
         }
 
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
    		$('#frmleave input').attr('readonly', true);
    		$('#leavedate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly:", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmleave input').attr('readonly', false);
    		$('#abbreviation').attr('readonly', true);
    		$('#leavedate').jqxDateTimeInput({ disabled: false});
    		$('#docno').attr('readonly', true);
    		
    		if ($("#mode").val() == "A") {
    			 $('#leavedate').val(new Date());
    		   }
	    } catch(e) { console.error("Error in funRemoveReadOnly:", e); }
	}
 
    /* SAFE SET VALUES FUNCTION */
	function setValues() {
	    try {
    		if($('#datehidden').length && $('#datehidden').val()){
    			$("#leavedate").jqxDateTimeInput('val', $('#datehidden').val());
    		}
    
    		if($('#msg').length && $('#msg').val()!=""){
    			   $.messager.alert('Message',$('#msg').val());
    		}
    		
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                var detailVal = $('#formdetail').val() || "";
                var codeVal = $('#formdetailcode').val() || "";
                document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
	    } catch(e) { console.error("Error in setValues:", e); }
	}
	
 
	     function funNotify(){
	        	if(document.getElementById("leave").value=="") {
	        		document.getElementById("errormsg").innerText=" Enter Leave";
	        		document.getElementById("leave").focus();
	        		return 0;
        		}
	    		return 1;
		}
	     
	     function funFocus(){
	    	 $('#leavedate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmleave" action="saveLeave" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui">

        <div class="erp-form-area">
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="5%">Date</td>
                    <td width="10%">
                        <div id="leavedate" name="leavedate" value='<s:property value="leavedate"/>'></div>
                    </td>
                    <td class="lbl-right" width="5%">Leave</td>
                    <td width="30%">
                        <input type="text" name="leave" id="leave" placeholder="Leave" value='<s:property value="leave"/>'>
                    </td>
                    <td class="lbl-right" width="10%">Abbreviation</td>
                    <td width="15%">
                        <input type="text" name="abbreviation" id="abbreviation" placeholder="Press F3 to Search" onkeydown="getAbbrevation(event);" readonly="readonly" value='<s:property value="abbreviation"/>'>
                    </td>
                    <td class="lbl-right" width="10%">Doc No</td>
                    <td width="15%">
                        <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
                    </td>
                </tr>

                <tr>
                    <td class="lbl-right" style="padding-top: 10px;">Remarks</td>
                    <td colspan="7" style="padding-top: 10px;">
                        <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>'>
                    </td>
                </tr>
            </table>
        </div>

        <div class="grid-container">
            <div id="leavegrid"></div>
        </div>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

    </div>
</form>

<div id="abbrevationDetailsWindow"><div></div></div> 

</div>
</body>
</html>