<%@page import="com.operations.agreement.leaseagreementcosmo.ClsLeaseAgreementCosmoDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.agreement.rentalagreementcosmo.*" %>
<%
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
ClsLeaseAgreementCosmoDAO viewDAO=new ClsLeaseAgreementCosmoDAO();
%>  
<style type="text/css">
.yellowClass
{
background-color: #deb887; 
}
</style>
<script type="text/javascript">
  var temp='<%=docno%>';
  var da;
  var datas;
  var datas1;
 if(temp>0)
	{
	 
	da='<%=viewDAO.getPreAuthHistory(docno,id)%>';
	//  alert(da);
	}

 else
	 
	{   
	var da= '[{"payment":"Advance"},{"payment":"Security"},{"payment":"Pre Auth"}]';
	

	
	datas='<%=viewDAO.getmode()%>';  
	
	datas1='<%=viewDAO.getcard()%>';  
	//alert(datas);
	 var list = datas.split(","); 
	 var list1 = datas1.split(",");  

/* var list =['CASH','CARD','ONLINE'];
var list1 =['VISA','MASTER']; */
	
	 } 



$(document).ready(function () { 
   var columnsrenderer = function (value) {
		return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
	}
var source =
 {
 datatype: "json",
 datafields: [
            {name : 'payment' , type: 'string'},
           	{name : 'paytype' , type: 'string'},
            {name : 'mode' , type:'String'},
            {name : 'amount' , type:'number'}, 
            {name : 'acode' , type:'String'},
           	{name : 'card' , type:'String'},
           	{name : 'cardno' , type:'number'},
            {name : 'cardtype' , type:'number'},
            {name : 'expdate' , type:'date'},
           	{name : 'recieptno' , type:'String'},
           	{name : 'hidexpdate' , type:'String'}
			   ],
			localdata: da,
      
      pager: function (pagenum, pagesize, oldpagenum) {
          // callback called when a page or pagse size is changed.
      }
};
var cellclassname =  function (row, column, value, data) {


	 return "yellowClass";

		}
var dataAdapter = new $.jqx.dataAdapter(source,
 		 {
     		loadError: function (xhr, status, error) {
           //alert(error);
        }
      });


  $("#preAuthHistoryGrid").jqxGrid(
  {
     width: '100%',
     height: 300,
     source: dataAdapter,
     selectionmode: 'singlerow',
     editable:false,
     showaggregates:true,
     enableAnimations: true,
     filtermode:'excel',
     filterable: true,
     sortable:true,
     pagermode: 'default',
      columns: [
				{ text: 'Payment', datafield: 'payment', width: '9%',editable:false, cellsalign: 'center',align: 'center'},
				{ text: 'Mode',  datafield: 'mode',  width: '10%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
                        editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
					  }
				},
				{ text: 'Amount',  datafield: 'amount',  width: '15%',editable:true,cellsalign: 'right',align: 'right',cellsformat: 'd2'},
				{ text: 'Auth No',  datafield: 'acode',  width: '17.6%',editable:true,cellsalign: 'left',align: 'left',
						cellbeginedit: function (row) {
							var temp=$('#preAuthHistoryGrid').jqxGrid('getcellvalue', row, "paytype");
						     if (parseInt(temp) ==1)
						    	 {
						    			    	 
						       return false; 
						    	 }
						      
						   
						  }
					
					
					},
					
					 { text: ' ', datafield: 'btnsave', width: '2%',editable:false,cellclassname: cellclassname,cellsalign: 'center',align: 'center',hidden:true},
					{ text: 'Card Type',  datafield: 'card',  width: '10%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
                       editor.jqxDropDownList({autoDropDownHeight: true,  enableBrowserBoundsDetection:true,source: list1 });
                        
					
					},cellbeginedit: function (row) {
						var temp=$('#preAuthHistoryGrid').jqxGrid('getcellvalue', row, "paytype");
					     if (parseInt(temp) ==1)
					    	 {
						       return false;
							 }
					    /*  if (temp =="CHEQUE")
					    	 {
					    	 
					    	 
					       return false;
					    	 } */
					     
					     			    	
					    	 
					  }
				
                         },
                   { text: 'cardtypeno',  datafield: 'cardtype',  width: '14%',editable:true,hidden:true},    
					{ text: 'Card NO',  datafield: 'cardno',  width: '19%'  ,editable:true ,cellsalign: 'left',align: 'left',
						cellbeginedit: function (row) {
							var temp=$('#preAuthHistoryGrid').jqxGrid('getcellvalue', row, "paytype");
						     if (parseInt(temp) ==1)
						    	 {
							       return false;
								 }
						   /*   if (temp =="CHEQUE")
						    	 {
						    	 
						    	 
						       return false;
						    	 }
						      */
						     			    	
						    	 
						  }
						  
					},
					{ text: 'Exp:Date',  datafield: 'expdate',  width: '10%', editable:true,columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'MM-yyyy',
			
						cellbeginedit: function (row) {
							var temp=$('#preAuthHistoryGrid').jqxGrid('getcellvalue', row, "paytype");
						     if (parseInt(temp) ==1)
						    	 {
							       return false;
						    	 }
						     /* if (temp =="CHEQUE")
						       return false; */
						  },
						
					
					  createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
			               editor.jqxDateTimeInput({ enableBrowserBoundsDetection: true});
			               
			             
			           }
					
					},
					{ text: 'Hide Date', datafield: 'hidexpdate', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
					{ text: 'Reciept NO', datafield: 'recieptno', width: '9.5%',editable:false, cellsalign: 'left',align: 'left'},
					{ text: 'modetypeno', datafield: 'paytype', width: '8%',editable:false,hidden:true},
					{ text: 'Status', datafield: 'status', width: '12%',editable:false, cellsalign: 'left',align: 'left',hidden:true}
					
					
	              ]
        });

     
   		
         });
         
         
   function getmode(modeval,rowBoundIndex)
   {

			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				
		     			
					var items=x.responseText;
			var docno=items.trim();
		//alert(docno);
					 if(parseInt(docno)>0)
						 {
						 $('#preAuthHistoryGrid').jqxGrid('setcellvalue',rowBoundIndex, "paytype",docno);
						 }
					
			
					
					}
				
			}
				
		x.open("GET","getmodeforpayment.jsp?modeval="+modeval,true);
		
		x.send();

   }
   function getcard(modeval,rowBoundIndex)
   {

			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				
		     			
					var items=x.responseText;
			var docno=items.trim();
		//alert(docno);
					 if(parseInt(docno)>0)
						 {
						 $('#preAuthHistoryGrid').jqxGrid('setcellvalue',rowBoundIndex, "cardtype",docno);
						 }
					
			
					
					}
				
			}
				
		x.open("GET","getcardtypeforpayment.jsp?modeval="+modeval,true);
		
		x.send();

   }
         
   </script>

          
  <div id="preAuthHistoryGrid"></div>  


