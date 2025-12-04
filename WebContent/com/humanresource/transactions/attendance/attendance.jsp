<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
    /* --- GLOBAL LAYOUT --- */
    html { overflow-y: scroll; }
    body {
        background-color: #f0f4f8;
        font-family: 'Segoe UI', 'Roboto', Helvetica, Arial, sans-serif;
        margin: 0; padding: 0;
        color: #334155;
    }

    #mainBG, .homeContent {
        width: 100%;
        min-width: 1350px !important; 
        height: auto;
        min-height: 100vh;
        padding-bottom: 80px;
    }

    /* --- LEFT PANEL: BLUE CARD --- */
    /* Applied to the div that was originally pink */
    .header-card-section {
        background: linear-gradient(to bottom right, #dbeafe, #eff6ff); 
        border-radius: 16px;
        padding: 15px;
        box-shadow: 0 4px 15px rgba(59, 130, 246, 0.15);
        border: 1px solid #bfdbfe;
    }

    /* --- RIGHT PANEL: GRID CARD --- */
    .grid-card-section {
        background: #ffffff;
        border-radius: 16px;
        padding: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        border: 1px solid #e2e8f0;
        height: 100%;
        min-height: 500px;
    }

    /* --- TABLE LABEL & INPUT ALIGNMENT --- */
    .header-card-section table td[align="right"] {
        text-align: right;
        color: #1e3a8a;
        font-weight: 700;
        font-size: 15px; /* 15px Font */
        white-space: nowrap;
        vertical-align: middle;
        padding-right: 10px;
        padding-bottom: 8px;
    }
    
    .header-card-section table td {
        vertical-align: middle;
        padding-bottom: 8px;
    }

    /* --- PILL INPUTS --- */
    .header-card-section input[type="text"],
    .header-card-section select,
    .header-card-section .jqxDateTimeInput {
        background-color: #ffffff !important;
        border: 1px solid #94a3b8 !important;
        border-radius: 8px !important; 
        height: 34px !important;
        padding: 0 10px !important;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05) !important;
        color: #334155;
        font-size: 13px;
        width: 100% !important;
        box-sizing: border-box; 
    }

    .header-card-section input[type="text"]:focus,
    .header-card-section select:focus {
        border-color: #2563eb !important;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2) !important;
        outline: none;
    }

    /* --- BUTTONS --- */
    .myButtonses, .myButtons, .myButtonReCheck, .icon {
        border-radius: 6px;
        border: none;
        cursor: pointer;
        padding: 6px 15px;
        font-weight: 600;
        transition: transform 0.2s;
    }
    .myButtonses { background-color: #3b82f6; color: white; } /* View/Apply */
    .myButtons { background-color: #64748b; color: white; } /* Clear */
    .myButtonReCheck { background-color: #f59e0b; color: white; width: 100%;} /* Recheck */
    
    .myButtonses:hover, .myButtons:hover, .myButtonReCheck:hover {
        transform: translateY(-1px);
        opacity: 0.9;
    }

    /* JQX Fix */
    .jqx-widget-content { border-radius: 8px !important; border-color: #94a3b8 !important; }
    
    #errormsg { color: red; font-weight: bold; text-align: center;}
</style>

<script type="text/javascript">
      $(document).ready(function () {

          $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );
          $('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );

          /* Time */
          $("#overtime").jqxDateTimeInput({ width: '100%', height: '34px', formatString:'HH:mm', showCalendarButton: false});

          /* Searching Window */
         $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#employeeDetailsWindow').jqxWindow('close');

         $('#txtemployeeid').dblclick(function(){
            employeeSearchContent("employeeDetailsSearch.jsp");
          });

         $('#btnApply').attr('disabled', true);
         $('#btnApplyDelete').attr('disabled', true);
         document.getElementById("rdholiday").checked=true;
         document.getElementById("chckhalfday").checked=false;
         document.getElementById("hidchckhalfday").value = 0;
         document.getElementById("chckmarkall").checked=false;
         document.getElementById("hidchckmarkall").value = 0;
         $('#overtime').jqxDateTimeInput({disabled: true});
         $("#attendanceGridID").jqxGrid('clear');
         $("#attendanceGridID").jqxGrid('addrow', null, {});
         $("#attendanceGridID").jqxGrid({ disabled: true});radioClick();
         $('#txtemployeeid').attr('readonly', true);
         $('#txtemployeename').attr('readonly', true);
         $('#txtmarkedattendance').val('0');

          getDepartment();getPayrollCategory();getYear();getDay();getLeaveType();getHoliday();getAttendanceLeaveEditEnable();
      });




      function upload(){
        //$('#txtexcelvalidation').val(1);
        var year=$('#cmbyear').val();

        var month=$('#cmbmonth').val();

        if($('#cmbyear').val()==''){
         document.getElementById("errormsg").innerText="Year is Mandatory.";
             return 0;
         }

    if($('#cmbmonth').val()==''){
         document.getElementById("errormsg").innerText="Month is Mandatory.";
             return 0;
         }
        getAttachDocumentNo();

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
                  url:'fileAttachAction.action?formCode=ATTN&doc_no='+docNo+'&descpt=Excel Import' ,
                  secureuri:false,
                  fileElementId:'fileexcelimport',
                  dataType: 'json',
                  success: function (data, status)
                  {
                      //alert("status--"+status)
                      if(status=='success'){
                        // alert("test"+docNo)
                           saveExcelDataData(docNo);
                           $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
                             style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}


                         });
                           $("#overlay, #PleaseWait").show();
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
        //alert("ehjk"+docNo)
        var x = document.getElementById("cmbday").length;
        var totdays=(x-1);
        var employeebranchchk=window.parent.employeebranchchk.value;
        var branch=document.getElementById("brchName").value;
        var year=$('#cmbyear').val();
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                var items=x.responseText.trim();

                if(items==1){
                    $("#attendanceDiv").load("attendanceGridMARBLELIFE.jsp?totdays="+totdays+"&year="+$('#cmbyear').val()+"&month="+$('#cmbmonth').val()+"&day="+$('#cmbday').val()+"&department="+$('#cmbempdepartment').val()+"&category="+$('#cmbempcategory').val()+"&empid="+$('#txtemployeedocno').val()+"&check=1"+'&branchid='+branch+'&employeebranchchk='+employeebranchchk);

                  $.messager.alert('Message', ' Successfully Imported.', function(r){

                });

            }

          }
        }

    x.open("GET","savedataexcel.jsp?docNo="+docNo+"&year="+$('#cmbyear').val()+"&month="+$('#cmbmonth').val(),true);
    x.send();
    }



      function employeeSearchContent(url) {
            $('#employeeDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#employeeDetailsWindow').jqxWindow('setContent', data);
            $('#employeeDetailsWindow').jqxWindow('bringToFront');
        });
        }

      function getDepartment() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var departmentItems = items[0].split(",");
                var departmentIdItems = items[1].split(",");
                var optionsdepartment = '<option value="">--Select--</option>';
                for (var i = 0; i < departmentItems.length; i++) {
                    optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
                            + departmentItems[i] + '</option>';
                }
                $("select#cmbempdepartment").html(optionsdepartment);
                if ($('#hidcmbempdepartment').val() != null) {
                    $('#cmbempdepartment').val($('#hidcmbempdepartment').val());
                }
            } else {
            }
        }
        x.open("GET", "getDepartment.jsp", true);
        x.send();
    }

    function getPayrollCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var payrollcategoryItems = items[0].split(",");
                var payrollcategoryIdItems = items[1].split(",");
                var optionspayrollcategory = '<option value="">--Select--</option>';
                for (var i = 0; i < payrollcategoryItems.length; i++) {
                    optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
                            + payrollcategoryItems[i] + '</option>';
                }
                $("select#cmbempcategory").html(optionspayrollcategory);
                if ($('#hidcmbempcategory').val() != null) {
                    $('#cmbempcategory').val($('#hidcmbempcategory').val());
                }
            } else {
            }
        }
        x.open("GET", "getPayrollCategory.jsp", true);
        x.send();
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

    function getDay() {
          $('#hidcmbyear').val($('#cmbyear').val());
          $('#hidcmbmonth').val($('#cmbmonth').val());

        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var daysItems = items[0].split(",");
                var daysIdItems = items[1].split(",");
                var optionsdays = '<option value="">--Select--</option>';
                for (var i = 0; i < daysItems.length; i++) {
                    optionsdays += '<option value="' + daysIdItems[i] + '">'
                            + daysItems[i] + '</option>';
                }
                $("select#cmbday").html(optionsdays);
                if ($('#hidcmbday').val() != null) {
                    $('#cmbday').val($('#hidcmbday').val());
                }
            } else {
            }
        }
        x.open("GET", "getDay.jsp?year="+$('#cmbyear').val()+"&month="+$('#cmbmonth').val(), true);
        x.send();
    }

    function getLeaveType() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var leavetypeItems = items[0].split(",");
                var leavetypeIdItems = items[1].split(",");
                var optionsleavetype = '<option value="">--Select--</option>';
                for (var i = 0; i < leavetypeItems.length; i++) {
                    optionsleavetype += '<option value="' + leavetypeIdItems[i] + '">'
                            + leavetypeItems[i] + '</option>';
                }
                $("select#cmbleavetype").html(optionsleavetype);
                if ($('#hidcmbleavetype').val() != null) {
                    $('#cmbleavetype').val($('#hidcmbleavetype').val());
                }
            } else {
            }
        }
        x.open("GET", "getLeaveType.jsp", true);
        x.send();
    }

    function getHoliday() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var holidayItems = items[0].split(",");
                var holidayIdItems = items[1].split(",");
                var optionsholiday = '<option value="">--Select--</option>';
                for (var i = 0; i < holidayItems.length; i++) {
                    optionsholiday += '<option value="' + holidayIdItems[i] + '">'
                            + holidayItems[i] + '</option>';
                }
                $("select#cmbholiday").html(optionsholiday);
                if ($('#hidcmbholiday').val() != null) {
                    $('#cmbholiday').val($('#hidcmbholiday').val());
                }
            } else {
            }
        }
        x.open("GET", "getHoliday.jsp", true);
        x.send();
    }

    function getNewGridValue(a){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();

                $('#txtselectedcelltextvalue').val(items);
        }
        }
        x.open("GET", "getNewGridValue.jsp?refno="+a, true);
        x.send();
    }

    function getHolidaysOfMonth(year,month) {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#txtholidaysofmonth').val(items);
        }
        }

        x.open("GET", "getHolidaysOfMonth.jsp?year="+year+"&month="+month, true);
        x.send();
     }

    function getAttendanceLeaveEditEnable(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#txtattendanceleaveseditgrid').val(items);

                if(parseInt($('#txtattendanceleaveseditgrid').val())==0){
                     $("#rdtotalleaves").hide();document.getElementById("rdtotalleaves1").innerText=" ";$("#btnRecheck").show();
                 } else {
                     $("#rdtotalleaves").show();document.getElementById("rdtotalleaves1").innerText="Total Leaves";$("#btnRecheck").hide();
                 }
        }
        }
        x.open("GET", "getAttendanceLeaveEditEnable.jsp", true);
        x.send();
    }

    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
            employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
        }

    function funReadOnly(){}

    function funRemoveReadOnly(){}

    function funSearchLoad(){}

    function funChkButton(){
        /* funReset(); */
    }

     function funNotify(){
         return 1;
        }

     function funSearchLoad(){}

     function funFocus(){
            document.getElementById("cmbyear").focus();
        }

     function setValues(){

             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  }

             document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
             funSetlabel();

             var indexVal = document.getElementById("docno").value;
             if(indexVal> 0){
                 var employeebranchchk=window.parent.employeebranchchk.value;
                 var branch=document.getElementById("brchName").value;
                 $("#attendanceDiv").load("attendanceGridMARBLELIFE.jsp?docno="+indexVal+'&branchid='+branch+'&employeebranchchk='+employeebranchchk);
             }
        }

     function radioClick(){
         if(document.getElementById("rdovertime").checked==true){
             $('#overtime').jqxDateTimeInput({disabled: false});
             $('#cmbholiday').attr('disabled', true);
             $('#cmbleavetype').attr('disabled', true);
             $('#chckhalfday').attr('disabled', true);
             document.getElementById("cmbholiday").value = "";
             document.getElementById("cmbleavetype").value = "";
             document.getElementById("chckhalfday").checked=false;
             document.getElementById("hidchckhalfday").value = 0;

             var overtimes = $('#overtime').val();
             var overtime = overtimes.split(":");
             var value = ((overtime[0]*60)+overtime[1]);
             $('#txtselectedcellvalue').val(value);

         }else if(document.getElementById("rdleavetype").checked==true){
             $('#cmbleavetype').attr('disabled', false);
             $('#chckhalfday').attr('disabled', false);
             $('#cmbholiday').attr('disabled', true);
             $('#overtime').jqxDateTimeInput({disabled: true});
             document.getElementById("cmbholiday").value = "";
             var settime=new Date();
             settime.setHours(0,0,0,0);
             $('#overtime').jqxDateTimeInput('setDate',settime);
         }else if(document.getElementById("rdtotalleaves").checked==true){
             $('#cmbleavetype').attr('disabled', true);
             $('#chckhalfday').attr('disabled', true);
             $('#cmbholiday').attr('disabled', true);
             $('#overtime').jqxDateTimeInput({disabled: true});
             document.getElementById("cmbholiday").value = "";
             var settime=new Date();
             settime.setHours(0,0,0,0);
             $('#overtime').jqxDateTimeInput('setDate',settime);
         }else{
             $('#cmbleavetype').attr('disabled', true);
             $('#chckhalfday').attr('disabled', true);
             $('#overtime').jqxDateTimeInput({disabled: true});
             $('#cmbholiday').attr('disabled', false);
             document.getElementById("cmbleavetype").value = "";
             document.getElementById("chckhalfday").checked=false;
             document.getElementById("hidchckhalfday").value = 0;
             var settime=new Date();
             settime.setHours(0,0,0,0);
             $('#overtime').jqxDateTimeInput('setDate',settime);
           }
     }

     function clearhalfdaycheck(){
            document.getElementById("chckhalfday").checked=false;
            document.getElementById("hidchckhalfday").value = 0;
     }

     function markallcheck(){
              if(document.getElementById("chckmarkall").checked){
                  document.getElementById("hidchckmarkall").value = 1;
              }
              else{
                  document.getElementById("hidchckmarkall").value = 0;
            }
        }

     function halfdaycheck(){
         if(document.getElementById("chckhalfday").checked){
             document.getElementById("hidchckhalfday").value = 1;
         }
         else{
             document.getElementById("hidchckhalfday").value = 0;
         }

         var leavetype = $('#cmbleavetype').val();
         var halfday = $('#hidchckhalfday').val();
         var celltextvalue = ($('#txtselectedcelltextvalue').val()).charAt(0);
         if(halfday=='0'){
             $('#txtselectedcellvalue').val(leavetype);
             $('#txtselectedcelltextvalue').val(celltextvalue);
         }
         if(halfday=='1'){
             $('#txtselectedcellvalue').val(leavetype+"2");
             $('#txtselectedcelltextvalue').val(celltextvalue+"2");
         }
     }

     function newValueSet(){
         if(document.getElementById("rdovertime").checked==true){
             var overtimes = $('#overtime').val();
             var overtime = overtimes.split(":");
             var value = ((parseInt(overtime[0])*60)+parseInt(overtime[1]));
             $('#txtselectedcellvalue').val(value);
             $('#txtselectedcelltextvalue').val(overtimes);

         }else if(document.getElementById("rdleavetype").checked==true){
             var leavetype = $('#cmbleavetype').val();
             var halfday = $('#hidchckhalfday').val();

             if(halfday=='0'){
                $('#txtselectedcellvalue').val(leavetype);
             }
             if(halfday=='1'){
                 $('#txtselectedcellvalue').val(leavetype+"2");
             }
         }else{
             var holiday = $('#cmbholiday').val();
             $('#txtselectedcellvalue').val(holiday);
           }
     }

     function funViewAttendance(){

         if(document.getElementById("btnView").value =="View"){

             if($('#cmbyear').val()==''){
                     document.getElementById("errormsg").innerText="Year is Mandatory.";
                     return 0;
                 }

                if($('#cmbmonth').val()==''){
                     document.getElementById("errormsg").innerText="Month is Mandatory.";
                     return 0;
                 }

                document.getElementById("errormsg").innerText="";

                $('#txtmarkedattendance').val('0');
                var x = document.getElementById("cmbday").length;
                //alert(x);
                var totdays=(x-1);
                //alert(totdays);
                $("#overlay, #PleaseWait").show();
                var employeebranchchk=window.parent.employeebranchchk.value;
                var branch=document.getElementById("brchName").value;
                $("#attendanceDiv").load("attendanceGridMARBLELIFE.jsp?totdays="+totdays+"&year="+$('#cmbyear').val()+"&month="+$('#cmbmonth').val()+"&day="+$('#cmbday').val()+"&department="+$('#cmbempdepartment').val()+"&category="+$('#cmbempcategory').val()+"&empid="+$('#txtemployeedocno').val()+"&check=1"+'&branchid='+branch+'&employeebranchchk='+employeebranchchk);
                document.getElementById("btnView").value ="Mark Attendance";
                $('#btnApply').attr('disabled', false);$('#btnApplyDelete').attr('disabled', false);
                $("#attendanceGridID").jqxGrid({ disabled: false});

            }else if(document.getElementById("btnView").value =="Mark Attendance"){

                if($('#txtmonthlypayrollprocessed').val()=='1'){
                     $.messager.alert('Message','Payroll Processed,Attendance cannot be Changed.','warning');
                     return 0;
                } else {
                    document.getElementById("errormsg").innerText="";
                    $('#attendanceGridID').jqxGrid({ editable: false});

                    if($('#hidchckmarkall').val()=='1'){
                        var rows = $("#attendanceGridID").jqxGrid('getrows');
                        for(var i=0 ; i < rows.length ; i++){
                            $("#overlay, #PleaseWait").show();
                            $('#attendanceGridID').jqxGrid('setcellvalue', i, $('#txtselectedcellcolumn').val() ,$('#txtselectedcelltextvalue').val());
                        }

                        $("#overlay, #PleaseWait").hide();

                    } else {
                        $('#attendanceGridID').jqxGrid('setcellvalue', $('#txtselectedcellrow').val(), $('#txtselectedcellcolumn').val(),$('#txtselectedcelltextvalue').val());
                    }

                    if($('#txtattendanceleaveseditgrid').val().trim()=='0'){
                        $('#txtmarkedattendance').val('1');
                    }
                }
            }

     }

    function  funClearInfo(){

            var attendanceleavesedit = document.getElementById("txtattendanceleaveseditgrid").value;

            $('input[type=text]').val('');
            $('select').find('option').prop("selected", false);
            $('input[type=radio]').prop("checked", false);
            $('input:checkbox').removeAttr('checked');


            document.getElementById("txtattendanceleaveseditgrid").value=attendanceleavesedit;
            $('#txtmarkedattendance').val('0');
            document.getElementById("rdholiday").checked=true;
            document.getElementById("chckhalfday").checked=false;
            document.getElementById("hidchckhalfday").value = 0;
            document.getElementById("chckmarkall").checked=false;
            document.getElementById("hidchckmarkall").value = 0;

            document.getElementById("txtrecheckemptotalleaves").value="";
            document.getElementById("txtrecheckemptotalleavesgridlength").value="";

            radioClick();
            var settime=new Date();
            settime.setHours(0,0,0,0);
            $('#overtime').jqxDateTimeInput('setDate',settime);

            $("#attendanceGridID").jqxGrid('clear');
            $("#attendanceGridID").jqxGrid('addrow', null, {});
            $("#attendanceGridID").jqxGrid({ disabled: true});

             if (document.getElementById("txtemployeeid").value == "") {
                $('#txtemployeeid').attr('placeholder', 'Press F3 to Search');
                $('#txtemployeename').attr('placeholder', 'Employee Name');
            }

             document.getElementById("btnView").value ="View";
             $('#btnApply').attr('disabled', true);
             $('#btnApplyDelete').attr('disabled', true);
             document.getElementById("savemsg").innerText="";
             document.getElementById("errormsg").innerText="";
    }

     function  funClearYearInfo(){

            var year = document.getElementById("cmbyear").value;
            var attendanceleavesedit = document.getElementById("txtattendanceleaveseditgrid").value;

            $('input[type=text]').val('');
            $('select').find('option').prop("selected", false);
            $('input[type=radio]').prop("checked", false);
            $('input:checkbox').removeAttr('checked');

            document.getElementById("cmbyear").value=year;
            document.getElementById("txtattendanceleaveseditgrid").value=attendanceleavesedit;
            $('#txtmarkedattendance').val('0');
            document.getElementById("rdholiday").checked=true;
            document.getElementById("chckhalfday").checked=false;
            document.getElementById("hidchckhalfday").value = 0;
            document.getElementById("chckmarkall").checked=false;
            document.getElementById("hidchckmarkall").value = 0;

            document.getElementById("txtrecheckemptotalleaves").value="";
            document.getElementById("txtrecheckemptotalleavesgridlength").value="";

            radioClick();
            var settime=new Date();
            settime.setHours(0,0,0,0);
            $('#overtime').jqxDateTimeInput('setDate',settime);

            $("#attendanceGridID").jqxGrid('clear');
            $("#attendanceGridID").jqxGrid('addrow', null, {});
            $("#attendanceGridID").jqxGrid({ disabled: true});

             if (document.getElementById("txtemployeeid").value == "") {
                $('#txtemployeeid').attr('placeholder', 'Press F3 to Search');
                $('#txtemployeename').attr('placeholder', 'Employee Name');
            }

             document.getElementById("btnView").value ="View";
             $('#btnApply').attr('disabled', true);
             $('#btnApplyDelete').attr('disabled', true);
             document.getElementById("savemsg").innerText="";
             document.getElementById("errormsg").innerText="";
    }

     function  funClearMonthInfo(){

            var year = document.getElementById("cmbyear").value;
            var month = document.getElementById("cmbmonth").value;
            var attendanceleavesedit = document.getElementById("txtattendanceleaveseditgrid").value;

            $('input[type=text]').val('');
            $('select').find('option').prop("selected", false);
            $('input[type=radio]').prop("checked", false);
            $('input:checkbox').removeAttr('checked');

            document.getElementById("cmbyear").value=year;
            document.getElementById("cmbmonth").value=month;
            document.getElementById("txtattendanceleaveseditgrid").value=attendanceleavesedit;
            $('#txtmarkedattendance').val('0');
            document.getElementById("rdholiday").checked=true;
            document.getElementById("chckhalfday").checked=false;
            document.getElementById("hidchckhalfday").value = 0;
            document.getElementById("chckmarkall").checked=false;
            document.getElementById("hidchckmarkall").value = 0;

            document.getElementById("txtrecheckemptotalleaves").value="";
            document.getElementById("txtrecheckemptotalleavesgridlength").value="";

            radioClick();
            var settime=new Date();
            settime.setHours(0,0,0,0);
            $('#overtime').jqxDateTimeInput('setDate',settime);

            $("#attendanceGridID").jqxGrid('clear');
            $("#attendanceGridID").jqxGrid('addrow', null, {});
            $("#attendanceGridID").jqxGrid({ disabled: true});

             if (document.getElementById("txtemployeeid").value == "") {
                $('#txtemployeeid').attr('placeholder', 'Press F3 to Search');
                $('#txtemployeename').attr('placeholder', 'Employee Name');
            }

             document.getElementById("btnView").value ="View";
             $('#btnApply').attr('disabled', true);
             $('#btnApplyDelete').attr('disabled', true);
             document.getElementById("savemsg").innerText="";
             document.getElementById("errormsg").innerText="";
    }

     function funApplyAttendance(event){
            var year = $('#cmbyear').val();
            var month = $('#cmbmonth').val();
            var employee = $('#txtselectedemployee').val();
            var cellcolumn = $('#txtselectedcellcolumn').val();
            var cellvalue = $('#txtselectedcellvalue').val();
            var leave1total = $('#txtselectedcellleave1totalvalue').val();
            var leave2total = $('#txtselectedcellleave2totalvalue').val();
            var leave3total = $('#txtselectedcellleave3totalvalue').val();
            var leave4total = $('#txtselectedcellleave4totalvalue').val();
            var leave5total = $('#txtselectedcellleave5totalvalue').val();
            var leave6total = $('#txtselectedcellleave6totalvalue').val();
            var leave7total = $('#txtselectedcellleave7totalvalue').val();
            var overtimevalue = $('#txtselectedcellovertimevalue').val();
            var holidayovertimevalue = $('#txtselectedcellholidayovertimevalue').val();
            var holidaysofmonth = $('#txtholidaysofmonth').val();
            var monthlypayrollprocessed = $('#txtmonthlypayrollprocessed').val();
            var category = $('#cmbempcategory').val();
            var department = $('#cmbempdepartment').val();
            var markall = $('#hidchckmarkall').val();
            var emptotalleavesarray="";
            var emptotalleavesgridlength="0";

            var funtype="1";

            if(document.getElementById("rdtotalleaves").checked==true){
                funtype="3";
            }

            if(cellcolumn.trim()==''){
                 document.getElementById("errormsg").innerText="Choose a Cell.";
                 return 0;
             }

            if(year==''){
                 document.getElementById("errormsg").innerText="Year is Mandatory.";
                 return 0;
             }

            if(month==''){
                 document.getElementById("errormsg").innerText="Month is Mandatory.";
                 return 0;
             }

            if(monthlypayrollprocessed=='1'){
                 $.messager.alert('Message','Payroll Processed,Attendance cannot be Changed.','warning');
                 return 0;
            }

            if(document.getElementById("rdovertime").checked==true){
                 if($('#overtime').val()=='00:00'){
                     document.getElementById("errormsg").innerText="Enter a Valid Time.";
                     return 0;
                 }
             }

             if(document.getElementById("rdleavetype").checked==true){
                 if($('#cmbleavetype').val()==''){
                     document.getElementById("errormsg").innerText="Choose an Leave Type.";
                     return 0;
                 }

             }

             if(document.getElementById("rdholiday").checked==true){
                 if($('#cmbholiday').val()==''){
                     document.getElementById("errormsg").innerText="Choose an Holiday Type.";
                     return 0;
                 }
               }

             if($('#txtattendanceleaveseditgrid').val().trim()=='0' && $('#txtmarkedattendance').val().trim()=='0'){
                 document.getElementById("errormsg").innerText="Mark Attendance & Apply.";
                 return 0;
            }

            document.getElementById("errormsg").innerText="";

            var x = document.getElementById("cmbday").length;
            var totdays=(x-1);

                $.messager.confirm('Message', 'Do you want to apply changes?', function(r){

                    if(r==false)
                      {
                        return false;
                      }
                    else{

                         if(document.getElementById("rdtotalleaves").checked==true && $('#hidchckmarkall').val()=='1'){

                            var rows = $("#attendanceGridID").jqxGrid('getrows');

                            var i=0;var tempemptotalleaves="",tempemptotalleaves1="";
                            $('#txtemptotalleavesgridlength').val(rows.length);
                            for (i = 0; i < rows.length; i++) {
                                if(i==0){
                                    tempemptotalleaves=rows[i].employeedocno+"::"+rows[i].leave1total+"::"+rows[i].leave2total+"::"+rows[i].leave3total+"::"+rows[i].leave4total+"::"+rows[i].leave5total+"::"+rows[i].leave6total+"::"+rows[i].leave7total;
                                }
                                else{
                                    tempemptotalleaves=tempemptotalleaves+","+rows[i].employeedocno+"::"+rows[i].leave1total+"::"+rows[i].leave2total+"::"+rows[i].leave3total+"::"+rows[i].leave4total+"::"+rows[i].leave5total+"::"+rows[i].leave6total+"::"+rows[i].leave7total;
                                }
                                tempemptotalleaves1=tempemptotalleaves+",";
                            }
                            $('#txtemptotalleaves').val(tempemptotalleaves1);
                            emptotalleavesarray=$('#txtemptotalleaves').val();
                            emptotalleavesgridlength=$('#txtemptotalleavesgridlength').val();
                         }

                         $("#overlay, #PleaseWait").show();
                         saveAttendanceData(year,month,employee,cellcolumn,cellvalue,totdays,leave1total,leave2total,leave3total,leave4total,leave5total,leave6total,leave7total,emptotalleavesarray,emptotalleavesgridlength,overtimevalue,holidayovertimevalue,category,department,markall,funtype);
                    }
             });
        }

     function funDeleteAttendance(event){
            var year = $('#cmbyear').val();
            var month = $('#cmbmonth').val();
            var employee = $('#txtselectedemployee').val();
            var cellcolumn = $('#txtselectedcellcolumn').val();
            var cellvalue = $('#txtselectedcelltextvalue').val();
            var leave1total = $('#txtselectedcellleave1totalvalue').val();
            var leave2total = $('#txtselectedcellleave2totalvalue').val();
            var leave3total = $('#txtselectedcellleave3totalvalue').val();
            var leave4total = $('#txtselectedcellleave4totalvalue').val();
            var leave5total = $('#txtselectedcellleave5totalvalue').val();
            var leave6total = $('#txtselectedcellleave6totalvalue').val();
            var leave7total = $('#txtselectedcellleave7totalvalue').val();
            var overtimevalue = $('#txtselectedcellovertimevalue').val();
            var holidayovertimevalue = $('#txtselectedcellholidayovertimevalue').val();
            var holidaysofmonth = $('#txtholidaysofmonth').val();
            var monthlypayrollprocessed = $('#txtmonthlypayrollprocessed').val();
            var category = $('#cmbempcategory').val();
            var department = $('#cmbempdepartment').val();
            var markall = $('#hidchckmarkall').val();
            var emptotalleavesarray="";
            var emptotalleavesgridlength="0";

            var funtype="2";

            if(document.getElementById("rdtotalleaves").checked==true){
                funtype="3";
            }

            if(document.getElementById("rdtotalleaves").checked==true){
                 document.getElementById("errormsg").innerText="Invalid Click.";
                 return 0;
            }

            if(cellcolumn==''){
                 document.getElementById("errormsg").innerText="Choose a Cell.";
                 return 0;
             }

            if(year==''){
                 document.getElementById("errormsg").innerText="Year is Mandatory.";
                 return 0;
             }

            if(month==''){
                 document.getElementById("errormsg").innerText="Month is Mandatory.";
                 return 0;
             }

            if(monthlypayrollprocessed=='1'){
                 $.messager.alert('Message','Payroll Processed,Attendance cannot be Changed.','warning');
                 return 0;
            }

            document.getElementById("errormsg").innerText="";

            var x = document.getElementById("cmbday").length;
            var totdays=(x-1);

                $.messager.confirm('Message', 'Do you want to apply changes?', function(r){

                    if(r==false)
                      {
                        return false;
                      }
                    else{
                         $("#overlay, #PleaseWait").show();
                         saveAttendanceData(year,month,employee,cellcolumn,cellvalue,totdays,leave1total,leave2total,leave3total,leave4total,leave5total,leave6total,leave7total,emptotalleavesarray,emptotalleavesgridlength,overtimevalue,holidayovertimevalue,category,department,markall,funtype);
                    }
             });
        }

        function funReCheckAttendance(event){
            var year = $('#cmbyear').val();
            var month = $('#cmbmonth').val();
            var monthlypayrollprocessed = $('#txtmonthlypayrollprocessed').val();

            if(year==''){
                 document.getElementById("errormsg").innerText="Year is Mandatory.";
                 return 0;
            }

            if(month==''){
                 document.getElementById("errormsg").innerText="Month is Mandatory.";
                 return 0;
            }

            var rows = $('#attendanceGridID').jqxGrid('getrows');
            if(rows.length==1 && (rows[0].employeedocno=="undefined" || rows[0].employeedocno==null || rows[0].employeedocno=="")){
                $.messager.alert('Message','View Attendance and Re-Check. ','warning');
                return 0;
            }

            if(monthlypayrollprocessed=='1'){
                 $.messager.alert('Message','Payroll Processed,Attendance cannot be Changed.','warning');
                 return 0;
            }

            document.getElementById("errormsg").innerText="";

                $.messager.confirm('Message', 'Do you want to Re-Check Attendance?', function(r){

                    if(r==false)
                      {
                        return false;
                      }
                    else{

                          $("#overlay, #PleaseWait").show();
                          getLeavesGridTotal("2");

                    }
             });
        }

         function funExcelBtn() {
             JSONToCSVConNew(data, 'Attendance', true);
              //JSONToCSVCon(dataExcelExport, 'Attendance', true);
            /* $("#attendanceDiv").excelexportjs({
                 containerid: "attendanceDiv",
                 datatype: 'json',
                 dataset: null,
                 gridId: "attendanceGridID",
                 columns: getColumns("attendanceGridID") ,
                 worksheetName:"Attendance"
                 }); */
          }


            function JSONToCSVConNew(JSONData, ReportTitle, ShowLabel) {
                // console.log(JSONData)
                 var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;

                var CSV = '';
                //Set Report title in first row or line

                //CSV += ReportTitle + '\r\n\n';

                //This condition will generate the Label/Header
                 if (ShowLabel) {
                    var row = "";

                    //This loop will extract the label from 1st index of on array
                    for (var index in arrData[0]) {
                         if(index=="employeedocno" ||  index=="employeeid" ||index=="employeename" ||index=="year" ||index=="month" || index=="date1" || index=="date2" || index=="date3" ||  index=="date4"  ||  index=="date5" ||  index=="date6" ||  index=="date7" ||  index=="date8" ||  index=="date9" ||  index=="date10" ||  index=="date11" ||  index=="date12" ||  index=="date13" ||  index=="date14" ||  index=="date15" ||  index=="date16" ||  index=="date17" ||  index=="date18" ||  index=="date19" ||  index=="date20" ||  index=="date21" ||  index=="date22" ||  index=="date23" ||  index=="date24" ||  index=="date25" ||  index=="date26" ||  index=="date27" ||  index=="date28" ||  index=="date29" ||  index=="date30" ||  index=="date31" ){

                            console.log(index)
                            //Now convert each value to string and comma-seprated
                            row += index + ',';
                        }
          }
                    row = row.slice(0, -1);

                    //append Label row with line break
                    CSV += row + '\r\n';
                }

                //1st loop is to extract each row
                var strquote = "'";
                for (var i = 0; i < arrData.length; i++) {
                    var row = "";

                    //2nd loop will extract each column and convert it in string comma-seprated
                    for (var index in arrData[i]) {
                    //  console.log(index);
                         //row += strquote+'"' + arrData[i][index] + '",';
                      if(index=="employeedocno" ||  index=="employeeid" ||index=="employeename" ||index=="year" ||index=="month" || index=="date1" || index=="date2" || index=="date3" ||  index=="date4"  ||  index=="date5" ||  index=="date6" ||  index=="date7" ||  index=="date8" ||  index=="date9" ||  index=="date10" ||  index=="date11" ||  index=="date12" ||  index=="date13" ||  index=="date14" ||  index=="date15" ||  index=="date16" ||  index=="date17" ||  index=="date18" ||  index=="date19" ||  index=="date20" ||  index=="date21" ||  index=="date22" ||  index=="date23" ||  index=="date24" ||  index=="date25" ||  index=="date26" ||  index=="date27" ||  index=="date28" ||  index=="date29" ||  index=="date30" ||  index=="date31" ){


                          if(isNaN(arrData[i][index])){
                                row += arrData[i][index]+',';

                            }else{
                                //console.log('='+arrData[i][index]);
                                 row += arrData[i][index]+',';
                            }
                        }else{
                            //row += arrData[i][index]+',';
                        }

                    }
                   //   console.log("row------" +row);

                    row.slice(0, row.length - 1);

                    //add a line break after each row
                    CSV += row + '\r\n';
                }

                if (CSV == '') {
                    //alert("Invalid data");
                    return;
                }

                //Generate a file name
                var fileName = "";
                //this will remove the blank-spaces from the title and replace it with an underscore
                fileName += ReportTitle.replace(/ /g,"_");

                 // newly added
                var temp = CSV;
                blob = new Blob([temp],{type: 'text/csv'});
                var bigcsv= window.webkitURL.createObjectURL(blob);


                //Initialize file format you want csv or xls
              //  var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);

                // Now the little tricky part.
                // you can use either>> window.open(uri);
                // but this will not work in some browsers
                // or you will not get the correct file extension

                //this trick will generate a temp <a /> tag
                var link = document.createElement("a");
                 //   link.href = uri;
                  link.href = bigcsv;

                //set the visibility hidden so it will not effect on your web-layout
                link.style = "visibility:hidden";
                link.download = fileName + ".csv";

                //this part will append the anchor tag and remove it after automatic click
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }

        function saveAttendanceData(year,month,employee,cellcolumn,cellvalue,totdays,leave1total,leave2total,leave3total,leave4total,leave5total,leave6total,leave7total,emptotalleavesarray,emptotalleavesgridlength,overtimevalue,holidayovertimevalue,category,department,markall,funtype){
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    var items=x.responseText;

                    var employee = $('#txtselectedemployee').val(' ');
                    var cellcolumn = $('#txtselectedcellcolumn').val(' ');
                    var cellvalue = $('#txtselectedcellvalue').val(' ');

                    document.getElementById("cmbday").value="";
                    document.getElementById("cmbempdepartment").value="";
                    document.getElementById("cmbempcategory").value="";
                    document.getElementById("txtemployeeid").value="";
                    document.getElementById("txtemployeedocno").value="";
                    document.getElementById("txtemployeename").value="";
                    document.getElementById("cmbholiday").value="";
                    document.getElementById("cmbleavetype").value="";

                    document.getElementById("rdholiday").checked=true;
                    document.getElementById("chckhalfday").checked=false;
                    document.getElementById("hidchckhalfday").value = 0;

                    document.getElementById("chckmarkall").checked=false;
                    document.getElementById("hidchckmarkall").value = 0;

                    document.getElementById("txtselectedcellrow").value="";
                    document.getElementById("txtselectedcelltextvalue").value="";

                    document.getElementById("txtselectedcellleave1totalvalue").value="";
                    document.getElementById("txtselectedcellleave2totalvalue").value="";
                    document.getElementById("txtselectedcellleave3totalvalue").value="";
                    document.getElementById("txtselectedcellleave4totalvalue").value="";
                    document.getElementById("txtselectedcellleave5totalvalue").value="";
                    document.getElementById("txtselectedcellleave6totalvalue").value="";
                    document.getElementById("txtselectedcellleave7totalvalue").value="";
                    document.getElementById("txtemptotalleaves").value="";
                    document.getElementById("txtemptotalleavesgridlength").value="";
                    document.getElementById("txtselectedcellovertimevalue").value="";
                    document.getElementById("txtselectedcellholidayovertimevalue").value="";
                    document.getElementById("txtmonthlypayrollprocessed").value="";
                    document.getElementById("txtmarkedattendance").value="0";

                    document.getElementById("txtrecheckemptotalleaves").value="";
                    document.getElementById("txtrecheckemptotalleavesgridlength").value="";

                    var settime=new Date();
                    settime.setHours(0,0,0,0);
                    $('#overtime').jqxDateTimeInput('setDate',settime);

                    $("#attendanceGridID").jqxGrid('clear');
                    $("#attendanceGridID").jqxGrid('addrow', null, {});
                    $("#attendanceGridID").jqxGrid({ disabled: true});

                     if (document.getElementById("txtemployeeid").value == "") {
                        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search');
                        $('#txtemployeename').attr('placeholder', 'Employee Name');
                    }

                     document.getElementById("btnView").value ="View";
                     $('#btnApply').attr('disabled', true);
                     $('#btnApplyDelete').attr('disabled', true);

                     document.getElementById("savemsg").innerText="";
                     document.getElementById("errormsg").innerText="";

                    $.messager.alert('Message', '  Record Successfully Updated ', function(r){
                  });
                    funViewAttendance();
                    radioClick();
              }
            }

        x.open("GET","saveData.jsp?year="+year+"&month="+month+"&employee="+employee+"&cellcolumn="+cellcolumn+"&cellvalue="+cellvalue+"&totdays="+totdays+"&leave1total="+leave1total+"&leave2total="+leave2total+"&leave3total="+leave3total+"&leave4total="+leave4total+"&leave5total="+leave5total+"&leave6total="+leave6total+"&leave7total="+leave7total+"&emptotalleavesarray="+emptotalleavesarray+"&emptotalleavesgridlength="+emptotalleavesgridlength+"&overtimevalue="+overtimevalue+"&holidayovertimevalue="+holidayovertimevalue+"&category="+category+"&department="+department+"&markall="+markall+"&funtype="+funtype,true);
        x.send();
        }

        function updateAttendanceData(year,month,emptotalleavesarray,emptotalleavesgridlength){
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    var items=x.responseText;

                    var employee = $('#txtselectedemployee').val(' ');
                    var cellcolumn = $('#txtselectedcellcolumn').val(' ');
                    var cellvalue = $('#txtselectedcellvalue').val(' ');

                    document.getElementById("cmbday").value="";
                    document.getElementById("cmbempdepartment").value="";
                    document.getElementById("cmbempcategory").value="";
                    document.getElementById("txtemployeeid").value="";
                    document.getElementById("txtemployeedocno").value="";
                    document.getElementById("txtemployeename").value="";
                    document.getElementById("cmbholiday").value="";
                    document.getElementById("cmbleavetype").value="";

                    document.getElementById("rdholiday").checked=true;
                    document.getElementById("chckhalfday").checked=false;
                    document.getElementById("hidchckhalfday").value = 0;

                    document.getElementById("chckmarkall").checked=false;
                    document.getElementById("hidchckmarkall").value = 0;

                    document.getElementById("txtselectedcellrow").value="";
                    document.getElementById("txtselectedcelltextvalue").value="";

                    document.getElementById("txtselectedcellleave1totalvalue").value="";
                    document.getElementById("txtselectedcellleave2totalvalue").value="";
                    document.getElementById("txtselectedcellleave3totalvalue").value="";
                    document.getElementById("txtselectedcellleave4totalvalue").value="";
                    document.getElementById("txtselectedcellleave5totalvalue").value="";
                    document.getElementById("txtselectedcellleave6totalvalue").value="";
                    document.getElementById("txtselectedcellleave7totalvalue").value="";
                    document.getElementById("txtemptotalleaves").value="";
                    document.getElementById("txtemptotalleavesgridlength").value="";
                    document.getElementById("txtselectedcellovertimevalue").value="";
                    document.getElementById("txtselectedcellholidayovertimevalue").value="";
                    document.getElementById("txtmonthlypayrollprocessed").value="";
                    document.getElementById("txtmarkedattendance").value="0";

                    document.getElementById("txtrecheckemptotalleaves").value="";
                    document.getElementById("txtrecheckemptotalleavesgridlength").value="";

                    var settime=new Date();
                    settime.setHours(0,0,0,0);
                    $('#overtime').jqxDateTimeInput('setDate',settime);

                    $("#attendanceGridID").jqxGrid('clear');
                    $("#attendanceGridID").jqxGrid('addrow', null, {});
                    $("#attendanceGridID").jqxGrid({ disabled: true});

                     if (document.getElementById("txtemployeeid").value == "") {
                        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search');
                        $('#txtemployeename').attr('placeholder', 'Employee Name');
                    }

                     document.getElementById("btnView").value ="View";
                     $('#btnApply').attr('disabled', true);
                     $('#btnApplyDelete').attr('disabled', true);

                     document.getElementById("savemsg").innerText="";
                     document.getElementById("errormsg").innerText="";

                    $.messager.alert('Message', '  Record Successfully Re-Checked ', function(r){
                  });
                    funViewAttendance();
                    radioClick();
              }
            }

        x.open("GET","updateData.jsp?year="+year+"&month="+month+"&emptotalleavesarray="+emptotalleavesarray+"&emptotalleavesgridlength="+emptotalleavesgridlength,true);
        x.send();
        }

</script>



</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEmployeeAttendance" action="saveEmployeeAttendance" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar receipt-header'>
<table class="cr-table" width="99%">
  <tr>
    <td width="20%" valign="top">
        <div class="header-card-section">
            <table class="cr-table" width="99%">
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
              <tr>
                <td width="29%" align="right">Year</td>
                <td width="71%">
                    <select id="cmbyear" name="cmbyear" style="width:80%;" onchange="funClearYearInfo();getDay();" value='<s:property value="cmbyear"/>'>
                      <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/>
                </td>
              </tr>
              <tr>
                <td align="right">Month</td>
                <td>
                    <select id="cmbmonth" name="cmbmonth" style="width:80%;" onchange="funClearMonthInfo();getDay();getHolidaysOfMonth($('#cmbyear').val(),this.value);" value='<s:property value="cmbmonth"/>'>
                      <option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
                      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
                      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
                      <option value="12">December</option>
                    </select>
                    <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/>
                </td>
              </tr>
              <tr>
                <td align="right">Day</td>
                <td>
                    <select id="cmbday" name="cmbday" style="width:80%;" value='<s:property value="cmbday"/>'>
                      <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbday" name="hidcmbday" value='<s:property value="hidcmbday"/>'/>
                </td>
              </tr>
              <tr>
                <td align="right">Department</td>
                <td>
                    <select id="cmbempdepartment" name="cmbempdepartment" style="width:80%;" value='<s:property value="cmbempdepartment"/>'>
                      <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbempdepartment" name="hidcmbempdepartment" value='<s:property value="hidcmbempdepartment"/>'/>
                </td>
              </tr>
              <tr>
                <td align="right">Category</td>
                <td>
                    <select id="cmbempcategory" name="cmbempcategory" style="width:80%;" value='<s:property value="cmbempcategory"/>'>
                      <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbempcategory" name="hidcmbempcategory" value='<s:property value="hidcmbempcategory"/>'/>
                </td>
              </tr>
              <tr>
                <td align="right">Employee</td>
                <td>
                    <input type="text" id="txtemployeeid" name="txtemployeeid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>'  onkeydown="getEmployeeId(event);"/>
                    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
                </td>
              </tr>
               <tr>
                <td colspan="2"><input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="width:95%;" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td>
              </tr>
              <tr>
                <td colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td  align="center"><input type="radio" id="rdholiday" name="rdo" value="rdholiday" onclick="radioClick();"><label for="rdholiday">Holiday</label></td>
                <td>
                    <select id="cmbholiday" name="cmbholiday" style="width:80%;" onchange="newValueSet();getNewGridValue(this.value);" value='<s:property value="cmbholiday"/>'>
                      <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbholiday" name="hidcmbholiday" value='<s:property value="hidcmbholiday"/>'/>
                </td>
              </tr>
              <tr>
                <td colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="2">
                  <div>
                     <table class="cr-table" width="100%">
                      <tr>
                        <td width="36%" align="center"><input type="radio" id="rdleavetype" name="rdo" value="rdleavetype" onclick="radioClick();"><label for="rdleavetype">Leave Type</label></td>
                        <td width="64%">
                            <select id="cmbleavetype" name="cmbleavetype" style="width:80%;" onchange="clearhalfdaycheck();newValueSet();getNewGridValue(this.value);" value='<s:property value="cmbleavetype"/>'>
                              <option value="">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbleavetype" name="hidcmbleavetype" value='<s:property value="hidcmbleavetype"/>'/>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2" align="center">
                            <input type="checkbox" id="chckhalfday" name="chckhalfday" value="" onchange="halfdaycheck();newValueSet();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Half Day
                            <input type="hidden" id="hidchckhalfday" name="hidchckhalfday" value='<s:property value="hidchckhalfday"/>'/>
                        </td>
                      </tr>
                    </table>
                  </div>
                </td>
              </tr>
              <tr>
                <td colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><input type="radio" id="rdovertime" name="rdo" value="rdovertime" onclick="radioClick();"><label for="rdovertime">Over Time</label></td>
                <td>
                    <div id="overtime" name="overtime" onchange="newValueSet();" value='<s:property value="overtime"/>'></div>
                    <input type="hidden" id="hidovertime" name="hidovertime" value='<s:property value="hidovertime"/>'/>
                </td>
              </tr>
              <tr>
                <td colspan="2"><input type="radio" id="rdtotalleaves" name="rdo" value="rdtotalleaves" onclick="radioClick();"><label id="rdtotalleaves1" for="rdtotalleaves"></label></td>
              </tr>
              <tr>
                <td>
                    <input type="checkbox" id="chckmarkall" name="chckmarkall" value="" onchange="markallcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Mark All
                    <input type="hidden" id="hidchckmarkall" name="hidchckmarkall" value='<s:property value="hidchckmarkall"/>'/>
                </td>
                <td align="center"><input type="button" class="myButtonses" name="btnView" id="btnView"  value="View" onclick="funViewAttendance();"></td>
              </tr>
              <tr>
                <td colspan="2" align="center" style="padding-top:10px;">
                    <input type="button" class="myButtonses" name="btnApply" id="btnApply"  value="Apply" onclick="funApplyAttendance(event);">&nbsp;&nbsp;
                    <input type="button" class="myButtonses" name="btnApplyDelete" id="btnApplyDelete"  value="Delete" onclick="funDeleteAttendance(event);">&nbsp;&nbsp;
                    <input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
                </td>
              </tr>
              <tr>
                <td colspan="2" align="center" style="padding-top:10px;">
                    <input type="button" class="myButtonReCheck" name="btnRecheck" id="btnRecheck"  value="Re-Check" onclick="funReCheckAttendance(event);">
                </td>
              </tr>
            </table>
            
            <div id="errormsg"></div>

            <table>
                <tr> 
                    <td width="28%" align="right"><input type="file" id="fileexcelimport" name="file" style="border:none; background:transparent;"/></td>
                    <td width="11%" align="center"> 
                        <button class="icon" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();">
                            <img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png">
                        </button>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
            </table>
        </div>
    </td>
    
    <td width="80%" valign="top">
        <div class="grid-card-section">
            <div class="cr-table" id="attendanceDiv"><jsp:include page="attendanceGridMARBLELIFE.jsp"></jsp:include></div>
        </div>
    </td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="docno" name="txtattendancedocno" style="width:75%;" value='<s:property value="txtattendancedocno"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtselectedemployee" name="txtselectedemployee" value='<s:property value="txtselectedemployee"/>'/>
<input type="hidden" id="txtselectedcellrow" name="txtselectedcellrow" value='<s:property value="txtselectedcellrow"/>'/>
<input type="hidden" id="txtselectedcellcolumn" name="txtselectedcellcolumn" value='<s:property value="txtselectedcellcolumn"/>'/>
<input type="hidden" id="txtselectedcellvalue" name="txtselectedcellvalue" value='<s:property value="txtselectedcellvalue"/>'/>
<input type="hidden" id="txtselectedcelltextvalue" name="txtselectedcelltextvalue" value='<s:property value="txtselectedcelltextvalue"/>'/>
<input type="hidden" id="txtselectedcellleave1totalvalue" name="txtselectedcellleave1totalvalue" value='<s:property value="txtselectedcellleave1totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave2totalvalue" name="txtselectedcellleave2totalvalue" value='<s:property value="txtselectedcellleave2totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave3totalvalue" name="txtselectedcellleave3totalvalue" value='<s:property value="txtselectedcellleave3totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave4totalvalue" name="txtselectedcellleave4totalvalue" value='<s:property value="txtselectedcellleave4totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave5totalvalue" name="txtselectedcellleave5totalvalue" value='<s:property value="txtselectedcellleave5totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave6totalvalue" name="txtselectedcellleave6totalvalue" value='<s:property value="txtselectedcellleave6totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave7totalvalue" name="txtselectedcellleave7totalvalue" value='<s:property value="txtselectedcellleave7totalvalue"/>'/>
<input type="hidden" id="txtemptotalleaves" name="txtemptotalleaves" value='<s:property value="txtemptotalleaves"/>'/>
<input type="hidden" id="txtemptotalleavesgridlength" name="txtemptotalleavesgridlength" value='<s:property value="txtemptotalleavesgridlength"/>'/>
<input type="hidden" id="txtselectedcellovertimevalue" name="txtselectedcellovertimevalue" value='<s:property value="txtselectedcellovertimevalue"/>'/>
<input type="hidden" id="txtselectedcellholidayovertimevalue" name="txtselectedcellholidayovertimevalue" value='<s:property value="txtselectedcellholidayovertimevalue"/>'/>
<input type="hidden" id="txtholidaysofmonth" name="txtholidaysofmonth" value='<s:property value="txtholidaysofmonth"/>'/>
<input type="hidden" id="txtmonthlypayrollprocessed" name="txtmonthlypayrollprocessed" value='<s:property value="txtmonthlypayrollprocessed"/>'/>
<input type="hidden" id="txtattendanceleaveseditgrid" name="txtattendanceleaveseditgrid" value='<s:property value="txtattendanceleaveseditgrid"/>'/>
<input type="hidden" id="txtmarkedattendance" name="txtmarkedattendance" value='<s:property value="txtmarkedattendance"/>'/>
<input type="hidden" id="txtrecheckemptotalleaves" name="txtrecheckemptotalleaves" value='<s:property value="txtrecheckemptotalleaves"/>'/>
<input type="hidden" id="txtrecheckemptotalleavesgridlength" name="txtrecheckemptotalleavesgridlength" value='<s:property value="txtrecheckemptotalleavesgridlength"/>'/>
</div>
</form>

<div id="employeeDetailsWindow">
   <div></div>
</div>
</div>
</body>
</html>