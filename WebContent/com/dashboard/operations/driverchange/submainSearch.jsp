 <%@ page import="com.dashboard.operations.driverchange.ClsDriverchangeDAO" %>
<%ClsDriverchangeDAO clad=new ClsDriverchangeDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String flno = request.getParameter("flno")==null?"0":request.getParameter("flno");
 String sregno = request.getParameter("sregno")==null?"0":request.getParameter("sregno");
 String smra = request.getParameter("smra")==null?"0":request.getParameter("smra");
 String agmttype=request.getParameter("agmttype")==null?"0":request.getParameter("agmttype");
%> 
 <script type="text/javascript">
var loaddatass='<%=clad.getAgmtno(sclname,smob,rno,flno,sregno,smra,agmttype)%>';  
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                 		
     						{name : 'refname', type: 'String'},
     						{name : 'per_mob', type: 'String'},
     						 {name : 'fleet_no', type: 'String'}, 
     						{name : 'reg_no', type: 'String'},
     						 {name : 'mrano ', type: 'string'}, 
      						{name : 'doc_no', type: 'String'  },
      						{name : 'cldocno', type: 'String'  },
      						{name : 'voc_no',type:'string'},
      						{name : 'mrano', type: 'String'  },
      						{name : 'gid', type: 'String'  }
      						
                          	],
                          	localdata: loaddatass,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#jqxsubmainsearch").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
             
               
                //Add row method
     					
     					
                columns: [
							{ text: 'Original DOC NO', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'DOC NO', datafield: 'voc_no', width: '10%' },
							{ text: 'FLEET NO', datafield: 'fleet_no', width: '10%' },
							{ text: 'NAME', datafield: 'refname', width: '28%' }, 
							{ text: 'MOB', datafield: 'per_mob', width: '22%' },
							{ text: 'REG NO', datafield: 'reg_no', width: '15%'},
							{ text: 'MRA', datafield: 'mrano', width: '15%'},
							 { text: 'Cldoc', datafield: 'cldocno', width: '15%',hidden:true },
							 { text: 'Gid', datafield: 'gid', width: '15%',hidden:true }
							 
			
					
					
					]
            });
    
          /*   $("#jqxsubmainsearch").jqxGrid('addrow', null, {}); */
      
				            
				          $('#jqxsubmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				       //     	document.getElementById("hidagmtno").value=$('#jqxsubmainsearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
				               document.getElementById("docnoos").value=$('#jqxsubmainsearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
				               document.getElementById("docnos").value=$('#jqxsubmainsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				              
				             $('#agmtnowindow').jqxWindow('close');
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxsubmainsearch"></div>
    
