<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<jsp:include page="../../../../includes.jsp"></jsp:include>   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Split Invoice</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
 <script type="text/javascript">
 
	$(document).ready(function () {
		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#postdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	
	     $('#clientwindow').jqxWindow({autoOpen:false, width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#clientwindow').jqxWindow('close');
	     $('#postaccwindow').jqxWindow({autoOpen:false, width: '50%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#postaccwindow').jqxWindow('close');
	     $('#txtclientname').dblclick(function(){
			    $('#clientwindow').jqxWindow('open');
			$('#clientwindow').jqxWindow('focus');
			 clientSearchContent('clientsearch.jsp?id=1', $('#clientwindow'));
			});
	   
	 
	     
	     $('#txtpostacc').dblclick(function(){
			    $('#postaccwindow').jqxWindow('open');
			$('#postaccwindow').jqxWindow('focus');
			 postaccSearchContent('postaccountsearch.jsp?id=1', $('#postaccwindow'));
			});
	   
	});

	     
	    
	 function clientSearchContent(url) {
	 	    //alert(url);
	 	      $.get(url).done(function (data) {
	 	//alert(data);
	 	    $('#clientwindow').jqxWindow('setContent', data);

	 	}); 
	 	}   
	 
	   function getClient(event){
	   	
      var x= event.keyCode;
      if(x==114){
    	   $('#clientwindow').jqxWindow('open');
   		$('#clientwindow').jqxWindow('focus');
   		 clientSearchContent('clientsearch.jsp?id=1', $('#clientwindow'));
      }
      else{
       }
      }

	   function postaccSearchContent(url) {
	 	 	    //alert(url);
	 	 	      $.get(url).done(function (data) {
	 	 	//alert(data);
	 	 	    $('#postaccwindow').jqxWindow('setContent', data);

	 	 	}); 
	 	 	}    
	   
	   function getpostacc(event){
		   	
		      var x= event.keyCode;
		      if(x==114){
		    	   $('#postaccwindow').jqxWindow('open');
		   		$('#postaccwindow').jqxWindow('focus');
		   		 postaccSearchContent('postaccountsearch.jsp?id=1', $('#postaccwindow'));
		      }
		      else{
		       }
		      }
	  	
  function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var client = $('#client').val();
		 
		 $("#overlay, #PleaseWait").show();
		 $("#splitinvoiceDiv").load("splitinvoiceGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&client='+client+'&id=1');
 	 
		 	$("#postacc").val(''); 
			$("#txtpostacc").val('');
			$("#txtpostacc").attr('placeholder','Press F3 to Search');  
			$("#description").val(''); 
			$("#postdate").val(new Date()); 
		 $('#jqxsplitinvoice').jqxGrid('clear');
		 $('#jqxsplitinvoicedetail').jqxGrid('clear');
		 $('#jqxsplitinvoicejvdetails').jqxGrid('clear');
		 	
  } 
  
		 function funCalculate(){
			 $('#jqxsplitinvoicejvdetails').jqxGrid('clear');
			 var postacc =document.getElementById("postacc").value;
				if(postacc=="" || postacc==null){
	   				$.messager.alert('Warning','Please select Post Account.'); 
	   			 	return false;
	   			}
				 
			 
			   var rowindex1= $("#rowindex1").val();
			   
			  $("#jqxsplitinvoicejvdetails").jqxGrid('addrow', null, {});
                $('#jqxsplitinvoicedetail').jqxGrid('clearfilters', true);
  			 
   			var selectedrows = $("#jqxsplitinvoicedetail").jqxGrid('selectedrowindexes');
   			selectedrows = selectedrows.sort(function(a,b){return a - b});

   			if(selectedrows.length==0){
   				$("#overlay, #PleaseWait").hide();
   				$.messager.alert('Warning','Please select documents.'); 
   			    $('#jqxsplitinvoicejvdetails').jqxGrid('clear');
   				return false;
   			}
   				var i=0;var temptrno="";var val1=0,val2=0;            
   				var j=0;
   				var nettotal=0.0;
   				for (i = 0,j=1; i < selectedrows.length; i++) {
   				     var docno= $('#jqxsplitinvoicedetail').jqxGrid('getcellvalue',selectedrows[i], "docno");
   				    var acno= $('#jqxsplitinvoicedetail').jqxGrid('getcellvalue',selectedrows[i], "acno");
	   				var account= $('#jqxsplitinvoicedetail').jqxGrid('getcellvalue',selectedrows[i], "account");
		   		     var description= $('#jqxsplitinvoicedetail').jqxGrid('getcellvalue',selectedrows[i], "description");
		   	         var chargetodrive= $('#jqxsplitinvoicedetail').jqxGrid('getcellvalue',selectedrows[i], "chargetodrive");
		   	         nettotal=nettotal+chargetodrive;
		   	         
		   	         var total= $('#jqxsplitinvoicedetail').jqxGrid('getcellvalue',selectedrows[i], "total");
		   	       
			      	if(chargetodrive=='' || chargetodrive=='undefined' || typeof(chargetodrive)=='undefined' || chargetodrive==null){
			      		val1++;
			      		break;
			      	}else{
			      		if(parseFloat(chargetodrive)>parseFloat(total)){
			      			val2++;
				      		break;
			      		}
			      	}
		   	        $("#jqxsplitinvoicejvdetails").jqxGrid('addrow', null, {});
		   	        $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',j, "docno",docno);
		   	        $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',j, "acno",acno);
		            $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',j, "account",account);
		            $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',j, "description",description);
		            $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',j, "debit",chargetodrive);
		            j++;
	            }
   				var postacc=$('#postacc').val();
   				var txtpostacc=$('#txtpostacc').val();
   				var acno= $('#jqxsplitinvoice').jqxGrid('getcellvalue',rowindex1, "acno");
   			 var refno= $('#jqxsplitinvoice').jqxGrid('getcellvalue',rowindex1, "refno");
   			 var invdocno= $('#jqxsplitinvoice').jqxGrid('getcellvalue',rowindex1, "invdocno");
  			var account= $('#postacc').val();
  			
			 $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',0, "docno",docno);
			 $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',0, "acno",postacc);
			 $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',0, "refno",refno);
			 $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',0, "invdocno",invdocno);
	   		 $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',0, "account",txtpostacc);
             $('#jqxsplitinvoicejvdetails').jqxGrid('setcellvalue',0, "credit",nettotal);
           
   				if(val1>0){
   					$.messager.alert('Warning','Please Enter Charge to drive');
   					$('#jqxsplitinvoicejvdetails').jqxGrid('clear');
		      		return false;
   				}
   				if(val2>0){
   					$.messager.alert('Warning','Please Enter Correct Value');
   					$('#jqxsplitinvoicejvdetails').jqxGrid('clear');
		      		return false;
   				}
   				
		 }
		 function funcreatejv(){ 
			var postdate=$('#postdate').val();
			var description=$('#description').val();
			var refno=$('#refno').val();
			var invdocno=$('#invdocno').val();
			var brhid=$('#brhid').val();
			
			
			 $.messager.confirm('Message', 'Do you want to create JV?', function(r){     
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }  
			     	else {
			     		 var gridarray=new Array();       
						   var rows=$('#jqxsplitinvoicejvdetails').jqxGrid('getrows')
					   var drtot=0.0,crtot=0.0;
						for(var i=0;i<rows.length;i++){
							var chk1=rows[i].docno;
							var chk2=rows[i].description;
							var debit=rows[i].debit;
							var credit=rows[i].credit;
							var amount=0.0;
							var id=0;
							if((typeof(chk1) != "undefined" && typeof(chk1) != "NaN" && chk1 != "")){
								if(debit!="undefined" && typeof(debit)!="undefined" && debit!=null && debit!=""){
									amount=debit;
									id=-1;
									drtot=drtot+debit;	
								}
								if(credit!="undefined" && typeof(credit)!="undefined" && credit!=null && credit!=""){
									amount=credit;
									id=1;
									crtot=crtot+credit;	
								}
								gridarray.push(rows[i].acno+" :: "+rows[i].description+" :: "+1+"::"+1+"::"+amount*id+"::"+amount*id+"::"+1+"::"+id+":: "+0+":: "+0);
							} 
							}
					 console.log(gridarray);
			     	createJVData(gridarray,postdate,postacc,brhid,drtot,crtot,description,refno,invdocno);              
			     	}  
			 });
			 
		      }
			   function createJVData(gridarray,postdate,postacc,brhid,debit,credit,description,refno,invdocno){                     
					 var x=new XMLHttpRequest();
					x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText;     
					   if(parseInt(items)>=1)
						{
						   $.messager.alert('Warning','JVT - '+items+' Successfully Created.'); 
						   $('#jqxsplitinvoice').jqxGrid('clear');
						   $('#jqxsplitinvoicedetail').jqxGrid('clear');
						   $('#jqxsplitinvoicejvdetails').jqxGrid('clear');
							$("#txtclientname").val(''); 
							$("#txtclientname").attr('placeholder','Press F3 to Search');
							$("#client").val('');
							$("#postacc").val(''); 
							$("#txtpostacc").val(''); 
							$("#txtpostacc").attr('placeholder','Press F3 to Search');
							$("#description").val(''); 
							$("#postdate").val(new Date()); 
							}
						else
						{      
							 $.messager.alert('Warning','Not Created.'); 
				   			  
						}
					}                 
					}   
					x.open("GET","createJV.jsp?gridarray="+encodeURIComponent(gridarray)+'&postdate='+postdate+'&postacc='+postacc+'&brhid='+brhid+'&debit='+debit+'&credit='+credit+'&description='+encodeURIComponent(description)+'&refno='+encodeURIComponent(refno)+'&invdocno='+invdocno);                                     
					x.send();
				} 
		 
		 
</script>
<style type="text/css">
.tabheight{
height:130px;
}
</style>
</head>
<body onload="getBranch()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr>
	 <td align="right"><label class="branch">From Date</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To Date</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr>
	<td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" ondblclick="(getClient(event));" onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" name="client" id="client" value='<s:property value="client"/>'>
    </tr>
    <tr><td>&nbsp;</td></tr>
  <tr><td>&nbsp;</td></tr>
  <tr><td>&nbsp;</td></tr>
   <tr><td>&nbsp;</td></tr>
   <tr><td>&nbsp;</td></tr>
   <tr><td>&nbsp;</td></tr>
  
     <tr>
    <td align="right"><label class="branch">Post Date</label></td>
     <td align="left"><div id="postdate" name="postdate" value='<s:property value="postdate"/>'></div></td></tr> 
	
   <tr>
	<td align="right"><label class="branch">Post Account</label></td>
	<td align="left"><input type="text" id="txtpostacc" name="txtpostacc" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" ondblclick="getpostacc(event);" onkeydown="getpostacc(event);" value='<s:property value="txtpostacc"/>'/>
     <input type="hidden" name="postacc" id="postacc" value='<s:property value="postacc"/>'>
    </tr>
    <tr>
    <td align="right"><label class="branch">Description</label></td>
	<td align="left"><input type="text" id="description" name="description" style="width:100%;height:20px;" value='<s:property value="description"/>'/>
    </tr>
   
   <tr><td>&nbsp;</td></tr>
    <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btncreatejv" name="btncreatejv" onclick="funcreatejv();">Create JV</button></td></tr>
    <tr class="tabheight"><td >&nbsp;</td></tr>
    <tr><td>
    <input type="hidden" name="calcu" id="calcu" style="width:100%;height:20px;" value='<s:property value="calcu"/>'>
    <input type="hidden" name="brhid" id="brhid" value='<s:property value="brhid"/>'>
    <input type="hidden" name="refno" id="refno" value='<s:property value="refno"/>'>
    <input type="hidden" name="invdocno" id="invdocno" value='<s:property value="invdocno"/>'>
   
    </td></tr>
    
  
   </table>
   </fieldset>
   
   <td width="80%">
	<table width="100%">
		<tr>
		 <td><div id="splitinvoiceDiv"><jsp:include page="splitinvoiceGrid.jsp"></jsp:include></div></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
   <tr>
		 <td><div id="splitinvoicedetailDiv"><jsp:include page="splitinvoicedetailGrid.jsp"></jsp:include></div></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	 <tr>
		 <td><div id="splitinvoicejvdetailsDiv"><jsp:include page="jvdetailsGrid.jsp"></jsp:include></div></td>
	</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
   <div></div><div></div>
</div>
<div id="postaccwindow">
   <div></div><div></div>
   </div>
</div>
</body>
</html>