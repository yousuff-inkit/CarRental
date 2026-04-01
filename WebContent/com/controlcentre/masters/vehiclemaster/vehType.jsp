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
/* =========================================================
SCOPED UI: Compact Input Sizing (Plain Colors)
*Note: All rules strictly scoped to .modern-ui so header.jsp is safe*
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding-top: 15px;
    box-sizing: border-box; 
}

/* Master Input Heights - Set to 24px */ 
.modern-ui input[type="text"], 
.modern-ui select, 
.modern-ui textarea {
    height: 24px !important; 
    border: 1px solid #ccc; 
    border-radius: 3px;
    padding: 2px 6px; 
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
}

/* Compact Width Classes */
.modern-ui .input-xs { width: 60px !important; }
.modern-ui .input-sm { width: 100px !important; }
.modern-ui .input-md { width: 140px !important; }
.modern-ui .input-lg { width: 220px !important; }
.modern-ui .input-xl { width: 350px !important; }
.modern-ui .input-full { width: 100% !important; }

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus, 
.modern-ui textarea:focus { 
    border-color: #007bff;
    outline: none;
}

.modern-ui input[readonly], 
.modern-ui textarea[readonly], 
.modern-ui select:disabled, 
.modern-ui input:disabled { 
    background-color: #f3f4f6;
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right {
    text-align: right; 
    color: #444; 
    font-size: 12px;
    font-weight: bold; 
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #e1e4e8; 
    padding: 20px 10px 10px 10px; 
    background: #fff;
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -10px;
    left: 10px; 
    background: #fff; 
    padding: 0 5px 0 6px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

.modern-ui #vehTypeGridMain {
    margin-top: 10px;
}
</style>

		<script type="text/javascript">
			var data='<%=dao.getVehTypeData("1")%>';

      		$(document).ready(function (){   
      	 		/* Upgraded height to 24px for Modern UI */
      	 		$("#date").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"}); 
      	 		
      	 		/* Force internal alignment AFTER render */
			    setTimeout(function () {
			        $(".jqx-datetimeinput").find("input").css({
			            "margin-top": "0px", 
			            "line-height": "24px", 
			            "font-size": "12px", 
			            "font-family": "Arial, sans-serif",
			            "padding": "0 6px", 
			            "box-sizing":"border-box"
			        });
			        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
			    }, 0);
      	  
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
                	width: '200%',
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
		<div class="homeContent" data-type="background">
			<form id="frmVehType" action="saveActionVehType" autocomplete="off">     
				
				<jsp:include page="../../../../header.jsp" />
				
				<div class="modern-ui">

					<div class="middle-panel">
		                <span class="middle-panel-title">Vehicle Type Details</span>
		                <div style="padding-top: 5px;">
		
		                    <div class="field-row">
		                        
		                        <label class="lbl-right" style="width: 60px;">Date</label>
		                        <div style="width: 125px;">
		                        	<div id="date" name="date"></div>
		                        </div>
		                        
		                        <div style="margin-left: 50px; display: flex; align-items: center; gap: 8px;">
		                            <label class="lbl-right" style="width: 60px;">Doc No</label>
		                            <input type="text" name="docno" id="docno" class="input-sm" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1">
		                        </div>
		                    </div>
		
		                    <div class="field-row" style="margin-bottom: 0;">
		                        <label class="lbl-right" style="width: 60px;">Name</label>
		                        <input type="text" name="name" id="name" value='<s:property value="name"/>' style="width: 250px !important;">
		                    </div>
		
		                </div>
		            </div>

					<div id="vehTypeGridMain" style="width:100%"><jsp:include page="vehtypegrid.jsp"></jsp:include></div>
					<div id="vehTypeGrid" hidden=true></div>
					
					<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
	        		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
					<input type="hidden" id="mode" name="mode"/>
					<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>
					<input type="hidden" id="deletedrows" name="deletedrows" value='<s:property value="deletedrows"/>'/>
					
				</div>
			</form>
		</div>
	</body>
</html>