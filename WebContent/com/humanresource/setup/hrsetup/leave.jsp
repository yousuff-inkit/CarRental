<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* scroll area if you need it later */
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

/* main card like User Master */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 18px 28px;
    max-width: 100%;
    margin: 0 auto;
}

/* section card */
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
    border-left: 4px solid #007bff; /* blue bar */
    color: #253858;
    font-size: 17.4px;
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
    font-size: 16px;
    vertical-align: middle;
}
.cr-table td[align="right"] {
    white-space: nowrap;
    font-weight: 500;
    color: #333;
}

/* unified textboxes */
.cr-table input[type="text"] {
    width: 100%;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 4px 8px;
    height: 30px;
    font-size: 13px;
    box-sizing: border-box;
    background: #fff;
}
.cr-table input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* jqx date cell */
#leavedate {
    width: 100%;
}

/* grid under form */
#leavegrid {
    margin-top: 10px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 0 0 1px #eef0f6;
}
</style>


<%@page import="com.humanresource.setup.hrsetup.leave.ClsLeaveDAO"%>
<% ClsLeaveDAO showDAO = new ClsLeaveDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Leave(LEV)";
		document.getElementById("formdetail").value="Leave";
		document.getElementById("formdetailcode").value="LEV";
		window.parent.formCode.value="LEV";
		window.parent.formName.value="Leave";
		
	    $("#leavedate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
 
	    $('#abbrevationDetailsWindow').jqxWindow({width: '31%', height: '38%',  maxHeight: '50%' ,maxWidth: '31%' , title: 'Abbreviation Search',position: { x: 600, y: 100 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#abbrevationDetailsWindow').jqxWindow('close'); 
		 
		$('#abbreviation').dblclick(function(){
			abbrevationSearchContent("leaveAbbreviationSearch.jsp");
		});
		
	        var leavedata='<%=showDAO.searchLeave()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'leave1', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  },
                        	{name : 'abbreviation', type: 'String'  }
                          	
                 ],
                  localdata: leavedata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // leavedata called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#leavegrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Leave',columntype: 'textbox', filtertype: 'input', datafield: 'leave1', width: '30%' },
		        					{ text: 'Abbreviation',columntype: 'textbox', filtertype: 'input', datafield: 'abbreviation', width: '10%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '38%' },
        	              ]
                    });
            
           $('#leavegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
           
                document.getElementById("docno").value= $('#leavegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("leave").value = $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "leave1");
                $("#leavedate").jqxDateTimeInput('val', $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("abbreviation").value=$("#leavegrid").jqxGrid('getcellvalue', rowindex1, "abbreviation"); 
            });   
        });
	
	
	function abbrevationSearchContent(url) {
	    $('#abbrevationDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#abbrevationDetailsWindow').jqxWindow('setContent', data);
		$('#abbrevationDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funSearchLoad(){
		 changeContent('leavesearch.jsp'); 
	 }
	
	 function getAbbrevation(event){
         var x= event.keyCode;
         if(x==114){
        	 abbrevationSearchContent("leaveAbbreviationSearch.jsp");
         }
         else{}
         }
 
	function funReadOnly() {
		$('#frmleave input').attr('readonly', true);
		$('#leavedate').jqxDateTimeInput({ disabled: true});
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmleave input').attr('readonly', false);
		$('#abbreviation').attr('readonly', true);
		$('#leavedate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#leavedate').val(new Date());
		   }
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#leavedate").jqxDateTimeInput('val', $('#datehidden').val());
		}

		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
 
	     function funNotify(){
	        	if(document.getElementById("leave").value=="") {
	        		document.getElementById("errormsg").innerText=" Enter Leave";
	        		document.getElementById("leave").focus();
	        		return 0;
        		}
	    		return 1;
		}
	     
	     function funFocus(){
	    	 $('#leavedate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmleave" action="saveLeave" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" /> <br/>

    <div class="hidden-scrollbar">

        <div class="table-section" style="width:100%;">
            <h3>Leave Details</h3>

            <table class="cr-table">
                <tr>
                    <td align="right" style="width:10%;">Date</td>
                    <td style="width:18%;">
                        <div id="leavedate" name="leavedate"
                             value='<s:property value="leavedate"/>'></div>
                    </td>

                    <td align="right" style="width:8%;">Leave</td>
                    <td style="width:32%;">
                        <input type="text" name="leave" id="leave"
                               placeholder="Leave"
                               value='<s:property value="leave"/>'>
                    </td>

                    <td align="right" style="width:12%;">Abbreviation</td>
                    <td style="width:14%;">
                        <input type="text" name="abbreviation" id="abbreviation"
                               placeholder="Press F3 to Search"
                               onkeydown="getAbbrevation(event);"
                               readonly="readonly"
                               value='<s:property value="abbreviation"/>'>
                    </td>

                    <td align="right" style="width:8%;">Doc No</td>
                    <td style="width:16%;">
                        <input type="text" name="docno" id="docno"
                               value='<s:property value="docno"/>'
                               readonly="readonly" tabindex="-1">
                    </td>
                </tr>

                <tr>
                    <td align="right">Remarks</td>
                    <td colspan="7">
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

        <div id="leavegrid"></div><br/>
    </div>
</form>

<div id="abbrevationDetailsWindow">
    <div></div>
</div> 

</div>
</body>

</html>