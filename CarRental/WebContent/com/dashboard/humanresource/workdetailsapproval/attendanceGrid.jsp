<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.workdetailsapproval.ClsWorkDetailsApprovalDAO"%>
<%ClsWorkDetailsApprovalDAO DAO= new ClsWorkDetailsApprovalDAO(); %> 
<% String totDays = request.getParameter("totdays")==null?"0":request.getParameter("totdays");
   String year = request.getParameter("year")==null?"2016":request.getParameter("year");
   String month = request.getParameter("month")==null?"01":request.getParameter("month");
   String empId = request.getParameter("emp")==null?"0":request.getParameter("emp");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");
   String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");

   %> 
     
<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #fff;
        }
         .greenClass
        {
           background-color: #BEFF33;
        }
</style>
<script type="text/javascript">
		var temp='<%=year%>';
		var tempDays='<%=totDays%>'; 
		var month='<%=month%>';
		var year='<%=year%>';

		var data;
		var dataExcelExport;
        $(document).ready(function () { 	
        	
        	if(temp!='2016')
        	 { 
        		    
        		data='<%=DAO.attendanceGridLoading(session,year,totDays,month,branch,empId)%>';    
        		<%-- dataExcelExport='<%=DAO.attendanceGridLoadingExcelExport(session,totDays,year,month,day,department,category,empId)%>'; --%>  
        	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
			    	        {name : 'tr_no', type: 'int' },
			    	        {name : 'srno', type: 'int' },
                	        {name : 'costtype', type: 'string' },
					    	{name : 'code', type: 'int' },
     						{name : 'name', type: 'string' },
     						{name : 'tr_no', type: 'string' },
     						{name : 'totdays', type: 'int' },
     						{name : 'tot_leave1', type: 'number' },
     						{name : 'dbname', type: 'string' },
     						{name : 'date1', type: 'string' },
     						{name : 'date2', type: 'string' },
     						{name : 'date3', type: 'string' },
     						{name : 'date4', type: 'string' },
     						{name : 'date5', type: 'string' },
     						{name : 'date6', type: 'string' },
     						{name : 'date7', type: 'string' },
     						{name : 'date8', type: 'string' },
     						{name : 'date9', type: 'string' },
     						{name : 'date10', type: 'string' },
     						{name : 'date11', type: 'string' },
     						{name : 'date12', type: 'string' },
     						{name : 'date13', type: 'string' },
     						{name : 'date14', type: 'string' },
     						{name : 'date15', type: 'string' },
     						{name : 'date16', type: 'string' },
     						{name : 'date17', type: 'string' },
     						{name : 'date18', type: 'string' },
     						{name : 'date19', type: 'string' },
     						{name : 'date20', type: 'string' },
     						{name : 'date21', type: 'string' },
     						{name : 'date22', type: 'string' },
     						{name : 'date23', type: 'string' },
     						{name : 'date24', type: 'string' },
     						{name : 'date25', type: 'string' },
     						{name : 'date26', type: 'string' },
     						{name : 'date27', type: 'string' },
     						{name : 'date28', type: 'string' },
     						{name : 'date29', type: 'string' },
     						{name : 'date30', type: 'string' },
     						{name : 'date31', type: 'string' },
     						{name : 'confirmed', type: 'string' },
     						{name : 'empname', type: 'string' },
     						{name : 'emp', type: 'string' },
							{name : 'dbs', type: 'string' },

     						{name : 'brhid', type: 'string' },
     						{name : 'clientaprvdhrs', type: 'string' },
     						{name : 'pholiday', type: 'string' },
     						{name : 'comments', type: 'string' },
     						{name : 'site', type: 'string' },

     						   ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
         
            
            var cellclassname = function (row, column, value, data) {
            	if (data.confirmed == '1') {
                    return "greenClass";
            	};
            }; 
            
      
            
            $("#attendanceGridID").on("bindingcomplete", function (event) {
					 if(tempDays=='28'){
						    $('#attendanceGridID').jqxGrid('hidecolumn', 'date29');
							$("#attendanceGridID").jqxGrid('hidecolumn', 'date30');
			    			$("#attendanceGridID").jqxGrid('hidecolumn', 'date31');
					 }else if(tempDays=='29'){
							$("#attendanceGridID").jqxGrid('hidecolumn', 'date30');
			    			$("#attendanceGridID").jqxGrid('hidecolumn', 'date31');
					 }else if(tempDays=='30'){
			    			$("#attendanceGridID").jqxGrid('hidecolumn', 'date31');
					 }else{
						    $("#attendanceGridID").jqxGrid('showcolumn', 'date29');
						    $("#attendanceGridID").jqxGrid('showcolumn', 'date30');
						    $("#attendanceGridID").jqxGrid('showcolumn', 'date31');
					 }
					 
					  
            });
            
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#attendanceGridID").jqxGrid(
            {
            	width: '100%',
                height: 180,
                source: dataAdapter,
                editable: true,
                selectionmode: 'checkbox',
                localization: {thousandsSeparator: ""},
                showaggregates: true,
                filterable:true,
                showfilterrow:true,
                rowsheight:25,
                enabletooltips:true,

                columns: [
							{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '2%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'C Type', datafield: 'costtype', editable: false , width: '3%' ,   cellclassname: cellclassname},
							{ text: 'Code',  datafield: 'code', editable: false , width: '4%',   cellclassname: cellclassname },
							{ text: 'Employee', datafield: 'empname', editable: false, width: '9%' , hidden:true ,   cellclassname: cellclassname},			
							{ text: 'Client',  datafield: 'name', editable: false,   cellclassname: cellclassname},			
							{ text: 'Site',  datafield: 'site', editable: false   , width: '7%' ,   cellclassname: cellclassname},			

							{ text: '1', datafield: 'date1',   width: '2%' ,  cellsalign: 'center', align: 'center',aggregates: ['sum'] ,   cellclassname: cellclassname },
							{ text: '2', datafield: 'date2',   width: '2%' ,  cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname },
							{ text: '3', datafield: 'date3',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '4', datafield: 'date4',   width: '2%' ,  cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '5', datafield: 'date5',   width: '2%' ,  cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '6', datafield: 'date6',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '7', datafield: 'date7',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '8', datafield: 'date8',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '9', datafield: 'date9',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '10', datafield: 'date10',   width: '2%' ,  cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '11', datafield: 'date11',   width: '2%' ,  cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '12', datafield: 'date12',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '13', datafield: 'date13',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '14', datafield: 'date14',   width: '2%' ,  cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '15', datafield: 'date15',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '16', datafield: 'date16',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '17', datafield: 'date17',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '18', datafield: 'date18',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '19', datafield: 'date19',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '20', datafield: 'date20',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '21', datafield: 'date21',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '22', datafield: 'date22',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '23', datafield: 'date23',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '24', datafield: 'date24',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '25', datafield: 'date25',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '26', datafield: 'date26',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '27', datafield: 'date27',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '28', datafield: 'date28',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '29', datafield: 'date29',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '30', datafield: 'date30',  width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: '31', datafield: 'date31',  width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'],   cellclassname: cellclassname},
							{ text: 'Total', datafield: 'totdays',  editable: false, cellsalign: 'center', align: 'center',width: '3%',   cellclassname: cellclassname},
							{ text: 'Client Approved Hrs', datafield: 'clientaprvdhrs',  cellsalign: 'center', align: 'center',width: '3%',   cellclassname: cellclassname},

							{ text: 'dbname', datafield: 'dbname', editable: false, hidden: true ,  width: '17%' ,   cellclassname: cellclassname},			
							{ text: 'Leave', datafield: 'tot_leave1',hidden:true, editable: false, width: '3%', cellsalign: 'center', align: 'center' ,   cellclassname: cellclassname},
							{ text: 'tr_no', datafield: 'tr_no', editable: false, width: '7%', hidden: true,   cellclassname: cellclassname },
							{ text: 'srno', datafield: 'srno', editable: false, width: '7%',hidden:true,   cellclassname: cellclassname},
							{ text: 'empid', datafield: 'emp', editable: false, width: '7%',hidden: true,  cellclassname: cellclassname},
							{ text: 'confirmed', datafield: 'confirmed', editable: false,hidden: true ,aggregates: ['sum']  ,  width: '17%',   cellclassname: cellclassname },			
							{ text: 'brhid', datafield: 'brhid', editable: false, hidden: true ,  width: '17%' ,   cellclassname: cellclassname},			
							{ text: 'pholiday', datafield: 'pholiday', editable: false, hidden: true ,  width: '17%',   cellclassname: cellclassname },			
							{ text: 'comments', datafield: 'comments', editable: false, hidden: true ,  width: '17%',   cellclassname: cellclassname },			
							{ text: 'dbs', datafield: 'dbs', editable: false,hidden:true,  width: '17%',   cellclassname: cellclassname },			

							],

            });
           
            
            
	    	$("#overlay, #PleaseWait").hide();

	    	$("#attendanceGridID").on('cellclick', function (event) {
           	 var datafield = event.args.datafield;
	   			   var rowIndex = event.args.rowindex;
	   			   var columnIndex = event.args.columnindex;
	   			 var temp=     $("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "emp");	
			   		//alert("date"+(columnIndex-6));
		   			   $('#hiddate').val((columnIndex-6));
			    		//getCheckdate(temp);
			    	
           	  var rows = $('#attendanceGridID').jqxGrid('getrows');
         	      var rowlength= rows.length;
         	    if(datafield=="date1" ||datafield=="date2" || datafield=="date3" || datafield=="date4"|| datafield=="date5"||
         	    		datafield=="date6" || datafield=="date7"||datafield=="date8"||datafield=="date9"||datafield=="date10"||
         	    		datafield=="date11" ||datafield=="date12" || datafield=="date13" || datafield=="date14"|| datafield=="date15"||
         	    		datafield=="date16" || datafield=="date17"||datafield=="date18"||datafield=="date19"||datafield=="date20"||
         	    		datafield=="date21" ||datafield=="date22" || datafield=="date23" || datafield=="date24"|| datafield=="date25"||
         	    		datafield=="date26" || datafield=="date27"||datafield=="date28"||datafield=="date29"||datafield=="date30"||datafield=="date31")
         		  {
         	    	 $('#txtcomments').attr('readonly', false);

		   			   $('#hidcostcode').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "code"));
		   			   $('#hidcosttype').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "costtype"));
		   			   $('#hiddbname').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "dbname"));
		   			  $('#hidempid').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "emp"));
		   		//    $('#hiddate').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "date"+(columnIndex-3)));
         	
         		  }
         	    });
	
	    	 $("#attendanceGridID").on('cellvaluechanged', function (event) {
            	 var datafield = event.args.datafield;
	   			   var rowIndex = event.args.rowindex;
	   			   var columnIndex = event.args.columnindex;
	   		  
            	  var rows = $('#attendanceGridID').jqxGrid('getrows');
          	      var rowlength= rows.length;
          	    if(datafield=="date1" ||datafield=="date2" || datafield=="date3" || datafield=="date4"|| datafield=="date5"||
          	    		datafield=="date6" || datafield=="date7"||datafield=="date8"||datafield=="date9"||datafield=="date10"||
          	    		datafield=="date11" ||datafield=="date12" || datafield=="date13" || datafield=="date14"|| datafield=="date15"||
          	    		datafield=="date16" || datafield=="date17"||datafield=="date18"||datafield=="date19"||datafield=="date20"||
          	    		datafield=="date21" ||datafield=="date22" || datafield=="date23" || datafield=="date24"|| datafield=="date25"||
          	    		datafield=="date26" || datafield=="date27"||datafield=="date28"||datafield=="date29"||datafield=="date30"||datafield=="date31")
          		  {
          	    	 $('#txtcomments').attr('readonly', false);

		   			   $('#hidcostcode').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "code"));
		   			   $('#hidcosttype').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "costtype"));
		   			   $('#hiddbname').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "dbname"));
		   			   $('#hidempid').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "emp"));
		   			   $('#hiddate').val($("#attendanceGridID").jqxGrid('getcellvalue', rowIndex, "date"+(columnIndex-6)));

          		 for(i=0;i<=rowlength-1;i++) {
          			 
          			 
          			 
          		//	 var tothrs=$("#attendanceGridID").jqxGrid('getcellvalue', i, "totdays");
  	          	   var date1=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date1");
  	          	   var date2=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date2");
  	          	   var date3=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date3");
  	          	   var date4=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date4");
  	          	   var date5=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date5");
  	          	   var date6=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date6");
  	          	   var date7=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date7");
  	          	   var date8=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date8");
  	          	   var date9=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date9");
  	          	   var date10=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date10");
  	          	   var date11=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date11");
  	          	   var date12=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date12");
  	          	   var date13=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date13");
  	          	   var date14=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date14");
  	          	   var date15=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date15");
  	          	   var date16=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date16");
  	          	   var date17=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date17");
  	          	   var date18=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date18");
  	          	   var date19=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date19");
  	          	   var date20=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date20");
  	          	   var date21=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date21");
  	          	   var date22=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date22");
  	          	   var date23=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date23");
  	          	   var date24=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date24");
  	          	   var date25=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date25");
  	          	   var date26=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date26");
  	          	   var date27=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date27");
  	          	   var date28=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date28");
  	          	   var date29=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date29");
  	          	   var date30=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date30");
  	          	   var date31=$("#attendanceGridID").jqxGrid('getcellvalue', i, "date31");

  	          	  var regex = /^[-+]?[0-9]+\.[0-9]+$/;
   	  	    	if(regex.test(date1) || regex.test(date2) || regex.test(date3) || regex.test(date4) || regex.test(date5) ||regex.test(date6) ||regex.test(date7)||regex.test(date8)||regex.test(date9)||regex.test(date10)||
     	          			regex.test(date11) || regex.test(date12) || regex.test(date13) || regex.test(date14) || regex.test(date15) ||regex.test(date16) ||regex.test(date17)||regex.test(date18)||regex.test(date19)||regex.test(date20)||
     	          		regex.test(date21) || regex.test(date22) || regex.test(date23) || regex.test(date24) || regex.test(date25) ||regex.test(date26) ||regex.test(date27)||regex.test(date28)||regex.test(date29)||regex.test(date30)||regex.test(date31))
     	          		 {
   	  	    		document.getElementById("errormsg").innerText="Decimal Numbers Not Allowed";
						 return 0;
     	          		 }   
        		          
        		          
        		          
        		          
        /* 		          
   	  	 	 var dvalue=(columnIndex-6);
   			 if(dvalue<10)
   				 {
   				 dvalue="0"+dvalue;
   				 }
			var dat=(year+"-"+month+"-"+dvalue);
			var startdate=$('#hidsdate').val();
			var enddate=$('#hidedate').val();
			//alert("date---"+dat+"sdate==="+startdate+"edate====="+enddate);
			var costtype=$('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "costtype");
		//alert(costtype);
		if(costtype!='COST')
			{
if(startdate!="" || enddate!="")
			{
		if(dat<startdate || dat>enddate)
		{
			$.messager.alert('warning','Project Valid till-'+enddate);  
			date[i]=0;
			return false;
		}
			}
			}
        		 */          
        		          
	  	          		 
  	          
 	  	    	var val="0";
  	          	 if(isNaN(date1)==true )
  	          		 {
  	          		document.getElementById("errormsg").innerText="";    

  	          		if(!(date1=='H') && !(date1=='LH' ))
  	          			{
	  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date1" ,val);

  	          		document.getElementById("errormsg").innerText="Characters Not Allowed";    

  	          		return 0;
     	             
  	          		 }
  	          		else
  	          			{
  	          			date1=0;
  	          			}
  	          		
  	          		 }
  	          	if(isNaN(date2)==true )
	          		 {
  	          		document.getElementById("errormsg").innerText="";    

  	          	if(!(date2=='H') && !(date2=='LH') )
          			{
  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date2" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    

  	          	return 0;
	          		 }
  	          else
      			{
      			date2=0;
      			}
	          		 }
  	          	
  	          	if(isNaN(date3)==true )
	          		 {
  	          	document.getElementById("errormsg").innerText="";    

  	          	if(!(date3=='H') && !(date3=='LH') )
      			{
  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date3" ,val);

	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
	             return 0;
	  	          		 }
  	          else
      			{
      			date3=0;
      			}
	          		 }
	          		 if(isNaN(date4)==true )
  	          		 {
	  	          		document.getElementById("errormsg").innerText="";    

	          			if(!(date4=='H') && !(date4=='LH') )
          			{
		  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date4" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
 	             return 0;
		  	          		 }
	          			else
	          			{
	          			date4=0;
	          			}
  	          		 }
	          		 
	          		 
	          		 if(isNaN(date5)==true )
		  	          		 {
	  	          		document.getElementById("errormsg").innerText="";    
	          			if(!(date5=='H') && !(date5=='LH') )
          			{
		  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date5" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
 	             return 0;
			  	          		 }
	          			else
	          			{
	          			date5=0;
	          			}
		  	          		 }
	          		 if(isNaN(date6)==true )
	          		 {
		  	          	document.getElementById("errormsg").innerText="";    

	          			if(!(date6=='H')&& !(date6=='LH') )
          			{
		  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date6" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
 	             return 0;
	          		 }
	          			else
	          			{
	          			date6=0;
	          			}
	          		 }
	          	if(isNaN(date7)==true )
          		 {
  	          	document.getElementById("errormsg").innerText="";    

	          	if(!(date7=='H')&& !(date7=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date7" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
          		 }
	          else
  			{
  			date7=0;
  			}
          		 }
	          	if(isNaN(date8)==true )
          		 {
  	          	document.getElementById("errormsg").innerText="";    

	          	if(!(date8=='H')&& !(date8=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date8" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
  	          		 }
	          else
  			{
  			date8=0;
  			}
          		 }
          		 if(isNaN(date9)==true )
	          		 {
 	  	          	document.getElementById("errormsg").innerText="";    

          			if(!(date9=='H')&& !(date9=='LH') )
          			{
	  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date9" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
 	             return 0;
	  	          		 }
          			else
	          			{
	          			date9=0;
	          			}
	          		 }
          		 if(isNaN(date10)==true )
	  	          		 {
 	  	          	document.getElementById("errormsg").innerText="";    

          			if(!(date10=='H')&& !(date10=='LH') )
          			{
	  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date10" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
 	             return 0;
		  	          	 }
          			else
	          			{
	          			date10=0;
	          			}
	  	          		 }
          		 if(isNaN(date11)==true )
	          		 {
 	  	          	document.getElementById("errormsg").innerText="";    

          			if(!(date11=='H')&& !(date11=='LH') )
          			{
	  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date11" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
 	             return 0;
	          		 }
          			else
	          			{
	          			date11=0;
	          			}
	          		 }
	          	if(isNaN(date12)==true )
          		 {
	          		document.getElementById("errormsg").innerText="";    

	          	if(!(date12=='H')&& !(date12=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date12" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
          		 }
	          else
  			{
  			date12=0;
  			}
          		 }
	          	if(isNaN(date13)==true )
          		 {
  	          	document.getElementById("errormsg").innerText="";    

	          	if(!(date13=='H')&& !(date13=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date13" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
  	          		 }
	          else
  			{
  			date13=0;
  			}
          		 }
          		 if(isNaN(date14)==true )
	          		 {
 	  	          	document.getElementById("errormsg").innerText="";    

          			if(!(date14=='H')&& !(date14=='LH') )
          			{
	  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date14" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
 	             return 0;
	  	          		 }
          			else
	          			{
	          			date14=0;
	          			}
	          		 }
          		 
          		 if(isNaN(date15)==true )
	  	          		 {
 	  	          	document.getElementById("errormsg").innerText="";    

          			if(!(date15=='H')&& !(date15=='LH') )
          			{
	  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date15" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
 	             return 0;
		  	          		 }
          			else
	          			{
	          			date15=0;
	          			}
	  	          		 }
          		 if(isNaN(date16)==true )
          		 {
 	  	          	document.getElementById("errormsg").innerText="";    

          			if(!(date16=='H')&& !(date16=='LH') )
          			{
	  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date16" ,val);

  	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
 	             return 0;
          		 }
          			else
	          			{
	          			date16=0;
	          			}
          		 }
          	if(isNaN(date17)==true )
      		 {
  	          	document.getElementById("errormsg").innerText="";    

          		if(!(date17=='H')&& !(date17=='LH') )
      			{
  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date17" ,val);

	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
	             return 0;
      		 }
          		else
          			{
          			date17=0;
          			}
      		 }
          	if(isNaN(date18)==true )
      		 {
  	          	document.getElementById("errormsg").innerText="";    

          		if(!(date18=='H')&& !(date18=='LH') )
      			{
  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date18" ,val);

	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
	             return 0;
	          		 }
          		else
          			{
          			date18=0;
          			}
      		 }
      		 if(isNaN(date19)==true )
          		 {
	  	          	document.getElementById("errormsg").innerText="";    

      			if(!(date19=='H')&& !(date19=='LH') )
      			{
  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date19" ,val);

	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
	             return 0;
  	          		 }
      			else
          			{
          			date19=0;
          			}
          		 }
      		 if(isNaN(date20)==true )
  	          		 {
	  	          	document.getElementById("errormsg").innerText="";    

      			if(!(date20=='H')&& !(date20=='LH') )
      			{
  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date20" ,val);

	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
	             return 0;
	  	          	 }
      			else
          			{
          			date20=0;
          			}
  	          		 }
      		 if(isNaN(date21)==true )
          		 {
	  	          	document.getElementById("errormsg").innerText="";    

      			if(!(date21=='H')&& !(date21=='LH') )
      			{
  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date21" ,val);

	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
	             return 0;
          		 }
      			else
          			{
          			date21=0;
          			}
          		 }
          	if(isNaN(date22)==true )
   		 {
  	          	document.getElementById("errormsg").innerText="";    

          		if(!(date22=='H')&& !(date22=='LH') )
      			{
  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date22" ,val);

	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
	             return 0;
   		 }
          		else
          			{
          			date22=0;
          			}
   		 }
          	if(isNaN(date23)==true )
    		 {
  	          	document.getElementById("errormsg").innerText="";    

          		if(!(date23=='H')&& !(date23=='LH') )
      			{
  	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date23" ,val);

	          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
	             return 0;
          		 }
          		else
          			{
          			date23=0;
          			}
    		 }
   		 if(isNaN(date24)==true )
          		 {
  	          	document.getElementById("errormsg").innerText="";    

   			if(!(date24=='H')&& !(date24=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date24" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
  	          		 }
   			else
    			{
    			date24=0;
    			}
          		 }
   		 if(isNaN(date25)==true )
  	          		 {
  	          	document.getElementById("errormsg").innerText="";    

   			if(!(date25=='H')&& !(date25=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date25" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
	  	          		 }
   			else
    			{
    			date25=0;
    			}
  	          		 }
   		 if(isNaN(date26)==true )
    		 {
  	          	document.getElementById("errormsg").innerText="";    

   			if(!(date26=='H')&& !(date26=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date26" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
    		 }
   			else
    			{
    			date26=0;
    			}
    		 }
    	if(isNaN(date27)==true )
  		 {
	          	document.getElementById("errormsg").innerText="";    

    		if(!(date27=='H')&& !(date27=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date27" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
  		 }
    		else
    			{
    			date27=0;
    			}
  		 }
    	if(isNaN(date28)==true )
  		 {
	          	document.getElementById("errormsg").innerText="";    

    		if(!(date28=='H')&& !(date28=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date28" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
          		 }
    		else
    			{
    			date28=0;
    			}
  		 }
  		 if(isNaN(date29)==true )
    		 {
  	          	document.getElementById("errormsg").innerText="";    

  			if(!(date29=='H')&& !(date29=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date29" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
	          		 }
  			else
    			{
    			date29=0;
    			}
    		 }
  		 
  		 if(isNaN(date30)==true )
	          		 {
  	          	document.getElementById("errormsg").innerText="";    

  			if(!(date30=='H')&& !(date30=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date30" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
  	          	 }
  			else
    			{
    			date30=0;
    			}
	          		 }
  		if(isNaN(date31)==true )
   		 {
	          	document.getElementById("errormsg").innerText="";    

  			if(!(date31=='H') && !(date31=='LH') )
  			{
	          		$('#attendanceGridID').jqxGrid('setcellvalue', i, "date31" ,val);

          	document.getElementById("errormsg").innerText="Characters Not Allowed";    
             return 0;
          	 }
  			else
    			{
    			date31=0;
    			}
  			
   		 }
  		
  		
  		
 			var	totdays=parseFloat(date1)+parseFloat(date2)+parseFloat(date3)+parseFloat(date4)+parseFloat(date5)+parseFloat(date6)+parseFloat(date7)+parseFloat(date8)+parseFloat(date9)+parseFloat(date10)+parseFloat(date11)+parseFloat(date12)+parseFloat(date13)+parseFloat(date14)+parseFloat(date15)+parseFloat(date16)+parseFloat(date17)+parseFloat(date18)+parseFloat(date19)+parseFloat(date20)+parseFloat(date21)+parseFloat(date22)+parseFloat(date23)+parseFloat(date24)+parseFloat(date25)+parseFloat(date26)+parseFloat(date27)+parseFloat(date28)+parseFloat(date29)+parseFloat(date30)+parseFloat(date31);
 				
 			var costtype=$("#attendanceGridID").jqxGrid('getcellvalue', i, "costtype");
       	   var costcode=$("#attendanceGridID").jqxGrid('getcellvalue', i, "code");
       	   var pholiday=$("#attendanceGridID").jqxGrid('getcellvalue', i, "pholiday");

			for(var j=1;j<=31;j++)
			{
				var b=$('#attendanceGridID').jqxGrid('getcelltext', i, "date"+[j]);

		 	if(costtype=='STC' && b=='LH' && pholiday=='1')
		 		{
		 				 			
		 				//alert("in");
		 			
	 		 		totdays=totdays+8;

		 		}
		 		else
		 			{
	 		 		totdays=totdays;

		 			}
 			
 			
 			$('#attendanceGridID').jqxGrid('setcellvalue', i, "totdays" ,totdays);

			}	 
          		 }
          		  }
          	      
          
          	
				 
    	
    	  });

        });
	    
	
    </script>
    <div id="attendanceGridID"></div>
 