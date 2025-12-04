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
        min-width: 1250px !important; 
        height: auto;
        min-height: 100vh;
        box-sizing: border-box;
        padding-bottom: 80px;
    }

    #frmallowance {
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

<%@page import="com.humanresource.setup.hrsetup.allowances.ClsAllowancesDAO"%>
<% ClsAllowancesDAO showDAO = new ClsAllowancesDAO(); %>  

<script type="text/javascript">
    $(document).ready(function () {     
        document.getElementById("formdet").innerText="Allowance(ALC)";
        document.getElementById("formdetail").value="Allowance";
        document.getElementById("formdetailcode").value="ALC";
        window.parent.formCode.value="ALC";
        window.parent.formName.value="Allowance";
        
        // UPDATED SIZE
        $("#allowancedate").jqxDateTimeInput({ width: '100%', height: '38px' ,formatString : "dd.MM.yyyy" });
        
        $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#accountSearchwindow').jqxWindow('close');
        
        $('#acno').dblclick(function(){
            if($('#mode').val()!= "view") {
                 $('#accountSearchwindow').jqxWindow('open');
                 accountSearchContent('accountsDetailsSearch.jsp');
             }
         });    
        
            var alcdata='<%=showDAO.searchAllowance()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no' , type: 'number' },
                            {name : 'code', type: 'String'  },
                        {name : 'allowance', type: 'String'  },
                            {name : 'date', type: 'date'  },
                            {name : 'acno', type: 'String'  },
                            {name : 'accname', type: 'String'  },
                            {name : 'remarks', type: 'String'  },
                            {name : 'accdocno', type: 'String'  },
                            
                 ],
                   localdata: alcdata,

                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
                $("#allowancegrid").jqxGrid(
                    {
                        width: '100%',
                        height: 375,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
                        editable: false,
                        columnsresize: true,
                        showfilterrow: true,
                        filterable: true,
                        
                        columns: [
                                    { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
                                    { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
                                    { text: 'Allowance Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '8%' },
                                    { text: 'Allowance Name',columntype: 'textbox', filtertype: 'input', datafield: 'allowance', width: '15%' },
                                    { text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
                                    { text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '25%' },
                                    { text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '28%' },
                                    { text: 'Account Doc No',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
                            ]
                    });
                
             $('#allowancegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#allowancegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("allowancecode").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("allowance").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "allowance");
                $("#allowancedate").jqxDateTimeInput('val', $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("acno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("accname").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accname");
                document.getElementById("accdocno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
            });    
        });

    function funSearchLoad(){
         changeContent('allowancessearch.jsp'); 
     }
 
     function accountSearchContent(url) {
          $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('setContent', data);
          }); 
        }
       
    function funReadOnly() {
        $('#frmallowance input').attr('readonly', true);
        $('#allowancedate').jqxDateTimeInput({ disabled: true});
    }
    
    function funRemoveReadOnly() {
        $('#frmallowance input').attr('readonly', false);
        $('#docno').attr('readonly', true);
        $('#acno').attr('readonly', true);
        $('#accname').attr('readonly', true);
        $('#allowancedate').jqxDateTimeInput({ disabled: false});
        
        if ($("#mode").val() == "A") {
             $('#allowancedate').val(new Date());
        }
    }
 
    function setValues() {
        if($('#datehidden').val()){
            $("#allowancedate").jqxDateTimeInput('val', $('#datehidden').val());
        }
        
        if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
        }
        
         //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    }
    
    function getaccountdetails(event){
         var x= event.keyCode;
        
        if($('#mode').val()!="view") {
         if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsSearch.jsp');   
         }
         else{}
            }
         }
 
         function funNotify(){
            if(document.getElementById("allowance").value=="")
            {
            document.getElementById("errormsg").innerText=" Enter Allowance";
            document.getElementById("allowance").focus();
            return 0;
            }
            
            
            if(document.getElementById("acno").value=="")
            {
            document.getElementById("errormsg").innerText=" Search Account";
            document.getElementById("acno").focus();
            return 0;
            }
            return 1;
        } 
         
         function funFocus(){
                $('#allowancedate').jqxDateTimeInput('focus');
         }
      
</script>    
 
</head>
<body onLoad="setValues();" > 

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmallowance" action="saveAllowance" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<div class="header-card-section">
    <h3>Allowance Details</h3>
    
    <table class="header-table">
        <colgroup>
            <col style="width: 10%;"> <col style="width: 15%;"> 
            <col style="width: 10%;"> <col style="width: 15%;"> 
            <col style="width: 10%;"> <col style="width: 25%;"> 
            <col style="width: 10%;"> <col style="width: 5%;"> 
        </colgroup>
        
        <tr>
            <td class="label-cell">Date</td>  
            <td class="input-cell">
                <div id="allowancedate" name="allowancedate" value='<s:property value="allowancedate"/>'> </div>
            </td>
            
            <td class="label-cell">Code</td>
            <td class="input-cell">
                <input type="text" name="allowancecode" id="allowancecode" placeholder="Allowance Code" value='<s:property value="allowancecode"/>'>
            </td>
            
            <td class="label-cell">Name</td>
            <td class="input-cell">
                <input type="text" name="allowance" id="allowance" placeholder="Allowance Name" value='<s:property value="allowance"/>'>
            </td>
            
            <td class="label-cell">Doc No</td>
            <td class="input-cell">
                <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
            </td>
        </tr> 
        
        <tr>
            <td class="label-cell">Account</td> 
            <td class="input-cell" style="position: relative;">
                <input type="text" name="acno" id="acno" readonly  placeholder="Press F3" onKeyDown="getaccountdetails(event);"  value='<s:property value="acno"/>' > 
            </td>
            <td colspan="3" class="input-cell">
                <input type="text" name="accname" id="accname" readonly value='<s:property value="accname"/>' >
            </td>
            <td colspan="3"></td>
        </tr>
        
        <tr>
            <td class="label-cell">Remarks</td>
            <td class="input-cell" colspan="7">
                <input type="text" name="remarks" id="remarks"  placeholder="Remarks" value='<s:property value="remarks"/>' >
            </td>
        </tr>
    </table>
    
    <div id="errormsg"></div>
    
    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
    <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
    <input type="hidden" name="accdocno" id="accdocno"        value='<s:property value="accdocno"/>' >
    
</div> 
</form>

<div class="grid-card-section">
    <div id="allowancegrid"></div>
</div>

<div id="accountSearchwindow">
    <div ></div>
</div>  
    
</div>  

</body>
</html>