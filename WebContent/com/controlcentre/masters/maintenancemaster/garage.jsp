<%@page import="com.controlcentre.masters.maintenancemaster.garage.ClsGarageDAO" %>
<%ClsGarageDAO cgd=new ClsGarageDAO(); %>


<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* ------------------------------
   GLOBAL STYLES
------------------------------ */

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 130vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
   COMMON UI ELEMENTS
------------------------------ */

input[type="text"], select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

/* ------------------------------
   HEADER SECTION
------------------------------ */

.receipt-header {
    display: flex;
    flex-direction: column;
    margin-bottom: 16px;
    padding: 0 10px 10px;
}

.receipt-header table {
    width: 100%;
}

.receipt-header td {
    padding: 6px 4px;
    vertical-align: middle;
}

#txtStatus {
    font-size: 14px;
    font-weight: 600;
    color: #e67e22;
}

/* ------------------------------
   FORM ROWS LAYOUT (FIXED)
------------------------------ */

.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    text-align: right;
    padding-right: 8px;
    font-size:1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

/* For rows with multiple input pairs (Currency/Rate, Amount/Base Amount) */
.form-group.dual-input {
    display: grid;
    grid-template-columns: 120px 1fr 120px 1fr;
    align-items: center;
    gap: 12px 16px;
}
form-group.dual-input label {
    text-align: right;
    padding-right: 8px;
}

/* Special case: One label with two equal-width inputs */
.form-group.single-label-dual-input {
    grid-template-columns: 120px 1fr 1fr;
}

.form-group.single-label-dual-input input[type="text"]:first-of-type {
    width: 100%;
}

.form-group.single-label-dual-input input[type="text"]:nth-of-type(2) {
    width: 100%;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 30px;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
}

/* Special handling for the "to-account-row" - all items in one line */
.dual-input-type-location {
    display: grid;
    grid-template-columns: 140px 375px 160px 240px; 
    /* Label | Type Select | Location Label | Location Select */
    align-items: center;
    gap: 14px 20px;
    margin-bottom: 14px;
}

.dual-input-type-location label {
    text-align: right;
    padding-right: 10px;
    white-space: nowrap;
    font-weight: 700;       /* Increased font-weight */
    font-size: 15px;
}

/* Type dropdown width */
.dual-input-type-location #type {
    width: 400px !important;
}

/* Location dropdown — bigger & aligns with Doc No */
.dual-input-type-location #location {
    width: 400px !important;
    font-weight: 600;
}


/* ------------------------------
   TABLE SECTIONS
------------------------------ */

.table-section {
    margin: 20px 0;
}

.table-section h3 {
    color: #253858;
    font-size: 1.05rem;
    font-weight: 600;
    margin-bottom: 12px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e5e7eb;
}

.cr-table th,
.cr-table td {
    padding: 8px 12px;
    border-bottom: 1px solid #eef0f6;
    font-size: 14px;
}

.cr-table th {
    background: #eef0f6;
    font-weight: 600;
    color: #354B6A;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ------------------------------
   SCROLL AREAS
------------------------------ */

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* Hide scrollbars (but allow scrolling) */
.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
}

/* ------------------------------
   BUTTONS
------------------------------ */

button, .myButton {
    background: #007bff;
    border: none;
    padding: 6px 16px;
    color: #fff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: background 0.2s;
}

button:hover, .myButton:hover {
    background: #0056b3;
}

/* ------------------------------
   ERROR LABELS
------------------------------ */

#validrate,
#validrate1 {
    color: red;
    font-size: 12px;
    grid-column: 2 / -1;
}

/* ------------------------------
   APPROVAL TABLE
------------------------------ */

.dual-input-date-docno {
    display: grid;
    grid-template-columns: 140px 380px 160px 240px; 
    /*   Label | Date | DocNo Label | DocNo Input  */
    align-items: center;
    gap: 14px 20px;
    margin-bottom: 14px;
}

.dual-input-date-docno label {
    text-align: right;
    padding-right: 10px;
    white-space: nowrap;
    font-weight: 700;            /* Increased font weight */
    font-size: 15px;
}

/* Date control width */
.dual-input-date-docno #garagedate {
    width: 200px !important;
    padding-left:-10px
}

/* Doc No input field wider */
.dual-input-date-docno input[type="text"] {
    width: 240px !important;
    font-weight: 600;
}


</style>
<script type="text/javascript">

$(document).ready(function() {
	   $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '61%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	   $('#accountWindow').jqxWindow('close');
 	   $("#garagedate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  

 	    document.getElementById("formdet").innerText="Garage(GRG)";
 		document.getElementById("formdetail").value="Garage";
 		document.getElementById("formdetailcode").value="GRG";
 		window.parent.formCode.value="GRG";
 		window.parent.formName.value="Garage";
    var data2= '<%=cgd.getGarage()%>';

            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number'},
     						{name : 'code', type: 'String'},
                          	{name : 'name', type: 'String'},
                          	{name : 'date',type:'date'},
                          	{name : 'type', type:'String'},
                          	{name : 'branch', type:'String'},
                          	{name : 'location', type:'String'},
                          	{name : 'acc_no', type:'number'},
                          	{name : 'description', type:'String'}
                 ],
                 localdata: data2,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    //alert(error);    
	                    }
		            }		
            );
            $("#jqxGarageSearch1").jqxGrid(
            {
                width: '100%',
                height: 310,
                source: dataAdapter,
                sortable: true,
                selectionmode: 'singlerow',

                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Code', datafield: 'code', width: '50%',hidden:true },
					{text: 'Name',datafield:'name',width:'40%'},
					{ text: 'Branch', datafield: 'branch', width: '20%' ,hidden:true},
					{ text: 'Location', datafield: 'location', width: '20%' ,hidden:true},
					{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Acc No', datafield: 'acc_no', width: '20%' ,hidden:true},
					{ text: 'Type', datafield: 'type', width: '20%' ,hidden:true},
					{ text: 'Description', datafield: 'description', width:'30%'}
					]
            });

            $('#jqxGarageSearch1').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("garagecode").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("garagename").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "name");
                $('#location').val($("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "location")) ;
                $('#type').val($("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "type")) ;
                document.getElementById("txtaccname").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("txtaccno").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "acc_no");
                $("#garagedate").jqxDateTimeInput('val',$("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
               
            }); 
       
});
function accountSearchContent(url) {
	  $('#accountWindow').jqxWindow('open');
		 $.get(url).done(function (data) {
			// alert(data);
		$('#accountWindow').jqxWindow('setContent', data);
	}); 
	}
function funSearchdblclick(){
	var url=document.URL;
	var reurl=url.split("com/");
	var dtype = "GRG";
	accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);    
}
function funSearchLoad(){
	changeContent('garageSearch.jsp', $('#window')); 
 }
function getAcc(event){
	
   var x= event.keyCode;
   if(x==114){
	   var url=document.URL;
		var reurl=url.split("com/");
		var dtype = "GRG";
		accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
   }
   else{
    }
   }
  </script>

<script>

function getLocation()
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			
			 	items=items.split('***');
		        var locItems=items[0].split(",");
		        var locnoItems=items[1].split(",");
		        	var optionsloc = '<option value="">--Select--</option>';
		       for ( var i = 0; i < locItems.length; i++) {
		    	   optionsloc += '<option value="' + locnoItems[i] + '">' + locItems[i] + '</option>';
		        }
		       $("select#location").html(optionsloc);
		       
		   	$('#location').val($('#hidlocation').val()) ;
		   	//$('#type').val($('#hidtype').val()) ;

			}
		else
			{
			}
	}
	x.open("GET","getLocation.jsp",true);
	x.send();
	}
</script>
<script type="text/javascript">
function funReadOnly(){
	$('#frmGarage input').attr('readonly', true );
	$('#frmGarage select').attr('disabled', true );
	 $('#garagedate').jqxDateTimeInput({ disabled: true});
	//getLocation();
}
function funRemoveReadOnly(){
	$('#frmGarage input').attr('readonly', false );
	$('#frmGarage select').attr('disabled', false );
	 $('#garagedate').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
	$('#txtaccname').attr('readonly', true);
}
function funFocus()
{
	document.getElementById("garagecode").focus();
		
}
function funNotify(){
	
	return 1;
} 
$(function(){
    $('#frmGarage').validate({
            	 rules: {
                     garagecode: {
                    	 required:true,
                    	 maxlength:2
                     },
                    garagename:{
                    	required:true,
                    	maxlength:25
                    }    	
                    },
                     
                     messages: {
                    	 garagecode:{
                    	  required:" *",
                    	  maxlength:"Max 2 chars"
                      },
                      garagename:{
                    	 required:" *",
                    	  maxlength:"Max 25 chars"
                      }
                     
                      }
    });});
function setValues()
{
  	$('#location').val($('#hidlocation').val()) ;
   	$('#type').val($('#hidtype').val()) ;
	//$('#accno').val($('#hidaccno').val()) ;
   	if($('#garagedatehidden').val()){
		$("#garagedate").jqxDateTimeInput('val', $('#garagedatehidden').val());
	}
   	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

	}
</script>
</head>
<body onLoad="getLocation();setValues();">
<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmGarage" action="saveActionGarage" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Garage Details</legend>
<div class="section-block">
 
  <div class="dual-input-date-docno">
    <label>Date</label>
    <div id="garagedate" name="garagedate" value='<s:property value="garagedate"/>'></div></td>
    <label>Doc No</label>  
    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly>
  </div>
  <div class="form-group dual-input">
    <label>Code</label>
    <label><input type="text" name="garagecode" id="garagecode" value='<s:property value="garagecode"/>'>
    <label>Name</label>
    <input type="text" name="garagename" id="garagename" value='<s:property value="garagename"/>' >
  </div>
  <div class="form-group dual-input-type-location">
    
      <label>Type</label>
    
    <select name="type" id="type" value='<s:property value="type"/>' style="width:90%;">
      <option value="">--Select--</option>
      <option value="E">External</option>
      <option value="O">Own</option>
    </select>
    <label>Location</label>
    <select name="location" id="location" value='<s:property value="location"/>' style="width:32.5%;">
      <option>----</option>
    </select>
  </div>
  <div class="form-group ">
    <label>Account</label>
    <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' style="width:32%;" ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" placeholder="Press F3 to Search" readonly="readonly">
    <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
  </div>
</div>
</fieldset><br/>
	 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>'>
<input type="hidden" name="hidlocation" id="hidlocation" value='<s:property value="hidlocation"/>'>
<input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'>
<input type="hidden" name="hidgaragedate" id="hidgaragedate" value='<s:property value="hidgaragedate"/>'></form>

<div id="jqxGarageSearch1"></div>
 <div id="accountWindow">
				<div></div><div></div>
				</div> </div>
</body>
</html>