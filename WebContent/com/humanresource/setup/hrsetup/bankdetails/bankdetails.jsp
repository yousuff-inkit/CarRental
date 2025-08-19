<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>

<%@page import="com.humanresource.setup.hrsetup.bankdetails.ClsBankdetailsDAO"%>
<% ClsBankdetailsDAO DAO = new ClsBankdetailsDAO(); %>
<script type="text/javascript">

	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Bank Details(BDS)";
		document.getElementById("formdetail").value="Bank Details";
		document.getElementById("formdetailcode").value="BDS";
		window.parent.formCode.value="BDS";
		window.parent.formName.value="Bank Details";
		
		$("#bankdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
		 
	    
	    $('#ifsccodeWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '27%' , title: 'IFSC Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#ifsccodeWindow').jqxWindow('close');
 		 
	    
	    $('#brchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Branch Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#brchWindow').jqxWindow('close');
  		
 		$('#brchname').dblclick(function(){
 			brchSearchContent("branchdetailsGrid.jsp");
		  });
 		
	    $('#ifsccode').dblclick(function(){
	    	ifsccodeSearchContent("ifsccodedetailsGrid.jsp");
		 });

     
	    var deptdata= '<%=DAO.loadgrid() %>'; 
  
	    var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'ifsccode', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'brchname', type: 'String'  },
                        	{name : 'remarks', type: 'String'  }
                 ],
               	 localdata: deptdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
	    
	        var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#bankgrid").jqxGrid(
                  {
                  	width: "100%",
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                        
                    columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'IFSC Code',columntype: 'textbox', filtertype: 'input', datafield: 'ifsccode', width: '15%' },
	        					{ text: 'Branch Name',columntype: 'textbox', filtertype: 'input', datafield: 'brchname',width:'30%' },
	        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks' },
	             	           
	        					]
                    });
	}); 

            
            function getbrchname(event){
     	        var x= event.keyCode;
	        if(x==114){
	        	brchSearchContent("branchdetailsGrid.jsp");
	        }
	        else{}
	        }
	    
		function brchSearchContent(url) {
		 	$('#brchWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#brchWindow').jqxWindow('setContent', data);
			$('#brchWindow').jqxWindow('bringToFront');
		}); 
		}
	  
	    function getifsccode(event){
	          var x= event.keyCode;
	          if(x==114){
	        	  ifsccodeSearchContent("ifsccodedetailsGrid.jsp");
	          }
	          else{}
	          }
	   
	    function ifsccodeSearchContent(url) {
			$('#ifsccodeWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#ifsccodeWindow').jqxWindow('setContent', data);
			$('#ifsccodeWindow').jqxWindow('bringToFront');
		}); 
		}
	    
            function funReadOnly() {
    			$('#frmbankdetails input').attr('readonly', true);
    		 
    		}
    		function funRemoveReadOnly() {
    			$('#frmbankdetails input').attr('readonly', false);
    		}
    	
    		function setValues(){
    			if($('#datehidden').val()){
    				$("#bankdate").jqxDateTimeInput('val', $('#datehidden').val());
    			}
    			
    			if($('#msg').val()!=""){
    				  $.messager.alert('Message',$('#msg').val());
    			}
    		}
    	 
    		function funNotify(){
            	if(document.getElementById("brchname").value=="") {
            		
            		document.getElementById("errormsg").innerText=" Enter Branch Name";
            		document.getElementById("brchname").focus();
            		return 0;
            	}
        		return 1;
    	}
    		 function funFocus(){
    			 
    		 }
    		 
    		 function funSearchLoad(){
    			 changeContent('loadsearchGrid.jsp'); 
    		 }

	
	</script>   
	 
	</head>
	<body onLoad="setValues();" >
<form id="frmbankdetails" action="saveBankdetails" method="post" autocomplete="off">
 <jsp:include page="../../../../../header.jsp" /><br/>

<fieldset><legend>Bank Details</legend> 
<table width="100%">
	<tr><td  width="10%" align="right">Date</td>
	<td  width="15%" align="left"><div id="bankdate" name="bankdate" value='<s:property value="bankdate"/>'> </div></td>
	<td   width="12%" align="right">Branch Name</td>
  	<td width="20%"><input type="text" name="brchname" id="brchname" style="width:100%;" placeholder="Press F3 to Search" value='<s:property value="brchname"/>'></td>
	<td   width="12%" align="right">IFSC Code</td>
  	<td width="12%"><input type="text" name="ifsccode" id="ifsccode" style="width:100%;" placeholder="Press F3 to Search" value='<s:property value="ifsccode"/>'></td>
	<td  width="10%" align="right">Doc No</td>
	<td  width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td>
	<td  width="9%" >&nbsp;</td></tr> 
	<tr><td align="right">Remarks</td>
	<td colspan="4"><input type="text" name="remarks" id="remarks"  style="width:80%;" placeholder="Remarks" value='<s:property value="remarks"/>' ></td></tr>
</table>
</fieldset> 

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 

</form>

<table width="100%">
    <tr><td><div id="bankgrid"></div></td></tr>
</table><br/>

<div id="brchWindow">
   <div></div></div>	
<div id="ifsccodeWindow">
   <div></div></div>

</body>
</html>
