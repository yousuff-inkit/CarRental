
<%@page import="com.dashboard.operations.invoiceauditing.*"%>
<%
 
	String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
	String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
	String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
	String flno = request.getParameter("flno")==null?"0":request.getParameter("flno");
	String sregno = request.getParameter("sregno")==null?"0":request.getParameter("sregno");
	String smra = request.getParameter("smra")==null?"0":request.getParameter("smra");
	String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
 	String id = request.getParameter("id")==null?"0":request.getParameter("id");
 	String agmttype = request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
 	
 	ClsInvoiceAuditingDAO closedao=new ClsInvoiceAuditingDAO();
%> 
<script type="text/javascript">
	var agmtdata=[];
	var id='<%=id%>';
	if(id=="1"){
		agmtdata='<%=closedao.getAgmtSearchData(sclname,smob,rno,flno,sregno,smra,branch,id,agmttype)%>';	
	}
	
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                         
     						{name : 'refname', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						 {name : 'fleet_no', type: 'String'  }, 
     						{name : 'reg_no', type: 'String'  },
     						 {name : 'mrano', type: 'String'  }, 
      						{name : 'doc_no', type: 'String'  },
      						{name :'agmtno',type:'number'},
      						{name :'voc_no',type:'number'},
      						{name :'voucherno',type:'number'},
							{name : 'allbranch',type:'number'},
      						{name : 'agmtdocno',type:'number'},
      						{name : 'agmtvocno',type:'string'}
      						
      						
                          	],
                          	localdata: agmtdata,
                          
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            $("#agmtSearchGrid").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            }); 
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#agmtSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Doc No', datafield: 'voucherno', width: '10%' },
					{ text: 'Original Doc No',datafield:'doc_no',width:'10%',hidden:true},
					{ text:'Agmt No',datafield:'voc_no',width: '10%'},
					{ text: 'Original Agreement',datafield:'agmtno',width:'10%',hidden:true},
					{ text: 'Agmt Doc No',datafield:'agmtdocno',width:'10%',hidden:true},
					{ text: 'Agmt Voc No',datafield:'agmtvocno',width:'10%',hidden:true},
					{ text: 'Fleet No', datafield: 'fleet_no', width: '10%' },
					{ text: 'Client', datafield: 'refname', width: '28%' }, 
					{ text: 'Mobile', datafield: 'per_mob', width: '22%' },
					{ text: 'Reg No', datafield: 'reg_no', width: '10%'},
					 { text: 'MRA No', datafield: 'mrano', width: '10%' },
					 {text:'All Branch',datafield:'allbranch',width:'10%',hidden:true}
					
					 
			
					
					
					]
            });
      
	$('#agmtSearchGrid').on('rowdoubleclick', function (event){
		var row1=event.args.rowindex;
		document.getElementById("agmtdocno").value=$('#agmtSearchGrid').jqxGrid('getcellvalue', row1, "agmtdocno");
		document.getElementById("agmtvocno").value=$('#agmtSearchGrid').jqxGrid('getcellvalue', row1, "agmtvocno");
		$('#agmtwindow').jqxWindow('close');
	});	 
}); 
				       
                       
    </script>
    <div id="agmtSearchGrid"></div>
    
