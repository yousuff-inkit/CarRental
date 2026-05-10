<%@page import="com.controlcentre.masters.tarifmgmtnew.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>

<!-- The div must exist before the script runs -->
<div id="tarifSearch"></div>

<script type="text/javascript">
    var data8= <%=ctd.mainSearchList()%>;
  
    // REMOVED $(document).ready() wrapper here!
    
    var num = 0;
    var source =
    {
        datatype: "array", 
        datafields: [
                    {name : 'docno' , type: 'int' },
                    {name : 'date', type: 'String'  },
                    {name : 'tariftype', type: 'String'  },
                    {name : 'tariffor', type:'String'},
                    {name : 'fromdate', type:'String'},
                    {name : 'todate', type:'String'},
                    {name : 'notes', type:'String'},
                    {name : 'clientid', type:'String'},
                    {name : 'clientname', type: 'String'}
            ],
        localdata: data8,
        pager: function (pagenum, pagesize, oldpagenum) {
        }
    };
    var dataAdapter = new $.jqx.dataAdapter(source,
                {
                loadError: function (xhr, status, error) {
                }
            }		
    );
    $("#tarifSearch").jqxGrid(
    {
        width: 800, 
        height: 350,
        source: dataAdapter,
        columnsresize: true,
        altRows: true,
        selectionmode: 'singlerow',
        filterable:true,
        showfilterrow:true,
        columns: [
                    { text: 'Doc No', datafield: 'docno', width: '8%' },
                    { text: 'Date', datafield: 'date', width: '60%',cellsformat:'dd.MM.yyyy',hidden:true },
                    { text: 'Tarif Type', datafield: 'tariftype', width: '20%' },
                    { text: 'Tarif For', datafield: 'tariffor', width:'20%',hidden:true},
                    { text: 'From Date', datafield: 'fromdate', width:'20%',cellsformat:'dd.MM.yyyy'},
                    { text: 'To Date', datafield: 'todate', width:'20%',cellsformat:'dd.MM.yyyy'},
                    { text: 'Notes', datafield:'notes',width:'32%'},
                    {text: 'Client Id',datafield:'clientid',width:'20%',hidden:true},
                    {text: 'Client Name',datafield:'clientname',width:'20%',hidden:true}
            ]
    });
    
    $('#tarifSearch').on('rowdoubleclick', function (event) {
        var temp00="";
        var temp01=0;
        var rowindex1=event.args.rowindex;
        $('#jqxTariffFromDate').jqxDateTimeInput({ disabled: false});
        $('#jqxTariffToDate').jqxDateTimeInput({ disabled: false});
        $('#jqxTariffDate').jqxDateTimeInput({ disabled: false});
        document.getElementById("docno").value= $('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "docno");
        var docno1=document.getElementById("docno").value==null?0:document.getElementById("docno").value;
        $("#jqxTariffDate").jqxDateTimeInput('val',$("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "date"));
        $("#jqxTariffFromDate").jqxDateTimeInput('val',$("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "fromdate"));
        $("#jqxTariffToDate").jqxDateTimeInput('val',$("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "todate"));
        $('#cmbtariftype').val($("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "tariftype")) ;
        $('#cmbtariffor').val($("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "tariffor")) ;
        
        if($('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientname")=="undefined" ||$('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientname")==null){
            temp00="";
        }
        else{
            temp00=$('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientname");
        }
        if($('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientid")=="undefined" ||$('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientid")==null){
            temp01=0;
        }
        else{
            temp01=$('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientid");
        }
        document.getElementById("txtclient").value=temp00;
        document.getElementById("hidtxtclient").value=temp01;
            document.getElementById("notes").innerHTML=$("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "notes") ;
            $("#divgroup1").load("gridgroup1.jsp?id="+docno1);
            $("#divgroup2").load("gridgroup2.jsp?id="+docno1);
            $("#divRegularTarif").load("gridRegularTarif.jsp");
            $("#divfoc").load("gridFoc.jsp");
            $("#divweekday").load("gridWeekday.jsp");
        $("#divslab").load("gridSlabTarif.jsp");
        $("#divpackage").load("gridPackageTarif.jsp");
            document.getElementById("grouplabel").style.display="none";
            document.getElementById("btnTarifEdit").style.display="none";
            document.getElementById("btnTarifSave").style.display="none";
            $('#jqxTariffFromDate').jqxDateTimeInput({ disabled: true});
        $('#jqxTariffToDate').jqxDateTimeInput({ disabled: true});
        $('#jqxTariffDate').jqxDateTimeInput({ disabled: true});

        tariftype=document.getElementById("cmbtariftype").value;
        if((!(tariftype=='Client')) && (!(tariftype=='Corporate'))){
            document.getElementById("txtclient").value="";
        }
        if(tariftype=='Weekend'){
            document.getElementById("fieldextrainsur").style.display="none";
            document.getElementById("fieldfoc").style.display="none";
            document.getElementById("fieldregular").style.display="none";
            document.getElementById("fieldpackage").style.display="none";
            document.getElementById("fieldslab").style.display="none";
            document.getElementById("fieldweekday").style.display="block";
            }
            if(tariftype=='Slab'){
            document.getElementById("fieldextrainsur").style.display="none";
            document.getElementById("fieldfoc").style.display="none";
            document.getElementById("fieldregular").style.display="none";
            document.getElementById("fieldpackage").style.display="none";
        document.getElementById("fieldweekday").style.display="none";
        document.getElementById("fieldslab").style.display="block";
            
            }
            if(tariftype=='Package'){
            document.getElementById("fieldextrainsur").style.display="none";
            document.getElementById("fieldfoc").style.display="none";
            document.getElementById("fieldregular").style.display="none";
            document.getElementById("fieldslab").style.display="none";
            document.getElementById("fieldweekday").style.display="none";
            document.getElementById("fieldpackage").style.display="block";
            }
            if(tariftype=='FOC'){
                document.getElementById("fieldextrainsur").style.display="none";
                document.getElementById("fieldregular").style.display="none";
                document.getElementById("fieldslab").style.display="none";
                document.getElementById("fieldweekday").style.display="none";
                document.getElementById("fieldpackage").style.display="none";
                document.getElementById("fieldfoc").style.display="block";
            }
            if(tariftype=='Corporate'){
                document.getElementById("fieldextrainsur").style.display="none";
                document.getElementById("fieldslab").style.display="none";
            document.getElementById("fieldweekday").style.display="none";
            document.getElementById("fieldpackage").style.display="none";
            document.getElementById("fieldfoc").style.display="none";
            document.getElementById("fieldregular").style.display="block";
            }
            if(tariftype=='Regular'){
                document.getElementById("fieldslab").style.display="none";
                document.getElementById("fieldweekday").style.display="none";
                document.getElementById("fieldpackage").style.display="none";
                document.getElementById("fieldfoc").style.display="none";
                document.getElementById("fieldextrainsur").style.display="block";
                document.getElementById("fieldregular").style.display="block";
            }
            $('#window').jqxWindow('close');
        
    });  
    // REMOVED closing tags for $(document).ready() here!
</script>