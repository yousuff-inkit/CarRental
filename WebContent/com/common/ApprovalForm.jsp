<%@page import="com.common.ClsExeFolio" %>
<%ClsExeFolio cef=new ClsExeFolio(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" import="java.util.*" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
 <% String docNo = request.getParameter("docno")==null || request.getParameter("docno").equals("")?"0":request.getParameter("docno"); %>
 <% String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype"); %>  
 <% String brch = request.getParameter("brch")==null || request.getParameter("brch").equals("")?"0":request.getParameter("brch"); %>
 <% String userid = request.getParameter("userid")==null?"0":request.getParameter("userid");%>
 <% String aprstatus = request.getParameter("aprstatus")==null?"0":request.getParameter("aprstatus");%>
 <% String isfirstappr = request.getParameter("isfirstappr")==null?"0":request.getParameter("isfirstappr"); %>
 
 <style type="text/css">
    body {
        font-family: 'Segoe UI', Arial, sans-serif;
        background-color: #f0f4f8;
        margin: 0;
        padding: 20px;
        color: #2d3436;
    }

    .redClass { background-color: #FFEBEB; }
    .yellowClass { background-color: #FFFFD1; }
    .greyClass { background-color: #D8D8D8; }

    .main-container {
        display: flex;
        gap: 20px;
        max-width: 100%;
        margin: 0 auto;
    }

    .left-section {
        flex: 0 0 40%;
        background: #ffffff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .right-section {
        flex: 1;
        background: #ffffff;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        min-height: 600px;
    }

    .header-label {
        font-size: 20px;
        font-weight: 700;
        color: #4530f6;
        margin-bottom: 5px;
        border-bottom: 2px solid #f1f2f6;
        padding-bottom: 10px;
    }

    .field-label {
        font-weight: 600;
        font-size: 16px;
        color: #2d3436;
        margin-bottom: 5px;
        display: block;
    }

    input[type="text"], textarea {
        width: 100%;
        padding: 15px;
        font-size: 18px;
        border: 2px solid #dfe6e9;
        border-radius: 8px;
        box-sizing: border-box;
        background-color: #f9f9f9;
    }

    textarea {
        height: 150px !important;
        resize: none;
        background-color: #ffffff;
    }

select.list1 {
    width: 100%;
    padding: 10px 15px !important;
    font-size: 20px !important; 
    font-weight: 600;
    border: 2px solid #0984e3;
    border-radius: 8px;
    background-color: #ffffff !important;
    color: #2d3436 !important;
    cursor: pointer;
    height: auto !important;
    line-height: 1.5 !important;
    display: block !important;
}

select.list1 option {
    font-size: 18px !important;
    padding: 10px;
    background-color: #ffffff;
    color: #2d3436;
}

    .btn-row {
        text-align: right;
        margin-top: 10px;
    }

    .my {
        background-color: #4530f6;
        color: white;
        border: none;
        padding: 15px 50px;
        font-size: 20px;
        font-weight: 700;
        border-radius: 8px;
        cursor: pointer;
        transition: background 0.2s;
    }

    .my:hover {
        background-color: #074b83;
    }

    .flex-row {
        display: flex;
        gap: 15px;
    }

    #jqxApprovalGrid {
        width: 100% !important;
    }
.approval-locked #btnSend {
    display: none !important;
}

.approval-locked select,
.approval-locked textarea {
    pointer-events: none;
    background-color: #f0f0f0 !important;
    opacity: 0.7;
}
</style>

    <script type="text/javascript">
    
    // Global flag to track if this is a brand new document
    var isNewDocument = false; 

    $(document).ready(function(){
        getStatOpt();
        funcurdate();
        
        var data4='<%=cef.approvalGridload(session,dtype,brch,docNo)%>';
        Check(data4);
    });
    
    function Check(data4){
        if(document.getElementById("apprdesc")) { document.getElementById("apprdesc").closest("div").style.display = ""; }
        if(document.getElementById("btnSend")) { document.getElementById("btnSend").closest("div").style.display = ""; }

        if (!data4 || data4.trim() === "" || data4 === "null" || data4 === "[]") {
            data4 = "[]"; 
            isNewDocument = true; 
            $("#statusDropdownDiv").hide();
        } else {
            isNewDocument = false; 
            $("#statusDropdownDiv").show();
            $("#optname").val(""); 
        }

        var source =
          {
              datatype: "json",
              datafields: [
                        {name : 'apprtype', type: 'String'   },
                        {name : 'user_name', type: 'string'  }, 
                        {name : 'apprdatetime', type: 'string'   },
                        {name : 'remarks', type: 'string'   },
                        {name : 'apprlevel', type: 'string'   }
               ],
               localdata: data4, 
               pager: function (pagenum, pagesize, oldpagenum) { }
          };
          
        var cellclassname = function (row, column, value, data) {
            if (data.apprlevel==1) {
                  return "redClass";
            } else if (data.apprlevel==2) {
                  return "yellowClass";
            } else {
                return "greyClass";
            };
        };
          
        var dataAdapter = new $.jqx.dataAdapter(source, {
            loadError: function (xhr, status, error) {
                console.error("Grid Load Error: ", error);   
            }
        });
          
        $("#jqxApprovalGrid").jqxGrid(
        {
            width: '100%',
            height: 250,
            source: dataAdapter,
            columnsresize: true,
            editable: false,
            rowsheight:40,
            selectionmode: 'singlerow',
            columns: [
                { text: 'Type', datafield: 'apprtype',  width: '10%',cellclassname: cellclassname },
                { text: 'User', datafield: 'user_name', width: '15%',cellclassname: cellclassname },
                { text: 'Submit Time', datafield: 'apprdatetime', width: '12%',cellclassname: cellclassname },   
                { text: 'Remarks' , datafield: 'remarks', width: '63%',cellclassname: cellclassname },
                { text: 'ApprlLevel', datafield: 'apprlevel', hidden:true , width: '10%',cellclassname: cellclassname }
            ]
        }); 

         $('#jqxApprovalGrid').on('rowdoubleclick', function (event) 
              { 
               var rowindexes=event.args.rowindex;
               console.log("Double clicked row: " + rowindexes);
              }); 
        
         $('#jqxApprovalGrid').on('rowclick', function (event) 
              { 
               var rowindexes=event.args.rowindex;
               console.log("Clicked row: " + rowindexes);
              });
         $("#jqxApprovalGrid").jqxGrid('autoresizecolumns');
    }

    function saveApprlevel()  {  
        var currentLevel = $("#apprlevel").val();

        if(!isNewDocument && (currentLevel === "0" || currentLevel === "")) {
            $.messager.alert('Warning', 'You have no pending approval tasks for this document. It may already be fully approved.');
            $("#windowapprove").jqxWindow('Close');
            return false;
        }

        if($("#statusDropdownDiv").is(":visible")) {
            if($("#optname").val() === "" || $("#optname").val() === null) {
                alert("Please select a status (Approved, Rejected, Returned, etc.).");
                return false;
            }
        }

        setTimeout(function() {$("#btnSend").attr("disabled", true);},100);
        
        var uri=encodeURI('saveApprove.action?docno='+$("#hidocno").val()+'&dtype='+$("#hidtype").val()+'&userid='+$("#hiuserid").val()+'&brchid='+$("#hibrchid").val()+'&desc='+$("#apprdesc").val()+'&apprlevel='+$("#apprlevel").val()+'&minapprl='+$("#minapprl").val()+'&optid='+$("#optid").val()+'&apprlist='+$("#apprlist").val());

         $.ajaxFileUpload  
         (    
             {  
                 url: uri,
                 secureuri:false,
                 fileElementId:'file_hidden', 
                 dataType: 'text',
                 success: function (data, status)  
                 {  
                     if(status=='success'){   
                        $.messager.show({title:'Message',msg:'Transaction Completed',showType:'show',
                           style:{left:15,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                       });
                        $("#windowapprove").jqxWindow('Close');
                     }
                     
                     if(typeof(data.error) != 'undefined')  
                     {  
                         if(data.error != '')  
                         {  
                             $.messager.show({title:'Message',msg: data.error,showType:'show',
                               style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                           }); 
                         }
                     }  
                 },  
                 error: function (data, status, e)
                 {  
                     $.messager.alert('Message',e);
                     $("#btnSend").attr("disabled", false);
                 }  
             }  
         )  
         return false;  
     }

    function funcurdate(){
        var currentdate=new Date();
        var date = currentdate.getDate()+ "/"+ (currentdate.getMonth()+1)+ "/"+currentdate.getFullYear(); 
        var time= currentdate.getHours() + ":"+currentdate.getMinutes();
        
        document.getElementById("apprdate").value=date;
        document.getElementById("apprtime").value=time;
        document.getElementById("hidocno").value='<%=docNo%>';
        document.getElementById("hidtype").value='<%=dtype%>';
        document.getElementById("hiuserid").value='<%=userid%>';
        document.getElementById("hibrchid").value='<%=brch%>';
        getapprlevel();
    }
    
    function getapprlevel(){
        var docno=document.getElementById('hidocno').value;
        var dtype=document.getElementById('hidtype').value;
        var brch='<%=brch%>';
        var usrid='<%=userid%>';
        var isfirstappr='<%=isfirstappr%>';
        
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var items = x.responseText.split('####');
                if(items.length > 4) {
                	var apprlevel = items[1] ? items[1].trim() : "0";
                    var minapprl  = items[2] ? items[2].trim() : "0";
                    var apprlist  = items[3] ? items[3].trim() : "";
                    var globalAprStatus = items[4] ? items[4].trim() : "0";
                    
                    var urlStatus = '<%=aprstatus%>'.trim();
                    if(urlStatus === "1" || urlStatus === "0") {
                        globalAprStatus = urlStatus;
                    }

                    $("#minapprl").val(minapprl);
                    $("#apprlist").val(apprlist);
                    $("#hidAprStatus").val(globalAprStatus);
                    
                    var numericLevel = parseInt(apprlevel, 10);

                    // --- FIX: Strict View-Only UI Logic ---
                    if (isNewDocument) {
                        // 1. BRAND NEW DOCUMENT - Allow Submission to start workflow
                        apprlevel = "0";
                        $("#apprlevel").val("0");
                        $("#minapprl").val("0"); 
                        
                        $("#btnSend").show().text("Submit to Workflow");
                        $("#statusDropdownDiv").hide();
                        $("#apprdesc").prop("disabled", false);
                        
                        if ($('#optname option[value="Forward"]').length === 0) {
                            $('#optname').append('<option value="Forward">Forward</option>');
                        }
                        $("#optname").val("Forward"); 
                        $("#optid").val("0"); 
                        
                    } else if (numericLevel === 0) {
                        // 2. EXISTING DOCUMENT, BUT NOT THIS USER'S TURN - Lock it down!
                        // This fixes the bug where Level 2 opens it while it's waiting for Level 1.
                        $("#apprlevel").val("0");
                        $("#btnSend").hide();
                        $("#statusDropdownDiv").hide();
                        $("#apprdesc").prop("disabled", true);
                        
                    } else {
                        // 3. EXISTING DOCUMENT AND IT IS THIS USER'S TURN - Show dropdown
                        $("#apprlevel").val(apprlevel);
                        $("#btnSend").show().text("SUBMIT");
                        $("#statusDropdownDiv").show();
                        $("#apprdesc").prop("disabled", false);
                        
                        if($("#optname").val() === "Forward") {
                            var firstRealOption = $("#optname option:first").val();
                            $("#optname").val(firstRealOption); 
                            getStat(firstRealOption);
                        }
                    }
                    
                    // 4. OVERRIDE FOR FULLY APPROVED/REJECTED DOCUMENTS
                    if (globalAprStatus === "3" || globalAprStatus === "4") {
                        document.body.classList.add("approval-locked");
                        $("#btnSend").hide();
                        $("#statusDropdownDiv").hide();
                        $("#apprdesc").prop("disabled", true);
                    } else {
                        document.body.classList.remove("approval-locked");
                    }
                    
                    console.log("isNewDoc=" + isNewDocument + " apprlevel=" + apprlevel + " locked status=" + globalAprStatus);
                }
            }
        }
        x.open("GET", "<%=contextPath%>/com/common/getApprLevel.jsp?docno="+docno+"&dtype="+dtype+"&brch="+brch+"&usrid="+usrid+"&isfirstappr="+isfirstappr,true);
        x.send();
    }
    
    function getStat(c){
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var items= x.responseText;
                items = items.split('####');
                if(items.length > 2) {
                    var refdocno = items[2].split(",");
                    document.getElementById("optid").value=refdocno;
                }
            }
        }
        x.open("GET", "<%=contextPath%>/com/common/getStat.jsp?opt_name="+c,true);
        x.send();
    }
    
    function getStatOpt() {   
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {  
                var items= x.responseText;
                items=items.split('####');
                
                var refname=items[0].split(",");
                var optionref = '<option value="">-- Choose Status --</option>'; 
                for ( var i = 0; i < refname.length; i++) {
                    if(refname[i] !== "") {
                        optionref += '<option value="' + refname[i] + '">' + refname[i] + '</option>';
                    }
                }
                $("select#optname").html(optionref); 
                
                if(refname.length > 0) {
                    var firstValidOption = refname[0];
                    $("select#optname").val(firstValidOption);
                    getStat(firstValidOption);
                }
            }
        }
        x.open("GET", "<%=contextPath%>/com/common/getStatOpt.jsp",true);
        x.send();
    }
    </script>
    
<body>

<div id="search">
    <input type="file" id="file_hidden" name="file" style="display:none;">

    <div class="main-container">
        <div class="left-section">
            <div class="header-label">Approval Details</div>
            
            <div class="flex-row">
                <div style="flex: 1;">
                    <label class="field-label">Date</label>
                    <input type="text" name="apprdate" id="apprdate" readonly>
                </div>
                <div style="flex: 1;">
                    <label class="field-label">Time</label>
                    <input type="text" name="apprtime" id="apprtime" readonly>
                </div>
            </div>

            <div>
                <label class="field-label">Remarks / Description</label>
                <textarea maxlength="540" id="apprdesc" name="apprdesc"><s:property value="apprdesc" ></s:property></textarea>
            </div>

            <div id="statusDropdownDiv" style="display: none;">
                <label class="field-label">Status</label>
                <select name="optname" class="list1" id="optname" onchange="getStat(this.value);">
                    <option value="">-- Choose Status --</option>
                    <option value="Approved">Approved</option>
                    <option value="Rejected">Rejected</option>
                    <option value="Returned">Returned</option>
                </select>
            </div>

            <div class="btn-row">
                <button class="my" type="button" id="btnSend" name="btnSend" onClick="saveApprlevel()">SUBMIT</button>
            </div>
        </div>

        <div class="right-section">
            <div class="header-label">Approval Queue / History</div>
            <div id="refreshdiv">
                <div id="jqxApprovalGrid"></div>
            </div>
        </div>

    </div>

    <input type="hidden" id="optid"/>
    <input type="hidden" id="hidtype"/>
    <input type="hidden" id="hidocno"/>
    <input type="hidden" id="hiuserid"/>
    <input type="hidden" id="hibrchid"/>
    <input type="hidden" id="apprlevel"/>
    <input type="hidden" id="minapprl"/>
    <input type="hidden" id="apprlist"/>
    <input type="hidden" id="hidAprStatus"/>
    
</div>

</body>
</html>