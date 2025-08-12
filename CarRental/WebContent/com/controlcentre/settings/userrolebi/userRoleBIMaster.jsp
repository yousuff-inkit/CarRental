<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>

<script type="text/javascript">
      
		$(document).ready(function() {
			$('#btnclone').hide();
			 $('#userRoleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User-Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
			 $('#userRoleDetailsWindow').jqxWindow('close');
		});
		
		function userRoleSearchContent(url) {
		    $('#userRoleDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#userRoleDetailsWindow').jqxWindow('setContent', data);
			$('#userRoleDetailsWindow').jqxWindow('bringToFront');
		}); 
		}
		
		function funReadOnly(){
			$('#frmUserRoleBIMaster input').attr('readonly', true );
			$("#jqxUserRoleBI").jqxGrid({ disabled: true});
		}
		
		function funRemoveReadOnly(){
			$('#frmUserRoleBIMaster input').attr('readonly', false );
			$('#txtrolename').attr('readonly', true);
			$('#docno').attr('readonly', true);
			$("#jqxUserRoleBI").jqxGrid({ disabled: false});
			
		    if ($("#mode").val() == "A") {
				$("#userRoleBIDiv").load("userRoleBIGrid.jsp");  
		    }

		}
		
		function funSearchLoad(){
			 changeContent('ubiMainSearch.jsp');  
		 }
			
		function funChkButton() {
				/* funReset(); */
		}
		 
		function funFocus(){
			document.getElementById("txtrolename").focus(); 	    		
		}
		
		function funNotify(){	
			if(document.getElementById("txtroleid").value=="") {
        		
        		document.getElementById("errormsg").innerText=" Select Role";
        		return 0;
        	}
    		
		
	/* User Role Grid Saving */
  	 		var rows = $("#jqxUserRoleBI").jqxGrid('getrows');
  			 var length=0;
  			 for(var i=0 ; i < rows.length ; i++){
  				var chk=rows[i].mno;
  				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  					newTextBox = $(document.createElement("input"))
  				    .attr("type", "dil")
  				    .attr("id", "test"+length)
  				    .attr("name", "test"+length)
  					.attr("hidden", "true");
  					length=length+1;
  					
  				newTextBox.val(rows[i].mno+"::"+rows[i].master+":: "+rows[i].dno+":: "+rows[i].detail+":: "+rows[i].permission+":: "+rows[i].email+":: "+rows[i].excel);
  				newTextBox.appendTo('form');
  				}
  			  }
  			$('#gridlength').val(length);
  			 /* User Role Grid Saving Ends*/ 
		    		
  			 return 1;
			} 
		  
		  function setValues(){
			  
			  if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			  
			  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			  funSetlabel();
			  
			  var indexVal = document.getElementById("docno").value;
			  if(indexVal>0){
	          $("#userRoleBIDiv").load("userRoleBIGrid.jsp?roleid="+indexVal);
			  }
			  
			}
		  
		  function funSearchdblclick(){
			  $('#txtrolename').dblclick(function(){
				  userRoleSearchContent('userRoleSearchGrid.jsp');
			  });
		  }
		  
		  function getRole(event){
	          var x= event.keyCode;
	          if(x==114){
	        	  userRoleSearchContent('userRoleSearchGrid.jsp');
	          }
	          else{}
	          }
		  function funClone(){
				 $('#docno').val("");
				 $("#mode").val("A");
				 $("#msg").val("");
				 $("#txtrolename").val("");
				 $("#txtroleid").val("");
				// funRemoveReadOnly();
				 $("#btnSendmail").hide();
				 $("#status").val(1);	 $("#btnSave").show();		 $("#btnCancel").show();
				 $("#btnApproval").hide();	 $("#btnCreate").hide();	funFocus();
				 $("#btnEdit").hide();	 $("#btnPrint").hide();	 $("#btnExcel").hide();		 $("#btnDelete").hide();
				 $("#btnSearch").hide(); $("#btnAttach").hide();  $("#btnCosting").hide(); $("#btnTerms").hide(); $("#btnGuideLine").hide();
				 $("#brchName").hide();  $("#brchNames").show(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
				 $("#currency").hide();  $("#currencys").show(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
				 $('#frmUserRoleBIMaster input').attr('readonly', false );
					$('#docno').attr('readonly', true);
					$("#jqxUserRoleBI").jqxGrid({ disabled: false}); 
					$('#fileexcelimport').attr('hidden', false );
					$('#btnsearch').attr('hidden', false );
					$('#btnEdit').attr('disabled', false );
					$("#jqxUserRoleBI").jqxGrid('addrow', null, {});
			 }
			
  </script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUserRoleBIMaster" action="saveUserRoleBIMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<fieldset><legend>User Role Info</legend>
<table width="100%">
  <tr>
    <td width="9%" align="right">Role</td>
    <td width="47%"><input type="text" id="txtrolename" name="txtrolename" placeholder="Press F3 to Search" style="width:60%;" ondblclick="funSearchdblclick();" onkeydown="getRole(event);" value='<s:property value="txtrolename"/>'/>
    <input type="hidden" id="txtroleid" name="txtroleid" value='<s:property value="txtroleid"/>'/></td>
    <td ><button class="myButton" type="button" id="btnclone" name="btnclone"  onclick="funClone();">Clone</button></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="38%"><input type="text" id="docno" name="txtuserrolebidocno" style="width:35%;" value='<s:property value="txtuserrolebidocno"/>' tabindex="-1"/></td>
  </tr>
</table></fieldset><br/>

<div id="userRoleBIDiv"><jsp:include page="userRoleBIGrid.jsp"></jsp:include></div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</form>

<div id="userRoleDetailsWindow">
	<div></div>
</div> 

</div>
</body>
</html>