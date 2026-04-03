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
/* ------------------------------
       GLOBAL STYLES & LAYOUT (From Master)
    ------------------------------ */
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
        padding: 20px;
        max-width: 100%;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important;
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons) (From Master)
    ------------------------------ */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }

    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

    /* ------------------------------
       GRID SYSTEM (FORM LAYOUT) (From Master)
    ------------------------------ */
    .receipt-header {
        display: block; /* Content container for the whole form body */
        padding: 0 0 0 5px;
    }

    .form-group {
        display: grid;
        grid-template-columns: 120px 1fr;
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }

    .form-group.dual-input {
        grid-template-columns: 120px 1fr 120px 1fr;
    }

    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }

    .section-block {
        flex: 1;
        background: #f6f8fa; /* Uniform background color */
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        min-width: 45%;
    }

    .full-width-block {
        flex: 1 1 100%;
    }


       
  .section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff; /* Blue line accent */
}
    
    .section-block legend {
        /* Ensure legend specific properties are maintained/cleaned up */
        border: none; /* Remove default legend border */
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px; 
        padding-left: 10px;
        border-left: 4px solid #007bff; /* Blue vertical line */
        color: #333;
        display: block;
        border: none;
    }

    /* ------------------------------
       INPUTS & CONTROLS (From Master)
    ------------------------------ */
    input[type="text"], input[type="email"], select, textarea {
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

    input[type="text"]:focus, input[type="email"]:focus, select:focus, textarea:focus {
        border-color: #007bff;
        outline: none;
    }

    input[readonly], textarea[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 16px;
    }
    
    form label.error {
        color:red;
        font-weight:bold;
    }

    /* ------------------------------
       TABLES & UTILS (From Master)
    ------------------------------ */
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
    }
    .myButton:hover { background: #0056b3; }

    /* SCROLLBAR FIX */
    .hidden-scrollbar { overflow: auto; height: 530px; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }
    
    
    
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
</style>

<%@page import="com.humanresource.setup.hrsetup.agent.ClsAgentDAO"%>
<% ClsAgentDAO showDAO = new ClsAgentDAO(); %>   

<script type="text/javascript">

	$(document).ready(function () {   
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Agent(AGT)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Agent";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="AGT";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="AGT";
		if(window.parent && window.parent.formName) window.parent.formName.value="Agent";
	   
        /* FIXED DATE WIDTHS & HEIGHTS (Changed from 100% to 120px to make it smaller) */
		$("#agentdate").jqxDateTimeInput({ width: '120px', height: '24px' ,formatString : "dd.MM.yyyy" });
	   
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

	    	var agentdata='<%=showDAO.searchAgent()%>';
 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'agent', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  }
                 ],
               	 localdata: agentdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#agentgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',

                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Agent',columntype: 'textbox', filtertype: 'input', datafield: 'agent', width: '38%' },
        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });

            $('#agentgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#agentgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("agent").value = $("#agentgrid").jqxGrid('getcellvalue', rowindex1, "agent");
                $("#agentdate").jqxDateTimeInput('val', $("#agentgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#agentgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
              
            });   
        });

	function funSearchLoad(){
		 changeContent('agentsearch.jsp'); 
	 }
 
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
    		$('#frmagent input').attr('readonly', true);
    		$('#agentdate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmagent input').attr('readonly', false);
    		$('#agentdate').jqxDateTimeInput({ disabled: false});
    		$('#docno').attr('readonly', true);
    		
    		if ($("#mode").val() == "A") {
    			 $('#agentdate').val(new Date());
    		   }
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
 
    /* SAFE SET VALUES FUNCTION */
	function setValues() {
	    try {
    		if($('#datehidden').length && $('#datehidden').val()){
    			$("#agentdate").jqxDateTimeInput('val', $('#datehidden').val());
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
	          	if(document.getElementById("agent").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Enter Agent	";
        		document.getElementById("agent").focus();
        		return 0;
        		}
	        	
	    		return 1;
		} 
	     function funFocus(){
	    	 $('#agentdate').jqxDateTimeInput('focus');
	     }
	  
</script>  
 
</head>
<body onLoad="setValues();" >

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmagent" action="saveAgent" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class="modern-ui">

    <div class="erp-form-area">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Date</td>
                <td width="25%">
                    <div id="agentdate" name="agentdate" value='<s:property value="agentdate"/>'></div>
                </td>
                <td class="lbl-right" width="10%">Doc No</td>
                <td width="55%">
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1" style="width: 150px;">
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Agent Name</td>
                <td colspan="3">
                    <input type="text" name="agent" id="agent" placeholder="Agent" value='<s:property value="agent"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 10px;">Remarks</td>
                <td colspan="3" style="padding-top: 10px;">
                    <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' >
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="agentgrid"></div>
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

</div>
</body>
</html>