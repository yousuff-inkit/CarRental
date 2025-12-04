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

    #frmdocument {
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
 
<%@page import="com.humanresource.setup.hrsetup.document.ClsDocumentDAO"%>
<% ClsDocumentDAO showDAO = new ClsDocumentDAO(); %>
   
<script type="text/javascript">
    $(document).ready(function () {     
        document.getElementById("formdet").innerText="Document(DOC)";
        document.getElementById("formdetail").value="Document";
        document.getElementById("formdetailcode").value="DOC";
        window.parent.formCode.value="DOC";
        window.parent.formName.value="Document";
        
        // UPDATED SIZE
        $("#documentdate").jqxDateTimeInput({ width: '100%', height: '38px' ,formatString : "dd.MM.yyyy" });
 
        var docdata='<%=showDAO.searchDocument()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no' , type: 'number' },
                        {name : 'document', type: 'String'  },
                            {name : 'date', type: 'date'  },
                            {name : 'remarks', type: 'String'  }
                 ],
                 localdata: docdata,
                
                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#documentgrid").jqxGrid(
                    {
                        width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
                                    { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
                                    { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
                                    { text: 'Document',columntype: 'textbox', filtertype: 'input', datafield: 'document', width: '38%' },
                                    { text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
                              ]
                    });
            
          $('#documentgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#documentgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("document").value = $("#documentgrid").jqxGrid('getcellvalue', rowindex1, "document");
                $("#documentdate").jqxDateTimeInput('val', $("#documentgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#documentgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
            });  
        });

    function funSearchLoad(){
         changeContent('documentsearch.jsp'); 
     }
 
    function funReadOnly() {
        $('#frmdocument input').attr('readonly', true);
        $('#documentdate').jqxDateTimeInput({ disabled: true});
        
        /* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
    }
    
    function funRemoveReadOnly() {
        $('#frmdocument input').attr('readonly', false);
        $('#documentdate').jqxDateTimeInput({ disabled: false});
        $('#docno').attr('readonly', true);
        
        if ($("#mode").val() == "A") {
             $('#documentdate').val(new Date());
           }
    }
 
    function setValues() {
        if($('#datehidden').val()){
            $("#documentdate").jqxDateTimeInput('val', $('#datehidden').val());
        }
         if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              }
         //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    }
 
         function funNotify(){
            if(document.getElementById("document").value=="") {
                document.getElementById("errormsg").innerText=" Enter Document";
                document.getElementById("document").focus();
                return 0;
            }
            return 1;
        } 
         
         function funFocus(){
             $('#documentdate').jqxDateTimeInput('focus');  
         }
      
</script>    
 
</head>
<body onLoad="setValues();" > 
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmdocument" action="saveDocument" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<div class="header-card-section">
    <h3>Document Details</h3>
    
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
                <div id="documentdate" name="documentdate" value='<s:property value="documentdate"/>'></div>
            </td>
            
            <td class="label-cell">Document</td>
            <td class="input-cell">
                <input type="text" name="document" id="document" style="width:100%;" placeholder="Document" value='<s:property value="document"/>'>
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
    <div id="documentgrid"></div>
</div>
</div>  

</body>
</html>