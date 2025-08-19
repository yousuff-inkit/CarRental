<%@page import="com.dashboard.operations.employeesponsor.ClsEmployeeSponsorDAO"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<%
ClsEmployeeSponsorDAO dao=new ClsEmployeeSponsorDAO();
String brchid=request.getParameter("brchid")==null?"0":request.getParameter("brchid");
String chk=request.getParameter("chk")==null?"0":request.getParameter("chk");
%>
<style type="text/css">
    .redClass
    {
       background-color: #F1948A; 
    }
</style>
<script type="text/javascript">

var brchid='<%=brchid%>'; 
var chk='<%=chk%>'; 
var databrand;
 if(chk>0){
	databrand='<%=dao.getEmployeeData(brchid,chk)%>';
}else{
	
	databrand; 
	
} 
databrand;
	$(document).ready(function () { 
	       var source =
	       {
	           datatype: "json",
	           datafields: [
	           				{name : 'riderid' , type: 'number' },
	                     	{name : 'doc_no' , type: 'number' },
							{name : 'empname', type: 'String'  },
							{name : 'empdocno', type: 'number'  },
							{name : 'saldocno', type: 'number'  },
							{name : 'empmobile', type: 'String'  },
	                     	{name : 'empdesig', type: 'String'  },
	                     	{name : 'empid', type: 'number'  },
	                     	{name : 'vendorid', type: 'number'  },
	                     	{name : 'vendor', type: 'String'  },
	            ],
	          localdata: databrand,
	          pager: function (pagenum, pagesize, oldpagenum) {
	               // callback called when a page or page size is changed.
	           }
	       };
	       
	       var dataAdapter = new $.jqx.dataAdapter(source,
	       		 {
	           		loadError: function (xhr, status, error) {
	                  // alert(error);    
	                   }
		            }		
	       );
	       
	       var cellclassname =  function (row, column, value, data) {

			}

	       $("#jqxemployeesponsorgrid").jqxGrid(
	               {
                       width: '99%',	
                       height: 500,
	                   source: dataAdapter,
	                   showfilterrow: true,
	                   filterable: true,
	                   editable:true,
	                   enabletooltips:true,
	                   columnsresize: true,
	                   selectionmode: 'checkbox',
	                   //Add row method
	                   columns: [
	                	{ text: 'Sr. No', sortable: false,pinned:true,filterable: false, editable: false,
	                           groupable: false, draggable: false, resizable: false,datafield: '',
	                           columntype: 'number', width: '3%',cellclassname: cellclassname,cellsalign: 'center', align: 'center',
	                           cellsrenderer: function (row, column, value) {
	                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                     }},
	   					{ text: 'Rider Id', datafield: 'riderid', width: '10%',editable:false},
	   					{ text: 'Employee ID', datafield: 'empid', width: '10%',editable:false},
	   					{ text: 'Employee Name', datafield: 'empname', width: '25%',editable:false},
	   					{ text: 'Employee Mobile No.',datafield: 'empmobile',editable:false,width: '15%'},
	   					{ text: 'Designation', datafield: 'empdesig', width: '15%',editable:false},
	   					{ text: 'Vendor', datafield: 'vendor', width: '20%',editable:false},
	   					
	   	              ]
	               });
	      
	       $("#overlay, #PleaseWait").hide();
	       
	     	       
        });
	
	  
</script>  
<div id="jqxemployeesponsorgrid" ></div> 

	