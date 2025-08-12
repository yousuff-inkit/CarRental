<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

   	<%
   	String rdocno = request.getParameter("rdocno")==null?"NA":request.getParameter("rdocno").trim();

  	String brexid = request.getParameter("brexid")==null?"NA":request.getParameter("brexid").trim();

   	%>

 
<script type="text/javascript">

var rtariffs;

var tepss='<%=rdocno%>';

if(tepss!='NA')
	{
	 rtariffs='<%=crad.ratariffapprovegrid(rdocno,brexid)%>';
	
	}
else
	{
	
	rtariffs;
	}

 

$(document).ready(function () { 
	
	var cellclassname;
	// var cellclass ;
    var num = 0; 
    
    
var source =
  {
  datatype: "json",
  datafields: [
              /* {name : 'available' , type: 'bool' }, */
              	{name : 'rentaltype' , type: 'string' },
              	{name : 'rate' , type:'number'},
              	{name : 'cdw' , type:'number'},
              	{name : 'pai' , type:'number'},
              	{name : 'cdw1' , type:'number'},
              	{name : 'pai1' , type:'number'},
              	{name : 'gps' , type:'number'},
              	{name : 'babyseater' , type:'number'},
              	{name : 'cooler' , type:'number'},
              	 {name : 'kmrest' , type:'number'},
              	{name : 'exkmrte' , type:'number'},
              	{name : 'oinschg' , type:'number'},
              	{name : 'exhrchg' , type:'number'},
              	{name : 'chaufchg' , type:'number'},
              	{name : 'chaufexchg' , type:'number'},
              	{name : 'status' , type:'number'},
              	{name : 'disclevel' , type:'number'},
               	
              	
			   ],
			   localdata: rtariffs,
       
			   
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or pagse size is changed.
       }
 };
 

    $('#rtaiffchange').on('bindingcomplete', function (event) {
    	
    	var rows = $("#rtaiffchange").jqxGrid('getrows');
   //alert(tepss) 	
  if(rows.length<6)
	  {

	 $("#rtaiffchange").jqxGrid('addrow', null,  {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
      

    $("#rtaiffchange").jqxGrid('addrow', null, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
    
    $("#rtaiffchange").jqxGrid('addrow', null, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
	
	 } 
   

});
  
	 
    var rowEdit = function (row) {
    	var rows11 = $("#rtaiffchange").jqxGrid('getrows');
    	
    	var rowval=rows11.length;
    	//alert(rowval);
    	var eidtval=rowval-2;
    	//alert(eidtval);
    		 if (row != eidtval){
    			 
    
    			 return false;
    	}
    }
    
    var cellsrenderer = function (row, column, value, defaultHtml) {
    				var rows11 = $("#rtaiffchange").jqxGrid('getrows');
    					var rowval=rows11.length;
    				var row1=rowval-1;
    				var row2=rowval-2;
    				
    				 if ( row == 0 || row == 1 || row == 2) {
     			    	//alert("row3"+row3);
     			        var element = $(defaultHtml);
     			        element.css({ 'background-color': '#ffe4e1', 'width': '100%', 'height': '100%', 'margin': '0px' });
     			        return element[0].outerHTML;
     			    }
     				 if ( row == row2 ) {
      			    	//alert("row3"+row3);
      			        var element = $(defaultHtml);
      			        element.css({ 'background-color': '#ffffe0', 'width': '100%', 'height': '100%', 'margin': '0px' });
      			        return element[0].outerHTML;
      			    }
     			    var row3=rowval-3;
     			   
     			    if (row == row3 || row == row1 ) {
     			    	//alert(row3);
     			        var element = $(defaultHtml);
     			        element.css({ 'background-color': '#FFE87C', 'width': '100%', 'height': '100%', 'margin': '0px' });
     			        return element[0].outerHTML;
     			    }
    				
    			   /*  if ( row == row1 ) {
    			    	//alert("row3"+row3);
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#e6e6fa', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    }
    				 if ( row == row2 ) {
     			    	//alert("row3"+row3);
     			        var element = $(defaultHtml);
     			        element.css({ 'background-color': '#ffffe0', 'width': '100%', 'height': '100%', 'margin': '0px' });
     			        return element[0].outerHTML;
     			    }
    			    var row3=rowval-3;
    			   
    			    if (row == row3) {
    			    	//alert(row3);
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#ffe4e1', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    } */
    			    return defaultHtml;
    			}


 var dataAdapter = new $.jqx.dataAdapter(source,
  		 {
      		loadError: function (xhr, status, error) {
            alert(error);    
         }
	            
       });


 
   $("#rtaiffchange").jqxGrid(
   {
      width: '100%',
      height: 167,
      source: dataAdapter,
      columnsresize: true,
      rowsheight:20,


      editable:true,
      selectionmode: 'singlecell',
      pagermode: 'default',
      theme: theme,
     
   
       columns: [  
            
					{ text: '   '+document.getElementById("mainrentaltype").value,   datafield: 'rentaltype', editable:false, cellsalign: 'center', align:'center',cellsrenderer: cellsrenderer },
					 { text: '      '+document.getElementById("mainrate").value,     datafield: 'rate', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer },
					{ text: '      '+document.getElementById("maincdw").value,        datafield: 'cdw',  editable:true ,cellsformat: 'd2' , cellsalign: 'right', align:'right',cellbeginedit: rowEdit, cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainpai").value,     	 datafield: 'pai',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit, cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maincdw1").value,    	 datafield: 'cdw1',  editable:true ,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainpai1").value,    	 datafield: 'pai1',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maingps").value,      	 datafield: 'gps',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainbabyseater").value,  	 datafield: 'babyseater',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maincooler").value,          datafield: 'cooler',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '  '+document.getElementById("mainkmrest").value,          datafield: 'kmrest',  editable:true, cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainexkmrte").value,         datafield: 'exkmrte', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainoinschg").value,         datafield: 'oinschg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainexhrchg").value,         datafield: 'exhrchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainchaufchg").value,        datafield: 'chaufchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainchaufexchg").value,      datafield: 'chaufexchg', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Status', datafield: 'status', editable:false,hidden:true},
					{ text: 'disclevel', datafield: 'disclevel', editable:false,hidden:true},
										]
      
        
					 }); 
   
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
   $('#rtaiffchange').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
  
   
  var setvalu = $("#rtaiffchange").jqxGrid('getrows');
	
	var tempone=setvalu.length;
	var nettotalrow=tempone-1;
	var discountrow=tempone-2;
	var rentalrow=tempone-3; 
	

	  $("#rtaiffchange").on('cellclick', function (event) 
			   {
			    
			       var dataField = event.args.datafield;
			     
			       var rowBoundIndex = event.args.rowindex;  
			     			       
			       if(dataField=="cdw"){
			    	   
			    
			    	   
			    var cdw1=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"cdw1") ;

			
			    	
			    if(cdw1>0||cdw1!="")
			    
			    	  {
			    $('#rtaiffchange').jqxGrid('unselectcell', rowBoundIndex, 'cdw'); 
			    $.messager.alert('Message', 'Super CDW Is Selected ');	
			    //	document.getElementById("errormsg").innerText="Super CDW Is Selected";  
	            
			    	return false;
			    	  }
			    else{
			    	 var cdwinsu=document.getElementById("cdwinsu").value;
			    	var tempss="excessinsur";
			    	 funRoundAmt(cdwinsu,tempss);  
			    	
			    	return true;
			      }
			       }
			       if(dataField=="cdw1"){
			     
					    var cdw=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"cdw") ;
				
					    if(cdw>0||cdw!="")
					    
					    	  {
					    	$('#rtaiffchange').jqxGrid('unselectcell', rowBoundIndex, 'cdw1'); 
					    	$.messager.alert('Message', 'CDW Is Selected ');	
					    	//document.getElementById("errormsg").innerText="CDW Is Selected";  
					    	return false;
					    	  }
					    else
					    	{
					         var supercdwinsu=document.getElementById("supercdwinsu").value; 
				            var tempsss="excessinsur";
				            funRoundAmt(supercdwinsu,tempsss); 
					    	return true;
					    	}
					       }
			       if(dataField=="pai"){
			    	   
					    var pai1=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"pai1") ;
						   
					    if(pai1>0||pai1!="")
					    
					    	  {
					    	$('#rtaiffchange').jqxGrid('unselectcell', rowBoundIndex, 'pai');
					    	$.messager.alert('Message', 'Super PAI Is Selected ');	
					    	//document.getElementById("errormsg").innerText="Super PAI Is Selected";  
					    	
					    	return false;
					    	  }
					    else{
					    	return true;
					    }
					       }
			       if(dataField=="pai1"){
			    	   
					    var pai=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"pai") ;
					
					    if(pai>0||pai!="")
					    
					    	  {
					    	$('#rtaiffchange').jqxGrid('unselectcell', rowBoundIndex, 'pai1');
					      	$.messager.alert('Message', 'Super PAI Is Selected');	
					    	
					    	
					    	//document.getElementById("errormsg").innerText="PAI Is Selected";  
					    	return false;
					    	  }
					    else
					    	{
					    	return true;
					    	}
					       }
			       
			   });
	       
	  $("#rtaiffchange").on("cellclick", function (event) {
          var dataFields = event.args.datafield;
         
         rowindex1 = event.args.rowindex;
        // alert("rowindex1======"+rowindex1)
			
            	
         var columnfrist = event.args.columnindex;
	         	 
				 if(columnfrist==0)
				  {
				 
				 if(rowindex1<rentalrow)
					 {
						
				$("#rtaiffchange").jqxGrid('updaterow', rentalrow, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": ""});
				$("#rtaiffchange").jqxGrid('updaterow', discountrow, {"rentaltype": "Discount","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": ""});
				$("#rtaiffchange").jqxGrid('updaterow', nettotalrow, {"rentaltype": "Net Total","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": ""});
				 var normalinsu=document.getElementById("normalinsu").value;
	        	 var tempss="excessinsur";
		    	 funRoundAmt(normalinsu,tempss);
		    		$('#rtaiffchange').jqxGrid('setcellvalue', rentalrow, "rentaltype",$('#rtaiffchange').jqxGrid('getcellvalue', rowindex1, "rentaltype"));
				
	 
				
	 		  $('#rtaiffchange').jqxGrid('setcellvalue', rentalrow, "rate",$('#rtaiffchange').jqxGrid('getcellvalue', rowindex1, "rate"));
				$('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "rate",$('#rtaiffchange').jqxGrid('getcellvalue', rowindex1, "rate"));
		    	
		    	 }
				  }
				 if(columnfrist==1)
				 {
					 
				 
				 var curdateout=new Date($('#jqxDaterentalout').jqxDateTimeInput('getDate')); 	
				 var onemounth=new Date(new Date(curdateout).setMonth(curdateout.getMonth()+1)); 
				    
                $('#jqxDateOut ').jqxDateTimeInput('setDate', new Date(onemounth));
				 
				 }
				 
				 if(columnfrist>0)
					 {
					
					 var value = $('#rtaiffchange').jqxGrid('getcellvalue', rowindex1, "rentaltype");	
					// alert("value :"+value);
					 var values = $('#rtaiffchange').jqxGrid('getcellvalue',3, "rentaltype");	
					// alert("values :"+values);
				
						
			   var val2;
               var val1 = $('#rtaiffchange').jqxGrid('getcellvalue', rowindex1, dataFields);
                 val2 = $('#rtaiffchange').jqxGrid('getcellvalue', discountrow, dataFields);
         	 if(value==values){
				// alert("test");

				 if(rowindex1!=discountrow){
					   
					   $('#rtaiffchange').jqxGrid('setcellvalue', rentalrow, dataFields,val1);
		                $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, dataFields,parseFloat(val3));
					   
				   }
	                $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, dataFields,val1);

				 
			 }
				   if(val2==null)   { val2=0;}   var  val3=parseFloat(val1)-val2;
				  
					 } 
		
	  
});

	   $("#rtaiffchange").on('cellendedit', function (event) 
						   {
					   var rowBoundIndex = event.args.rowindex;
					   var dataField = event.args.datafield;
					  //alert(""+rowBoundIndex)
					
					  
					  if(rowBoundIndex==discountrow)
						   {
							     
								   var value = event.args.value;
						
								   var temp = $('#rtaiffchange').jqxGrid('getcellvalue', rentalrow, dataField);
								
										   if(value=="")
											   {
											   if(dataField=="cdw"){
										    	 var cdw1=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"cdw1") ;
		                                                     if(cdw1>0||cdw1!="")
												    
												    	  {
		                                                    	  $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "cdw","");
		                                                    	
							
												  
												    	return false;
												    	  }
												    else{
										
												    	  $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "cdw",temp);
												    	return true;
												      }
												       }
												       if(dataField=="cdw1"){
												     
														    var cdw=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"cdw") ;
													
														    if(cdw>0||cdw!="")
														    
														    	  {
														    	 $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "cdw1","");
														   
														    	return false;
														    	  }
														    else
														    	{
														 
													            $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "cdw1",temp);
														    	return true;
														    	}
														       }
												       if(dataField=="pai"){
												    	   
														    var pai1=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"pai1") ;
															   
														    if(pai1>0||pai1!="")
														    
														    	  {
														    	 $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "pai","");
												
														    	
														    	return false;
														    	  }
														    else{
														    	 $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "pai",temp);
														    	return true;
														    }
														       }
												       if(dataField=="pai1"){
												    	   
														    var pai=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"pai") ;
														
														    if(pai>0||pai!="")
														    
														    	  {
														   	 $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "pai1","");
														 
														    	return false;
														    	  }
														    else
														    	{
														    	 $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "pai1",temp);
														    	return true;
														    	}
														       }
											
												       
											   $("#rtaiffchange").jqxGrid('setcellvalue', nettotalrow, dataField, temp);
											   }
										   if(value!="")
											   {
									
											var temp2=parseFloat(temp)-parseFloat(value);
												
									console.log(temp+"==="+temp2+"==="+value);     
												
							               $("#rtaiffchange").jqxGrid('setcellvalue', nettotalrow, dataField, temp2);
							    
									
											
											}
									
	                         }
					    }); 

		 		   $("#rtaiffchange").on('cellvaluechanged', function (event) 
				            {
					   
					   var rowBoundIndex1 = event.args.rowindex;
					   var dataField = event.args.datafield;
					
					  if(rowBoundIndex1==discountrow)
						   {
						   if(dataField=="cdw"){
							    	 var cdw1=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"cdw1") ;
	                                            if(cdw1>0||cdw1!="")
									    
									    	  {
	                                           	  $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "cdw","");
	                                           	 $('#rtaiffchange').jqxGrid('setcellvalue', discountrow, "cdw","");
									
									  
									    	return false;
									    	  }
									    
									       }
									       if(dataField=="cdw1"){
									     
											    var cdw=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"cdw") ;
										
											    if(cdw>0||cdw!="")
											    
											    	  {
											    	 $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "cdw1","");
											    	 $('#rtaiffchange').jqxGrid('setcellvalue', discountrow, "cdw1","");
											    
											    	return false;
											    	  }
											   
											       }
									       if(dataField=="pai"){
									    	   
											    var pai1=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"pai1") ;
												   
											    if(pai1>0||pai1!="")
											    
											    	  {
											    	 $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "pai","");
											  
											    	 $('#rtaiffchange').jqxGrid('setcellvalue', discountrow, "pai","");
											    	return false;
											    	  }
											   
											       }
									       if(dataField=="pai1"){
									    	   
											    var pai=$('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow,"pai") ;
											
											    if(pai>0||pai!="")
											    
											    	  {
											   	 $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, "pai1","");
											   	 $('#rtaiffchange').jqxGrid('setcellvalue', discountrow, "pai1","");
											    	return false;
											    	  }
											    
											       }
								
								
						  
						        var tempval = $('#rtaiffchange').jqxGrid('getcellvalue', rentalrow, dataField);
						        var value= $('#rtaiffchange').jqxGrid('getcellvalue', discountrow, dataField);
						 	  var value2= $('#rtaiffchange').jqxGrid('getcellvalue', nettotalrow, dataField);
						        var maxdisc=document.getElementById("calcuvals").value;
						       // console.log(tempval+"=="+value+"=="+value2+"=="+maxdisc+"=="+dataField);  
								if(parseFloat(value)>parseFloat(maxdisc) || (parseFloat(value)>parseFloat(tempval)))  
										{ 
									  var val="";
									  $('#rtaiffchange').jqxGrid('setcellvalue', discountrow, dataField,val);
					            	  $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, dataField,tempval);
					            		//document.getElementById("errormsg").innerText="Discount Limit Exceeded";  
					            		$.messager.alert('Message', 'Discount Limit Exceeded');	
					            		
										return 0;
									  }
								  //console.log("consoleval"+tempval);
					             if(tempval==="")
					              {
					            	// console.log("=blanktemp=");  
					            	  $('#rtaiffchange').jqxGrid('setcellvalue', discountrow, dataField,"");
					            	  $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, dataField,"");
					              }
					            
					             else if(tempval==0)
					                {
					            	
					            	 var dataval=0;
					            	 //console.log("=zerotemp=");  
					             $('#rtaiffchange').jqxGrid('setcellvalue', discountrow, dataField,value);
					            $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, dataField,value2);
					                }
				            }
					  
					  
				            }); 
				   $("#rtaiffchange").on("celldoubleclick", function (event)
						   {
					  
					   var columnIndex3 = event.args.columnindex;
					   //alert(columnIndex3);
					  var rowindex3 = event.args.rowindex;
					  
					  var dataField = event.args.datafield;
			
					   var val="";
					   var columnNames = event.args.datafield;
					   
				
			                if(columnIndex3>0) 
			                	{
			                	
									   if(rowindex3<discountrow)
										 {
										       
								                $('#rtaiffchange').jqxGrid('setcellvalue', discountrow, columnNames,val);
								                $('#rtaiffchange').jqxGrid('setcellvalue', nettotalrow, columnNames,val);
								                if(dataField=="cdw"){
													   
													   var normalinsu=document.getElementById("normalinsu").value;
														
												    	var tempss="excessinsur";
											             
											    	   funRoundAmt(normalinsu,tempss);
											    	   
										               }
										        if(dataField=="cdw1"){
										        	  var normalinsu=document.getElementById("normalinsu").value;
										        	  var tempss="excessinsur";
											             
											    	   funRoundAmt(normalinsu,tempss);
										    	 
												       }
								            
										 }
										
			                	}
					});
				   
				   $("#rtaiffchange").on('cellbeginedit', function (event) 
						   {
					   var rowBoundIndex = event.args.rowindex;
					   var dataField = event.args.datafield;
					  //alert(discountrow);
					  if(rowBoundIndex==discountrow)
						   {
							 
								   var rentalval = $('#rtaiffchange').jqxGrid('getcellvalue', rentalrow, dataField);
								   var discval = $('#rtaiffchange').jqxGrid('getcellvalue', rentalrow, "disclevel"); 
							
								var calcval=(parseFloat(rentalval)*parseFloat(discval))/100;
								
								if(parseFloat(calcval)==0)
								{
							
								 $('#rtaiffchange').jqxGrid('clearselection');
									$.messager.alert('Message', 'Discount Not Allowed');	
							//	document.getElementById("errormsg").innerText="Discount Not Allowed ";
						//	alert("Discount Not Allowed ");
								return 0;
								}
								else
									{
								if(parseFloat(rentalval)>0)
									{
								document.getElementById("calcuvals").value=parseFloat(calcval);
									
									}
								
									}
								
								 
									
	                         }
					    });
				   
				   $("#rtaiffchange").on('cellselect', function (event) 
						   {
					   var rowBoundIndex = event.args.rowindex;
					   var dataField = event.args.datafield;
					
					
					 //  alert(rowBoundIndex+"=="+discountrow);
					   
					  if(rowBoundIndex==discountrow)
						   {
							 
								  
								   var rentalval = $('#rtaiffchange').jqxGrid('getcellvalue', rentalrow, dataField);
								   var discval = $('#rtaiffchange').jqxGrid('getcellvalue', rentalrow, "disclevel");
							
								var calcval=(parseFloat(rentalval)*parseFloat(discval))/100;
								
								if(parseFloat(calcval)==0)
								{
							
								 $('#rtaiffchange').jqxGrid('clearselection');
								 $.messager.alert('Message', 'Discount Not Allowed');	
							//	document.getElementById("errormsg").innerText="Discount Not Allowed ";
								return 0;
								}
														 
									
	                         }
					    });
		   
		
			   

				  
			   
});
    </script>

           
   <div id="rtaiffchange"> </div>
   

<input type="hidden" id="calcuvals">

 <jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include>   



