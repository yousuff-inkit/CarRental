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

    /* --- CUSTOM BLUE SCROLLBAR --- */
    ::-webkit-scrollbar { width: 10px; height: 10px; }
    ::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 5px; }
    ::-webkit-scrollbar-thumb { background: #3b82f6; border-radius: 5px; border: 2px solid #f1f1f1; }
    ::-webkit-scrollbar-thumb:hover { background: #2563eb; }
    * { scrollbar-width: thin; scrollbar-color: #3b82f6 #f1f1f1; }

    /* --- BACKGROUND WIDTH FIX --- */
    #mainBG, .homeContent {
        width: 100%;
        min-width: 1250px !important; 
        height: auto;
        min-height: 100vh;
        box-sizing: border-box;
        padding-bottom: 80px;
    }

    #frmpayrollcategory {
        width: 99%; /* Expanded to utilize more width */
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
        table-layout: auto; /* REMOVED FIXED LAYOUT TO ALLOW COLUMNS TO STRETCH */
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
        width: 1%; /* Allow label cell to shrink to fit text */
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
    
    /* Checkbox styling */
    input[type="checkbox"] {
        transform: scale(1.2);
        margin-right: 5px;
        vertical-align: middle;
    }
    
    form label.error {
        color: red;
        font-weight: bold;
    }
    
    fieldset { border: none; padding: 0; margin: 0; }
    legend { display: none; } 
</style>

<%@page import="com.humanresource.setup.hrsetup.payrollcategory.ClsPayrollcategoryDAO"%>
<% ClsPayrollcategoryDAO showDAO = new ClsPayrollcategoryDAO();%> 

<script type="text/javascript">
    $(document).ready(function () {     
        document.getElementById("formdet").innerText="Payroll Category(PCT)";
        document.getElementById("formdetail").value="Payroll Category";
        document.getElementById("formdetailcode").value="PCT";
        window.parent.formCode.value="PCT";
        window.parent.formName.value="Payroll Category";
        
        // UPDATED SIZE
        $("#parrolldate").jqxDateTimeInput({ width: '100%', height: '38px' ,formatString : "dd.MM.yyyy" });
 
        var catdata='<%=showDAO.searchcategory()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no' , type: 'number' },
                        {name : 'category', type: 'String'  },
                            {name : 'date', type: 'date'  },
                            {name : 'remarks', type: 'String'  },
                            {name : 'timesheet', type: 'Int'  },
                 ],
                 localdata: catdata,
                
                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#categorygrid").jqxGrid(
                    {
                        width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
                                    { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
                                    { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
                                    { text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '38%' },
                                    { text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
                                    { text: 'timesheet',filtertype: 'number', datafield: 'timesheet', width: '10%',hidden:true },
                              ]
                    });

            $('#categorygrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
 
                document.getElementById("docno").value= $('#categorygrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("category").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "category");
                $("#parrolldate").jqxDateTimeInput('val', $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                
                $('#timesheet').attr('disabled', false);
                
                var timesheet=$("#categorygrid").jqxGrid('getcellvalue', rowindex1, "timesheet");
                if(parseInt(timesheet)==1) {
                     document.getElementById("timesheet").checked = true;
                     document.getElementById("timesheet").value=1;
                    } else {
                     document.getElementById("timesheet").checked = false;
                     document.getElementById("timesheet").value=0;
                    }
                
                if ($("#mode").val() == "view") {
                    $('#timesheet').attr('disabled', true);
                }

                /// parrolldate category
            });  
        });

    function funSearchLoad(){
         changeContent('payrollcategorysearch.jsp'); 
     }
 
    function funReadOnly() {
        $('#frmpayrollcategory input').attr('readonly', true);
        $('#timesheet').attr('disabled', true);
        $('#parrolldate').jqxDateTimeInput({ disabled: true});
        
        /* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
    }
    
    function funRemoveReadOnly() {
        $('#frmpayrollcategory input').attr('readonly', false);
        $('#timesheet').attr('disabled', false);
        $('#parrolldate').jqxDateTimeInput({ disabled: false});
        $('#docno').attr('readonly', true);
        
        if ($("#mode").val() == "A") {
             $('#parrolldate').val(new Date());
        }
    }
 
    function setValues() {
        if($('#datehidden').val()){
            $("#parrolldate").jqxDateTimeInput('val', $('#datehidden').val());
        }
         if($('#msg').val()!=""){
              $.messager.alert('Message',$('#msg').val());
             }

         //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        var hidtimesheet=$('#hidtimesheet').val();
        if(parseInt(hidtimesheet)==1) {
            document.getElementById("timesheet").checked = true;
            document.getElementById("timesheet").value=1;
        } else {
            document.getElementById("timesheet").checked = false;
            document.getElementById("timesheet").value=0;
        }
    }
 
         function funNotify(){
            if(document.getElementById("category").value=="") {
                document.getElementById("errormsg").innerText=" Enter Category";
                document.getElementById("category").focus();
                return 0;
            }
            return 1;
        } 

         function funFocus(){
             $('#parrolldate').jqxDateTimeInput('focus');
         }
      
</script>    
 
</head>
<body onLoad="setValues();" >

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpayrollcategory" action="savePayrollcategory" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<div class="header-card-section">
    <h3>Payroll Category Details</h3>
    
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
                <div id="parrolldate" name="parrolldate" value='<s:property value="parrolldate"/>'> </div>
            </td>
            
            <td class="label-cell">Category</td>
            <td class="input-cell">
                <input type="text" name="category" id="category" style="width:100%;" placeholder="Category" value='<s:property value="category"/>'>
            </td>
            
            <td class="input-cell" style="vertical-align: middle; padding-left: 15px;">
                <input type="checkbox" id="timesheet"  name="timesheet" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" >&nbsp;Time Sheet 
            </td>
            
            <td class="label-cell">Doc No</td>
            <td class="input-cell">
                <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
            </td>
        </tr> 
        
        <tr>
            <td class="label-cell">Remarks</td>
            <td class="input-cell" colspan="6">
                <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' >
            </td>
        </tr>
    </table>
    
    <div id="errormsg"></div>
    
    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
    <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
    <input type="hidden" id="hidtimesheet" name="hidtimesheet" value='<s:property value="hidtimesheet"/>'/> 
    
</div> 
</form>
        
<div class="grid-card-section">
    <div id="categorygrid"></div>
</div>
</div>  

</body>
</html>