<%@page import="com.controlcentre.masters.vehiclemaster.vehtype.*" %>
<%ClsVehTypeDAO dao=new ClsVehTypeDAO();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>GatewayERP(i)</title>
		<jsp:include page="../../../../includes.jsp"></jsp:include>
		<style>
			form label.error {
				color:red;
			  	font-weight:bold;
			}
		</style>
		<script type="text/javascript">
			var data='<%=dao.getVehTypeData("1")%>';

      		$(document).ready(function (){   
    	  		$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
    	  
    	  		document.getElementById("formdet").innerText="Vehicle Type(VTP)";
  		  		document.getElementById("formdetail").value="Vehicle Type";
  		  		document.getElementById("formdetailcode").value="VTP";
		  		window.parent.formName.value="Vehicle Type";
  				window.parent.formCode.value="VTP";    	  
          		var source =
          		{
              		datatype: "json",
              		datafields: [
                    	{name : 'doc_no' , type: 'number' },
                        {name : 'date', type: 'date'  },
                        {name : 'name',type:'String'}
               		],
               		localdata: data,
		            pager: function (pagenum, pagesize, oldpagenum) {
		            	// callback called when a page or page size is changed.
		            }
          		};
          
          		var dataAdapter = new $.jqx.dataAdapter(source,
          			{
              			loadError: function (xhr, status, error) {
	                		// alert(error);    
	                	}
		        	}		
          		);
          		$("#vehTypeGrid").jqxGrid(
                {
                	width: '100%',
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                    sortable: true,
                    altrows:true,
                    columns: [
      					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
      					{ text: 'Vehicle Type',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '70%' },
      					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
      	            ]
                });
     
          		$('#vehTypeGrid').on('rowdoubleclick', function (event) 
          		{ 
		        	var rowindex1=event.args.rowindex;
		            document.getElementById("docno").value= $('#vehTypeGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		            document.getElementById("name").value = $("#vehTypeGrid").jqxGrid('getcellvalue', rowindex1, "name");
		            $('#date').jqxDateTimeInput({ disabled: false});
		            $("#date").jqxDateTimeInput('val', $("#vehTypeGrid").jqxGrid('getcellvalue', rowindex1, "date")); 
		            $('#date').jqxDateTimeInput({ disabled: true});
          		}); 
      		});
     
      		function funSearchLoad(){
				changeContent('vehTypeSearchGrid.jsp?id=1', $('#window')); 
		 	}

			function funReadOnly(){
				$('#frmVehType input').attr('readonly', true );
				$('#date').jqxDateTimeInput({ disabled: true}); 	
				$("#vehTypeGridDiv").jqxGrid({ disabled: true}); 	
			}
			function funRemoveReadOnly(){
				$('#frmVehType input').attr('readonly', false );
				$("#vehTypeGridDiv").jqxGrid({ disabled: false}); 
				$('#date').jqxDateTimeInput({ disabled: false});
				$('#docno').attr('readonly', true);
				if($("#mode").val() == "A"){
					$('#vehTypeGridDiv').jqxGrid('clear');
				}
				if ($("#mode").val() == "A" || $("#mode").val() == "E") {
					$("#vehTypeGridDiv").jqxGrid('addrow', null, {});
				}
				
			}
			function setValues() {
				if($('#msg').val()!=""){
					$.messager.alert('Message',$('#msg').val());
				}
				 var maindoc=document.getElementById("docno").value;
				  if(maindoc>0)
					  {
					  $("#vehTypeGridMain").load("vehtypegrid.jsp?rdocno="+maindoc+"&chk=1");
					  }
			}
			
			function funFocus(){
				document.getElementById("name").focus();
			}
			function funNotify(){
				var rows = $("#vehTypeGridDiv").jqxGrid('getrows');
				var lengthupdate=0;
				 for(var i=0 ; i < rows.length ; i++){
					 var chka=rows[i].name;
					 var chkt=rows[i].tyre;
		  				if((typeof(chkt) != "undefined" && typeof(chkt) != "NaN" && chkt != "") && (typeof(chka) != "undefined" && chka != "")){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+lengthupdate)
					    .attr("name", "test"+lengthupdate)
					    .attr("hidden", "true");
						
					newTextBox.val(rows[i].name+" :: "+rows[i].tyre+" :: "+rows[i].rowno+" :: ");
					newTextBox.appendTo('form');
					lengthupdate=lengthupdate+1;
					}
	  			  }
				 if(lengthupdate<=0) {
					 $.messager.alert('Message','Please enter tyre and axle details','warning');
					 return 0;
				 }
				$('#gridlength').val(lengthupdate);
				$('#deletedrows').val(deleted);
				return 1;
			}
			
			function funload(){
				$("#vehTypeGridMain").load("vehtypegrid.jsp?chk="+aa);
			}
			
	    	$(function(){
	        	$('#frmVehType').validate({
	            	rules: {
	                	name: {
	                		required:true,
	                		maxlength:45
	                 	}
	                },
	                messages: {
	                	name:{
	                		required:" *",
	                	  	maxlength:"max 45 chars"
	                  	}
	               	}
	        	});
	       	});
	    	
	    	function funExcelBtn(){
	    		//$("#vehTypeGrid").jqxGrid('exportdata', 'xls', 'Authority');
	    	}
		</script>
	</head>
	<body onload="setValues();" >
		<div id="mainBG" class="homeContent" data-type="background">
			<form id="frmVehType" action="saveActionVehType" autocomplete="off">     
				<jsp:include page="../../../../header.jsp" />
				<fieldset><legend>Vehicle Type Details</legend>
					<table width="100%">
						<tr>
							<td width="6%" align="right">Date</td>
						  	<td width="21%"><div id="date" name="date"></div></td>
						  	<td width="6%">&nbsp;</td>
						  	<td>&nbsp;</td>
						  	<td width="30%"><div align="right">Doc No    </div></td>
						  	<td width="16%"><input type="text" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>'></td>
						</tr>
						<tr>
  							<td colspan="1" align="right">Name</td>
  							<td colspan="2"><input type="text" name="name" id="name" value='<s:property value="name"/>'style="width:85%;"></td>
  						</tr>
					</table>
				</fieldset>
				<table style="width:100%;">
					<tr><td><div id="vehTypeGridMain"><jsp:include page="vehtypegrid.jsp"></jsp:include></div></td></tr>
					<tr><td><div id="vehTypeGrid" hidden=true></div></td></tr>
				</table>
				<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
				<input type="hidden" id="mode" name="mode"/>
				<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>
				<input type="hidden" id="deletedrows" name="deletedrows" value='<s:property value="deletedrows"/>'/>
			</form>
			
			
		</div>
	</body>
</html>