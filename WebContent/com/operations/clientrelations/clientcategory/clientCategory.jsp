<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>

<html>
<%
String contextPath = request.getContextPath();
%>
<%@page import="com.operations.clientrelations.clientcategory.ClsClientCategoryDAO"%>
<%
ClsClientCategoryDAO DAO = new ClsClientCategoryDAO();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="ISO-8859-1">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" href="<%=contextPath%>/css/global.css" type="text/css">
<script type="text/javascript">

```
 var data= '<%=DAO.category()%>
';
$(document)
		.ready(
				function() {
					getAccountGroup();
					getconfig();
					var source = {
						datatype : "json",
						datafields : [ {
							name : 'doc_no',
							type : 'int'
						}, {
							name : 'dtypes',
							type : 'String'
						}, {
							name : 'category',
							type : 'String'
						}, {
							name : 'cat_name',
							type : 'String'
						}, {
							name : 'description',
							type : 'String'
						}, {
							name : 'approved',
							type : 'bool'
						}, {
							name : 'dtype',
							type : 'String'
						}, {
							name : 'approval',
							type : 'int'
						}, {
							name : 'acc_group',
							type : 'String'
						} ],
						localdata : data,

						pager : function(pagenum, pagesize, oldpagenum) {
						}
					};

					var dataAdapter = new $.jqx.dataAdapter(source, {
						loadError : function(xhr, status, error) {
							alert(error);
						}
					});

					$("#jqxCategorySearch1").jqxGrid({
						width : '70%',
						height : 375,
						source : dataAdapter,
						showfilterrow : true,
						filterable : true,
						selectionmode : 'singlerow',

						columns : [ {
							text : 'Type',
							columntype : 'textbox',
							filtertype : 'input',
							datafield : 'dtypes',
							width : '8%'
						}, {
							text : 'Category',
							columntype : 'textbox',
							filtertype : 'input',
							datafield : 'category',
							width : '20%'
						}, {
							text : 'Category Name',
							columntype : 'textbox',
							filtertype : 'input',
							datafield : 'cat_name',
							width : '34%'
						}, {
							text : 'Account Group',
							columntype : 'textbox',
							filtertype : 'input',
							datafield : 'description'
						}, {
							text : 'Approval',
							datafield : 'approved',
							columntype : 'checkbox',
							filterable : false,
							checked : true,
							width : '8%',
							cellsalign : 'center',
							align : 'center'
						}, {
							text : 'Doc No',
							datafield : 'doc_no',
							hidden : true,
							filterable : false,
							width : '10%'
						}, {
							text : 'Dtype',
							datafield : 'dtype',
							hidden : true,
							filterable : false,
							width : '10%'
						}, {
							text : 'Approval',
							datafield : 'approval',
							hidden : true,
							filterable : false,
							width : '10%'
						}, {
							text : 'Account Group',
							filterable : false,
							datafield : 'acc_group',
							hidden : true,
							width : '10%'
						},

						]
					});

					$('#jqxCategorySearch1')
							.on(
									'rowdoubleclick',
									function(event) {
										var rowindex1 = event.args.rowindex;
										getAccountGroup($(
												"#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1, "dtype"));
										document.getElementById("docno").value = $(
												"#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1, "doc_no");
										document.getElementById("cmbtype").value = $(
												"#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1, "dtype");
										document
												.getElementById("txtcategory").value = $(
												"#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1,
														"category");
										document
												.getElementById("txtcategoryname").value = $(
												"#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1,
														"cat_name");
										document
												.getElementById("cmbaccountgroup").value = $(
												"#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1,
														"acc_group");
										document
												.getElementById("hidcmbaccountgroup").value = $(
												"#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1,
														"acc_group");
										document
												.getElementById("hidchckapproval").value = $(
												"#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1,
														"approval");

										if ($("#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1,
														"approval") == 1) {
											document
													.getElementById("chckapproval").checked = true;
										} else if ($("#jqxCategorySearch1")
												.jqxGrid('getcellvalue',
														rowindex1,
														"approval") == 0) {
											document
													.getElementById("chckapproval").checked = false;
										}
									});
				});

$(function() {
	$('#frmClientCategory').validate({
		rules : {
			cmbtype : "required",
			txtcategory : "required",
			txtcategoryname : "required",
			cmbaccountgroup : "required"
		},
		messages : {
			cmbtype : " *",
			txtcategory : " *",
			txtcategoryname : " *",
			cmbaccountgroup : " *"
		}
	});
});

function getconfig() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('####');
			if (items[0] == 1) {
				$('#chckapproval').hide();
				$('#appr').hide();
				$('#config').val(1);
				$('#jqxCategorySearch1').jqxGrid('hidecolumn', 'approved');

			}

		} else {
			$('#chckapproval').show();
			$('#appr').show();
			$('#config').val(0);
			$('#jqxCategorySearch1').jqxGrid('showcolumn', 'approved');
		}
	}
	x.open("GET", "getconfig.jsp", true);
	x.send();
}

function getAccountGroup(type) {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var groupItems = items[0].split(",");
			var groupIdItems = items[1].split(",");
			var optionsgroup = '<option value="">--Select--</option>';
			for (var i = 0; i < groupItems.length; i++) {
				optionsgroup += '<option value="' + groupIdItems[i] + '">'
						+ groupItems[i] + '</option>';
			}
			$("select#cmbaccountgroup").html(optionsgroup);
			if ($('#hidcmbaccountgroup').val() != null) {
				$('#cmbaccountgroup').val($('#hidcmbaccountgroup').val());
			}
		} else {
		}
	}
	x.open("GET", "getAccountGroup.jsp?type=" + type, true);
	x.send();
}

function approval() {
	if (document.getElementById("chckapproval").checked) {
		document.getElementById("hidchckapproval").value = 1;
	} else {
		document.getElementById("hidchckapproval").value = 0;
	}
}

function funReadOnly() {
	getconfig();
	$('#frmClientCategory input').attr('readonly', true);
	$('#frmClientCategory select').attr('disabled', true);
	$('#chckapproval').attr('disabled', true);
}

function funRemoveReadOnly() {
	getconfig();
	$('#frmClientCategory input').attr('readonly', false);
	$('#frmClientCategory select').attr('disabled', false);
	$('#chckapproval').attr('disabled', false);

	if ($("#mode").val() == "A") {

		$('#hidchckapproval').val(0);
		document.getElementById("chckapproval").checked = false;
	}

}

function funNotify() {
	return 1;
}

function funChkButton() {
}

function funSearchLoad() {
	changeContent('categoryMainSearchGrid.jsp?check=1');
}

function funFocus() {
	document.getElementById("cmbtype").focus();
}

function setValues() {

	document.getElementById("cmbtype").value = document
			.getElementById("hidcmbtype").value;

	if (document.getElementById("hidchckapproval").value == 1) {
		document.getElementById("chckapproval").checked = true;
	} else if (document.getElementById("hidchckapproval").value == 0) {
		document.getElementById("chckapproval").checked = false;
	}

	if ($('#msg').val() != "") {
		$.messager.alert('Message', $('#msg').val());
	}

	document.getElementById("formdet").innerText = $('#formdetail').val()
			+ " (" + $('#formdetailcode').val().trim() + ")";
	funSetlabel();
}
```

</script>
<style>
html, body { height: 100%; overflow-y: auto; }
body::-webkit-scrollbar { width: 10px; }
body::-webkit-scrollbar-track { background: #eaf3ff; border-radius: 8px; }
body::-webkit-scrollbar-thumb { background: #4da3ff; border-radius: 8px; border: 2px solid #eaf3ff; }
body::-webkit-scrollbar-thumb:hover { background: #1a73e8; }
.hidden-scrollbar { max-height: 80vh; overflow-y: auto; padding-right: 10px; scrollbar-width: thin; scrollbar-color: #4da3ff #eaf3ff; }
.hidden-scrollbar::-webkit-scrollbar { width: 8px; }
.hidden-scrollbar::-webkit-scrollbar-track { background: #eaf3ff; border-radius: 4px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background-color: #4da3ff; border-radius: 4px; border: 2px solid #eaf3ff; }
.hidden-scrollbar::-webkit-scrollbar-thumb:hover { background-color: #1a73e8; }
body { background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%); font-family: "Poppins", "Segoe UI", sans-serif; color: #1f2f46; margin: 0; padding: 40px 0; min-height: 100vh; animation: fadeIn 0.6s ease-in-out; box-sizing: border-box; }
#mainBG { background: #f4f8ff; border-radius: 16px; box-shadow: 0 4px 25px rgba(50, 110, 255, 0.15); padding: 25px 30px; max-width: 1250px; margin: 0 auto; transition: 0.3s ease; }
.receipt-header { background: #edf4ff; border: 1px solid #c9dafc; border-radius: 14px; padding: 20px; margin-bottom: 26px; box-shadow: 0 2px 10px rgba(132, 168, 255, 0.2); }
.clean-grid-form { display: grid; grid-template-columns: repeat(3, 1fr); gap: 22px 32px; width: 100%; box-sizing: border-box; align-items: start; }
.clean-grid-item { display: flex; flex-direction: column; }
.clean-grid-item.full { grid-column: span 3; }
.clean-input, .clean-grid-item input[type="text"], .clean-grid-item select, .receipt-header input[type="text"], .receipt-header select { width: 100%; height: 44px; padding: 8px 12px; border: 1px solid #b9ccf2; border-radius: 8px; background: #ffffff; font-size: 0.95rem; color:#1f2f46; box-sizing: border-box; transition: 0.18s ease; }
.clean-input:focus, .receipt-header input[type="text"]:focus, .receipt-header select:focus { border-color: #4da3ff; box-shadow: 0 0 6px rgba(77,163,255,0.35); outline: none; }
#jqxRentalRefundDate, #jqxReferenceDate { width: 100% !important; height: 44px !important; }
#jqxRentalRefundDate input, #jqxReferenceDate input { height: 42px !important; padding-left: 10px !important; border-radius: 8px !important; background-color: #ffffff !important; box-shadow: none !important; }
.cr-table input[type="text"], .cr-table select { width: 100%; height: 40px; padding: 6px 10px; box-sizing: border-box; border-radius: 8px; border: 1px solid #d6e1ff; background: #fff; }
label { font-weight: 600; font-size: 14px; color: #1a2d4d; margin-bottom: 8px; display:block; }
.cr-table { width: 100%; border-collapse: collapse; background: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(100, 140, 255, 0.15); }
.cr-table th, .cr-table td { padding: 10px 12px; border-bottom: 1px solid #d6e1ff; text-align: left; font-size: 0.95rem; color: #1f2f46; vertical-align: middle; }
.cr-table th { background-color: #dcebff; color: #1b3f73; font-weight: 600; }
button, .myButton { background: linear-gradient(90deg, #3b82f6, #1a73e8); color: #fff; border: none; border-radius: 8px; padding: 9px 22px; font-weight: 600; cursor: pointer; transition: 0.25s ease; box-shadow: 0 3px 10px rgba(30, 100, 255, 0.25); }
@keyframes fadeIn { from { opacity: 0; transform: translateY(-5px); } to { opacity: 1; transform: translateY(0); } }
@media (max-width: 900px) { .clean-grid-form { grid-template-columns: repeat(1, 1fr); } .clean-grid-item.full { grid-column: span 1; } }

.hidden-scrollbar {
overflow-y: auto;
height: 530px;
scrollbar-width: thin;
scrollbar-color: #4da3ff #eaf3ff;
}
.hidden-scrollbar::-webkit-scrollbar {
width: 7px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb {
background-color: #4da3ff;
border-radius: 8px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb:hover {
background-color: #1a73e8;
}
#mainBG:hover {
box-shadow: 0 8px 35px rgba(30, 100, 255, 0.25);
}
.table-section h3 {
color: #1b3f73;
font-size: 1.05em;
font-weight: 600;
margin: 0 0 14px 2px;
}
.section-row {
display: flex;
gap: 24px;
margin-bottom: 18px;
flex-wrap: wrap;
}
.section-block {
flex: 1;
min-width: 100%;
background: transparent;
border-radius: 0;
padding: 6px 0;
box-shadow: none;
border: 0;
}
.section-block .form-group {
display: flex;
align-items: center;
gap: 18px;
margin-bottom: 10px;
flex-wrap: wrap;
}
.section-block label, .receipt-header label {
min-width: 120px;
text-align: left;
font-weight: 600;
color: #253858;
font-size: 14px;
}
.section-block input[type="text"], .section-block select,
.receipt-header input[type="text"], .receipt-header select {
border: 1px solid #b9ccf2;
border-radius: 10px;
padding: 9px 11px;
font-size: 0.95rem;
background: #ffffff;
color: #1f2f46;
transition: 0.25s ease;
box-sizing: border-box;
}
.section-block input[type="text"], .section-block select {
min-width: 180px;
}
.section-block input[type="text"]:focus, .section-block select:focus,
.receipt-header input[type="text"]:focus, .receipt-header select:focus
{
border-color: #4da3ff;
outline: none;
box-shadow: 0 0 6px rgba(77, 163, 255, 0.55);
}
.cr-table tr:hover td {
background-color: #eef5ff;
transition: 0.25s;
}
#appr {
font-weight: 600;
color: #253858;
}
#chckapproval {
transform: scale(1.05);
accent-color: #3b82f6;
}
#validrate, #validrate1 {
color: #d62828;
font-weight: 600;
font-size: 0.9rem;
}
@media ( max-width : 900px) {
.section-row {
flex-direction: column;
}
.section-block {
width: 100%;
}
} </style>

</head>
<body onload="setValues(); getconfig();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmClientCategory" action="saveClientCategory" method="post"
			autocomplete="off">
			<jsp:include page="../../../../header.jsp"></jsp:include><br />

```
		<div class='hidden-scrollbar receipt-header'>
			<div class="table-section" style="width: 100%;">
				<h3>Category Master</h3>
				<table class="cr-table" width="100%">
					<tr>
    <td width="5%" align="right">Type</td>
    <td width="7%">
        <select id="cmbtype" name="cmbtype"
            style="width: 200%;"
            onchange="getAccountGroup($('#cmbtype').val());"
            value='<s:property value="cmbtype"/>'>
                <option value="">--Select--</option>
                <option value="CRM">CLIENT</option>
                <option value="VND">VENDOR</option>
        </select>
        <input type="hidden" id="hidcmbtype" name="hidcmbtype"
            value='<s:property value="hidcmbtype"/>' />
    </td>
</tr>

<tr>
    <td width="12%" align="right">Category</td>
    <td width="20%">
        <input type="text" id="txtcategory" name="txtcategory"
            style="width: 70%;"
            value='<s:property value="txtcategory"/>'>
    </td>

    <td width="7%" align="right">Category Name</td>
    <td width="49%">
        <input type="text" id="txtcategoryname" name="txtcategoryname"
            style="width: 37%;"
            value='<s:property value="txtcategoryname"/>'>
    </td>
</tr>

					<tr>
						<td colspan="2" align="right">Account Group</td>
						<td colspan="2"><select id="cmbaccountgroup"
							name="cmbaccountgroup" style="width: 83%;"
							value='<s:property value="cmbaccountgroup"/>'>
								<option value="">--Select--</option>
						</select> <input type="hidden" id="hidcmbaccountgroup"
							name="hidcmbaccountgroup"
							value='<s:property value="hidcmbaccountgroup"/>' /></td>
						<td colspan="3"><input type="checkbox" id="chckapproval"
							name="chckapproval" value="" onchange="approval();"
							onclick="$(this).attr('value', this.checked ? 1 : 0)"><label
							id="appr">Approval</label> <input type="hidden"
							id="hidchckapproval" name="hidchckapproval"
							value='<s:property value="hidchckapproval"/>' /> <input
							type="hidden" id="config" name="config" /></td>
					</tr>

				</table>
			</div>
			<br />
			<div style="width: 100%;" id="jqxCategorySearch1"></div>

			<input type="hidden" id="mode" name="mode" /> <input type="hidden"
				id="deleted" name="deleted" value='<s:property value="deleted"/>' />
			<input type="hidden" id="msg" name="msg"
				value='<s:property value="msg"/>' /> <input type="hidden"
				id="docno" name="hidtxtclientcategorydocno"
				value='<s:property value="hidtxtclientcategorydocno"/>' />
		</div>
	</form>
</div>


</body>
</html>
