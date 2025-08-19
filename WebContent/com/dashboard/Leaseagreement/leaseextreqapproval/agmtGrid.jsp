
<%String brhid=request.getParameter("brhid")==""?"":request.getParameter("brhid"); %>

<script type="text/javascript">
var brhid='<%=brhid%>'; 

var agmturl='getGridData.jsp?mode=1&brhid='+brhid;
	$(document).ready(function(){
        
        var source = 
        {
            datatype: "json",
            datafields: [
                      	{name : 'docno' , type: 'number' },
                      	{name : 'vocno' , type: 'number' },
                      	{name : 'cldocno' , type: 'number' },
 						{name : 'refname', type: 'string'  },
                      	{name : 'expdate', type: 'date'  },
                      	{name : 'outdate',type:'date'},
                      	{name : 'invtodate',type:'date'},
                      	{name : 'date',type:'date'},
                      	{name : 'rate',type:'number'},
                      	{name : 'regno',type:'string'},
                      	{name : 'brand',type:'string'},
                      	{name : 'model',type:'string'},
                      	{name : 'residualvalue',type:'number'},
                      	{name : 'extdocno',type:'string'},
                      	{name : 'reqremarks',type:'string'},
                      	{name : 'totalrent',type:'string'},
                      	{name : 'extdate',type:'date'},
                      	{name : 'newresval',type:'string'},
                      	{name : 'startdt',type:'date'},
                      	{name : 'noofmonth',type:'string'},
                      	{name : 'bankname',type:'string'},
                      	{name : 'bankacno',type:'string'},
                      	{name : 'date1',type:'date'},
                       	{name : 'le_clacno',type:'string'},
                       	{name : 'extno',type:'string'},
                       	{name : 'brhid',type:'string'},
                       	{name : 'approvalstatus',type:'string'},
                       	{name : 'perfleet',type:'string'},


                      	
                      	
                      	
             ],
             url: agmturl,
            
            
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



        $("#agmtGrid").jqxGrid(
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                    sortable: true,
                    editable: false,
                    altrows:true,
                    enabletooltips:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false, cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Doc No',datafield: 'docno', width: '10%',hidden:true,editable:false },
    					{ text: 'Doc No',datafield: 'vocno', width: '3%',editable:false },
    					{ text: 'Client #',datafield: 'cldocno', width: '4%',editable:false },
    					{ text: 'Date',datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy',hidden:true,editable:false },
    					{ text: 'Client Name',datafield: 'refname',editable:false },
    					{ text: 'From Date',datafield: 'outdate', width: '5%',cellsformat:'dd.MM.yyyy',editable:false },
    					{ text: 'To Date',datafield: 'invtodate', width: '5%',cellsformat:'dd.MM.yyyy',editable:false,hidden:true },
    					{ text: 'Expiry Date',datafield: 'expdate', width: '5%',cellsformat:'dd.MM.yyyy',editable:false },
    					{ text: 'Contract Value',datafield: 'rate', width: '6%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false },
    					{ text: 'Extension No',datafield: 'extdocno', width: '5%',editable:false  ,hidden:true },
						{ text: 'Extension No',datafield: 'extno', width: '5%',editable:false},
    					{ text: 'Remarks',datafield: 'reqremarks', width: '10%',editable:false },
    					{ text: 'Reg No',datafield: 'regno', width: '6%',editable:false },
    					{ text: 'Brand',datafield: 'brand', width: '7%',editable:false },
    					{ text: 'Model',datafield: 'model', width: '10%',editable:false },
    					{ text: 'totalrent',datafield: 'totalrent', width: '10%',editable:false,hidden:true },
    					{ text: 'New Residual Value',datafield: 'newresval', width: '8%',hidden:true },
    					{ text: 'Residual Value',datafield: 'residualvalue', width: '8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false },
    					{ text: 'extdate',datafield: 'extdate', width: '6%',cellsformat:'dd.MM.yyyy',editable:false,hidden:true },
    					{ text: 'startdt',datafield: 'startdt', width: '6%',cellsformat:'dd.MM.yyyy',editable:false,hidden:true },
    					{ text: 'noofmonth',datafield: 'noofmonth', width: '10%',editable:false ,hidden:true},
    					{ text: 'bankname',datafield: 'bankname', width: '10%',editable:false ,hidden:true},
    					{ text: 'bankacno',datafield: 'bankacno', width: '10%',editable:false ,hidden:true},
    					{ text: 'date1',datafield: 'date1', width: '6%',cellsformat:'dd.MM.yyyy',editable:false ,hidden:true},
    					{ text: 'le_clacno',datafield: 'le_clacno', width: '10%',editable:false ,hidden:true},
    					{ text: 'approvalstatus',datafield: 'approvalstatus', width: '10%',editable:false ,hidden:true },
    					{ text: 'brhid',datafield: 'brhid', width: '10%',editable:false ,hidden:true},
    					{ text: 'perfleet',datafield: 'perfleet', width: '10%',editable:false  ,hidden:true},

    	              ]
                });
        $('.load-wrapp').hide(); 

    	$('#agmtGrid').on('rowdoubleclick', function (event) 
		{ 
	    	$('#field-existing > table > tbody > tr:nth-child(1) > td:nth-child(2)').text('');
	    	$('#field-existing > table > tbody > tr:nth-child(2) > td:nth-child(2)').text('');
	    	$('#field-existing > table > tbody > tr:nth-child(1) > td:nth-child(4)').text('');
	    	$('#field-existing > table > tbody > tr:nth-child(2) > td:nth-child(4)').text('');
	    	$('#pyttotalrent').text('');
	    //	$('#extdate').text('');
	    	$('#nwrsdvalue').text('');

		    var args = event.args;
		    // row's bound index.
		    var boundIndex = args.rowindex;
		    // row's visible index.
		    var visibleIndex = args.visibleindex;
		    // right click.
		    var rightclick = args.rightclick; 
		    // original event
		    var ev = args.originalEvent;
		      $('.textpanel p').text( $('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "refname"));

		    var agmtvocno=$('#agmtGrid').jqxGrid('getcellvalue',boundIndex,'vocno');
		    var agmtdocno=$('#agmtGrid').jqxGrid('getcellvalue',boundIndex,'docno');
		    var extdocno=$('#agmtGrid').jqxGrid('getcellvalue',boundIndex,'extdocno');
			$('#btnpytedit').show();
			$('#btnpytsave,#btnpytcancel,#btnprocess').hide();
					    if(extdocno!=""){
    			$('#btnpytedit').attr('disabled',false);
    		} 
		    $('span#agmtselected').text(agmtvocno);
		    $.get('getInitData.jsp',{'mode':2,'agmtdocno':agmtdocno,'extdocno':extdocno},function(data){
		    	data=JSON.parse(data);
		    	$('#field-existing > table > tbody > tr:nth-child(1) > td:nth-child(2)').text(data.pyttotalrent);
		    	$('#field-existing > table > tbody > tr:nth-child(2) > td:nth-child(2)').text(data.residualvalue);
		    	$('#field-existing > table > tbody > tr:nth-child(1) > td:nth-child(4)').text(data.pytduration);
		    	$('#field-existing > table > tbody > tr:nth-child(2) > td:nth-child(4)').text(data.deprdate+" - "+data.depramt);

            	
		    });
		    var extno=$('#agmtGrid').jqxGrid('getcellvalue',boundIndex,'extno');

            document.getElementById("pyttotalrent").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "totalrent");  
            $('#extdate').jqxDateTimeInput('setDate', $('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "extdate"));
            $('#pytstartdate').jqxDateTimeInput('setDate', $('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "startdt"));
            document.getElementById("nwrsdvalue").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "newresval");         
            document.getElementById("extdocno").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "extdocno");         
            document.getElementById("agmtdocno").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "docno");
            document.getElementById("agmtvocno").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "vocno");  
            document.getElementById("pytmonthsno").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "noofmonth");         
            document.getElementById("extno").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "extno");         
            document.getElementById("hidpytbankacno").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "bankacno");         
            document.getElementById("pytbankacno").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "bankname");         
            $('#date1').jqxDateTimeInput('setDate', $('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "date1"));
            document.getElementById("le_clacno").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "le_clacno");         
            document.getElementById("brhid1").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "brhid");         
            document.getElementById("hidapprstatus").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "approvalstatus");         
            document.getElementById("hidperfleet").value=$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "perfleet");         
           $('#hidfromdt').jqxDateTimeInput('setDate', $('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "outdate"));
          if(extno=="" || extno=="0")
        	  {
              $('#hidtodt').jqxDateTimeInput('setDate', $('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "expdate"));

        	  }
          else
        	  {
              $('#hidtodt').jqxDateTimeInput('setDate', $('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "extdate"));	  

        	  }

            $("#detailDiv").load("detailGrid.jsp?doc="+$('#agmtGrid').jqxGrid('getcellvalue', boundIndex, "docno"));       
			$('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('extdocno').value+'&id=2');

if(extdocno!="")
	{
	 $('#field-extension').attr("disabled",false);

	}
else{
	 $('#field-extension').attr("disabled",true);

}
		});
	});
</script>
<div id="agmtGrid"></div>