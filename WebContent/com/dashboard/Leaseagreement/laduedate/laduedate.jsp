<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar dynamically fills the left TD */
.sidebar-filters {
    width: 100%;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

/* Flex 1 allows this middle section to scroll while keeping top fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; 
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"], select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled {
    background: #9ca3af !important;
    cursor: not-allowed;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
     // Standardized height to 24px and width to 100%
     $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     $("#dateDue").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     $("#timeDue").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false });
     
     $("#duegridDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     $("#duegridDate1").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
     $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientwindow').jqxWindow('close');
     $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#fleetwindow').jqxWindow('close');
      
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

     $('#clientname').dblclick(function(){
          $('#clientwindow').jqxWindow('open');
          clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
     });
     
     $('#fleet').dblclick(function(){
          $('#fleetwindow').jqxWindow('open');
          fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
     });
      
     $('#dateDue').on('change', function (event) {
             var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
             var agmtdate1=new Date($('#dateDue').jqxDateTimeInput('getDate')); 
             var outdate=new Date($('#duegridDate1').jqxDateTimeInput('getDate'));
            if(outdate>agmtdate1){
               $.messager.alert('Message','Date Cannot Be Less Than Out Date ','warning');   
               return false;
          }    
     });
});

function funExportBtn(){
        $("#detlist").excelexportjs({
            containerid: "detlist", 
            datatype: 'json', 
            dataset: null, 
            gridId: "detailsgrid", 
            columns: getColumns("detailsgrid") ,   
            worksheetName:"LA Due Date List"
        });
}

function getfleet(event){
     var x= event.keyCode;
     if(x==114){
      $('#fleetwindow').jqxWindow('open');
      fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    
     }
} 
function fleetSearchContent(url) {
         $.get(url).done(function (data) {
             $('#fleetwindow').jqxWindow('open');
        $('#fleetwindow').jqxWindow('setContent', data);
    }); 
} 

function getclinfo(event){
     var x= event.keyCode;
     if(x==114){
      $('#clientwindow').jqxWindow('open');
      clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    
     }
} 
function clientSearchContent(url) {
         $.get(url).done(function (data) {
             $('#clientwindow').jqxWindow('open');
        $('#clientwindow').jqxWindow('setContent', data);
    }); 
} 

function funreload(event)
{
     var barchval = document.getElementById("cmbbranch").value;
     var uptodate = $('#uptodate').val();
      $("#overlay, #PleaseWait").show();
      $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&uptodate="+uptodate);
}

function funcleardata()
{
    document.getElementById("cldocno").value="";
    document.getElementById("fleet").value="";
    document.getElementById("clientname").value="";
    
     if (document.getElementById("clientname").value == "") {
        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
    }
     if (document.getElementById("fleet").value == "") {
        $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
    }
}
          
function getinfo() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            
            var srno  = items[0].split(",");
            var process = items[1].split(",");
            var optionsbranch = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < process.length; i++) {
                optionsbranch += '<option value="' + srno[i].trim() + '">' + process[i] + '</option>';
            }
            $("select#cmbinfo").html(optionsbranch);
        }
    }
    x.open("GET","getinfo.jsp", true);
    x.send();
}   

function funchangeinfo()
{
  if($('#cmbinfo').val()==1) {
     $('#dateDue').jqxDateTimeInput({ disabled: false});
     $('#timeDue').jqxDateTimeInput({ disabled: true});
     $('#dateDue').jqxDateTimeInput('focus'); 
  }
  else if($('#cmbinfo').val()==2) {
    $('#dateDue').jqxDateTimeInput({ disabled: false});
    $('#timeDue').jqxDateTimeInput({ disabled: true});
    $('#dateDue').jqxDateTimeInput('focus'); 
  }
  else if($('#cmbinfo').val()==3) {
    $('#dateDue').jqxDateTimeInput({ disabled: true});
    $('#timeDue').jqxDateTimeInput({ disabled: true});
    document.getElementById("remarks").focus();
  }
}
    
function disitems()
{
     $('#dateDue').jqxDateTimeInput({ disabled: true});
     $('#timeDue').jqxDateTimeInput({ disabled: true});
     $('#cmbinfo').attr("disabled",true);
     $('#remarks').attr("readonly",true);
     $('#driverUpdate').attr("disabled",true);
}

function funupdate()
{
     if(document.getElementById("cmbinfo").value=="") {
         $.messager.alert('Message','Select Process ','warning');   
         return 0;
     }
    
     if($('#remarks').val()=="") {
         $.messager.alert('Message','Enter Remarks ','warning');   
         return 0;
     }
    
     var remarkss = document.getElementById("remarks").value;
     var nmax = remarkss.length;
      if(nmax>99) {
          $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
            return false; 
       } 

     var rentaldocno = document.getElementById("rentaldoc").value;
     var branchids = document.getElementById("branchids").value;
     var remarks = document.getElementById("remarks").value;
     var cmbinfo = document.getElementById("cmbinfo").value;
     var exdate =  $('#dateDue').val();
     var extime =  $('#timeDue').val();
     var duedategd =  $('#duegridDate').val();
     
     if($('#cmbinfo').val()!=3) {
         var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
         var outdate=new Date($('#duegridDate1').jqxDateTimeInput('getDate'));
         var agmtdate1=new Date($('#dateDue').jqxDateTimeInput('getDate')); 
          if(outdate>agmtdate1){
               $.messager.alert('Message',' Date Cannot Be Less Than Out Date ','warning');     
           return false;
          }    
      }

    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r==false) {
            return false; 
        } else {
             savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,extime,duedategd);   
        }
     });
}

function savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,extime,duedategd)
{
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200) {
            var items=x.responseText;
             document.getElementById("fleetno").value="";
             document.getElementById("rentaldoc").value="";
             document.getElementById("branchids").value="";
             document.getElementById("remarks").value="";
             document.getElementById("cmbinfo").value="";
              $('#dateDue').val(new Date());
              $('#timeDue').val(new Date());
              $('#duegridDate').val("");
            
             $.messager.alert('Message', ' Record Successfully Updated ', function(r){ });
             funreload(event); 
             $("#duedetailsgrid").jqxGrid('clear');
             disitems();
            }
    }
        
x.open("GET","saveduedate.jsp?rentaldocno="+rentaldocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&exdate="+exdate+"&extime="+extime+"&duedategd="+duedategd,true);
x.send();
}

function funduedatesms(){
     if(document.getElementById("cmbbranch").value=="a") {
         $.messager.alert('Message','Select Branch ','warning');   
         return 0;
     }
    
     var uri=encodeURI('com/dashboard/leaseagreement/duedatesmssend1.action?dtype=BLDR'+'&branch='+document.getElementById("cmbbranch").value+'&docno='+document.getElementById("rentaldoc").value);
   $.ajaxFileUpload  
    (   
        {  
            url: uri,
            secureuri:false,
            fileElementId:'file',
            dataType: 'String',
            success: function (data, status) {  
               if(status=='success'){
                   $.messager.show({title:'Message',msg:'Msg Sent',showType:'show',
                      style:{left:15,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                  }); 
                }
                if(typeof(data.error) != 'undefined') {  
                    if(data.error != '') {  
                        $.messager.show({title:'Message',msg: data.error,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                    } else {  
                        $.messager.show({title:'Message',msg: data.message,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                    }  
                }  
            },  
            error: function (data, status, e) {  
                $.messager.alert('Message',e);
            }  
        }  
    )  
}
</script>
</head>

<body onload="getBranch();getinfo();disitems();">
<div id="mainBG" class="homeContent">
<div class='hidden-scrollbar'>
<div class="master-container">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="330px" valign="top">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            
            <!-- Update Filter Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fleet NO</td>
                        <td><input type="text" id="fleetno" name="fleetno" value='<s:property value="fleetno"/>' readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Process</td>
                        <td>
                            <select name="cmbinfo" id="cmbinfo" value='<s:property value="cmbinfo"/>' onchange="funchangeinfo()"></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Date</td>
                        <td><div id='dateDue' name='dateDue' value='<s:property value="dateDue"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Time</td>
                        <td><div id='timeDue' name='timeDue' value='<s:property value="timeDue"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td><input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'></td>
                    </tr>
                </table>
                
                <div style="margin-top: 15px;">
                    <button type="button" name="driverUpdate" id="driverUpdate" class="btn-submit" onclick="funupdate()">UPDATE</button>
                </div>
            </div>

            <!-- Hidden Data -->
            <div style="display:none;">
                <input type="hidden" name="branchids" id="branchids" value='<s:property value="branchids"/>' >
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" name="rentaldoc" id="rentaldoc" value='<s:property value="rentaldoc"/>' >
                <div id='duegridDate' name='duegridDate' value='<s:property value="duegridDate"/>'></div>   
                <div id='duegridDate1' name='duegridDate1' value='<s:property value="duegridDate1"/>'></div>   
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRIDS) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="detlist">
                <jsp:include page="detailsGrid.jsp"></jsp:include>
            </div>
            <div style="height:15px;"></div>
            <div id="detaildiv">
                <jsp:include page="detailgrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

</div>

<!-- Popups -->
<div id="clientwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>

</div>
</div>
</body>
</html>