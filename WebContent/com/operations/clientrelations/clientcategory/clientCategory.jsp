<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<%@page import="com.operations.clientrelations.clientcategory.ClsClientCategoryDAO"%>
<% ClsClientCategoryDAO DAO= new ClsClientCategoryDAO(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT
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
        max-width: 1450px;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        /* Force everything inside mainBG to align left */
        text-align: left !important; 
    }

    /* ------------------------------
       HEADER FIXES (Align Title Left)
    ------------------------------ */
    /* This overrides the <center> tag coming from header.jsp */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }
    
    /* Target the Title ID (#formdet) specifically to make it look like a proper header */
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
       SECTION BLOCKS
    ------------------------------ */
    .section-block {
        background: #f6f8fa;
        border-radius: 12px;
        padding: 25px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        margin-bottom: 20px;
    }

    .section-block h2 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
    }

    /* ------------------------------
       GRID FORM SYSTEM
    ------------------------------ */
    .form-row {
        display: grid;
        grid-template-columns: auto 150px auto 200px auto 1fr; 
        gap: 15px;
        align-items: center;
        margin-bottom: 15px;
    }
    
    .form-row.secondary {
        grid-template-columns: auto 1fr auto 1fr; 
    }

    /* ------------------------------
       INPUTS & CONTROLS
    ------------------------------ */
    input[type="text"], select {
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

    input[type="text"]:focus, select:focus {
        border-color: #007bff;
        outline: none;
    }
    
    input[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        font-size: 14px;
    }

    /* ------------------------------
       CHECKBOX & UTILS
    ------------------------------ */
    .checkbox-group {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 600;
        color: #253858;
        font-size: 14px;
        background: #fff;
        padding: 5px 10px;
        border-radius: 6px;
        border: 1px solid #d1d5db;
        width: fit-content;
    }

    .hidden-scrollbar { overflow: auto; height: 530px; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }
    
    #jqxCategorySearch1 {
        border-radius: 8px;
        border: 1px solid #d1d5db;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
</style>

<script type="text/javascript">

    /* Grid */
     var data= '<%= DAO.category() %>'; 
     $(document).ready(function () {
         getAccountGroup();
         getconfig();
         var source =
         {
             datatype: "json",
             datafields: [
                        {name : 'doc_no', type: 'int'  },
                        {name : 'dtypes', type: 'String'  },
                        {name : 'category', type: 'String'  },
                        {name : 'cat_name', type: 'String'  },
                        {name : 'description', type: 'String'  },
                        { name: 'approved', type: 'bool' },
                        {name : 'dtype', type: 'String'  },
                        { name: 'approval', type: 'int' },
                        {name : 'acc_group', type: 'String'  }
              ],
            localdata: data, 
             
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
        
         $("#jqxCategorySearch1").jqxGrid(
                 {
                     width: '100%', 
                     height: 375,
                     source: dataAdapter,
                     showfilterrow: true,
                     filterable: true,
                     selectionmode: 'singlerow',
                     theme: 'energyblue', 
                     
                     columns: [
                              { text: 'Type',columntype: 'textbox', filtertype: 'input', datafield: 'dtypes', width: '8%' },
                              { text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '20%' },
                              { text: 'Category Name',columntype: 'textbox', filtertype: 'input', datafield: 'cat_name', width: '34%' },
                              { text: 'Account Group',columntype: 'textbox', filtertype: 'input', datafield: 'description' },
                              { text: 'Approval', datafield: 'approved', columntype: 'checkbox', filterable: false, checked: true, width: '8%',cellsalign: 'center', align: 'center' },
                              { text: 'Doc No', datafield: 'doc_no', hidden: true, filterable: false, width: '10%' },
                              { text: 'Dtype', datafield: 'dtype', hidden: true, filterable: false, width: '10%' },
                              { text: 'Approval', datafield: 'approval', hidden: true, filterable: false, width: '10%' },
                              { text: 'Account Group', filterable: false, datafield: 'acc_group', hidden: true, width: '10%' },
                        
                   ]
                 });
        
        
         
            
         $('#jqxCategorySearch1').on('rowdoubleclick', function (event) {
             var rowindex1=event.args.rowindex;
             getAccountGroup($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "dtype"));
             document.getElementById("docno").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "doc_no");
             document.getElementById("cmbtype").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "dtype");
             document.getElementById("txtcategory").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "category");
             document.getElementById("txtcategoryname").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "cat_name");
             document.getElementById("cmbaccountgroup").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "acc_group");
             document.getElementById("hidcmbaccountgroup").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "acc_group");
             document.getElementById("hidchckapproval").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval");
             
             if($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval")==1){
                 document.getElementById("chckapproval").checked = true;
             }
             else if($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval")==0){
                document.getElementById("chckapproval").checked = false;
             }
         }); 
    });
 
    /* Validations */
      $(function(){
         $('#frmClientCategory').validate({
                 rules: {
                 cmbtype:"required",    
                 txtcategory:"required",
                 txtcategoryname:"required",
                 cmbaccountgroup:"required"
                 },
                 messages: {
                 cmbtype:" *",
                 txtcategory:" *",
                 txtcategoryname:" *",
                 cmbaccountgroup:" *"
                 }
          });}); 
    
       function getconfig() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    items = x.responseText;
                    items = items.split('####');
                    //alert(items[0])
                    if (items[0]==1) 
                    {
                        $('#chckapproval').hide();
                        $('#appr').hide();
                        $('.checkbox-group').hide(); 
                        $('#config').val(1);
                    $('#jqxCategorySearch1').jqxGrid('hidecolumn','approved');
                            
                      }

                } 
                else {
                    $('#chckapproval').show();
                    $('#appr').show();
                    $('.checkbox-group').show();
                    $('#config').val(0);
                $('#jqxCategorySearch1').jqxGrid('showcolumn','approved');
                }
            }
            x.open("GET", "getconfig.jsp", true);
            x.send();
        }       

 
    
       function getAccountGroup(type) {
             var x = new XMLHttpRequest();
             x.onreadystatechange = function() {
                 if (x.readyState == 4 && x.status == 200) {
                     var items = x.responseText;
                     items = items.split('####');
                     var groupItems = items[0].split(",");
                     var groupIdItems = items[1].split(",");
                     var optionsgroup = '<option value="">--Select--</option>';
                     for (var i = 0; i < groupItems.length; i++) {
                         optionsgroup += '<option value="' + groupIdItems[i] + '">'
                                 + groupItems[i] + '</option>';
                     }
                     $("select#cmbaccountgroup").html(optionsgroup);
                     if ($('#hidcmbaccountgroup').val() != null) {
                         $('#cmbaccountgroup').val($('#hidcmbaccountgroup').val());
                     }
                 } else {
                 }
             }
             x.open("GET", "getAccountGroup.jsp?type="+type, true);
             x.send();
         } 
    
       function approval(){
          if(document.getElementById("chckapproval").checked){
              document.getElementById("hidchckapproval").value = 1;
          }
          else{
              document.getElementById("hidchckapproval").value = 0;
          }
      }
    
    function funReadOnly() {
        getconfig();
        $('#frmClientCategory input').attr('readonly', true);
        $('#frmClientCategory select').attr('disabled', true);
        $('#chckapproval').attr('disabled', true);
    }
    
    function funRemoveReadOnly() {
        getconfig();
        $('#frmClientCategory input').attr('readonly', false);
        $('#frmClientCategory select').attr('disabled', false);
        $('#chckapproval').attr('disabled', false);
        
        if ($("#mode").val() == "A") {
        
             $('#hidchckapproval').val(0);
             document.getElementById("chckapproval").checked = false;
        }
        
    }
    
    function funNotify(){   
       return 1;
    } 
    
    function funChkButton() {
        /* funReset(); */
    }
    
    function funSearchLoad(){
       changeContent('categoryMainSearchGrid.jsp?check=1');  
    }
    
    function funFocus()
     {
        document.getElementById("cmbtype").focus();
     }
    
    function setValues(){
        
        document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
        
         if(document.getElementById("hidchckapproval").value==1){
             document.getElementById("chckapproval").checked = true;
         }
         else if(document.getElementById("hidchckapproval").value==0){
            document.getElementById("chckapproval").checked = false;
         }
        
        if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              }
          
         document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
         funSetlabel();
    }
    
</script>
            
</head>
<body onload="setValues(); getconfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientCategory" action="saveClientCategory" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='hidden-scrollbar'>
        
        <div class="section-block">
            <h2>Category Master</h2>
            
            <div class="form-row">
                <label for="cmbtype">Type</label>
                <div>
                    <select id="cmbtype" name="cmbtype" onchange="getAccountGroup($('#cmbtype').val());" value='<s:property value="cmbtype"/>'>
                        <option value="">--Select--</option>
                        <option value="CRM">CLIENT</option>
                        <option value="VND">VENDOR</option>
                    </select>
                    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                </div>

                <label for="txtcategory">Category</label>
                <input type="text" id="txtcategory" name="txtcategory" value='<s:property value="txtcategory"/>'>

                <label for="txtcategoryname">Category Name</label>
                <input type="text" id="txtcategoryname" name="txtcategoryname" value='<s:property value="txtcategoryname"/>'>
            </div>

            <div class="form-row secondary" style="grid-template-columns: auto 1fr auto 1fr;">
                <label for="cmbaccountgroup">Account Group</label>
                <div>
                    <select id="cmbaccountgroup" name="cmbaccountgroup" value='<s:property value="cmbaccountgroup"/>'>
                        <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbaccountgroup" name="hidcmbaccountgroup" value='<s:property value="hidcmbaccountgroup"/>'/>
                </div>

                <div class="checkbox-group">
                    <input type="checkbox" id="chckapproval" name="chckapproval" value="" onchange="approval();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                    <label id="appr" for="chckapproval" style="text-align: left;">Approval</label>     
                    <input type="hidden" id="hidchckapproval" name="hidchckapproval" value='<s:property value="hidchckapproval"/>'/>
                    <input type="hidden" id="config" name="config"/> 
                </div>
                <div></div>
            </div>
        </div>

        <div id="jqxCategorySearch1"></div>

        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="docno" name="hidtxtclientcategorydocno" value='<s:property value="hidtxtclientcategorydocno"/>'/>

    </div>

</form>
</div>
</body>
</html>