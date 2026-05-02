<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="com.dashboard.analysis.utilization.*" %>
<%ClsVehUtilizationDAO utilizedao=new ClsVehUtilizationDAO(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
      .master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}


html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    padding: 10px 15px;
    width: 100%;
    font-weight: 600;
    cursor: pointer;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
}
.main-content-wrapper{
    flex:1;
    width:100%;
}

.scrollable-grid-area{
    width:100%;
}

#delupdiv{
    width:100%;
}

/* ---- Analytics Dashboard ---- */
.view-btn{padding:7px 16px;border:none;border-radius:6px;font-size:13px;font-weight:600;cursor:pointer;background:#e5e7eb;color:#374151;transition:background .15s}
.view-btn.active,.view-btn:hover{background:#2563eb;color:#fff}
.d-tabs{display:flex;gap:6px;padding:0 0 14px;flex-wrap:wrap}
.d-tab{padding:6px 14px;border:0.5px solid #d4d4d4;border-radius:6px;font-size:13px;cursor:pointer;background:#fff;color:#5c5c5c}
.d-tab.active{background:#f7f7f7;color:#1a1a1a;font-weight:500;border-color:#bdbdbd}
.d-tab:hover{background:#f0f0f0}
.d-panel{display:none}
.d-panel.active{display:block}
.d-metric-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(130px,1fr));gap:10px;margin-bottom:18px}
.d-metric{background:#f7f7f7;border-radius:6px;padding:12px 14px}
.d-metric-label{font-size:11px;color:#5c5c5c;margin-bottom:4px}
.d-metric-val{font-size:20px;font-weight:500;color:#1a1a1a}
.d-metric-sub{font-size:10px;color:#9a9a9a;margin-top:2px}
.d-chart-row{display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:18px}
.d-chart-box{background:#fff;border:0.5px solid #e8e8e8;border-radius:10px;padding:14px}
.d-chart-title{font-size:13px;font-weight:500;color:#1a1a1a;margin-bottom:12px}
.d-legend{display:flex;flex-wrap:wrap;gap:10px;margin-bottom:8px;font-size:11px;color:#5c5c5c}
.d-leg-item{display:flex;align-items:center;gap:4px}
.d-leg-sq{width:10px;height:10px;border-radius:2px;flex-shrink:0}
.d-table-box{background:#fff;border:0.5px solid #e8e8e8;border-radius:10px;padding:14px;overflow-x:auto;margin-bottom:18px}
.d-table-box table{width:100%;font-size:12px;border-collapse:collapse}
.d-table-box th{font-size:11px;font-weight:500;color:#5c5c5c;text-align:left;padding:6px 8px;border-bottom:0.5px solid #e8e8e8;white-space:nowrap}
.d-table-box td{padding:6px 8px;border-bottom:0.5px solid #e8e8e8;color:#1a1a1a}
.d-table-box tr:last-child td{border-bottom:none}
.d-badge{display:inline-block;padding:2px 8px;border-radius:10px;font-size:10px;font-weight:500}
.d-b-green{background:#EAF3DE;color:#27500A}
.d-b-amber{background:#FAEEDA;color:#633806}
.d-b-red{background:#FCEBEB;color:#791F1F}
.d-b-blue{background:#E6F1FB;color:#0C447C}
.d-bar-wrap{display:flex;align-items:center;gap:8px;margin-bottom:5px}
.d-bar-label{width:110px;text-align:right;color:#5c5c5c;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;flex-shrink:0;font-size:11px}
.d-bar-track{flex:1;height:16px;background:#f0f0f0;border-radius:3px;overflow:hidden}
.d-bar-fill{height:100%;border-radius:3px}
.d-bar-val{width:46px;font-size:11px;color:#5c5c5c;flex-shrink:0;text-align:right}
.d-loading{text-align:center;padding:50px 20px;color:#9a9a9a;font-size:13px}
@media(max-width:520px){.d-chart-row{grid-template-columns:1fr}}

/* 🔹 Inputs + Dropdowns */
input[type="text"],
select {
    width: 100%;
    height: 24px !important;
    padding: 0 8px !important;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Dropdown text */
select {
    font-size: 13px !important;
}


/* 🔹 Fix for any library overriding (like jqx / external CSS) */
.jqx-widget input,
.jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#vehdetaildiv').hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#brandwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#groupwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   $('#yomwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#yomwindow').jqxWindow('close');
	   
	 
	   $('#fleetwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
});

function getFleet(){

	 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		fleetSearchContent('fleetSearch.jsp?id=1', $('#fleetwindow'));
	
}

function getBrand(){
	 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		 brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));

}


function getModel(){
	
	 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		 modelSearchContent('modelSearch.jsp?id=1', $('#brandwindow'));

}

function getGroup(event){

	$('#groupwindow').jqxWindow('open');
	$('#groupwindow').jqxWindow('focus');
	 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
	 groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));

}
function getYom(event){

	 $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
}


function brandSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#brandwindow').jqxWindow('setContent', data);

}); 
}

function modelSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#modelwindow').jqxWindow('setContent', data);

}); 
}

function groupSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#groupwindow').jqxWindow('setContent', data);

}); 
}

function yomSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#yomwindow').jqxWindow('setContent', data);

}); 
}

function fleetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	
		 var branch=document.getElementById("cmbbranch").value;
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');
	     var todate=$('#todate').jqxDateTimeInput('val');
	     var hidbrand=document.getElementById("hidbrand").value;
	     var hidmodel=document.getElementById("hidmodel").value;
	     var hidgroup=document.getElementById("hidgroup").value;
	     var hidyom=document.getElementById("hidyom").value;
	     var grpby1=document.getElementById("grpby1").value;
		 var hidfleet=document.getElementById("hidfleet").value;
	     var hidduration;
	     if(document.getElementById("rdohours").checked==true){
		  hidduration="hours";
	  }
	     else if(document.getElementById("rdodays").checked==true){
	    	 hidduration="days";
	     }
	    	
	     _dashData = null;
	     $("#overlay, #PleaseWait").show();
	    $("#vehutilizediv").load("vehUtilizeGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&fleet="+hidfleet+"&id=1&duration="+hidduration+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom, function(){
		    if(document.getElementById('analyticsDashboard').style.display !== 'none'){
		    	setTimeout(buildDashboard, 100);
		    }
		});
	
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	document.getElementById("rdohours").checked=true;
	
		 
	}
/* 	function funExportBtn(){
		  $("#vehUtilizeGrid").jqxGrid('exportdata', 'xls', 'Vehicle Utilization'); 
			 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(utilizedataexcel, 'Vehicle Utilization', true);
		  }
		 else  
		  {
			 $("#vehUtilizeGrid").jqxGrid('exportdata', 'xls', 'Vehicle Utilization');
		  }
		
	} */
	
	function funExportBtn(){
		$("#vehutilizediv").excelexportjs({
			containerid: "vehutilizediv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "vehUtilizeGrid", 
			columns: getColumns("vehUtilizeGrid") ,   
			worksheetName:"VEHICLE UTILIZATION"
			});
		
	}

	
	function funClearData(){
		$('input[type=text],[type=hidden], textarea').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		   
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    $('input:checkbox').removeAttr('checked');
	    $('input[type=radio]').prop("checked", false);
	    document.getElementById("rdohours").checked=true;
	    $('#cmbbranch').val('a');
	}
	function setSearch(){
		var value=$('#searchby').val().trim();
		
		if(value=="brand"){
			getBrand();
		}
		else if(value=="model"){
			getModel();
		}
		else if(value=="group"){
			getGroup();
		}
		else if(value=="yom"){
			getYom();
		}
		else if(value=="fleet"){
			getFleet();
		}
		else{
			
		}



	}
	
	
	
	function setRemove(){
		var value=$('#searchby').val().trim();
		 if(value=="brand"){
			document.getElementById("searchdetails").value="";
			document.getElementById("brand").value="";
			document.getElementById("hidbrand").value="";
			document.getElementById("searchdetails").value=document.getElementById("model").value;	
		
					if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="model"){
			document.getElementById("searchdetails").value="";
			document.getElementById("model").value="";
			document.getElementById("hidmodel").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
			
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="group"){
			document.getElementById("searchdetails").value="";
			document.getElementById("group").value="";
			document.getElementById("hidgroup").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
		
		
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="yom"){
			document.getElementById("searchdetails").value="";
			document.getElementById("yom").value="";
			document.getElementById("hidyom").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
			
			
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="fleet"){
			document.getElementById("searchdetails").value="";
			document.getElementById("fleet").value="";
			document.getElementById("hidfleet").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
			
			
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
	}
	// ===================== ANALYTICS DASHBOARD =====================
	var _dc={}, _dashData=null;
	var _DC={T:'#1D9E75',B:'#185FA5',B2:'#378ADD',A:'#EF9F27',C:'#D85A30',R:'#E24B4A',G:'#888780',P:'#7F77DD'};
	var _GC='rgba(128,128,128,0.1)';

	function showView(view){
		var g=document.getElementById('vehutilizediv'),d=document.getElementById('analyticsDashboard');
		var bg=document.getElementById('btnGridView'),bd=document.getElementById('btnDashView');
		if(view==='grid'){g.style.display='';d.style.display='none';bg.classList.add('active');bd.classList.remove('active');}
		else{g.style.display='none';d.style.display='';bg.classList.remove('active');bd.classList.add('active');setTimeout(buildDashboard,60);}
	}

	function switchDashTab(tab){
		document.querySelectorAll('.d-tab').forEach(function(b){b.classList.remove('active');});
		document.querySelectorAll('.d-panel').forEach(function(p){p.classList.remove('active');});
		document.getElementById('dt_'+tab).classList.add('active');
		document.getElementById('dp_'+tab).classList.add('active');
	}
	function _dcD(){ Object.keys(_dc).forEach(function(k){if(_dc[k]){_dc[k].destroy();delete _dc[k];}}); }
	function _pct(v,t){ return (!t||t===0)?0:Math.round(v/t*10000)/100; }
	function _fmt(v){ return v>=1e6?(v/1e6).toFixed(1)+'M':v>=1e3?Math.round(v/1e3)+'K':String(Math.round(v)); }
	function _bCls(p){ return p>=85?'d-b-green':p>=60?'d-b-amber':'d-b-red'; }
	function _lbl(r){ return (((r.description||r.refno||'')+'').trim())||'-'; }
	function _fld(r,f){ return parseFloat(r[f])||0; }
	function _setKpi(id,val,sub){
		var el=document.getElementById(id); if(!el) return;
		var ve=el.querySelector('.d-metric-val'),se=el.querySelector('.d-metric-sub');
		if(ve) ve.textContent=(val!==undefined&&val!==null)?val:'-';
		if(se) se.textContent=sub||'';
	}
	function _getDashParams(){
		var p={};
		p.branch=(document.getElementById('cmbbranch')||{}).value||'';
		p.fromdate='';p.todate='';
		try{p.fromdate=$('#fromdate').jqxDateTimeInput('val')||'';}catch(e){}
		try{p.todate=$('#todate').jqxDateTimeInput('val')||'';}catch(e){}
		var rh=document.getElementById('rdohours');
		p.duration=(rh&&rh.checked)?'hours':'days';
		p.hidbrand=(document.getElementById('hidbrand')||{}).value||'';
		p.hidmodel=(document.getElementById('hidmodel')||{}).value||'';
		p.hidgroup=(document.getElementById('hidgroup')||{}).value||'';
		p.hidyom  =(document.getElementById('hidyom')  ||{}).value||'';
		p.hidfleet=(document.getElementById('hidfleet')||{}).value||'';
		return p;
	}
	function _fetchGrp(grpby1,p,cb){
		$.ajax({
			url:'vehUtilizeDashData.jsp?id=1&branch='+encodeURIComponent(p.branch)+'&fromdate='+encodeURIComponent(p.fromdate)+'&todate='+encodeURIComponent(p.todate)+'&duration='+p.duration+'&grpby1='+grpby1+'&hidbrand='+encodeURIComponent(p.hidbrand)+'&hidmodel='+encodeURIComponent(p.hidmodel)+'&hidgroup='+encodeURIComponent(p.hidgroup)+'&hidyom='+encodeURIComponent(p.hidyom)+'&fleet='+encodeURIComponent(p.hidfleet),
			dataType:'json',
			success:function(d){cb(Array.isArray(d)?d:[]);},
			error:function(){cb([]);}
		});
	}
	function buildDashboard(){
		var noEl=document.getElementById('dashNoData'),conEl=document.getElementById('dashContent');
		var p=_getDashParams();
		if(!p.branch){noEl.style.display='';conEl.style.display='none';return;}
		noEl.style.display='none';conEl.style.display='';
		if(_dashData){_dcD();_renderAll(_dashData);return;}
		document.getElementById('dashLoading').style.display='';
		document.getElementById('dashTabs').style.display='none';
		var res={v:[],br:[],mo:[],gr:[],yo:[]},vehRows=null;
		try{var gr2=$('#vehUtilizeGrid').jqxGrid('getrows');if(gr2&&gr2.length>0)vehRows=gr2;}catch(e){}
		var pend=vehRows?4:5;
		if(vehRows){res.v=vehRows;}
		else{_fetchGrp('',p,function(d){res.v=d;_chk();});}
		function _chk(){if(--pend===0){document.getElementById('dashLoading').style.display='none';document.getElementById('dashTabs').style.display='';_dashData=res;_dcD();_renderAll(res);}}
		_fetchGrp('brand',p,function(d){res.br=d;_chk();});
		_fetchGrp('model',p,function(d){res.mo=d;_chk();});
		_fetchGrp('group',p,function(d){res.gr=d;_chk();});
		_fetchGrp('yom',  p,function(d){res.yo=d;_chk();});
	}
	function _renderAll(d){_renderOverview(d.v,d.gr,d.br);_renderBrand(d.br);_renderModel(d.mo);_renderYOM(d.yo);_renderGroup(d.gr);_renderLowUtil(d.v);}

	/* -- OVERVIEW -- */
	function _renderOverview(veh,grp,brd){
		var t=0,rn=0,ga=0,st=0,de=0,tr=0,fs=0,ot=0;
		veh.forEach(function(r){t+=_fld(r,'total');rn+=_fld(r,'rental');ga+=_fld(r,'garage');st+=_fld(r,'staff');de+=_fld(r,'delivery');tr+=_fld(r,'transfer');fs+=_fld(r,'forsale');ot+=_fld(r,'other');});
		_setKpi('ov_fleet', veh.length,'vehicles tracked');
		_setKpi('ov_util',  _pct(rn,t)+'%','rental vs live-in');
		_setKpi('ov_rented',_fmt(rn),'of '+_fmt(t)+' live days');
		_setKpi('ov_garage',_pct(ga,t)+'%',_fmt(ga)+' days');
		_setKpi('ov_staff', _pct(st,t)+'%',_fmt(st)+' days');
		_setKpi('ov_idle',  _pct(ot,t)+'%',_fmt(ot)+' days lost');
		if(_dc.ov1)_dc.ov1.destroy();
		_dc.ov1=new Chart(document.getElementById('ch_ov_donut').getContext('2d'),{type:'doughnut',
			data:{labels:['Rented ('+_pct(rn,t)+'%)','Garage ('+_pct(ga,t)+'%)','Staff ('+_pct(st,t)+'%)','Idle ('+_pct(ot,t)+'%)','Transfer ('+_pct(tr,t)+'%)','Delivery ('+_pct(de,t)+'%)','For Sale ('+_pct(fs,t)+'%)'],
				datasets:[{data:[rn,ga,st,ot,tr,de,fs],backgroundColor:[_DC.T,_DC.R,_DC.B2,_DC.G,_DC.A,_DC.C,_DC.P],borderWidth:0,hoverOffset:4}]},
			options:{responsive:true,maintainAspectRatio:false,cutout:'58%',plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.label+': '+_fmt(b.raw)+' days';}}}}}});
		if(grp&&grp.length>0){
			if(_dc.ov2)_dc.ov2.destroy();
			var gU=grp.map(function(r){return _pct(_fld(r,'rental'),_fld(r,'total'));});
			_dc.ov2=new Chart(document.getElementById('ch_ov_grp').getContext('2d'),{type:'bar',indexAxis:'y',
				data:{labels:grp.map(_lbl),datasets:[{data:gU,backgroundColor:gU.map(function(v){return v>=90?_DC.T:v>=75?_DC.B2:v>=60?_DC.A:_DC.R;}),borderRadius:4}]},
				options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.raw.toFixed(1)+'%';}}}},
					scales:{x:{min:0,max:105,ticks:{callback:function(v){return v+'%';}},grid:{color:_GC}},y:{ticks:{font:{size:11}}}}}});}
		if(brd&&brd.length>0){
			var sb=brd.slice().sort(function(a,b){return _fld(b,'total')-_fld(a,'total');}).slice(0,12);
			var mx=_fld(sb[0],'total');
			document.getElementById('ov_brandBars').innerHTML=sb.map(function(r){var w=mx>0?Math.round(_fld(r,'total')/mx*100):0;
				return '<div class="d-bar-wrap"><div class="d-bar-label">'+_lbl(r)+'</div><div class="d-bar-track"><div class="d-bar-fill" style="width:'+w+'%;background:'+_DC.B2+'"></div></div><div class="d-bar-val">'+_fmt(r.total)+'</div></div>';}).join('');}
	}

	/* -- BRAND -- */
	function _renderBrand(brd){
		if(!brd||!brd.length){document.getElementById('dp_brand').innerHTML='<div class="d-loading">No brand data â load data first.</div>';return;}
		var s=brd.slice().sort(function(a,b){return _fld(b,'total')-_fld(a,'total');});
		var bU=s.slice().sort(function(a,b){return _pct(_fld(b,'rental'),_fld(b,'total'))-_pct(_fld(a,'rental'),_fld(a,'total'));})[0];
		var mG=s.slice().sort(function(a,b){return _fld(b,'garage')-_fld(a,'garage');})[0];
		var mI=s.slice().sort(function(a,b){return _fld(b,'other')-_fld(a,'other');})[0];
		_setKpi('br_largest',_lbl(s[0]),_fmt(s[0].total)+' live days');
		_setKpi('br_bestutil',_lbl(bU),_pct(_fld(bU,'rental'),_fld(bU,'total'))+'% util');
		_setKpi('br_garage',_lbl(mG),_fmt(mG.garage)+' garage days');
		_setKpi('br_idle',_lbl(mI),_fmt(mI.other)+' idle days');
		var top=s.slice(0,15),lbls=top.map(_lbl),util=top.map(function(r){return _pct(_fld(r,'rental'),_fld(r,'total'));});
		if(_dc.br1)_dc.br1.destroy();
		_dc.br1=new Chart(document.getElementById('ch_br_bar').getContext('2d'),{type:'bar',indexAxis:'y',
			data:{labels:lbls,datasets:[{data:util,backgroundColor:util.map(function(v){return v>=90?_DC.T:v>=80?_DC.B2:v>=70?_DC.A:_DC.R;}),borderRadius:4}]},
			options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.raw.toFixed(1)+'%';}}}},
				scales:{x:{min:0,max:105,ticks:{callback:function(v){return v+'%';}},grid:{color:_GC}},y:{ticks:{font:{size:11}}}}}});
		if(_dc.br2)_dc.br2.destroy();
		_dc.br2=new Chart(document.getElementById('ch_br_stacked').getContext('2d'),{type:'bar',
			data:{labels:lbls,datasets:[
				{label:'Rented',data:top.map(function(r){return _fld(r,'rental');}),backgroundColor:_DC.T,stack:'s'},
				{label:'Garage',data:top.map(function(r){return _fld(r,'garage');}),backgroundColor:_DC.R,stack:'s'},
				{label:'Idle',  data:top.map(function(r){return _fld(r,'other' );}),backgroundColor:_DC.G,stack:'s'}]},
			options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_fmt(b.raw);}}}},
				scales:{y:{stacked:true,ticks:{callback:function(v){return _fmt(v);}},grid:{color:_GC}},x:{stacked:true,ticks:{font:{size:10},maxRotation:30,autoSkip:false}}}}});
		document.getElementById('br_table').innerHTML='<table><tr><th>Brand</th><th>Live days</th><th>Rented</th><th>Garage</th><th>Idle</th><th>Util %</th></tr>'
			+s.map(function(r){var p2=_pct(_fld(r,'rental'),_fld(r,'total'));return '<tr><td>'+_lbl(r)+'</td><td>'+_fmt(r.total)+'</td><td>'+_fmt(r.rental)+'</td><td>'+_fmt(r.garage)+'</td><td>'+_fmt(r.other)+'</td><td><span class="d-badge '+_bCls(p2)+'">'+p2+'%</span></td></tr>';}).join('')+'</table>';
	}

	/* -- MODEL -- */
	function _renderModel(mo){
		if(!mo||!mo.length){document.getElementById('dp_model').innerHTML='<div class="d-loading">No model data â load data first.</div>';return;}
		var s=mo.slice().sort(function(a,b){return _fld(b,'total')-_fld(a,'total');});
		var bM=s.slice().sort(function(a,b){return _pct(_fld(b,'rental'),_fld(b,'total'))-_pct(_fld(a,'rental'),_fld(a,'total'));})[0];
		_setKpi('mo_largest',_lbl(s[0]),_fmt(s[0].total)+' live days');
		_setKpi('mo_second',s[1]?_lbl(s[1]):'-',s[1]?_fmt(s[1].total)+' live days':'');
		_setKpi('mo_bestutil',_lbl(bM),_pct(_fld(bM,'rental'),_fld(bM,'total'))+'%');
		_setKpi('mo_count',s.length,'unique models');
		var t15=s.slice(0,15),mU=t15.map(function(r){return _pct(_fld(r,'rental'),_fld(r,'total'));});
		if(_dc.mo1)_dc.mo1.destroy();
		_dc.mo1=new Chart(document.getElementById('ch_mo_bar').getContext('2d'),{type:'bar',indexAxis:'y',
			data:{labels:t15.map(_lbl),datasets:[{data:mU,backgroundColor:mU.map(function(v){return v>=95?_DC.T:v>=85?_DC.B2:v>=70?_DC.A:_DC.R;}),borderRadius:4}]},
			options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.raw.toFixed(1)+'%';}}}},
				scales:{x:{min:0,max:108,ticks:{callback:function(v){return v+'%';}},grid:{color:_GC}},y:{ticks:{font:{size:11}}}}}});
		var t12=s.slice(0,12);
		if(_dc.mo2)_dc.mo2.destroy();
		_dc.mo2=new Chart(document.getElementById('ch_mo_stacked').getContext('2d'),{type:'bar',
			data:{labels:t12.map(_lbl),datasets:[
				{label:'Rented',data:t12.map(function(r){return _fld(r,'rental');}),backgroundColor:_DC.B,stack:'a'},
				{label:'Garage',data:t12.map(function(r){return _fld(r,'garage');}),backgroundColor:_DC.R,stack:'a'},
				{label:'Idle',  data:t12.map(function(r){return _fld(r,'other' );}),backgroundColor:_DC.G,stack:'a'}]},
			options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_fmt(b.raw);}}}},
				scales:{y:{stacked:true,ticks:{callback:function(v){return _fmt(v);}},grid:{color:_GC}},x:{stacked:true,ticks:{font:{size:10},maxRotation:35,autoSkip:false}}}}});
	}

	/* -- YOM -- */
	function _renderYOM(yo){
		if(!yo||!yo.length){document.getElementById('dp_yom').innerHTML='<div class="d-loading">No YOM data â load data first.</div>';return;}
		yo.sort(function(a,b){return (parseFloat(b.description)||0)-(parseFloat(a.description)||0);});
		var yL=yo.map(_lbl),yU=yo.map(function(r){return _pct(_fld(r,'rental'),_fld(r,'total'));});
		var older=yo.filter(function(r){return parseInt(r.description||0)<2022;});
		_setKpi('yo_newest',_lbl(yo[0]),_pct(_fld(yo[0],'rental'),_fld(yo[0],'total'))+'% util');
		_setKpi('yo_second',yo[1]?_lbl(yo[1]):'-',yo[1]?_pct(_fld(yo[1],'rental'),_fld(yo[1],'total'))+'% util':'');
		_setKpi('yo_older',older.length+' YOM groups',older.length?'pre-2022':'all recent');
		_setKpi('yo_oldest',yo[yo.length-1]?_lbl(yo[yo.length-1]):'-',yo[yo.length-1]?_pct(_fld(yo[yo.length-1],'rental'),_fld(yo[yo.length-1],'total'))+'% â oldest':'');
		if(_dc.yo1)_dc.yo1.destroy();
		_dc.yo1=new Chart(document.getElementById('ch_yo_fleetbar').getContext('2d'),{type:'bar',
			data:{labels:yL,datasets:[{label:'Live days',data:yo.map(function(r){return _fld(r,'total');}),backgroundColor:_DC.B2,borderRadius:4}]},
			options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{y:{ticks:{callback:function(v){return _fmt(v);}},grid:{color:_GC}},x:{grid:{display:false}}}}});
		if(_dc.yo2)_dc.yo2.destroy();
		_dc.yo2=new Chart(document.getElementById('ch_yo_util').getContext('2d'),{type:'line',
			data:{labels:yL,datasets:[{label:'Util %',data:yU,borderColor:_DC.T,backgroundColor:'rgba(29,158,117,0.08)',fill:true,tension:0.4,pointBackgroundColor:_DC.T,pointRadius:5,pointHoverRadius:7}]},
			options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.raw.toFixed(1)+'%';}}}},
				scales:{y:{min:0,max:105,ticks:{callback:function(v){return v+'%';}},grid:{color:_GC}},x:{grid:{display:false}}}}});
		if(_dc.yo3)_dc.yo3.destroy();
		_dc.yo3=new Chart(document.getElementById('ch_yo_garage').getContext('2d'),{type:'bar',
			data:{labels:yL,datasets:[{label:'Garage days',data:yo.map(function(r){return _fld(r,'garage');}),backgroundColor:_DC.R,borderRadius:4}]},
			options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.raw.toFixed(1)+' days';}}}},
				scales:{y:{ticks:{callback:function(v){return _fmt(v);}},grid:{color:_GC}},x:{grid:{display:false}}}}});
		document.getElementById('yo_table').innerHTML='<table><tr><th>Year</th><th>Live days</th><th>Rented</th><th>Garage</th><th>Idle</th><th>Util %</th><th>Status</th></tr>'
			+yo.map(function(r){var p2=_pct(_fld(r,'rental'),_fld(r,'total'));var st=p2>=90?'Excellent':p2>=80?'Good':p2>=60?'Review':'Flag';
				return '<tr><td>'+_lbl(r)+'</td><td>'+_fmt(r.total)+'</td><td>'+_fmt(r.rental)+'</td><td>'+_fmt(r.garage)+'</td><td>'+_fmt(r.other)+'</td><td><span class="d-badge '+_bCls(p2)+'">'+p2+'%</span></td><td><span class="d-badge '+_bCls(p2)+'">'+st+'</span></td></tr>';}).join('')+'</table>';
	}

	/* -- GROUP -- */
	function _renderGroup(grp){
		if(!grp||!grp.length){document.getElementById('dp_group').innerHTML='<div class="d-loading">No group data â load data first.</div>';return;}
		grp.sort(function(a,b){return _fld(b,'total')-_fld(a,'total');});
		var gC=[_DC.B,_DC.T,_DC.A,_DC.C,_DC.P,_DC.B2,_DC.R,_DC.G];
		document.getElementById('gr_kpis').innerHTML='<div class="d-metric-grid">'+grp.slice(0,6).map(function(r){var p2=_pct(_fld(r,'rental'),_fld(r,'total'));
			return '<div class="d-metric"><div class="d-metric-label">'+_lbl(r)+'</div><div class="d-metric-val">'+p2+'%</div><div class="d-metric-sub">'+_fmt(r.total)+' live days</div></div>';}).join('')+'</div>';
		var grand=grp.reduce(function(s,r){return s+_fld(r,'total');},0);
		document.getElementById('gr_legend').innerHTML=grp.map(function(r,i){return '<span class="d-leg-item"><span class="d-leg-sq" style="background:'+gC[i%gC.length]+'"></span>'+_lbl(r)+'</span>';}).join('');
		if(_dc.gr1)_dc.gr1.destroy();
		_dc.gr1=new Chart(document.getElementById('ch_gr_donut').getContext('2d'),{type:'doughnut',
			data:{labels:grp.map(function(r){return _lbl(r)+' ('+_pct(_fld(r,'total'),grand)+'%)';}),
				datasets:[{data:grp.map(function(r){return _fld(r,'total');}),backgroundColor:grp.map(function(_,i){return gC[i%gC.length];}),borderWidth:0,hoverOffset:4}]},
			options:{responsive:true,maintainAspectRatio:false,cutout:'55%',plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.label+': '+_fmt(b.raw)+' days';}}}}}});
		if(_dc.gr2)_dc.gr2.destroy();
		_dc.gr2=new Chart(document.getElementById('ch_gr_stacked').getContext('2d'),{type:'bar',
			data:{labels:grp.map(_lbl),datasets:[
				{label:'Rented',data:grp.map(function(r){return _fld(r,'rental');}),backgroundColor:_DC.T,stack:'g'},
				{label:'Garage',data:grp.map(function(r){return _fld(r,'garage');}),backgroundColor:_DC.R,stack:'g'},
				{label:'Idle',  data:grp.map(function(r){return _fld(r,'other' );}),backgroundColor:_DC.G,stack:'g'},
				{label:'Staff', data:grp.map(function(r){return _fld(r,'staff' );}),backgroundColor:_DC.B2,stack:'g'}]},
			options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_fmt(b.raw)+' days';}}}},
				scales:{y:{stacked:true,ticks:{callback:function(v){return _fmt(v);}},grid:{color:_GC}},x:{stacked:true,ticks:{font:{size:11}}}}}});
	}

	/* -- LOW UTIL -- */
	function _renderLowUtil(veh){
		if(!veh||!veh.length){document.getElementById('dp_lowutil').innerHTML='<div class="d-loading">No vehicle data â load data first.</div>';return;}
		var aU=veh.map(function(r){return _pct(_fld(r,'rental'),_fld(r,'total'));});
		var low=veh.filter(function(r,i){return aU[i]<50&&_fld(r,'total')>0;});
		var zero=veh.filter(function(r,i){return aU[i]===0&&_fld(r,'total')>0;});
		_setKpi('lu_count',low.length,'<50% rental rate');
		_setKpi('lu_zero',zero.length,'0% â investigate');
		_setKpi('lu_idle',_fmt(low.reduce(function(s,r){return s+_fld(r,'other');},0)),'idle days opportunity');
		_setKpi('lu_garage',_fmt(low.reduce(function(s,r){return s+_fld(r,'garage');},0)),'days in maintenance');
		var bkts=[0,10,20,30,40,50,60,70,80,90,100];
		if(_dc.lu1)_dc.lu1.destroy();
		_dc.lu1=new Chart(document.getElementById('ch_lu_dist').getContext('2d'),{type:'bar',
			data:{labels:bkts.map(function(b,i){return b+'-'+(bkts[i+1]||100)+'%';}),
				datasets:[{data:bkts.map(function(b,i){return aU.filter(function(v){return v>=b&&v<(bkts[i+1]||101);}).length;}),
					backgroundColor:bkts.map(function(b){return b>=90?_DC.T:b>=70?_DC.B2:b>=50?_DC.A:_DC.R;}),borderRadius:4}]},
			options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.raw+' vehicles';}}}},
				scales:{y:{grid:{color:_GC}},x:{ticks:{font:{size:11}}}}}});
		var worst=veh.filter(function(r){return _fld(r,'total')>0;}).sort(function(a,b){return _pct(_fld(a,'rental'),_fld(a,'total'))-_pct(_fld(b,'rental'),_fld(b,'total'));}).slice(0,20);
		document.getElementById('lu_table').innerHTML='<table><tr><th>Ref</th><th>Vehicle</th><th>Util %</th><th>Garage</th><th>Idle</th><th>Staff</th><th>Action</th></tr>'
			+worst.map(function(r){var p2=_pct(_fld(r,'rental'),_fld(r,'total')),ga=_fld(r,'garage'),id2=_fld(r,'other'),st=_fld(r,'staff');
				var act=ga>id2&&ga>0?'In garage':id2>ga&&id2>0?'Idle':st>0?'Staff only':'Investigate';
				var ac=act==='Idle'?'d-b-red':act==='In garage'?'d-b-amber':'d-b-blue';
				return '<tr><td>'+r.refno+'</td><td>'+_lbl(r)+'</td><td><span class="d-badge '+_bCls(p2)+'">'+p2+'%</span></td><td>'+_fmt(ga)+'</td><td>'+_fmt(id2)+'</td><td>'+_fmt(st)+'</td><td><span class="d-badge '+ac+'">'+act+'</span></td></tr>';}).join('')+'</table>';
	}
	// ===================== END ANALYTICS DASHBOARD =====================

	function setDetail(){
		if(document.getElementById("chkdetail").checked==true){
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','transfer','hidden',false);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','delivery','hidden',false);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','others','hidden',false);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','custody','hidden',false);
		}
		else if(document.getElementById("chkdetail").checked==false){
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','transfer','hidden',true);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','delivery','hidden',true);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','others','hidden',true);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','custody','hidden',true);
		}
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmSalesInvoiceList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From Date</td>
                        <td><div id="fromdate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To Date</td>
                        <td><div id="todate"></div></td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <div style="display: flex; justify-content: center; gap: 20px; padding: 5px 0;">
                    <span>
                        <input type="radio" name="duration" id="rdohours" value="hours">
                        <label class="branch" for="rdohours">Hours</label>
                    </span>
                    <span>
                        <input type="radio" name="duration" id="rdodays" value="days" checked>
                        <label class="branch" for="rdodays">Days</label>
                    </span>
                </div>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Grouping 1</td>
                        <td>
                            <select name="grpby1" id="grpby1">
                                <option value="">--Select--</option>
                                <option value="brand">Brand</option>
                                <option value="model">Model</option>
                                <option value="group">Group</option>
                                <option value="yom">YOM</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Search By</td>
                        <td>
                            <select name="searchby" id="searchby">
                                <option value="">--Select--</option>
                                <option value="brand">Brand</option>
                                <option value="model">Model</option>
                                <option value="group">Group</option>
                                <option value="yom">YOM</option>
                                <option value="fleet">Fleet</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
    <td colspan="2" style="padding-top:10px;">

        <div style="display:flex; justify-content:center; gap:6px;">

            <button type="button"
                    id="additem"
                    class="myButton"
                    onclick="setSearch();"
                    style="width:40px; height:28px;">
                +
            </button>

            <button type="button"
                    id="btnremoveitem"
                    class="myButton"
                    onclick="setRemove();"
                    style="width:40px; height:28px;">
                -
            </button>

        </div>

    </td>
</tr>
                    <tr>
<td colspan="2" style="padding-top: 10px;">
    <textarea id="searchdetails"
              name="searchdetails"
              rows="10"
              readonly
              style="resize:none; font-size:11px; width:100%; box-sizing:border-box;"></textarea>
</td>
                    </tr>
                </table>
            </div>

            <div style="padding: 5px;">
                <input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons btn-full" onclick="funClearData();">
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">

        <!-- View Toggle Bar -->
        <div style="display:flex;align-items:center;gap:8px;padding:9px 14px;background:#fff;border-bottom:1px solid #e1e8ed;flex-wrap:wrap;">
            <button type="button" id="btnGridView" onclick="showView('grid')" class="view-btn active">Grid View</button>
            <button type="button" id="btnDashView" onclick="showView('dashboard')" class="view-btn">Analytics Dashboard</button>
            <div style="margin-left:auto;display:flex;gap:8px;">
                <button type="button" onclick="funExportBtn()" class="view-btn" style="background:#059669;color:#fff;">Export Excel</button>
                <button type="button" onclick="funreload()" class="view-btn" style="background:#2563eb;color:#fff;">Load / Refresh</button>
            </div>
        </div>

        <div class="scrollable-grid-area">
            <div id="vehutilizediv">
                <jsp:include page="vehUtilizeGrid.jsp"></jsp:include>
            </div>

            <!-- Analytics Dashboard Panel -->
            <div id="analyticsDashboard" style="display:none;height:calc(100vh - 95px);overflow-y:auto;background:#f4f7f9;padding:14px 16px;">
                <div id="dashNoData" style="display:none;text-align:center;padding:60px 20px;color:#9a9a9a;">
                    <div style="font-size:32px;margin-bottom:10px;">&#128202;</div>
                    <div style="font-size:15px;font-weight:500;">No Data Loaded</div>
                    <div style="font-size:12px;margin-top:6px;">Select filters and click <strong>Load / Refresh</strong> to populate the dashboard.</div>
                </div>
                <div id="dashContent">
                    <div id="dashLoading" style="display:none;" class="d-loading">Loading analytics&hellip; fetching brand, model, group &amp; YOM data</div>
                    <div id="dashTabs">
                        <div class="d-tabs">
                            <div class="d-tab active" id="dt_overview" onclick="switchDashTab('overview')">Overview</div>
                            <div class="d-tab" id="dt_brand"   onclick="switchDashTab('brand')">By brand</div>
                            <div class="d-tab" id="dt_model"   onclick="switchDashTab('model')">By model</div>
                            <div class="d-tab" id="dt_yom"     onclick="switchDashTab('yom')">By YOM</div>
                            <div class="d-tab" id="dt_group"   onclick="switchDashTab('group')">By group</div>
                            <div class="d-tab" id="dt_lowutil" onclick="switchDashTab('lowutil')">Low utilisation</div>
                        </div>

                        <!-- OVERVIEW -->
                        <div id="dp_overview" class="d-panel active">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="ov_fleet"><div class="d-metric-label">Total fleet</div><div class="d-metric-val">-</div><div class="d-metric-sub">vehicles tracked</div></div>
                                <div class="d-metric" id="ov_util"><div class="d-metric-label">Avg utilisation</div><div class="d-metric-val">-</div><div class="d-metric-sub">rental vs live-in</div></div>
                                <div class="d-metric" id="ov_rented"><div class="d-metric-label">Rented days</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="ov_garage"><div class="d-metric-label">In garage</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="ov_staff"><div class="d-metric-label">Staff use</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="ov_idle"><div class="d-metric-label">Idle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-row">
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Fleet time allocation (days)</div>
                                    <div class="d-legend">
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#1D9E75"></span>Rented</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#E24B4A"></span>Garage</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#378ADD"></span>Staff</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#888780"></span>Idle</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#EF9F27"></span>Transfer</span>
                                    </div>
                                    <div style="position:relative;width:100%;height:220px"><canvas id="ch_ov_donut"></canvas></div>
                                </div>
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Utilisation rate by vehicle group</div>
                                    <div style="position:relative;width:100%;height:220px"><canvas id="ch_ov_grp"></canvas></div>
                                </div>
                            </div>
                            <div class="d-chart-box" style="margin-bottom:18px">
                                <div class="d-chart-title">Total live-in by brand (days)</div>
                                <div id="ov_brandBars" style="padding-top:4px"></div>
                            </div>
                        </div>

                        <!-- BY BRAND -->
                        <div id="dp_brand" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="br_largest"><div class="d-metric-label">Largest brand</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="br_bestutil"><div class="d-metric-label">Best utilisation</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="br_garage"><div class="d-metric-label">Most garage time</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="br_idle"><div class="d-metric-label">Most idle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-row">
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Utilisation % by brand</div>
                                    <div style="position:relative;width:100%;height:320px"><canvas id="ch_br_bar"></canvas></div>
                                </div>
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Rented vs garage vs idle by brand</div>
                                    <div class="d-legend">
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#1D9E75"></span>Rented</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#E24B4A"></span>Garage</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#888780"></span>Idle</span>
                                    </div>
                                    <div style="position:relative;width:100%;height:320px"><canvas id="ch_br_stacked"></canvas></div>
                                </div>
                            </div>
                            <div class="d-table-box" id="br_table"></div>
                        </div>

                        <!-- BY MODEL -->
                        <div id="dp_model" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="mo_largest"><div class="d-metric-label">Largest model</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mo_second"><div class="d-metric-label">2nd largest</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mo_bestutil"><div class="d-metric-label">Best util</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mo_count"><div class="d-metric-label">Total models</div><div class="d-metric-val">-</div><div class="d-metric-sub">unique models</div></div>
                            </div>
                            <div class="d-chart-box" style="margin-bottom:16px">
                                <div class="d-chart-title">Top 15 models &mdash; utilisation rate (%)</div>
                                <div style="position:relative;width:100%;height:380px"><canvas id="ch_mo_bar"></canvas></div>
                            </div>
                            <div class="d-chart-box" style="margin-bottom:16px">
                                <div class="d-chart-title">Top 12 models &mdash; rented vs garage vs idle</div>
                                <div class="d-legend">
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Rented</span>
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#E24B4A"></span>Garage</span>
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#888780"></span>Idle</span>
                                </div>
                                <div style="position:relative;width:100%;height:280px"><canvas id="ch_mo_stacked"></canvas></div>
                            </div>
                        </div>

                        <!-- BY YOM -->
                        <div id="dp_yom" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="yo_newest"><div class="d-metric-label">Newest year</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="yo_second"><div class="d-metric-label">Previous year</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="yo_older"><div class="d-metric-label">Older fleet</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="yo_oldest"><div class="d-metric-label">Oldest year</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-row">
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Fleet live-in by year of manufacture</div>
                                    <div style="position:relative;width:100%;height:240px"><canvas id="ch_yo_fleetbar"></canvas></div>
                                </div>
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Utilisation rate by YOM (%)</div>
                                    <div style="position:relative;width:100%;height:240px"><canvas id="ch_yo_util"></canvas></div>
                                </div>
                            </div>
                            <div class="d-chart-box" style="margin-bottom:18px">
                                <div class="d-chart-title">Garage days by YOM (maintenance load)</div>
                                <div style="position:relative;width:100%;height:200px"><canvas id="ch_yo_garage"></canvas></div>
                            </div>
                            <div class="d-table-box" id="yo_table"></div>
                        </div>

                        <!-- BY GROUP -->
                        <div id="dp_group" class="d-panel">
                            <div id="gr_kpis"></div>
                            <div class="d-chart-row">
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Fleet composition by group (live days)</div>
                                    <div class="d-legend" id="gr_legend"></div>
                                    <div style="position:relative;width:100%;height:240px"><canvas id="ch_gr_donut"></canvas></div>
                                </div>
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Utilisation vs garage vs idle vs staff by group</div>
                                    <div class="d-legend">
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#1D9E75"></span>Rented</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#E24B4A"></span>Garage</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#888780"></span>Idle</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#378ADD"></span>Staff</span>
                                    </div>
                                    <div style="position:relative;width:100%;height:240px"><canvas id="ch_gr_stacked"></canvas></div>
                                </div>
                            </div>
                        </div>

                        <!-- LOW UTILISATION -->
                        <div id="dp_lowutil" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="lu_count"><div class="d-metric-label">Low util vehicles</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="lu_zero"><div class="d-metric-label">Zero utilisation</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="lu_idle"><div class="d-metric-label">Idle days (low util)</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="lu_garage"><div class="d-metric-label">Garage (low util)</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-box" style="margin-bottom:16px">
                                <div class="d-chart-title">Utilisation rate &mdash; all vehicles ranked (each bar = 10% bucket)</div>
                                <div style="position:relative;width:100%;height:200px"><canvas id="ch_lu_dist"></canvas></div>
                            </div>
                            <div class="d-table-box">
                                <div class="d-chart-title" style="margin-bottom:10px">Vehicles requiring attention (util &lt;50%, sorted worst first)</div>
                                <div id="lu_table"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
            <input type="hidden" name="hidgroup" id="hidgroup">
            <input type="hidden" name="hidmodel" id="hidmodel">
            <input type="hidden" name="hidyom" id="hidyom">
            <input type="hidden" name="hidbrand" id="hidbrand">
            <input type="hidden" name="group" id="group">
            <input type="hidden" name="model" id="model">
            <input type="hidden" name="yom" id="yom">
            <input type="hidden" name="brand" id="brand">
            <input type="hidden" name="hidfleet" id="hidfleet">
            <input type="hidden" name="fleet" id="fleet">
        </div>
    </div>
</div>
</div>

</div>
<div id="fleetwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
<div id="brandwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
<div id="modelwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
<div id="groupwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
<div id="yomwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
</form>
</body>
</html>