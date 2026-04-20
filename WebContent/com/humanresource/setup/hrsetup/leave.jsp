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
   1. 100% SCOPED CSS - GUARANTEED NOT TO BREAK HEADER
========================================================= */

/* Validation Errors */
form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

/* Wrapper to isolate our form layout from the header */
#leave-form-container {
    padding-top: 15px;
    width: 100%;
}

/* Scoped Fieldsets (Replaces the .middle-panel logic cleanly) */
#leave-form-container .master-fieldset {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 20px 15px 15px 15px;
    margin-bottom: 25px;
    background-color: transparent; 
}

/* The Blue Left-Border Title */
#leave-form-container .master-legend {
    font-size: 15px;
    font-weight: 600;
    color: #0056b3;
    padding: 0 10px;
    border-left: 4px solid #0056b3;
    width: auto;
    margin-bottom: 0;
    border-bottom: none;
    line-height: 1.2;
}

/* Flexbox rows */
#leave-form-container .master-row {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    gap: 15px;
}

/* Right aligned labels */
#leave-form-container .master-label {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    text-align: right;
    min-width: 80px;
    white-space: nowrap;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Strict custom class for inputs so it NEVER affects the header */
#leave-form-container .master-input {
    height: 26px !important;
    border: 1px solid #cbd5e0;
    border-radius: 4px;
    padding: 2px 8px;
    font-size: 13px;
    box-sizing: border-box;
    color: #333;
    background-color: #fff;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

#leave-form-container .master-input:focus {
    border-color: #3b82f6;
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

#leave-form-container .master-input[readonly],
#leave-form-container .master-input:disabled {
    background-color: #f8f9fa;
    color: #6b7280;
}

/* Search Icon Wrapper */
#leave-form-container .search-wrapper {
    position: relative;
    display: flex;
    flex: 1;
}
#leave-form-container .search-wrapper input {
    padding-right: 28px !important;
}
#leave-form-container .search-wrapper svg {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
#leave-form-container .search-wrapper svg:hover { color: #007bff; }

/* Grid Container */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-top: 10px;
}
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
		
        /* FIXED DATE WIDTHS & HEIGHTS (26px) */ 
	    $("#leavedate").jqxDateTimeInput({ width: '120px', height: '26px' ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
 
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $("#leavedate").find("input").css({
                "margin-top": "0px", 
                "line-height": "26px", 
                "font-size": "13px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 8px", 
                "box-sizing":"border-box"
            });
            $("#leavedate").find(".jqx-action-button").css({"top": "0px", "height": "26px"});
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
    		$('#frmleave .master-input').attr('readonly', true);
    		$('#leavedate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly:", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmleave .master-input').attr('readonly', false);
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

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmleave" action="saveLeave" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div id="leave-form-container">

        <fieldset class="master-fieldset" style="max-width: 1000px; margin-top: 15px;">
            <legend class="master-legend">Leave Details</legend>
            
            <div class="master-row">
                <label class="master-label" style="width: 50px;">Date</label>
                <div style="width: 120px; flex: none;">
                    <div id="leavedate" name="leavedate" value='<s:property value="leavedate"/>'></div>
                </div>
                
                <label class="master-label" style="width: 60px; margin-left: 20px;">Leave</label>
                <input type="text" class="master-input" name="leave" id="leave" placeholder="Leave" value='<s:property value="leave"/>' style="flex: 2;">
                
                <label class="master-label" style="width: 80px; margin-left: 20px;">Abbreviation</label>
                <div class="search-wrapper" style="flex: 1; max-width: 180px;">
                    <input type="text" class="master-input" name="abbreviation" id="abbreviation" placeholder="Press F3 to Search" onkeydown="getAbbrevation(event);" readonly="readonly" value='<s:property value="abbreviation"/>'>
                    <svg onclick="abbrevationSearchContent('leaveAbbreviationSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="master-label" style="width: 60px; margin-left: auto;">Doc No</label>
                <input type="text" class="master-input" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1" style="width: 100px; flex: none;">
            </div>

            <div class="master-row" style="margin-bottom: 0;">
                <label class="master-label" style="width: 50px;">Remarks</label>
                <input type="text" class="master-input" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' style="flex: 1;">
            </div>
        </fieldset>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

        <fieldset class="master-fieldset" style="padding-bottom: 0; overflow: hidden;">
            <legend class="master-legend">Leave List</legend>
            <div class="grid-container">
                <div id="leavegrid" style="width: 100%;"></div>
            </div>
        </fieldset>

    </div>
</form>

<div id="abbrevationDetailsWindow"><div></div></div> 

</div>
</body>
</html>