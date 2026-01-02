<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* background */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    min-height: 100vh;
    box-sizing: border-box;
    font-size: 14px;
}

/* main card */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 18px 28px;
    max-width: 100%;
    margin: 0 auto;
}

/* section card like User Master */
.table-section {
    margin-bottom: 20px;
    padding-inline: 14px;
    padding-block: 14px;
    border-radius: 10px;
    background: #f6f8fa;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}
.table-section h3 {
    margin: 0 0 12px;
    padding-left: 10px;
    border-left: 4px solid #007bff;  /* blue bar */
    color: #253858;
    font-size: 15px;
    font-weight: 600;
}

/* grid/table layout for fields */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
    table-layout: fixed;
}
.cr-table td {
    padding: 6px 8px;
    font-size: 13px;
    vertical-align: middle;
}
.cr-table td[align="right"] {
    white-space: nowrap;
    font-weight: 500;
    color: #333;
}

/* unified inputs */
.cr-table input[type="text"] {
    width: 100%;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 4px 8px;
    height: 30px;
    font-size: 13px;
    box-sizing: border-box;
}
.cr-table input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* jqx date container */
#documentdate {
    width: 100%;
}

/* grid below */
#documentgrid {
    margin-top: 10px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 0 0 1px #eef0f6;
}
</style>

 
<%@page import="com.humanresource.setup.hrsetup.document.ClsDocumentDAO"%>
<% ClsDocumentDAO showDAO = new ClsDocumentDAO(); %>
   
<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Document(DOC)";
		document.getElementById("formdetail").value="Document";
		document.getElementById("formdetailcode").value="DOC";
		window.parent.formCode.value="DOC";
		window.parent.formName.value="Document";
	    
		$("#documentdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
 
		    var docdata='<%=showDAO.searchDocument()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'document', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  }
                 ],
               localdata: docdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#documentgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Document',columntype: 'textbox', filtertype: 'input', datafield: 'document', width: '38%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });
            
          $('#documentgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#documentgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("document").value = $("#documentgrid").jqxGrid('getcellvalue', rowindex1, "document");
                $("#documentdate").jqxDateTimeInput('val', $("#documentgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#documentgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
            });  
        });

	function funSearchLoad(){
		 changeContent('documentsearch.jsp'); 
	 }
 
	function funReadOnly() {
		$('#frmdocument input').attr('readonly', true);
		$('#documentdate').jqxDateTimeInput({ disabled: true});
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	
	function funRemoveReadOnly() {
		$('#frmdocument input').attr('readonly', false);
		$('#documentdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#documentdate').val(new Date());
		   }
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#documentdate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
 
	     function funNotify(){
	        	if(document.getElementById("document").value=="") {
	        		document.getElementById("errormsg").innerText=" Enter Document";
	        		document.getElementById("document").focus();
	        		return 0;
        		}
	    		return 1;
		} 
	     
	     function funFocus(){
	    	 $('#documentdate').jqxDateTimeInput('focus');  
	     }
	  
</script>   
 
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmdocument" action="saveDocument" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" /><br/>

    <div class="hidden-scrollbar">

        <div class="table-section" style="width:100%;">
            <h3>Document Details</h3>

            <table class="cr-table">
                <tr>
                    <td align="right" style="width:10%;">Date</td>
                    <td style="width:20%;">
                        <div id="documentdate" name="documentdate"
                             value='<s:property value="documentdate"/>'></div>
                    </td>

                    <td align="right" style="width:10%;">Document</td>
                    <td style="width:40%;">
                        <input type="text" name="document" id="document"
                               placeholder="Document"
                               value='<s:property value="document"/>'>
                    </td>

                    <td align="right" style="width:10%;">Doc No</td>
                    <td style="width:20%;">
                        <input type="text" name="docno" id="docno"
                               value='<s:property value="docno"/>'
                               readonly="readonly" tabindex="-1">
                    </td>
                </tr>

                <tr>
                    <td align="right">Remarks</td>
                    <td colspan="5">
                        <input type="text" name="remarks" id="remarks"
                               placeholder="Remarks"
                               value='<s:property value="remarks"/>'>
                    </td>
                </tr>
            </table>
        </div>

        <input type="hidden" id="mode" name="mode"
               value='<s:property value="mode"/>' />
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>'/>
        <input type="hidden" name="deleted" id="deleted"
               value='<s:property value="deleted"/>'/>
        <input type="hidden" id="datehidden" name="datehidden"
               value='<s:property value="datehidden"/>'/>

        <div id="documentgrid"></div><br/>
    </div>
</form>
</div>
</body>

</html>