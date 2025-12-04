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
        min-width: 1250px !important; 
        height: auto;
        min-height: 100vh;
        box-sizing: border-box;
        padding-bottom: 80px;
    }

    #frmagent {
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
        font-size: 15px; /* FIXED AT 15PX */
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
    input[type="text"], .jqxDateTimeInput {
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

<%@page import="com.humanresource.setup.hrsetup.agent.ClsAgentDAO"%>
<% ClsAgentDAO showDAO = new ClsAgentDAO(); %>   

<script type="text/javascript">

    $(document).ready(function () {     
        document.getElementById("formdet").innerText="Agent(AGT)";
        document.getElementById("formdetail").value="Agent";
        document.getElementById("formdetailcode").value="AGT";
        window.parent.formCode.value="AGT";
        window.parent.formName.value="Agent";
        
        // UPDATED SIZE
        $("#agentdate").jqxDateTimeInput({ width: '100%', height: '38px' ,formatString : "dd.MM.yyyy" });
        
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
                     // callback called when a page or page size is changed.
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
 
    function funReadOnly() {
        $('#frmagent input').attr('readonly', true);
        $('#agentdate').jqxDateTimeInput({ disabled: true});
        
        /* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
    }
    function funRemoveReadOnly() {
        $('#frmagent input').attr('readonly', false);
        $('#agentdate').jqxDateTimeInput({ disabled: false});
        $('#docno').attr('readonly', true);
        
        if ($("#mode").val() == "A") {
             $('#agentdate').val(new Date());
           }
    }
 
    function setValues() {
        if($('#datehidden').val()){
            $("#agentdate").jqxDateTimeInput('val', $('#datehidden').val());
        }
         if($('#msg').val()!=""){
              $.messager.alert('Message',$('#msg').val());
             }
         //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        
    }
    
 
         function funNotify(){
                if(document.getElementById("agent").value=="")
            {
            document.getElementById("errormsg").innerText=" Enter Agent    ";
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
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmagent" action="saveAgent" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<div class="header-card-section">
    <h3>Agent Details</h3>
    
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
                <div id="agentdate" name="agentdate" value='<s:property value="agentdate"/>'> </div>
            </td>
            
            <td class="label-cell">Agent</td>
            <td class="input-cell">
                <input type="text" name="agent" id="agent" style="width:100%;" placeholder="Agent" value='<s:property value="agent"/>'>
            </td>
            
            <td class="label-cell">Doc No</td>
            <td class="input-cell">
                <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
            </td>
            
            <td></td>
        </tr> 
        
        <tr>
            <td class="label-cell">Remarks</td>
            <td class="input-cell" colspan="4">
                <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' >
            </td>
            <td></td>
        </tr>
    </table> 
    
    <div id="errormsg"></div>
    
    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
    <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
    
</div> 
</form>

<div class="grid-card-section">
    <div id="agentgrid"></div>
</div>
</div>

</body>
</html>