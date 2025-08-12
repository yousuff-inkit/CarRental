<%@ page import="com.dashboard.vehicle.vehiclepickup.ClsVehiclePickUpDAO" %>
<%ClsVehiclePickUpDAO crcd=new ClsVehiclePickUpDAO(); %>



<% String docno=request.getParameter("docnochk")==null?"0":request.getParameter("docnochk").toString();
String fleet=request.getParameter("fleetchk")==null?"0":request.getParameter("fleetchk").toString();
String regno=request.getParameter("regnochk")==null?"0":request.getParameter("regnochk").toString();
String client=request.getParameter("clientchk")==null?"0":request.getParameter("clientchk").toString();
String date=request.getParameter("datechk")==null?"":request.getParameter("datechk").toString();
String mobile=request.getParameter("mobilechk")==null?"0":request.getParameter("mobilechk").toString();
String branch=request.getParameter("branchchk")==null?"0":request.getParameter("branchchk").toString();
String agmt=request.getParameter("agmt")==null?"0":request.getParameter("agmt").toString();
String chk=request.getParameter("chk")==null?"0":request.getParameter("chk").toString();
//System.out.println("Data"+docno+regno+client+date+mobile+chk+agmt);
%>
<script type="text/javascript">

      var radata='<%=crcd.getAgmtno(docno,fleet,regno,client,date,mobile,branch,agmt,chk)%>';	
		
        $(document).ready(function () { 	
       
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
                          	{name : 'voc_no' , type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'branchname', type: 'String'},
     						{name : 'flname',type:'String'},
     						{name : 'fleet_no',type: 'String'},
     						{name : 'reg_no',type: 'String'},
     						{name : 'color', type: 'String'},
     						{name : 'gid',type: 'String'},
     						{name : 'address', type:'String'},
     						{name : 'mail1',type:'String'},
     						{name : 'per_mob',type: 'String'},
     						{name : 'refname',type:'String'},
     						
     						{name :'cldocno',type:'string'},
     						{name :'okm',type:'string'},
     						
     					
                 ],
                localdata: radata,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#gridRaSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Voc No', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Branch', datafield: 'branchname', width: '15%' },
						 	{ text: 'Fleet No', datafield: 'fleet_no', width: '10%'},
							{ text: 'Fleet Name', datafield: 'flname', width: '30%',hidden:true},
							{ text: 'Reg No', datafield: 'reg_no', width: '15%' },
							{ text: 'color', datafield: 'color', width: '30%',hidden:true },
							{ text: 'Group', datafield: 'gid', width: '30%',hidden:true },
							{ text: 'Client', datafield: 'refname', width: '40%' },
							{ text: 'cldocno',datafield:'cldocno',width:'20%',hidden:true},
							{ text: 'okm',datafield:'okm',width:'20%',hidden:true}
							]
            });
           
            $('#gridRaSearch').on('rowdoubleclick', function (event) {
            	
            	var rowindex1=event.args.rowindex;
             	document.getElementById("agmtno").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	document.getElementById("agmtvocno").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
             	document.getElementById("cldocno").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
             	document.getElementById("fleet_no").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
             	document.getElementById("fleetdetails").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "flname")+" "+"Reg No: "+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
             	document.getElementById("hidkm").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "okm");
				funRoundAmt($('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "okm"),"inkm");
             	$('#agmtnowindow').jqxWindow('close');

            }); 
            var rows=$('#gridRaSearch').jqxGrid('getrows');
            if(rows.length==0){
            $("#gridRaSearch").jqxGrid("addrow", null, {});
            }
        });
    </script>
    <div id="gridRaSearch"></div>
