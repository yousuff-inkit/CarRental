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
            background-color: #f3f6f9 !important;
            color: #555;
            border-color: #e1e8ed;
            cursor: pointer;
        }

        input::placeholder {
            color: #9aa4b2;
            opacity: 1;
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
        #detlist, #detaildiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
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
            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
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
                            
                            <div class="action-buttons">
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
                        
                        <div id="detaildiv">
                            <jsp:include page="detailgrid.jsp"></jsp:include>
                        </div>
                        
                    </div>
                </div>

            </div>
        </div>

        <!-- POPUPS -->
        <div id="clientwindow"><div></div></div>
        <div id="fleetwindow"><div></div></div>

    </body>
</html>