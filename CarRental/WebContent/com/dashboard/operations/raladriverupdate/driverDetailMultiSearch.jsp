 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		var indexVal1 = document.getElementById("hidcldocno").value;
		  var indexVal2 = document.getElementById("type").value;
		  var indexVal3 = document.getElementById("hiddoc").value;
			
		getdata(indexVal1,indexVal2,indexVal3);
		
	}); 

		  
	function getdata(indexVal1,indexVal2,indexVal3){
		 $("#refreshdiv").load("clientDriverSearch.jsp?clientId="+indexVal1+"&raType="+indexVal2+"&raNo="+indexVal3);
		}
	
	function loadSearchSelect(){
		
		var rows = $("#jqxclientdriverSearch").jqxGrid('getrows');
		
		var selectedrows=$("#jqxclientdriverSearch").jqxGrid('selectedrowindexes');
	/* 	selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		var i=0;var j=0;var k=0;var tempdrivername="",tempdrid="";
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(k==0){
						tempdrivername=rows[i].name;
						tempdrid=rows[i].dr_id;
					}
					else{
						tempdrivername=tempdrivername+","+rows[i].name;
						tempdrid=tempdrid+","+rows[i].dr_id;
					}
					tempdrivername1=tempdrivername;
					tempdrid1=tempdrid;
				k++;	
				j++; 
			  }
            }
	    $('#txtselecteddrname').val(tempdrivername1);
	    $('#txtselecteddrdocno').val(tempdrid1);
	    
	 */
        
        $("#jqxDriver").jqxGrid({ disabled: false});

       
		for(var i=0;i<selectedrows.length;i++){
	        $("#jqxDriver").jqxGrid('addrow', null, {});
	        var rows = $('#jqxDriver').jqxGrid('getrows');
          
	    	var rowlength= rows.length;
	    	var rowindex1 = rowlength-1 ;
    	 $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "name" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', selectedrows[i], "name"));
         $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "dob", $('#jqxclientdriverSearch').jqxGrid('getcellvalue', selectedrows[i], "dob"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "nation1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "nation"));
         $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "mobno" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', selectedrows[i], "mobno"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "dlno" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "dlno"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "ltype" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "ltype"));
         $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "issfrm" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', selectedrows[i], "issfrm"));
         $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "issdate" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', selectedrows[i], "issdate"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "led" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "led"));
         $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "passport_no" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', selectedrows[i], "passport_no"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "pass_exp" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "pass_exp"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "visano" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "visano"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "visa_exp" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "visa_exp"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hiddob" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "hiddob"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hidpassexp" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "hidpassexp"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hidissdate" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "hidissdate"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hidled" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "hidled"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hidvisaexp" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "hidvisaexp"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "doc_no" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "doc_no"));
         $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "dr_id" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', selectedrows[i], "dr_id"));
         
      
		}
	    
	    
	    $('#driverDetailsWindow').jqxWindow('close'); 
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
   <td> <input type="button" name="btnsearchselectok" id="btnsearchselectok" class="myButton" value="OK"  onclick="loadSearchSelect();"></td>
 <td><input type="hidden" id="index" name="index" value='<s:property value="index"/>'/></td>
  </tr>
  <tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include page="clientDriverSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>