<%@page import="com.controlcentre.masters.vehiclemaster.insurance.ClsInsuranceAction" %>
<% ClsInsuranceAction cia =new ClsInsuranceAction();%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%; /* Master UI requirement */
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    text-align: left !important;
}

/* ------------------------------
    SECTION BLOCKS & HEADERS
------------------------------ */
.section-block {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff; /* Signature Blue Line */
    color: #333;
    display: block;
}

/* ------------------------------
    GRID SYSTEM (FORM LAYOUT)
------------------------------ */
.form-row {
    display: grid;
    grid-template-columns: 120px 1fr 120px 1fr; 
    gap: 15px 30px;
    align-items: center;
    margin-bottom: 12px;
}

/* ------------------------------
    INPUTS & CONTROLS
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
    width: 100%;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

input[readonly] {
    background-color: #f3f4f6;
    color: #6b7280;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    text-align: right;
    padding-right: 10px;
    font-size: 14px;
}

/* JQX Widget Overrides */
.jqx-datetimeinput {
    height: 32px !important;
    width: 100% !important;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: auto;
    min-height: 530px;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
}







#formdet {
    text-align: left !important;
    display: block;
}





</style>
<script type="text/javascript">
      $(document).ready(function () {          
          $("#insurdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
          $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '61%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#accountWindow').jqxWindow('close');
		  
		    document.getElementById("formdet").innerText="Insurance(VIS)";
			document.getElementById("formdetail").value="Insurance";
			document.getElementById("formdetailcode").value="VIS";
			window.parent.formCode.value="VIS";
			window.parent.formName.value="Insurance";
		  var data1= '<%=cia.searchDetails() %>';
             
             var num = 0; 
             var source =
             {
                 datatype: "json",
                 datafields: [
                           	{name : 'doc_no' , type: 'number' },
      						{name : 'inname', type: 'String'  },
                           	{name : 'date', type: 'date'  },
                           	{name : 'description',type:'String'},
                           	{name : 'acc_no',type:'String'}
                           	
                  ],
                  localdata: data1,
                 
                 
                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
             };
             
             var dataAdapter = new $.jqx.dataAdapter(source,
             		 {
                 		loadError: function (xhr, status, error) {
 	                    alert(error);    
 	                    }
 		            }		
             );
        
             $("#jqxInsuranceSearch1").jqxGrid(
                     {
                     	width: '100%',
                         height: 350,
                         source: dataAdapter,
                         showfilterrow: true,
                         filterable: true,
                         selectionmode: 'singlerow',
                         //pagermode: 'default',
                         sortable: true,
                        // pageable: true,
                         altrows:true,
                         //Add row method
                         columns: [
 							{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
 					{ text: 'Insurance', datafield: 'inname', width: '50%' },
 					{text: 'Date',datafield:'date',width:'20%',cellsformat:'dd.MM.yyyy'},
 					{text: 'Account',datafield:'description',width:'20%'},
 					{text: 'Acc No',datafield:'acc_no',width:'20%',hidden:true}
         			  ]
                     });
             $('#jqxInsuranceSearch1').on('rowdoubleclick', function (event) 
             		{ 
 		            	var rowindex1=event.args.rowindex;
 		                document.getElementById("docno").value= $('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
 		                document.getElementById("insurcompany").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "inname");
 		                $("#insurdate").jqxDateTimeInput('val',$("#jqxInsuranceSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
 						document.getElementById("txtaccname").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "description");
 						document.getElementById("txtaccno").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "acc_no");
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
            	var dtype="VIS";
              	 //alert("here");
       		//  $('#txtaccname').dblclick(function(){
       			   var url=document.URL;
			     var reurl=url.split("/com/");
				  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
       			//  });  
       	}
           function getAcc(event){
        	   var dtype="VIS";
                var x= event.keyCode;
                if(x==114){
              	 //alert("here");
                	 var url=document.URL;
    			     var reurl=url.split("/com/");
    				  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
                }
                else{
                 }
                }
	function funReadOnly() {
		$('#frmInsurance input').attr('readonly', true);
		 $('#insurdate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmInsurance input').attr('readonly', false);
		$('#insurdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
		$('#insurcompany').attr('readonly', true);
	}
	function setValues() {
		 if($('#insurdatehidden').val()){
				$("#insurdate").jqxDateTimeInput('val', $('#insurdatehidden').val());
			}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }

	}
	function funSearchLoad(){
		changeContent('insuranceSearch.jsp', $('#window')); 
	 }
	 function funFocus()
	    {
	    	document.getElementById("insurcompany").focus();
	    		
	    }
	    $(function(){
	        $('#frmInsurance').validate({
	                 rules: {
	                 insurcompany:{
	                	 required:true,
	                	 maxlength:40
	                 }, 
	                txtaccname:{
	                	required:true
	                	}
	                
	                 },
	                 messages: {
	                  insurcompany:{
	                	  required:" *",
	                	  maxlength:"max 40 chars"
	                  },
	                  txtaccname:{
	                	  required:" *"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	 if(document.getElementById("txtaccname").value==''){
	    			document.getElementById("errormsg").innerText="A/c is Mandatory";
	    		/* 	//document.getElementById("txtaccname").focus;
	    			$('#txtaccname').focus();
*/		    		return 0;
	    		}
	    		else{
	    			document.getElementById("errormsg").innerText="";
	    		}
	    		return 1;
		} 
	     function funExcelBtn(){
			  $("#jqxInsuranceSearch1").jqxGrid('exportdata', 'xls', 'Insurance');
		  }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmInsurance" action="saveActionInsurance" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />
        <br/>
        
        <div class="hidden-scrollbar">
            <div class="section-block">
                <h2>Insurance Details</h2>
                
                <div class="form-row">
                    <label>Date</label>
                    <div>
                        <div id="insurdate" name="insurdate" value='<s:property value="insurdate"/>'></div>
                    </div>

                    <label>Doc No</label>
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width: 150px !important;">
                </div>
                
                <div class="form-row">
                    <label>Account</label>
                    <input type="text" name="txtaccname" id="txtaccname"
                           value='<s:property value="txtaccname"/>'
                           ondblclick="funSearchdblclick();"
                           onkeydown="getAcc(event);"
                           placeholder="Press F3 to Search">

                    <label>Company</label>
                    <input type="text" name="insurcompany" id="insurcompany"
                           value='<s:property value="insurcompany"/>'>
                </div>

                <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
                <input type="hidden" id="mode" name="mode"/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
                <input type="hidden" id="insurdatehidden" name="insurdatehidden" value='<s:property value="insurdatehidden"/>'/>
            </div>

            <div class="section-block">
                <h2>Insurance Search List</h2>
                <div id="jqxInsuranceSearch1" style="width: 100%;"></div>
            </div>

        </div>
    </form>

    <div id="accountWindow">
        <div></div><div></div>
    </div> 
</div>
</body>
</html>