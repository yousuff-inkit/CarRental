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
.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}
.rowheight{
    height:366px;
}
</style>
<script type="text/javascript">  
     $(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 var year = window.parent.txtaccountperiodfrom.value;
		 var newDate = year.split('-');
		 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		 $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
	     
		 $("#branchlabel").attr('hidden',true);
		 $("#branchdiv").attr('hidden',true);
	});
	 
     function funreload(event) {
    	    var branchval = document.getElementById("cmbbranch").value;
    	    var fromdate = $('#fromdate').val();
    	    var todate = $('#todate').val();
    	    var check = 1;

    	    $("#overlay, #PleaseWait").show();
    	    $("#ratioDiv").load("ratioanalysisGrid.jsp?branchval=" + branchval + '&fromdate=' + fromdate + '&todate=' + todate + '&check=' + check);    
    	}
  
     function funExportBtn() {  
    	    if (parseInt(window.parent.chkexportdata.value) == "1") {   
    	    	JSONToCSVCon1(data, 'RatioAnalysis', true);
    	    } else {
    	        $("#jqxRatioGrid").jqxTreeGrid('exportData', 'xls');   
    	    }
    	} 
     function JSONToCSVCon1(JSONData, ReportTitle, ShowLabel) {    
    	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    	    var CSV = '';    
    	    CSV += ReportTitle + '\r\n\n';
    	    if (ShowLabel) {
    	        var row = "";
    	        for (var index in arrData[0]) {
    	        	//console.log("index="+index)
    	        	if(index=="description" || index=="group1"){
    	        		if(index=="description"){ 
    	        			index = "Description";
    	        		}
    	        		if(index=="group1"){ 
    	        			index = "Percentage";
    	        		}
    	        		row += index + ',';   
    	        	}
    	        }
    	        row = row.slice(0, -1);
    	        CSV += row + '\r\n';
    	    }
    	    for (var i = 0; i < arrData.length; i++) {
    	        var row = "";
    	        for (var index in arrData[i]) {
    	        	//console.log(index+"=index_inner="+arrData[i][index]) 
    	        	if(index=="description" || index=="group1"){  
    	            	row += '"' + arrData[i][index] + '",';
    	        	}
    	        }
    	        row.slice(0, row.length - 1);    
    	        CSV += row + '\r\n';
    	    }
    	    if (CSV == '') {        
    	        alert("Invalid data");
    	        return;
    	    }   
    	    var fileName = "";
    	    fileName += ReportTitle.replace(/ /g,"_");   
    	    var temp = CSV;
    	    blob = new Blob([temp],{type: 'text/csv'});
    	    var bigcsv= window.webkitURL.createObjectURL(blob);
    	    var link = document.createElement("a");    
    	      link.href = bigcsv;
    	    link.style = "visibility:hidden";
    	    link.download = fileName + ".csv";
    	    document.body.appendChild(link);
    	    link.click();
    	    document.body.removeChild(link);
    	}
</script>
</head>
<body onload="getBranch();">
   <div id="mainBG" class="homeContent" data-type="background">
      <div class='hidden-scrollbar'>
         <table width="100%" >
            <tr>
               <td width="20%" >
                  <fieldset style="background: #ECF8E0;">
                     <table width="100%"  >
                        <jsp:include page="../../heading.jsp"></jsp:include>
                        <tr>
                           <td colspan="2">
                              <table width="100%">
                                 <tr>
                                    <td align="right"><label class="branch">Period</label></td>
                                    <td align="left">
                                       <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                                    </td>
                                 </tr>
                              </table>
                        </tr>
                        <tr>
                           <td colspan="2">
                              <div id="viewDiv">
                                 <table width="100%">
                                    <tr>
                                       <td colspan="2">
                                          <table width="100%">
                                             <tr>
                                                <td width="17%" align="right"><label class="branch">To</label></td>
                                                <td width="83%" align="left">
                                                   <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                                                </td>
                                             </tr>
                                          </table>
                                       </td>
                                    </tr>
                                 </table>
                              </div>
                           </td>
                        </tr>
                        <tr>
                           <td colspan="2" class="rowheight">&nbsp;</td>
                        </tr>
                     </table>
                  </fieldset>
               </td>
               <td width="80%">
                  <table width="100%">
                     <tr>
                        <td>
                           <div id="ratioDiv"> <jsp:include page="ratioanalysisGrid.jsp"></jsp:include> </div>
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
         </table>
      </div>
   </div>
</body>
</html>