<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
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
        
        <style type="text/css">
        /* ===== MASTER LAYOUT (Modern Flexbox) ===== */
        html, body, #mainBG {
            height: 100%;
            margin: 0;
            overflow: hidden;
            background-color: #f4f7f9;
        }

        .master-container {
            display: flex;
            width: 100%;
            height: 100vh;
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
        }

        /* ===== LEFT SIDEBAR ===== */
        .sidebar-filters {
            width: 280px; 
            flex: 0 0 280px; 
            background: #fff;
            border-right: 1px solid #e1e8ed;
            display: flex;
            flex-direction: column;
            height: 100%;
            box-shadow: 2px 0 8px rgba(0,0,0,.05);
            z-index: 10;
        }

        .sidebar-scroll-content {
            flex: 1;
            overflow-y: auto;
            padding: 15px 15px 25px; 
        }

        /* Cards */
        .filter-card {
            background: #f8fafc;
            border: 1px solid #e3e8ee;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 12px;
        }

        /* Tables */
        .filter-table {
            width: 100%;
            border-spacing: 0 10px;
        }

        .filter-table .label-cell {
            text-align: right;
            padding-right: 10px;
            font-size: 12px;
            color: #4e5e71;
            font-weight: 600;
            width: 80px;
        }

        /* ===== UNIFORM 24px INPUTS & SELECTS ===== */
        input[type="text"], select, textarea,
        .filter-table input[type="text"],
        .filter-table select {
            width: 100%;
            height: 24px;             
            padding: 2px 8px;         
            border: 1px solid #ccd6e0;
            border-radius: 4px;       
            font-size: 12px;          
            background-color: #ffffff;
            box-sizing: border-box;
            color: #333;
            outline: none;
        }

        /* Readonly / disabled look */
        input[readonly],
        input:disabled,
        .filter-table input[readonly],
        .filter-table input:disabled {
            background-color: #ffffff !important;
            color: #333;
            border-color: #e1e8ed;
            cursor: pointer;
        }

        input::placeholder {
            color: #9aa4b2;
            opacity: 1;
        }

        input[type="checkbox"] {
            margin: 0;
            cursor: pointer;
            width: 14px;
            height: 14px;
            vertical-align: middle;
        }

        /* ===== BUTTONS ===== */
        .btn-submit {
            width: 100%;
            height: 30px;            
            padding: 0 12px;         
            background: #2563eb;
            color: #fff;
            border: none;
            border-radius: 4px;      
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            line-height: 30px;       
            transition: background 0.2s;
            text-align: center;
        }

        .btn-submit:hover {
            background: #1d4ed8;
        }

        .btn-clear {
            background: #64748b !important;
        }
        
        .btn-clear:hover {
            background: #475569 !important;
        }

        .btn-submit:disabled {
            background: #9ca3af !important;
            cursor: not-allowed;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: center;
        }

        /* ===== RIGHT CONTENT AREA ===== */
        .main-content-area {
            flex: 1; 
            display: flex;
            flex-direction: column;
            background: #ffffff;
            height: 100%;
            overflow: hidden;
        }

        .top-toolbar-container {
            width: 100%;
            padding: 10px 15px;
            background: #ffffff;
            border-bottom: 1px solid #e1e8ed;
            box-sizing: border-box;
        }

        .grid-content-container {
            flex: 1;
            padding: 15px;
            overflow: auto; 
            box-sizing: border-box;
            background: #fff;
        }

        /* Misc */
        #detlist, #rtariffchange {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             // Standardized height to 24px and width to 100%
             $("#jqxDateOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#jqxDaterentalout").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
                
             $('#clientwindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
             $('#clientwindow').jqxWindow('close');
             $('#ranowindow').jqxWindow({ width: '30%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'LA No. Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
             $('#ranowindow').jqxWindow('close');
              
             $('#clientname').dblclick(function(){
                  $('#clientwindow').jqxWindow('open');
                  clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
             });
             
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

             getConfigs();
               
             $('#rano').dblclick(function(){
                  $('#ranowindow').jqxWindow('open');
                  ranoSearchContent('ranosearch.jsp?', $('#ranowindow')); 
             });
              
             var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
             var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
             $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
             
             $('#todate').on('change', function (event) {
                   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
                   var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
                   if(fromdates>todates){
                       $.messager.alert('Message','To Date Less Than From Date ','warning');   
                       return false;
                  }    
             });
        });

        function getrano(event){
             var x= event.keyCode;
             if(x==114){
              $('#ranowindow').jqxWindow('open');
              ranoSearchContent('ranosearch.jsp?', $('#ranowindow'));    }
        } 
        function ranoSearchContent(url) {
             $.get(url).done(function (data) {
                 $('#ranowindow').jqxWindow('open');
                 $('#ranowindow').jqxWindow('setContent', data);
            }); 
        } 

        function getclinfo(event){
             var x= event.keyCode;
             if(x==114){
              $('#clientwindow').jqxWindow('open');
              clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    }
        } 
        function clientSearchContent(url) {
             $.get(url).done(function (data) {
                 $('#clientwindow').jqxWindow('open');
                 $('#clientwindow').jqxWindow('setContent', data);
            }); 
        } 

        function funreload(event)
        {
             var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
             var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
             if(fromdates>todates){
                 $.messager.alert('Message','To Date Less Than From Date ','warning');   
                 return false;
             } else {
                 var barchval = document.getElementById("cmbbranch").value;
                 var fromdate= $("#fromdate").val();
                 var todate= $("#todate").val(); 
                 $("#overlay, #PleaseWait").show();
                 $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&rano="+document.getElementById("hidrano").value);
             }
             disiem(); 
             $("#rtaiffchange").jqxGrid('clear');
        }

        function funcleardata()
        {
            document.getElementById("cldocno").value="";
            document.getElementById("rano").value="";
            document.getElementById("clientname").value="";
            $('#jqxDateOut').val(new Date());
            $('#jqxDaterentalout').val(new Date());
            document.getElementById("docnos").value="";
            document.getElementById("branchid").value="";
            document.getElementById("hidrano").value="";
            
             if (document.getElementById("clientname").value == "") {
                $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
            }
             if (document.getElementById("rano").value == "") {
                $('#rano').attr('placeholder', 'Press F3 TO Search'); 
            }
        }
            
        function funExportBtn(){
              $("#detlist").excelexportjs({
                    containerid: "detlist", 
                    datatype: 'json', 
                    dataset: null, 
                    gridId: "detailsgrid", 
                    columns: getColumns("detailsgrid") ,   
                    worksheetName:"LA Tarif Change Approval"
                    });
        }
            
        function funApprove()
        {
         var invdat=document.getElementById("invdate").value;
          $.messager.confirm('Message', 'Tariff Change Effective from '+invdat+'', function(r){
                if(r==false) {
                    return false; 
                } else{
                     if(document.getElementById("configmethod").value>0) {
                          if(document.getElementById("advchkval").value!=document.getElementById("advance_chk").value) {
                              $.messager.alert('Message', ' Please check the client invoice rule ');    
                              return 0;
                          }
                          if(document.getElementById("invval").value!=document.getElementById("cmbinvoicing_method").value) {
                              $.messager.alert('Message', ' Please check the client invoice rule ');    
                              return 0;
                          }
                     }
                    var rows = $("#rtaiffchange").jqxGrid('getrows'); 
                    var listss = new Array();
                    var a = 1;
                   for(var i=0 ; i < rows.length ; i++){
                         var rateval=rows[i].rate;
                            if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN"||rateval=="0.00") {
                                $.messager.alert('Message', ' Tariff Is Not Selected ');    
                                return 0;
                            }
                       listss.push(rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].kmrest+"::"+
                               rows[i].exkmrte+"::"+rows[i].oinschg+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+a+"::");  
                   }
                    save(listss); 
                }
            });
        }

        function save(listss)
        {
            var invoicevalue=document.getElementById("cmbinvoicing_method").value;
            var advance=document.getElementById("advance_chk").value;
            var btnclick="approve";
            var blexid=document.getElementById("blexid").value;
            var rdocno=document.getElementById("docnos").value;
            var invdate=document.getElementById("invdate").value;
            var branchid=document.getElementById("branchid").value; 
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200) {
                     var itemsapprove= x.responseText;
                     var itemvalappr=itemsapprove.trim();
                     
                  if(parseInt(itemvalappr)==1) {
                      $.messager.alert('Message', ' Record Approved Successfully ');
                     document.getElementById("blexid").value="";
                    document.getElementById("docnos").value="";
                    document.getElementById("advchkval").value="";
                     document.getElementById("invval").value="";
                    document.getElementById("configmethod").value="";
                    document.getElementById("advance_chk").value="";
                     document.getElementById("cmbinvoicing_method").value="1";
                    document.getElementById("advance_chk").checked = false;
                     document.getElementById("cldocno").value="";
                    document.getElementById("clientname").value="";
            document.getElementById("docnos").value="";
            document.getElementById("branchid").value="";
            document.getElementById("hidrano").value="";
            document.getElementById("rano").value="";
            document.getElementById("invdate").value="";        
                     funreload(event);
                    }
                else {
                    $.messager.alert('Message', '  Not Approved ', function(r){ });
                }  
            }
            }
             
            x.open("GET","savedata.jsp?list="+listss+"&invoicevalue="+invoicevalue+"&advance="+advance+"&blexid="+blexid+"&rdocno="+rdocno+"&btnclick="+btnclick+"&invdate="+invdate+"&branchid="+branchid);
            x.send();
        }

        function funCancel()
        {
            $.messager.confirm('Message', 'Do you want to Cancel?', function(r){
                if(r==false) {
                    return false; 
                } else {
                     var btnclick="cancel";
                   var blexid=document.getElementById("blexid").value;
                    var rdocno=document.getElementById("docnos").value;
                    var x=new XMLHttpRequest();
                    x.onreadystatechange=function(){
                        if (x.readyState==4 && x.status==200) {
                         var itemscancel= x.responseText;
                            var itemvalcan=itemscancel.trim();
                  if(parseInt(itemvalcan)==1) {
                      $.messager.alert('Message', ' Record Cancelled ');
                     document.getElementById("blexid").value="";
                    document.getElementById("docnos").value="";
                    document.getElementById("advchkval").value="";
                     document.getElementById("invval").value="";
                    document.getElementById("configmethod").value="";
                    document.getElementById("advance_chk").value="";
                     document.getElementById("cmbinvoicing_method").value="1";
                    document.getElementById("advance_chk").checked = false;
                    document.getElementById("cldocno").value="";
                    document.getElementById("clientname").value="";
            document.getElementById("docnos").value="";
                document.getElementById("branchid").value="";
                document.getElementById("hidrano").value="";
                document.getElementById("rano").value="";
                     funreload(event);
                    }
                    else {
                        $.messager.alert('Message', '  Not Cancelled ', function(r){ });
                    }  
                }
                }
                x.open("GET","savedata.jsp?blexid="+blexid+"&rdocno="+rdocno+"&btnclick="+btnclick);
                x.send();
                }
            });
        }

        function getConfigs(){
            $.get('getConfigs.jsp',function(data){
                data=JSON.parse(data);
                var htmldata='';
                    if(data.InvQuarterly=="1"){
                        htmldata+='<option value="4">Quarterly</option><option value="5">Half Yearly</option><option value="6">Yearly</option>';
                        $('#cmbinvoicing_method').append($.parseHTML(htmldata));
                        if($('#cmbinvoicing_method').val()!="")
                        {
                            $('#cmbinvoicing_method').val($('#hidcmbinvoicing_method').val());
                        } 
                    }
            });
        }

        function disiem()
        {
             $('#searchuser').attr("disabled",true);
             $('#approve').attr("disabled",true);
             $('#cancel').attr("disabled",true);
             $('#advance_chk').attr("disabled",true);
             $('#cmbinvoicing_method').attr("disabled",true);
        }
        </script>
    </head>

    <body onload="getBranch();disiem()">

        <div id="mainBG" class="homeContent">
            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Filters Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">From</td>
                                    <td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">To</td>
                                    <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Client</td>
                                    <td>
                                        <input type="text" name="clientname" id="clientname" 
                                               placeholder="Press F3 To Search" readonly="readonly" 
                                               onKeyDown="getclinfo(event);" 
                                               value='<s:property value="clientname"/>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">LA No.</td>
                                    <td>
                                        <input type="text" name="rano" id="rano"  
                                               placeholder="Press F3 To Search" readonly="readonly"    
                                               onkeydown="getrano(event)" 
                                               value='<s:property value="rano"/>'>
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="action-buttons">
                                <button type="button" class="btn-submit btn-clear" name="clear" id="clear" onclick="funcleardata();">Clear</button>
                            </div>
                        </div>

                        <!-- Approval Settings Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Advance</td>
                                    <td>
                                        <input type="checkbox" id="advance_chk" name="advance_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Invoice</td>
                                    <td>
                                        <select name="cmbinvoicing_method" id="cmbinvoicing_method" value='<s:property value="cmbinvoicing_method"/>'>
                                            <option value="">--Select--</option>
                                            <option value="1">Month End</option>
                                            <option value="2">Period</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>

                            <div class="action-buttons">
                                <button type="button" class="btn-submit" name="approve" id="approve" onclick="funApprove();">Approve</button>
                                <button type="button" class="btn-submit" name="cancel" id="cancel" onclick="funCancel();" style="background: #ef4444 !important;">Cancel</button>
                            </div>
                        </div>

                        <!-- Hidden Fields -->
                        <div style="display:none;">
                            <input type="hidden" name="hidrano" id="hidrano" value='<s:property value="hidrano"/>'>
                            <input type="hidden" id="hidcmbinvoicing_method" name="hidcmbinvoicing_method" value='<s:property value="hidcmbinvoicing_method"/>'/>
                            <div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
                            <div id='jqxDaterentalout' name='jqxDaterentalout' value='<s:property value="jqxDaterentalout"/>'></div> 
                            <input type="hidden" name="docnos" id="docnos" value='<s:property value="docnos"/>'>  
                            <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                            <input type="hidden" name="advchkval" id="advchkval" value='<s:property value="advchkval"/>'/>  
                            <input type="hidden" name="invval" id="invval" value='<s:property value="invval"/>' />
                            <input type="hidden" id="configmethod" name="configmethod" value='<s:property value="configmethod"/>' />
                            <input type="hidden" id="branchid" name="branchid" value='<s:property value="branchid"/>' >
                            <input type="hidden" id="blexid" name="blexid" value='<s:property value="blexid"/>' >
                            <input type="hidden" id="invdate" name="invdate" value='<s:property value="invdate"/>' >
                            <div id='paychaaaaa'></div>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRIDS) ================= -->
                <div class="main-content-area">
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        
                        <div id="detlist">
                            <jsp:include page="detailsGrid.jsp"></jsp:include>
                        </div>
                        
                        <div style="height:15px;"></div>
                        
                        <div id="rtariffchange">
                            <jsp:include page="ltariffdetails.jsp"></jsp:include>
                        </div>
                        
                    </div>
                </div>

            </div>
        </div>

        <!-- POPUPS -->
        <div id="clientwindow"><div></div></div>
        <div id="ranowindow"><div></div></div>

    </body>
</html>