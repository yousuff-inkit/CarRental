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
    <style>
/* no inner scrollbars */
.hidden-scrollbar {
    overflow: visible;   /* was auto */
    height: auto;        /* was 530px */
}

/* base typography */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 13px;
    color: #222;
    margin: 0;
    padding: 24px 0;
    min-height: 100vh;
    box-sizing: border-box;
}

/* main card – wider so grid fills page */
#mainBG {
    background: #fff;
    border-radius: 14px;
    padding: 12px 18px;
    max-width: 1400px;      /* adjust to 1600 or remove if you want true full width */
    margin: 0 auto;
}

/* header strip */
.receipt-header {
    display: block;
    margin-bottom: 14px;
    border-radius: 10px;
    padding: 0 12px;
    font-size: 13px;
}

.receipt-header label {
    font-weight: 500;
    color: #333;
    margin-right: 6px;
}

.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 4px;
    padding: 3px 6px;
    font-size: 12px;
    width: 120px;
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
    padding: 4px 12px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
    font-size: 12px;
}

.receipt-header button:hover {
    background: #0056b3;
}

/* optional generic sections */
.section-row {
    display: flex;
    gap: 16px;
    margin-bottom: 18px;
}

.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 14px 12px;
    box-shadow: 0 1px 6px rgba(160,177,217,0.05);
}

.section-block h2 {
    font-size: 14px;
    font-weight: 500;
    margin: 0 0 10px 0;
    color: #253858;
}

.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 8px;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 500;
    color: #253858;
    font-size: 12px;
}

.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #d1d5db;
    border-radius: 4px;
    padding: 3px 6px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 12px;
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}

/* table “card” */
.table-section {
    margin-bottom: 14px;
    padding-inline: 10px;
    padding-block: 10px;
    border-radius: 8px;
    background: #f6f8fa;
    box-shadow: 0 1px 6px rgba(160,177,217,0.05);
}

.table-section h3 {
    margin: 0 0 10px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    font-size: 13px;
    font-weight: 600;
}

/* full‑width grid table */
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
    padding: 6px 8px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 12px;
    vertical-align: middle;
}

.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* avoid wrapping small headers */
.cr-table td,
.cr-table th,
.cr-table label {
    white-space: nowrap;
}

/* primary button */
.myButton {
    background: #007bff;
    color: #fff;
    border: none;
    padding: 4px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    font-size: 12px;
}

.myButton:hover {
    background: #0056b3;
}
</style>
    

    
</style>
<script type="text/javascript">
      
		$(document).ready(function() {});
		
		function funReadOnly(){
			$('#btnclone').hide();
			$('#frmUserRoleMaster input').attr('readonly', true );
			$("#jqxUserRole").jqxGrid({ disabled: true});
		}
		
		function funRemoveReadOnly(){
			$('#frmUserRoleMaster input').attr('readonly', false );
			$('#docno').attr('readonly', true);
			$("#jqxUserRole").jqxGrid({ disabled: false});
			
		    if ($("#mode").val() == "A") {
				$("#userRoleDiv").load("userRoleGrid.jsp");  
		    }
		    if ($("#mode").val() == "E") {
		    	$('#txtrolename').attr('readonly', true);  
		    }
		}
		
		function funSearchLoad(){
			 changeContent('rleMainSearch.jsp');  
		 }
			
		function funChkButton() {
				/* funReset(); */
		}
		 
		function funFocus(){
			document.getElementById("txtrolename").focus(); 	    		
		}
		
		function funNotify(){	
			
            if(document.getElementById("txtrolename").value=="") {
        		
        		document.getElementById("errormsg").innerText=" Enter Role";
        		document.getElementById("txtrolename").focus();
	        	return 0;
        	}
    		
			/* User Role Grid Saving */
  	 		var rows = $("#jqxUserRole").jqxGrid('getrows');
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
  					
  				newTextBox.val(rows[i].mno+"::"+rows[i].menu_name+":: "+rows[i].add1+":: "+rows[i].edit+":: "+rows[i].del+":: "+rows[i].print+":: "+rows[i].attach+":: "+rows[i].excel+":: "+rows[i].email+":: "+rows[i].costing+":: "+rows[i].terms+":: "+rows[i].view);
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
	          $("#userRoleDiv").load("userRoleGrid.jsp?roleid="+indexVal);
			  }
			  
			}
		  function funClone(){
				 $('#docno').val("");
				 $("#mode").val("A");
				 $("#msg").val("");
				 $("#txtrolename").val("");
				 //funRemoveReadOnly();
				 $("#btnSendmail").hide();
				 $("#status").val(1);	 $("#btnSave").show();		 $("#btnCancel").show();
				 $("#btnApproval").hide();	 $("#btnCreate").hide();	funFocus();
				 $("#btnEdit").hide();	 $("#btnPrint").hide();	 $("#btnExcel").hide();		 $("#btnDelete").hide();
				 $("#btnSearch").hide(); $("#btnAttach").hide();  $("#btnCosting").hide(); $("#btnTerms").hide(); $("#btnGuideLine").hide();
				 $("#brchName").hide();  $("#brchNames").show(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
				 $("#currency").hide();  $("#currencys").show(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
				 $('#frmUserRoleMaster input').attr('readonly', false );
					$('#docno').attr('readonly', true);
					$("#jqxUserRole").jqxGrid({ disabled: false}); 
					$('#fileexcelimport').attr('hidden', false );
					$('#btnsearch').attr('hidden', false );
					$('#btnEdit').attr('disabled', false );
					$("#jqxUserRole").jqxGrid('addrow', null, {});
			 }
		
  </script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUserRoleMaster" action="saveUserRoleMaster" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br/>

    <div class="hidden-scrollbar receipt-header">

        <div class="table-section" style="width: 100%;">
            <h3>User Role Info</h3>

            <table class="cr-table" width="100%">
                <tr>
                    <!-- Role -->
                    <td align="right" style="width:8%;">Role</td>
                    <td style="width:22%;">
                        <input type="text" id="txtrolename" name="txtrolename"
                               style="width:100%;"
                               value='<s:property value="txtrolename"/>'/>
                    </td>

                    <!-- Email -->
                    <td align="right" style="width:8%;">Email</td>
                    <td style="width:32%;">
                        <input type="text" id="txtemail" name="txtemail"
                               placeholder="someone@example.com"
                               style="width:100%;"
                               value='<s:property value="txtemail"/>'/>
                    </td>

                    <!-- Doc No -->
                    <td align="right" style="width:8%;">Doc No.</td>
                    <td style="width:22%;">
                        <input type="text" id="docno" name="txtuserroledocno"
                               style="width:100%;"
                               value='<s:property value="txtuserroledocno"/>'
                               tabindex="-1"/>
                    </td>
                </tr>
            </table>
        </div>

        <br/>

        <!-- FULL-WIDTH GRID WRAPPER -->
        <div class="table-section" style="width:100%; padding-top:0;">
            <div class="cr-table" id="userRoleDiv" style="width:100%;">
                <jsp:include page="userRoleGrid.jsp"></jsp:include>
            </div>
        </div>

        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted"
               value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>

    </div>
</form>

<div id="roleDetailsWindow">
    <div></div>
</div>

</div>
</body>


</html>