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

<%@page import="com.humanresource.setup.hrsetup.companysetup.ClsCompanysetupDAO"%>
<% ClsCompanysetupDAO DAO = new ClsCompanysetupDAO(); %>


<script type="text/javascript"> 

	$(document).ready(function () {    
		
		    document.getElementById("formdet").innerText="Company Setup(CMS)";
			document.getElementById("formdetail").value="Company Setup";
			document.getElementById("formdetailcode").value="CMS";
			window.parent.formCode.value="CMS";
			window.parent.formName.value="Company Setup";
			
			
		    $("#compdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
		 
		    
		    $('#compWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '27%' , title: 'Company Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 		 $('#compWindow').jqxWindow('close');
	 		 
		    
		    $('#establishedCodeDetailsWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Establishment Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 		 $('#establishedCodeDetailsWindow').jqxWindow('close');
	  		
	 		$('#company').dblclick(function(){
	 			compSearchContent("companydetailsGrid.jsp");
			  });
	 		
		    $('#estcode').dblclick(function(){
		    	 establishedCodeSearchContent("establishmentCodeDetailsSearchGrid.jsp");
			 });

	   
		    var deptdata= '<%=DAO.loadgrid() %>'; 
	  var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'estcode', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'company', type: 'String'  },
                        	{name : 'remarks', type: 'String'  }
                            
                 ],
               	 localdata: deptdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
	    
	        var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#companygrid").jqxGrid(
                  {
                  	width: "100%",
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                        
                    columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'EST Code',columntype: 'textbox', filtertype: 'input', datafield: 'estcode', width: '15%' },
	        					{ text: 'Company',columntype: 'textbox', filtertype: 'input', datafield: 'company',width:'30%' },
	        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks' },
	             	           
	        					]
                    });
	}); 

       function getEstablishmentCode(event){
     	        var x= event.keyCode;
	        if(x==114){
	        	establishedCodeSearchContent("establishmentCodeDetailsSearchGrid.jsp");
	        }
	        else{}
	        }
	    
		function establishedCodeSearchContent(url) {
		 	$('#establishedCodeDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#establishedCodeDetailsWindow').jqxWindow('setContent', data);
			$('#establishedCodeDetailsWindow').jqxWindow('bringToFront');
		}); 
		}
	  
	    function getcomp(event){
	          var x= event.keyCode;
	          if(x==114){
	        	  compSearchContent("companydetailsGrid.jsp");
	          }
	          else{}
	          }
	   
	    function compSearchContent(url) {
			$('#compWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#compWindow').jqxWindow('setContent', data);
			$('#compWindow').jqxWindow('bringToFront');
		}); 
		}
	    
		function funReadOnly() {
			$('#frmcompanysetup input').attr('readonly', true);
		 
		}
		function funRemoveReadOnly() {
			$('#frmcompanysetup input').attr('readonly', false);
		}
	
		function setValues(){
			if($('#datehidden').val()){
				$("#compdate").jqxDateTimeInput('val', $('#datehidden').val());
			}
			
			if($('#msg').val()!=""){
				  $.messager.alert('Message',$('#msg').val());
			}
		}
	 
		function funNotify(){
        	if(document.getElementById("company").value=="") {
        		
        		document.getElementById("errormsg").innerText=" Enter Company";
        		document.getElementById("company").focus();
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
<form id="frmcompanysetup" action="saveCompanysetup" method="post" autocomplete="off">
 <jsp:include page="../../../../../header.jsp" /><br/>

<fieldset><legend>Company Setup</legend> 
<table width="100%">
	<tr><td  width="10%" align="right">Date</td>
	<td  width="15%" align="left"><div id="compdate" name="compdate" value='<s:property value="compdate"/>'> </div></td>
	<td   width="12%" align="right">Company</td>
  	<td width="20%"><input type="text" name="company" id="company" style="width:100%;" placeholder="Press F3 to Search" value='<s:property value="company"/>'></td>
	<td   width="12%" align="right">Est Code</td>
  	<td width="12%"><input type="text" name="estcode" id="estcode" style="width:100%;" placeholder="Press F3 to Search"  value='<s:property value="estcode"/>'></td>
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
    <tr><td><div id="companygrid"></div></td></tr>
</table><br/>

<div id="establishedCodeDetailsWindow">
   <div></div></div>	
<div id="compWindow">
   <div></div></div>
</body>
</html>
