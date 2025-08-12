<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include> 
<% String contextPath=request.getContextPath();%>
<html lang="en">
<head>
<style type="text/css">
	.icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
	}
        
</style>
<script type="text/javascript">
   
   $(document).ready(function () {
		
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	   $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../icons/31load.gif'/></div>");
          			
    });
   
   function funExportsBtn(){
		$("#clientListDiv").excelexportjs({
			containerid: "clientListDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "client", 
			columns: getColumns("client") ,   
			worksheetName:"Client"
			});
	} 
	
	 function funLoadData() {
		 
	  	var aa="load";
	  	  	   
	  	$("#overlay, #PleaseWait").show();
	  	$("#clientListDiv").load("clientListGrid.jsp?check="+aa);
	  }
	 
    </script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<button type="button" class="icon" id="excelExport" onclick="funExportsBtn();" title="Export Excel">
 <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<button type="button" class="icon" id="btnSubmit" title="Load" onclick="funLoadData();">
							<img alt="Load" src="<%=contextPath%>/icons/submit_new.png">
						</button>&nbsp;&nbsp;&nbsp;&nbsp;
	<table width="100%">
		<tr>
			 <td><div id="clientListDiv"><jsp:include page="clientListGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>

</div>
</div>
</body>
</html>
 