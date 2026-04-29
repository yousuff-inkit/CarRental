<jsp:include page="../../../../includes.jsp"></jsp:include>  

<%@ taglib prefix="s" uri="/struts-tags" %>

<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
 
    
    
    // $('#vehiclewindow1').jqxWindow({ autoOpen: false,width: '80%', height: '80%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 240, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
      $('#movementwindow').jqxWindow({ autoOpen: false,width: '77%', height: '74%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Movement Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); 
 
});

function funreload(event)  
{     
    document.getElementById("fleetno").value="";
    document.getElementById("brach").value="";
    document.getElementById("grp").value="";
     document.getElementById("docno").value="";
     document.getElementById("rentaltype").value="";
     document.getElementById("typeingrid").value="";
    
     disitems();
         var barchval = document.getElementById("cmbbranch").value;
     
     $("#fleetdiv").load("vehlistshowgrid.jsp?brchval="+barchval);
    
    
    }
    
    
function disitems()
{
     $('#btnvehicle').attr("disabled",true);
     $('#btnmove').attr("disabled",true);
     $('#btnupdate').attr("disabled",true);
     $('#rentaltype').attr("disabled",true);
     $('#fleetno').attr("disabled",true);
    
      
}
    
 function getVehicleMov(){
      var fleetno=document.getElementById("fleetno").value;
      var vals=0;
      var ready="ready";
      $('#movementwindow').jqxWindow('setContent', '');
      $('#movementwindow').jqxWindow('open');  
      movementSearchContent("<%=contextPath%>/com/dashboard/vehicle/vehiclemovement/vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+vals+"&todate="+vals+"&ready="+ready);
     }
 
 function movementSearchContent(url) {
     //$('#vehiclewindow').jqxWindow('open'); 
     $('#movementwindow').jqxWindow('focus'); 
     $.get(url).done(function (data) {
    $('#movementwindow').jqxWindow('setContent', data);
    }); 
     
 }
 function changeClientAttachContent(url) {
        $.get(url).done(function (data) {
                $('#windowattach').jqxWindow('open');
                $('#windowattach').jqxWindow('setContent',data);
                $('#windowattach').jqxWindow('bringToFront');
    }); 
    }
 function funClientAttach(){
    
     
        if ($("#docno").val()!="") {
              $("#windowattach").jqxWindow('setTitle',"VEH - "+document.getElementById("docno").value);
            changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=VEH&docno="+document.getElementById("docno").value);       
        } else {
            $.messager.alert('Message','Select Fleet....!','warning');
            return;
        }
    }

    
 function funsamechk()
 {
     
     if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value)
     {
         $.messager.alert('Message','Rent Type Is Same','warning');   
         document.getElementById("rentaltype").focus();
                    
         return 0;
     }
    
 }
 
 
 
          function funupdate()
          
            {

              
              if(document.getElementById("rentaltype").value=="")
                 {
                     $.messager.alert('Message','Select Rent Type ','warning');   
                                
                     return 0;
                 }
                
              if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value)
                 {
                     $.messager.alert('Message','Rent Type Is Same','warning');   
                     document.getElementById("rentaltype").focus();
                                
                     return 0;
                 }
              var fleetno=document.getElementById("fleetno").value;
              
              var renttype=document.getElementById("rentaltype").value;
              
              savegriddata(fleetno,renttype);
             
            }   
                
    
        
            function savegriddata(fleetno,renttype)
            {
                
                var x=new XMLHttpRequest();
                x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200)
                    {
                    
                        var items=x.responseText;
                         document.getElementById("rentaltype").value="";
                         document.getElementById("fleetno").value="";
                         document.getElementById("brach").value="";
                         document.getElementById("grp").value="";
                         document.getElementById("docno").value="";
                         document.getElementById("typeingrid").value="";
                          
                      $.messager.alert('Message', '  Record Successfully Updated ', function(r){
                             
                     });
                         funreload(event); 
                        
                         disitems();
                        
                        
                        }
                    
                }
                    
            x.open("GET","saverenttype.jsp?fleet="+fleetno+"&renttype="+renttype,true);

            x.send();
                    
            }
            
            
            function funExportBtn(){
                
                   
                   
                   
                   
                   
                     if(parseInt(window.parent.chkexportdata.value)=="1")
                     {
                     JSONToCSVCon(sssss, 'Rent Status', true);
                     }
                 else
                     {
                       $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Rent Status');
                     }
                       
                    
                   
                 }          
            
            
            
            
            
</script>
</head>
  <style type="text/css">
   
/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; /* UNIFORM FONT */
    background-color: #f4f7f9;
}

.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
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

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; /* Uniform 12px label */
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select {
    width: 100%;
    height: 24px;             /* Enforced 24px height */
    padding: 2px 8px;         /* Tighter padding for 24px */
    border: 1px solid #ccd6e0;
    border-radius: 4px;       /* Sharper corners */
    font-size: 12px;          /* Adjusted font to fit 24px box */
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 10px;
}

.btn-submit {
    flex: 1;
    width: 100%;
    height: 30px;            /* Scaled button height */
    padding: 0 12px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;
    white-space: nowrap;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}


html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
</style>
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%">
<tr>

<td width="20%" valign="top">

    <div class="master-container">
        <div class="sidebar-filters">

            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <div class="sidebar-scroll-content">

                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td>
                                <input type="text" name="fleetno" id="fleetno"
                                       readonly
                                       value='<s:property value="fleetno"/>'>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">RentType</td>
                            <td>
                                <select name="rentaltype" id="rentaltype" onchange="funsamechk()">
                                    <option value="">--Select--</option>
                                    <option value="R" selected>Rental</option>
                                    <option value="L">Lease</option>
                                    <option value="LM">Limousine</option>
                                    <option value="A">All</option>
                                </select>
                            </td>
                        </tr>

                    </table>
                </div>

                <button type="button"
                        class="btn-submit"
                        id="btnupdate"
                        onclick="funupdate();">
                    Update
                </button>

                <div class="button-group" style="margin-top: 0px;">
                    <button type="button"
                            class="btn-submit"
                            id="btnvehicle"
                            onclick="funClientAttach();">
                        Attach
                    </button>

                    <button type="button"
                            class="btn-submit"
                            id="btnmove"
                            onclick="getVehicleMov();">
                        Movement
                    </button>
                </div>

                <div class="filter-card" style="margin-top:10px;">
                    <div id='pieChart1' style="width:100%; height:170px;"></div>
                </div>

            </div>
        </div>
    </div>

    <input type="hidden" name="brach" id="brach" value='<s:property value="brach"/>'>
    <input type="hidden" name="grp" id="grp" value='<s:property value="grp"/>'>
    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
    <input type="hidden" name="typeingrid" id="typeingrid" value='<s:property value="typeingrid"/>'>

</td>

<td width="80%" valign="top">
    <table width="100%">
        <tr>
            <td>
                <div id="fleetdiv">
                    <jsp:include page="vehlistshowgrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

</div>

<label hidden="true" id="trncodeval"></label>
<label hidden="true" id="statusval"></label>

<div id="movementwindow">
    <div></div>
</div> 

</div>
</body>
</html>