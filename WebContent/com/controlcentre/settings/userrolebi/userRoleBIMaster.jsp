
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>
<style>
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* page background */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    min-height: 100vh;
    box-sizing: border-box;
}

/* WIDER main card */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 18px 28px;
    max-width: 1600px;          /* was 1200px */
    margin: 0 auto;
}

/* top container */
.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 20px;
    border-radius: 12px;
    padding: 0 10px;            /* less side padding so content uses width */
    font-size: 14px;
}
.receipt-header label {
    font-weight: 500;
    color: #333;
    margin-right: 8px;
}
.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 14px;
    width: 150px;
    background: #fff;
    transition: border-color 0.2s;
}
.receipt-header input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}
.receipt-header button {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 18px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
}
.receipt-header button:hover {
    background: #0056b3;
}

/* optional generic blocks */
.section-row {
    display: flex;
    gap: 28px;
    margin-bottom: 24px;
}
.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}
.section-block h2 {
    font-size: 1.1em;
    font-weight: 500;
    margin: 0 0 16px;
    color: #253858;
}
.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}
.section-block label {
    min-width: 120px;
    text-align: right;
    font-weight: 500;
    color: #253858;
}
.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
}
.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}

/* section cards */
.table-section {
    margin-bottom: 20px;
    padding-inline: 14px;
    padding-block: 14px;
    border-radius: 10px;
    background: #f6f8fa;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}
.table-section h3 {
    margin: 0 0 14px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    font-size: 14px;
    font-weight: 600;
}

/* tables – use full new width */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
    table-layout: fixed;
}
.cr-table th,
.cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 14px;
}
.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}
.cr-table tr:last-child td {
    border-bottom: none;
}

/* primary button */
.myButton {
    background: #007bff;
    color: #fff;
    border: none;
    padding: 6px 18px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    font-size: 13px;
}
.myButton:hover {
    background: #0056b3;
}
</style>


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
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br/>

    <div class="hidden-scrollbar receipt-header">

        <div class="table-section" style="width: 100%;">
            <h3>User Role Info</h3>

            <table class="cr-table" width="100%">
                <tr>
                    <!-- Role -->
                    <td align="right" style="width:10%;">Role</td>
                    <td style="width:40%;">
                        <input type="text" id="txtrolename" name="txtrolename"
                               placeholder="Press F3 to Search"
                               style="width:70%;"
                               ondblclick="funSearchdblclick();"
                               onkeydown="getRole(event);"
                               value='<s:property value="txtrolename"/>'/>
                        <input type="hidden" id="txtroleid" name="txtroleid"
                               value='<s:property value="txtroleid"/>'/>
                    </td>

                    <!-- Clone button in middle -->
                    <td style="width:15%;" align="left">
                        <button class="myButton" type="button"
                                id="btnclone" name="btnclone"
                                onclick="funClone();">
                            Clone
                        </button>
                    </td>

                    <!-- Doc No on one line -->
                    <td align="right" style="width:10%;">Doc No.</td>
                    <td style="width:25%;">
                        <input type="text" id="docno" name="txtuserrolebidocno"
                               style="width:60%;"
                               value='<s:property value="txtuserrolebidocno"/>'
                               tabindex="-1"/>
                    </td>
                </tr>
            </table>
        </div>

        <br/>

        <div class="cr-table" id="userRoleBIDiv">
            <jsp:include page="userRoleBIGrid.jsp"></jsp:include>
        </div>

        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted"
               value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>

    </div>
</form>

<div id="userRoleDetailsWindow">
    <div></div>
</div>

</div>
</body>

</html>