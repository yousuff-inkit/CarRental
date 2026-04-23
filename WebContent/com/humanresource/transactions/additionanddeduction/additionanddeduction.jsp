<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include> 
<script type="text/javascript" src="../../../../js/ajaxfileupload.js"></script> 

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Cash Receipts)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
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
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

form label.error { color: red; font-weight: bold; font-size: 11px; }
#errormsg { color: red; font-weight: bold; font-size: 12px; margin-bottom: 10px; display: block; padding-left: 15px; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

input[type="file"] {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-size: 12px;
}
</style>

<script type="text/javascript">

 $(document).ready(function () {
     
      /* Formatted jqxDateTimeInput heights to match modern UI 24px */
      $("#masterdate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy"});   
      
      // force internal alignment AFTER render
      setTimeout(function () {
          $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#b8c6d8", "border-radius": "3px"});
          $(".jqx-datetimeinput").find("input").css({
              "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
              "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
          });
          $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
      }, 100);
      
      /* Searching Window */
      $('#empsearchwndow').jqxWindow({width: '60%', height: '59%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Employee Search',position: { x: 300, y: 80 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
      $('#empsearchwndow').jqxWindow('close'); 
      
      $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
      $('#accountDetailsWindow').jqxWindow('close');
      
      $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
      $('#costTypeSearchGridWindow').jqxWindow('close');
     
      $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
      $('#costCodeSearchWindow').jqxWindow('close');
      
  }); 
    
    function empSearchContent(url) {
         $.get(url).done(function (data) {
         $('#empsearchwndow').jqxWindow('open');
         $('#empsearchwndow').jqxWindow('setContent', data);
        }); 
    } 

    function accountSearchContent(url) {
        $('#accountDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
        $('#accountDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function costTypeSearchContent(url) {
        $('#costTypeSearchGridWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#costTypeSearchGridWindow').jqxWindow('setContent', data);
        $('#costTypeSearchGridWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function costCodeSearchContent(url) {
        $('#costCodeSearchWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#costCodeSearchWindow').jqxWindow('setContent', data);
        $('#costCodeSearchWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function funReset(){}
    
    function funReadOnly(){
         $('#frmalw input').prop('readonly', true );
         $('#frmalw select').prop('disabled', true );
         $('#masterdate').jqxDateTimeInput({ disabled: true});
         $("#descdetailsGrid").jqxGrid({ disabled: true});
    }
    
    function funRemoveReadOnly(){
         $('#frmalw input').prop('readonly', false );
         $('#frmalw select').prop('disabled', false );
         $('#masterdate').jqxDateTimeInput({ disabled: false});
         $('#docno').attr("readonly", true);
         $("#descdetailsGrid").jqxGrid({ disabled: false});
           
         if ($("#mode").val() == "A") {
               $('#masterdate').val(new Date());
               $("#descdetailsGrid").jqxGrid('clear');
               $("#descdetailsGrid").jqxGrid('addrow', null, {}); 
         }
           
         if ($("#mode").val() == "E") {
               $("#descdetailsGrid").jqxGrid('addrow', null, {});
         }
    }
        
    function funNotify(){
    
           if(document.getElementById("cmbyear").value=="") {
               document.getElementById("errormsg").innerText="Select Year";
               document.getElementById("cmbyear").focus();
               return 0;
           }
           
           if(document.getElementById("cmbmonth").value=="") {
               document.getElementById("errormsg").innerText="Select Month";
               document.getElementById("cmbmonth").focus();
               return 0;
           }
           
           /* Addition and Deduction Grid  Saving*/
              var rows = $("#descdetailsGrid").jqxGrid('getrows');
              var length=0;
              for(var i=0 ; i < rows.length ; i++){
                    var chk=rows[i].empdoc;
                    var errorstat=rows[i].errorstat;
                    if(errorstat==1) {
                        document.getElementById("errormsg").innerText="Please fill the Grid data";
                        return 0;
                    }
                    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                        var chks=rows[i].acno;
                        if(typeof(chks) == "undefined" || typeof(chks) == "NaN" || chks == "") {
                            document.getElementById("errormsg").innerText="Invalid Account for "+rows[i].empname;
                            return 0;
                        }
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "dil")
                        .attr("id", "test"+length)
                        .attr("name", "test"+length)
                        .attr("hidden", "true");
                        length=length+1;
                        
                    newTextBox.val(rows[i].empdoc+":: "+rows[i].addition+":: "+rows[i].deduction+":: "+rows[i].remarks+":: "+rows[i].atype+":: "+rows[i].acno+":: "+rows[i].costtype+":: "+rows[i].costcode);
                    newTextBox.appendTo('form');
                  }
               }
               $('#descdetailsGridlenght').val(length);
           /* Addition and Deduction Grid  Saving Ends*/
            
           document.getElementById("errormsg").innerText="";
           
        return 1;
    } 

    function funChkButton() {}

    function funSearchLoad(){
         changeContent('alwMainSearch.jsp'); 
    }
        
    function funFocus(){
        $('#masterdate').jqxDateTimeInput('focus'); 
    }
     
     function getYear() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var yearItems = items[0].split(",");
                    var yearIdItems = items[1].split(",");
                    var optionsyear = '<option value="">--Select--</option>';
                    for (var i = 0; i < yearItems.length; i++) {
                        optionsyear += '<option value="' + yearIdItems[i] + '">'
                                + yearItems[i] + '</option>';
                    }
                    $("select#cmbyear").html(optionsyear);
                    if ($('#hidcmbyear').val() != null) {
                        $('#cmbyear').val($('#hidcmbyear').val());
                    }
                } else {
                }
            }
            x.open("GET", "getYear.jsp", true);
            x.send();
        }
 
    function setValues() {
           
             if($('#hidmasterdate').val()!="") {
              $('#masterdate').val($('#hidmasterdate').val());
            }
          
            if($('#hidcmbyear').val()!="") {
                $('#cmbyear').val($('#hidcmbyear').val());
            } else {
                $('#cmbyear').val('');
            }
           
            if($('#hidcmbmonth').val()!="") {
                $('#cmbmonth').val($('#hidcmbmonth').val());
            } else {
               $('#cmbmonth').val('');
            }
            
            if($('#msg').val()!=""){
                $.messager.alert('Message',$('#msg').val());
            }

            document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
            funSetlabel();
            
             var docVal1 = document.getElementById("docno").value;
             if(docVal1>0) {
                  $("#desdet").load("empdetails.jsp?docno="+docVal1+"&id=1");
             }
    }
    
    function clearmsg() {   
        document.getElementById("errormsg").innerText="";
    }
    
function funPrintBtn() {
        if (($("#mode").val() == "view") && $("#docno").val()!="") {

             $("#docno").prop("disabled", false);
             $("#formdetailcode").prop("disabled", false);
            
            var docno=$('#docno').val();
            var dtype=$('#formdetailcode').val();
            var brhid=<%= session.getAttribute("BRANCHID").toString()%>
            var url=document.URL;
            var reurl=url.split("com/"); 
            
             var win= window.open(reurl[0]+"printAddDeduct?docno="+docno+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                  win.focus(); 
         }
        else {
            $.messager.alert('Message','Select a Document....!','warning');
            return;
        } 
}

function getAttachDocumentNo(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
        {
            var items=x.responseText.trim();
            
            if(items>0){
                
                var path=document.getElementById("fileexcelimport").value;
                var fsize = $('#fileexcelimport')[0].files[0].size;
                var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
                
                if((extn=='xls') || (extn=='csv')){ 
                        ajaxFileUpload(items);  
                 }else{
                         $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
                             style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                         }); 
                            return;
                 } 
            }
      }
    }
        
x.open("GET","getAttachDocumentNo.jsp",true);
x.send();
}

function excelimport()
{
     if(document.getElementById("cmbyear").value=="") {
               document.getElementById("errormsg").innerText="Select Year";
               document.getElementById("cmbyear").focus();
               return 0;
           }
           
           if(document.getElementById("cmbmonth").value=="") {
               document.getElementById("errormsg").innerText="Select Month";
               document.getElementById("cmbmonth").focus();
               return 0;
           }
    getAttachDocumentNo();
}

function ajaxFileUpload(docNo) {  
    
    if (window.File && window.FileReader && window.FileList && window.Blob)
    {
        var fsize = $('#fileexcelimport')[0].files[0].size;
        
        if(fsize>1048576) {
            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                 style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             }); 
            return;
        }
    }else{
         $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
                       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                   }); 
        return;
    }
    
     $.ajaxFileUpload  
     (  
         {  
             url:'fileAttachAction.action?formCode=ALW&doc_no='+docNo+'&descpt=Excel Import' ,
             secureuri:false,  
             fileElementId:'fileexcelimport',   
             dataType: 'json', 
             success: function (data, status)   
             {  
                if(status=='success'){
                    saveExcelDataData(docNo);
                    $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
                       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                   }); 
                 }
                
                 if(typeof(data.error) != 'undefined')  
                 {  
                     if(data.error != '')  
                     {  
                         $.messager.show({title:'Message',msg: data.error,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                     }else  
                     {  
                         $.messager.show({title:'Message',msg: data.message,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                          }); 
                     }  
                 }  
             },  
             error: function (data, status, e){  
                 $.messager.alert('Message',e);
             }  
         });  
     return false;  
 }

function saveExcelDataData(docNo){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
        {
            var items=x.responseText.trim();
            
            if(items==1){
                 var docVal1 = document.getElementById("docno").value;

                  $("#desdet").load("empdetails.jsp?docno="+docVal1+"&id=2");
                $.messager.alert('Message', ' Successfully Imported.', function(r){
            });
            }
            
      }
    }
        
x.open("GET","saveData.jsp?docNo="+docNo,true);
x.send();
}
</script>
</head>

<body onload="setValues();getYear();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmalw" action="saveAddDeduct" autocomplete="OFF">

    <jsp:include page="../../../../header.jsp"></jsp:include>
    <span id="errormsg"></span>

    <div class="modern-ui hidden-scrollbar">
        
        <div class="middle-panel">
            <span class="middle-panel-title">General Info</span>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 120px;">
                    <div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
                    <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>' />
                </div>
                
                <label class="lbl-right" style="width:80px;">Ref No</label>
                <input type="text" id="refno" name="refno" placeholder="Ref No" value='<s:property value="refno"/>' style="width:120px;" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' style="width:120px;" readonly />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Effect In</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Year</label>
                <select id="cmbyear" name="cmbyear" value='<s:property value="cmbyear"/>' onchange="clearmsg();" style="width:120px;">
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>' />
                
                <label class="lbl-right" style="width:80px;">Month</label>
                <select id="cmbmonth" name="cmbmonth" value='<s:property value="cmbmonth"/>' onchange="clearmsg();" style="width:120px;">
                    <option value="">--Select--</option>
                    <option value="1">January</option>
                    <option value="2">February</option>
                    <option value="3">March</option>
                    <option value="4">April</option>
                    <option value="5">May</option>
                    <option value="6">June</option>
                    <option value="7">July</option>
                    <option value="8">August</option>
                    <option value="9">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                </select>
                <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>' />
                
                <div style="display:flex; align-items:center; margin-left:20px; gap:10px;">
                    <input type="file" id="fileexcelimport" name="file" />
                    <button type="button" id="btnimport" class="myButton" onclick="excelimport();">Excel Import</button>
                </div>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Description</label>
                <input type="text" id="desc" name="desc" placeholder="Description" value='<s:property value="desc"/>' style="flex:1;" />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Employee Details</span>
            <div id="desdet" class="grid-container" style="border:none;">
                <jsp:include page="empdetails.jsp"></jsp:include>
            </div>
        </div>

        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        <input type="hidden" id="descdetailsGridlenght" name="descdetailsGridlenght" value='<s:property value="descdetailsGridlenght"/>' />

    </div></form>

<div id="empsearchwndow"><div></div></div>
<div id="accountDetailsWindow"><div></div></div>
<div id="costTypeSearchGridWindow"><div></div></div>
<div id="costCodeSearchWindow"><div></div></div>

</div></body>
</html>