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
/* no inner scrollbars */
.hidden-scrollbar {
    overflow: visible;
    height: auto;
}


html, body {
    background: #ffffff;                
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 12px;                     
    color: #333;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* kill any blue/other window background if present */
.windowCont,
#mainBG.homeContent {
    background: #ffffff !important;
}

/* 2. main content area – flat like master */
#mainBG {
    background: #ffffff;
    border-radius: 8px;
    padding: 16px 18px;
    max-width: 1400px;
    margin: 0 auto;
    box-shadow: none;                    /* master has almost no card shadow */
}

/* 3. headings / section blocks same feel */
.table-section {
    margin-bottom: 16px;
    padding: 14px 12px;
    border-radius: 8px;
    background: #ffffff;
    box-shadow: none;
    border: 1px solid #e5e7eb;          /* light border like master card edge */
}

.table-section h3 {
    margin: 0 0 10px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    font-size: 13px;
    font-weight: 600;
}

/* 4. labels and inputs – same size/shape as master forms */
.section-block {
    flex: 1;
    background: #ffffff;
    border-radius: 8px;
    padding: 10px 12px 4px;
    box-shadow: none;
    border: 1px solid #e5e7eb;
}

.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 6px;
}

.section-block label {
    min-width: 120px;
    text-align: right;
    font-weight: 500;
    color: #445;
    font-size: 12px;
}

/* shared input style (match master text boxes) */
.section-block input[type="text"],
.section-block select,
.cr-table input[type="text"],
.cr-table select {
    flex: 1;
    border: 1px solid #d3d7de;
    border-radius: 4px;
    padding: 4px 6px;
    background: #fdfdfd;
    font-size: 12px;
    height: 26px;
    box-sizing: border-box;
}

.section-block input[type="text"]:focus,
.section-block select:focus,
.cr-table input[type="text"]:focus,
.cr-table select:focus {
    border-color: #7aa7ff;
    outline: none;
    box-shadow: 0 0 0 1px rgba(122,167,255,0.35);
}

/* 5. grid table – keep subtle like master */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 6px;
    overflow: hidden;
    border: 1px solid #e5e7eb;
    table-layout: fixed;
}

.cr-table th,
.cr-table td {
    padding: 6px 8px;
    border-bottom: 1px solid #e5e7eb;
    text-align: left;
    font-size: 12px;
    vertical-align: middle;
}

.cr-table th {
    background: #f3f4f6;
    color: #354b6a;
    font-weight: 600;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* prevent wrapping of small headers */
.cr-table td,
.cr-table th,
.cr-table label {
    white-space: nowrap;
}

/* 6. primary button like master */
.myButton,
.receipt-header button {
    background: #007bff;
    color: #fff;
    border: none;
    padding: 4px 14px;
    border-radius: 14px;
    cursor: pointer;
    font-weight: 500;
    font-size: 12px;
}

.myButton:hover,
.receipt-header button:hover {
    background: #0056b3;
}

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