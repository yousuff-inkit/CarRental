<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Budget Variance Detail</title>           
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../../../../js/animate/animate.css">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>            
<link rel="stylesheet" type="text/css" href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="../../../../vendors/select2/select2.min.css">
  <style type="text/css"> 
      .hidefields {
        display: none;
      }
	  .branch {
		color: black;
		width: 100%;
		font-family: Tahoma;
		font-size: 12px;
	   }  
      .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);   
        border-radius: 8px;
        margin-bottom: 15px;
		background-color:#fff;
    }
    .card-container .card-body{
        width: 100%;
        padding-top: 8px;
        padding-bottom: 8px;
    }
    .card-container .card-body .card-chart-container,.card-icon-container{
        width: 30%;
        text-align: center;
        vertical-align: middle;
    }
    .card-container .card-body .card-detail-container{
        width: 68%;
        vertical-align: middle;
    }
    .card-container .card-body>div{
        display: inline-block;
    }
    .card-container .card-body .card-detail-container>div{
        display: inline-block;
        width:24%;
        text-align:center;
    }
    .card-container .card-body .card-detail-container>div:not(:last-child){
    	border-right: 1px solid #efefef;
    } 
   @media (min-width: 900px) {  
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
}
   .textpanel{
        color: blue;    
  		overflow:auto; 
  		width:260px;  
  		/* height:50px;       */           
  } 
  .textpanel1{
        color: #00008B;    
  }   
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;  
    }
    .custompanel1{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: #fff;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
     .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .actionpanel{
        padding-right: 5px; 
    }
    .otherpanel{
        padding-right: 5px; 
    }
    .primarypanel{
        padding-right: 5px; 
    }
    .padtop{
        padding-top: 5px; 
    }
    .class-pad5{
     padding-top: 5px; 
    }
  </style>
</head>       
<body>   
<form  method="post" autocomplete="off">      
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
       <div class="primarypanel custompanel">
	      <table width="100%">
		      <tr> 
		      <td align="right" width="6%"><label class="branch" style="font-size: 13px">From Date &nbsp;</label></td>  
		      <td align="left" width="5%"><div id="fromdate" ></div></td>
		      <td align="right" width="5%"><label class="branch" style="font-size: 13px">&nbsp;&nbsp;To Date &nbsp;</label></td>  
		      <td align="left" width="5%"><div id="todate" ></div></td>
		      <td align="right" width="5%" class="hidefields"><label class="branch" style="font-size: 13px">&nbsp;&nbsp;Currency &nbsp;</label></td>  
		      <td align="left" width="5%" class="hidefields"><select id="currencyid" name="currencyid" onchange="getRates();">
                     <option value="">--Select--</option>
               </select>
               <input type="hidden" id="hidcurid" name="hidcurid"></td>        
		      <td align="right" width="4%" class="hidefields"><label class="branch" style="font-size: 13px">&nbsp;&nbsp;Rate &nbsp;</label></td>  
		      <td align="left" width="5%" class="hidefields"><input type="text" id="txtrate" name="txtrate" style="width:99%;height:20px;text-align:right"></td>                                        
		 	  <td align="right" width="5%"><label class="branch" style="font-size: 13px">&nbsp;Level 1 &nbsp;</label></td>  
		      <td align="left" width="2%"><input type="checkbox" id="chcklevel1" name="chcklevel1" class="chcklevels" value="" onchange="checklevel1();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> 
                               <input type="hidden" id="hidchcklevel1" name="hidchcklevel1" /></td>
		      <td align="right" width="5%"><label class="branch" style="font-size: 13px">&nbsp;&nbsp;Level 2 &nbsp;</label></td>  
		      <td align="left" width="2%"><input type="checkbox" id="chcklevel2" name="chcklevel2" class="chcklevels" value="" onchange="checklevel2();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> 
                               <input type="hidden" id="hidchcklevel2" name="hidchcklevel2" /></td>
		      <td align="right" width="5%"><label class="branch" style="font-size: 13px">&nbsp;&nbsp;Level 3 &nbsp;</label></td>  
		      <td align="left" width="2%"><input type="checkbox" id="chcklevel3" name="chcklevel3" class="chcklevels" value="" onchange="checklevel3();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> 
                               <input type="hidden" id="hidchcklevel3" name="hidchcklevel3" /></td>
		      <td align="right" width="5%"><label class="branch" style="font-size: 13px">&nbsp;&nbsp;Level 4 &nbsp;</label></td>  
		      <td align="left" width="2%"><input type="checkbox" id="chcklevel4" name="chcklevel4" class="chcklevels" value="" onchange="checklevel4();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> 
                               <input type="hidden" id="hidchcklevel4" name="hidchcklevel4" />&nbsp;</td>
		      <td align="left" width="2%"><button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>&nbsp;</td>
		      <td align="left" width="2%"><button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button></td>  
		      <td align="left" width="20%">&nbsp;</td></tr>    
		 </table>              
      </div>  
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="budDiv"><jsp:include page="budgetVarianceGrid.jsp"></jsp:include></div>           
      </div>
    </div>    
  <input type="hidden" id="entrydate" name="entrydate"/> 
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="../../../../vendors/cookie/cookie.min.js"></script>
<script type="text/javascript">   
var selectedBox = null;
    $(document).ready(function(){    
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');   
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:650px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();     
    	getCurrency();
        $("#fromdate").jqxDateTimeInput({
            width: '110px',
            height: '22px',
            formatString: "dd.MM.yyyy"
        });
        $("#todate").jqxDateTimeInput({
            width: '110px',
            height: '22px',
            formatString: "dd.MM.yyyy"
        });
        var year = window.parent.txtaccountperiodfrom.value;
        var newDate = year.split('-');
        year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
        $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
        
        $('#btnsubmit').click(function(){    
            loads(); 
        });
    	  
        $('#btnexcel').click(function(){  
        	if (parseInt(window.parent.chkexportdata.value) == "1") {
                JSONToCSVCon(dataExcelExport, 'Budget Variance Detail', true);
            } else {
                $("#jqxBudgetGrid").jqxTreeGrid('exportData', 'xls');
            }  
        });
        
        $(".chcklevels").click(function() {
            selectedBox = this.id;

            $(".chcklevels").each(function() {
                if (this.id == selectedBox) {
                    this.checked = true;
                } else {
                    this.checked = false;
                };
            });
        });
        document.getElementById("hidchcklevel4").value = 1;
        document.getElementById("chcklevel4").checked = true;   
    });
  
    function addGridFilters(filtervalue,datafield){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	var filtercondition = 'equal';
    	var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
    	filtergroup.addfilter(filter_or_operator, filter1);
    	$("#jqxBudgetGrid").jqxGrid('addfilter', datafield, filtergroup);
    	$("#jqxBudgetGrid").jqxGrid('applyfilters');       
 	}
    
    function loads(){   
    	var fromdate = $('#fromdate').val();
        var todate = $('#todate').val();
        var level1 = $('#hidchcklevel1').val();
        var level2 = $('#hidchcklevel2').val();
        var level3 = $('#hidchcklevel3').val();
        var level4 = $('#hidchcklevel4').val();
        var check = 1;
        var rate = $('#txtrate').val();  
        var d = new Date();
        var entrydate = d.getTime();
        $("#entrydate").val(entrydate);
        d.setDate(d.getDate() - 1);
        var onedaylessdt = d.getTime();
        $("#overlay, #PleaseWait").show();  
	    $('#budDiv').load('budgetVarianceGrid.jsp?fromdate=' + fromdate + '&todate=' + todate + '&level1=' + level1 + '&level2=' + level2 + '&level3=' + level3 + '&level4=' + level4 + '&check=' + check+ '&rate=' + rate+ '&entrydate=' + entrydate+'&onedaylessdt=' + onedaylessdt);         
    }
    
    function getCurrency() {
        var x = new XMLHttpRequest();
        var items, currIdItems, mcloseItems, currCodeItems;
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                items = x.responseText;
                items = items.split('####');
                currIdItems = items[0].split(",");
                currCodeItems = items[1].split(",");

                var optionscurr = '';
                for (var i = 0; i < currCodeItems.length; i++) {
                    optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
                }
                $("select#currencyid").html(optionscurr);
                window.parent.monthclosed.value = mcloseItems;
                getRates();
            } else {}

            if ($('#hidcurid').val()) {
                $("#currencyid").val($('#hidcurid').val());
            }
        }
        x.open("GET", "getCurrency.jsp", true);
        x.send();
    }

    function getRates() {
        var curid = $("#currencyid").val();
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                items = x.responseText;
                $("#txtrate").val(items);
            } else {}
        }
        x.open("GET", "getRate.jsp?curid=" + curid, true);
        x.send();
    }
    
    function checklevel1() {
        if (document.getElementById("chcklevel1").checked) {
            document.getElementById("hidchcklevel1").value = 1;
            document.getElementById("hidchcklevel2").value = 0;
            document.getElementById("hidchcklevel3").value = 0;
            document.getElementById("hidchcklevel4").value = 0;
        } else {
            document.getElementById("hidchcklevel1").value = 0;
        }
    }

    function checklevel2() {
        if (document.getElementById("chcklevel2").checked) {
            document.getElementById("hidchcklevel2").value = 1;
            document.getElementById("hidchcklevel1").value = 0;
            document.getElementById("hidchcklevel3").value = 0;
            document.getElementById("hidchcklevel4").value = 0;
        } else {
            document.getElementById("hidchcklevel2").value = 0;
        }
    }

    function checklevel3() {
        if (document.getElementById("chcklevel3").checked) {
            document.getElementById("hidchcklevel3").value = 1;
            document.getElementById("hidchcklevel1").value = 0;
            document.getElementById("hidchcklevel2").value = 0;
            document.getElementById("hidchcklevel4").value = 0;
        } else {
            document.getElementById("hidchcklevel3").value = 0;
        }
    }

    function checklevel4() {
        if (document.getElementById("chcklevel4").checked) {
            document.getElementById("hidchcklevel4").value = 1;
            document.getElementById("hidchcklevel1").value = 0;
            document.getElementById("hidchcklevel2").value = 0;
            document.getElementById("hidchcklevel3").value = 0;
        } else {
            document.getElementById("hidchcklevel4").value = 0;
        }
    }
    
    function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {
        var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
        var CSV = '';    
        CSV += ReportTitle + '\r\n\n';
        if (ShowLabel) {
            var row = "";
            for (var index in arrData[0]) {
                row += index + ',';
            }
            row = row.slice(0, -1);
            CSV += row + '\r\n';
        }
        for (var i = 0; i < arrData.length; i++) {
            var row = "";
            for (var index in arrData[i]) {
                row += '"' + arrData[i][index] + '",';
            }
            row.slice(0, row.length - 1);
            CSV += row + '\r\n';
        }

        if (CSV == '') {        
            alert("Invalid data");
            return;
        }   
        var fileName = "";
        fileName += ReportTitle.replace(/ /g,"_");   
        var temp = CSV;
        blob = new Blob([temp],{type: 'text/csv'});
        var bigcsv= window.webkitURL.createObjectURL(blob);
        var link = document.createElement("a");    
          link.href = bigcsv;
        link.style = "visibility:hidden";
        link.download = fileName + ".csv";
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
  </script>  
  </div>
  </form>   
</body>
</html>
