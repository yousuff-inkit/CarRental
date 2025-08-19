<%@page import="com.dashboard.limousine.limoschedule.ClsLimoScheduleDAO"%>
<%@page import="com.limousine.limobooking.*" %>
<%ClsLimoScheduleDAO limodao=new ClsLimoScheduleDAO();%>
<% String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
String modelid=request.getParameter("modelid")==null?"0":request.getParameter("modelid");
String tarifmode=request.getParameter("gridname")==null?"":request.getParameter("gridname");
String pickuplocid=request.getParameter("pickuplocid")==null?"":request.getParameter("pickuplocid");
String dropofflocid=request.getParameter("dropofflocid")==null?"":request.getParameter("dropofflocid");
String blockhrs=request.getParameter("blockhrs")==null?"":request.getParameter("blockhrs");
String cldocno=request.getParameter("client")==null?"":request.getParameter("client");
String transfertype=request.getParameter("transfertype")==null?"":request.getParameter("transfertype");
%>
 <script type="text/javascript">

var tarifdata= '<%=limodao.getTarifData(tarifmode,brandid,modelid,pickuplocid,dropofflocid,blockhrs,cldocno,transfertype)%>';

        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'doc_no', type: 'string'},
     						{name : 'validto', type: 'date'},
     						{name : 'tariftype',type:'string'},
     						{name : 'tarifclient',type:'string'},
     						{name : 'estdistance',type:'number'},
     						{name : 'esttime',type:'date'},
     						{name : 'tarif',type:'number'},
     						{name : 'exdistancerate',type:'number'},
     						{name : 'extimerate',type:'number'},
     						{name : 'gid',type:'string'},
     						{name : 'blockhrs',type:'number'},
     						{name : 'exhrrate',type:'number'},
     						{name : 'nighttarif',type:'number'},
     						{name : 'nightexhrrate',type:'number'},
     						{name : 'tarifdetaildocno',type:'number'}
     						
     											
                 ],               
               localdata:tarifdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
            			loadComplete: function () {
                    		 $("#loadingImage").css("display", "none"); 
                		},
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#tarifSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                showfilterrow: true,
                filterable: true, 
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                  /*   var cell = $('#invAcSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#invAcSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                },
                
  
                
                columns: [
                           	{ text:'Doc No',datafield:'doc_no',width:'20%'},	
							{ text: 'Valid To', datafield: 'validto', width: '20%',cellsformat:'dd.MM.yyyy' },
							{text: 'Tarif Type',datafield:'tariftype',width:'40%'},
							{text: 'Tarif Client',datafield:'tarifclient',width:'20%'},
							{text: 'Est.Distance',datafield:'estdistance',width:'20%',hidden:true},
							{text: 'Est.Time',datafield:'esttime',width:'20%',hidden:true,cellsformat:'HH:mm'},
							{text: 'Tarif',datafield:'tarif',width:'20%',hidden:true},
							{text: 'exdistancerate',datafield:'exdistancerate',width:'20%',hidden:true},
							{text: 'extimerate',datafield:'extimerate',width:'20%',hidden:true},
							{text: 'gid',datafield:'gid',width:'20%',hidden:true},
							{text: 'Block Hrs',datafield:'blockhrs',width:'20%',hidden:true},
							{text: 'Ex.Hr rate',datafield:'exhrrate',width:'20%',hidden:true},
							{text: 'Night Tarif',datafield:'nighttarif',width:'20%',hidden:true},
							{text: 'Night ex.hr rate',datafield:'nightexhrrate',width:'20%',hidden:true},
							{text: 'Tarif Detail Docno',datafield:'tarifdetaildocno',width:'20%',hidden:true}
	              		]
            });
       $('#tarifSearch').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	
            	$('#tariffdocno').val($('#tarifSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));
            	$('#tariff').val($('#tarifSearch').jqxGrid('getcellvalue', rowindex, "tarif"));
            	$('#tarifdetaildocno').val($('#tarifSearch').jqxGrid('getcellvalue', rowindex, "tarifdetaildocno"));
            	$('#gid').val($('#tarifSearch').jqxGrid('getcellvalue', rowindex, "gid"));
            	var gridname =  $('#cmbtype').val()=='1'?'transferGrid':'hoursGrid';
            	if(gridname=="transferGrid"){
                	
                	$('#edrate').val($('#tarifSearch').jqxGrid('getcellvalue', rowindex, "exdistancerate"));
                	$('#etrate').val($('#tarifSearch').jqxGrid('getcellvalue', rowindex, "extimerate"));
            	}
            	else if(gridname=="hoursGrid"){
            		
					$('#exhrrate').val($('#tarifSearch').jqxGrid('getcellvalue', rowindex, "exhrrate"));
					$('#ntariff').val($('#tarifSearch').jqxGrid('getcellvalue', rowindex, "nighttarif"));
					$('#nehour').val($('#tarifSearch').jqxGrid('getcellvalue', rowindex, "nightexhrrate"));
            	}
                
                $('#tarifwindow').jqxWindow('close');
                });
            
        });
    </script>
    <div id="tarifSearch"></div>
 
