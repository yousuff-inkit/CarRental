<jsp:include page="../../../../includes.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<style type="text/css">
.master-container{display:flex;width:100%;height:100%;font-family:'Segoe UI',Tahoma,sans-serif;background-color:#f4f7f9}
.sidebar-filters{width:300px;flex:0 0 300px;background:#fff;border-right:1px solid #e1e8ed;display:flex;flex-direction:column;height:100vh;box-shadow:2px 0 8px rgba(0,0,0,.05)}
.sidebar-fixed-top{padding:15px 20px;border-bottom:1px solid #f0f4f8}
.sidebar-scroll-content{flex:1;overflow-y:auto;padding:15px 20px 25px}
.filter-card{background:#f8fafc;border:1px solid #e3e8ee;border-radius:12px;padding:15px;margin-bottom:12px}
.filter-table{width:100%;border-spacing:0 10px}
.label-cell{text-align:right;padding-right:10px;font-size:13px;font-weight:600;color:#4e5e71;width:70px}
input[type="text"],select{width:100%;padding:7px 10px;border:1px solid #ccd6e0;border-radius:6px;font-size:13px;box-sizing:border-box}
html,body,#mainBG,.hidden-scrollbar{height:100%;margin:0;overflow:hidden}
.myButtons,.myButton{background-color:#2563eb!important;color:#fff!important;border:none!important;border-radius:6px;padding:10px 15px;width:100%;font-weight:600;cursor:pointer;font-size:13px}
.myButtons:hover,.myButton:hover{background-color:#1d4ed8!important}
.main-content-wrapper{flex:1;width:100%;display:flex;flex-direction:column;overflow:hidden}
.scrollable-grid-area{width:100%;flex:1;overflow:hidden}
/* view toggle */
.view-btn{padding:7px 16px!important;border:none!important;border-radius:6px;font-size:13px;font-weight:600;cursor:pointer;background:#e5e7eb;color:#374151;transition:background .15s;height:auto!important;width:auto!important;line-height:normal!important;box-sizing:content-box!important}
.view-btn.active,.view-btn:hover{background:#2563eb!important;color:#fff!important}
/* dashboard */
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
.d-loading{text-align:center;padding:50px 20px;color:#9a9a9a;font-size:13px}
@media(max-width:520px){.d-chart-row{grid-template-columns:1fr}}
</style>
<script type="text/javascript">

$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index:1;display:none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display:none;position:absolute;z-index:1;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#fromdate").jqxDateTimeInput({ width:'125px', height:'15px', formatString:"dd.MM.yyyy" });
    $("#todate").jqxDateTimeInput({ width:'125px', height:'15px', formatString:"dd.MM.yyyy" });
    $('#vehicleDetailsWindow').jqxWindow({ width:'51%', height:'58%', maxHeight:'70%', maxWidth:'51%', title:'Vehicle Search', position:{x:300,y:87}, theme:'energyblue', showCloseButton:true, keyboardCloseKey:27 });
    $('#vehicleDetailsWindow').jqxWindow('close');
    $('#inspectionWindow').jqxWindow({ autoOpen:false, width:'78%', height:'85%', maxHeight:'85%', maxWidth:'78%', title:'Inspection Details', theme:'energyblue', position:{x:280,y:10}, keyboardCloseKey:27, showCloseButton:true, closeButtonAction:'hide' });
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthback=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthback);
    $('#txtvehicle').dblclick(function(){ vehicleSearchContent('vehicleDetailsGrid.jsp?id=1'); });
    document.getElementById('rdosummary').checked=true;
    setReportType();
});

function vehicleSearchContent(url){
    $('#vehicleDetailsWindow').jqxWindow('open');
    $.get(url).done(function(data){ $('#vehicleDetailsWindow').jqxWindow('setContent',data); $('#vehicleDetailsWindow').jqxWindow('bringToFront'); });
}
function inspectionSearchContent(url){
    $('#inspectionWindow').jqxWindow('focus');
    $.get(url).done(function(data){ $('#inspectionWindow').jqxWindow('setContent',data); });
}
function getVehicle(event){
    if(event.keyCode==114) vehicleSearchContent('vehicleDetailsGrid.jsp?id=1');
}

function funreload(){
    var branchval = document.getElementById('cmbbranch').value;
    var type = $('#hidreporttype').val();
    var fleetno = $('#txtfleetno').val();
    var fromdate = $('#fromdate').val();
    var todate = $('#todate').val();
    if(type==''){
        $.messager.alert('Message','Please Choose a Report Type.','warning');
        return;
    }
    _mrData = null;
    $("#overlay, #PleaseWait").show();
    if(type=='1'){
        $("#summarygriddiv").prop("hidden", false);
        $("#detailgriddiv").prop("hidden", true);
        $("#summarygriddiv").load("summaryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1', function(){
            if(document.getElementById('mrDashboard').style.display!=='none'){
                setTimeout(buildMrDashboard, 100);
            }
        });
    } else {
        $("#summarygriddiv").prop("hidden", true);
        $("#detailgriddiv").prop("hidden", false);
        $("#detailgriddiv").load("detailGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1');
    }
}

function funClearInfo(){
    $('#fromdate').val(new Date());
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthback=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthback);
    $('#todate').val(new Date());
    $("#hidreporttype").val('');
    $("#txtvehicle").val('');
    $("#txtfleetno").val('');
    $("#txtvehdocno").val('');
    document.getElementById('rdosummary').checked=true;
    setReportType();
    try{ $("#summaryGrid").jqxGrid('clear'); }catch(e){}
    try{ $("#detailGrid").jqxGrid('clear'); }catch(e){}
    if(document.getElementById('txtvehicle').value=='')
        $('#txtvehicle').attr('placeholder','Press F3 to Search');
}

function funMaintenancePrint(){
    var fleetno=$('#txtfleetno').val();
    if(fleetno==''){
        $.messager.alert('Message','Please Choose a Fleet.','warning');
        return;
    }
    var url=document.URL;
    var reurl=url.split("maintenanceReview.jsp");
    $("#txtfleetno").prop("disabled", false);
    var win=window.open(reurl[0]+"printMaintenanceReview?&fleetno="+fleetno+'&branch='+document.getElementById('cmbbranch').value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value)=="1"){
        var reporttype=$('#hidreporttype').val();
        if(reporttype=='1'){
            $("#summaryGrid").excelexportjs({ containerid:"summaryGrid", datatype:'json', dataset:null, gridId:"summaryGrid", columns:getColumns("summaryGrid"), worksheetName:"Summary Data" });
        }
        if(reporttype=='2'){
            $("#detailGrid").excelexportjs({ containerid:"detailGrid", datatype:'json', dataset:null, gridId:"detailGrid", columns:getColumns("detailGrid"), worksheetName:"Detail Data" });
        }
    } else {
        var reporttype=$('#hidreporttype').val();
        if(reporttype=='1') $("#summaryGrid").jqxGrid('exportdata','xls','Summary Data');
        if(reporttype=='2') $("#detailGrid").jqxGrid('exportdata','xls','Detail Data');
    }
}

function setReportType(){
    if(document.getElementById('rdosummary').checked){
        document.getElementById('hidreporttype').value='1';
    } else if(document.getElementById('rdodetail').checked){
        document.getElementById('hidreporttype').value='2';
    }
}

// ===================== VIEW TOGGLE =====================
function showMrView(view){
    var sg=document.getElementById('summarygriddiv');
    var dg=document.getElementById('detailgriddiv');
    var d =document.getElementById('mrDashboard');
    var bg=document.getElementById('mrBtnGrid');
    var bd=document.getElementById('mrBtnDash');
    if(view==='grid'){
        var rt=document.getElementById('hidreporttype').value;
        if(rt==='2'){dg.hidden=false;sg.hidden=true;}
        else{sg.hidden=false;dg.hidden=true;}
        d.style.display='none';
        bg.classList.add('active'); bd.classList.remove('active');
    } else {
        sg.hidden=true; dg.hidden=true;
        d.style.display='';
        bg.classList.remove('active'); bd.classList.add('active');
        setTimeout(buildMrDashboard, 60);
    }
}

function switchMrTab(tab){
    document.querySelectorAll('#mrDashboard .d-tab').forEach(function(b){b.classList.remove('active');});
    document.querySelectorAll('#mrDashboard .d-panel').forEach(function(p){p.classList.remove('active');});
    document.getElementById('mrt_'+tab).classList.add('active');
    document.getElementById('mrp_'+tab).classList.add('active');
}

// ===================== ANALYTICS DASHBOARD =====================
var _mrc={}, _mrData=null;
var _MRC={T:'#1D9E75',B:'#185FA5',B2:'#378ADD',A:'#EF9F27',C:'#D85A30',R:'#E24B4A',G:'#888780',P:'#7F77DD'};
var _MGC='rgba(128,128,128,0.1)';

function _mrcD(){ Object.keys(_mrc).forEach(function(k){if(_mrc[k]){_mrc[k].destroy();delete _mrc[k];}}); }
function _mrFmt(v){ return v>=1e6?(v/1e6).toFixed(1)+'M':v>=1e3?Math.round(v/1e3)+'K':String(Math.round(v)); }
function _mrFld(r,f){ return parseFloat(r[f])||0; }
function _mrLbl(r){ return (((r.flname||r.reg_no||r.fleet_no||'')+'').trim())||'-'; }
function _mrSetKpi(id,val,sub){
    var el=document.getElementById(id); if(!el)return;
    var ve=el.querySelector('.d-metric-val'), se=el.querySelector('.d-metric-sub');
    if(ve) ve.textContent=(val!=null)?val:'-';
    if(se) se.textContent=sub||'';
}

function buildMrDashboard(){
    var rows=[];
    try{ var g=$('#summaryGrid').jqxGrid('getrows'); if(g&&g.length>0) rows=g; }catch(e){}
    var noEl=document.getElementById('mrDashNoData');
    var conEl=document.getElementById('mrDashContent');
    if(!rows.length){ noEl.style.display=''; conEl.style.display='none'; return; }
    noEl.style.display='none'; conEl.style.display='';
    _mrData=rows;
    _mrcD();
    _mrRenderOverview(rows);
    _mrRenderCostSplit(rows);
    _mrRenderTopVehicles(rows);
    _mrRenderByGroup(rows);
    _mrRenderByYom(rows);
}

function _mrRenderOverview(rows){
    var totLab=0, totParts=0, totNet=0;
    rows.forEach(function(r){ totLab+=_mrFld(r,'labourcost'); totParts+=_mrFld(r,'partscost'); totNet+=_mrFld(r,'nettotal'); });
    var avgNet=rows.length?Math.round(totNet/rows.length):0;
    var topVeh=rows.slice().sort(function(a,b){return _mrFld(b,'nettotal')-_mrFld(a,'nettotal');})[0];
    _mrSetKpi('mr_ov_fleet',rows.length,'vehicles');
    _mrSetKpi('mr_ov_lab',_mrFmt(totLab),'total labour cost');
    _mrSetKpi('mr_ov_parts',_mrFmt(totParts),'total parts cost');
    _mrSetKpi('mr_ov_net',_mrFmt(totNet),'total maintenance cost');
    _mrSetKpi('mr_ov_avg',_mrFmt(avgNet),'avg cost / vehicle');
    _mrSetKpi('mr_ov_top',topVeh?_mrLbl(topVeh):'-',topVeh?'Cost: '+_mrFmt(_mrFld(topVeh,'nettotal')):'');

    if(_mrc.ov1)_mrc.ov1.destroy();
    _mrc.ov1=new Chart(document.getElementById('mr_ch_ov_donut').getContext('2d'),{
        type:'doughnut',
        data:{labels:['Labour','Parts'],datasets:[{data:[totLab,totParts],backgroundColor:[_MRC.B,_MRC.A],borderWidth:0,hoverOffset:4}]},
        options:{responsive:true,maintainAspectRatio:false,cutout:'58%',plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.label+': '+_mrFmt(b.raw);}}}}}
    });
    var top=rows.slice().sort(function(a,b){return _mrFld(b,'nettotal')-_mrFld(a,'nettotal');}).slice(0,15);
    if(_mrc.ov2)_mrc.ov2.destroy();
    _mrc.ov2=new Chart(document.getElementById('mr_ch_ov_top').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:top.map(_mrLbl),datasets:[{data:top.map(function(r){return _mrFld(r,'nettotal');}),backgroundColor:_MRC.B,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Cost: '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}},y:{ticks:{font:{size:11}}}}}
    });
}

function _mrRenderCostSplit(rows){
    var top=rows.slice().sort(function(a,b){return _mrFld(b,'nettotal')-_mrFld(a,'nettotal');}).slice(0,15);
    var totLab=rows.reduce(function(s,r){return s+_mrFld(r,'labourcost');},0);
    var totParts=rows.reduce(function(s,r){return s+_mrFld(r,'partscost');},0);
    var totNet=rows.reduce(function(s,r){return s+_mrFld(r,'nettotal');},0);
    var labPct=totNet>0?Math.round(totLab/totNet*100):0;
    var partsPct=totNet>0?Math.round(totParts/totNet*100):0;
    var highestLab=rows.slice().sort(function(a,b){return _mrFld(b,'labourcost')-_mrFld(a,'labourcost');})[0];
    _mrSetKpi('mr_cs_labpct',labPct+'%','of total is labour');
    _mrSetKpi('mr_cs_partspct',partsPct+'%','of total is parts');
    _mrSetKpi('mr_cs_highlab',highestLab?_mrLbl(highestLab):'-',highestLab?'Labour: '+_mrFmt(_mrFld(highestLab,'labourcost')):'');
    _mrSetKpi('mr_cs_ratio',totParts>0?Math.round(totLab/totParts*10)/10+':1':'-','labour to parts ratio');

    if(_mrc.cs1)_mrc.cs1.destroy();
    _mrc.cs1=new Chart(document.getElementById('mr_ch_cs_stacked').getContext('2d'),{
        type:'bar',
        data:{labels:top.map(_mrLbl),datasets:[
            {label:'Labour',data:top.map(function(r){return _mrFld(r,'labourcost');}),backgroundColor:_MRC.B,borderRadius:4},
            {label:'Parts', data:top.map(function(r){return _mrFld(r,'partscost');}), backgroundColor:_MRC.A,borderRadius:4}
        ]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_mrFmt(b.raw);}}}},
            scales:{x:{stacked:false,ticks:{font:{size:10},maxRotation:30,autoSkip:false}},y:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}}}}
    });
    var nets=rows.map(function(r){return _mrFld(r,'nettotal');});
    var minN=Math.min.apply(null,nets), maxN=Math.max.apply(null,nets);
    var range=maxN-minN, bktSz=range>0?range/10:1;
    var bkts=[];
    for(var i=0;i<10;i++) bkts.push({mn:minN+i*bktSz,mx:minN+(i+1)*bktSz,cnt:0});
    nets.forEach(function(n){ var idx=Math.min(Math.floor((n-minN)/bktSz),9); if(idx>=0&&idx<10)bkts[idx].cnt++; });
    if(_mrc.cs2)_mrc.cs2.destroy();
    _mrc.cs2=new Chart(document.getElementById('mr_ch_cs_hist').getContext('2d'),{
        type:'bar',
        data:{labels:bkts.map(function(b){return _mrFmt(b.mn)+'~'+_mrFmt(b.mx);}),
              datasets:[{data:bkts.map(function(b){return b.cnt;}),backgroundColor:_MRC.B2,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.raw+' vehicles';}}}},
            scales:{y:{grid:{color:_MGC}},x:{ticks:{font:{size:10},maxRotation:35}}}}
    });
}

function _mrRenderTopVehicles(rows){
    var byNet=rows.slice().sort(function(a,b){return _mrFld(b,'nettotal')-_mrFld(a,'nettotal');});
    var byLab=rows.slice().sort(function(a,b){return _mrFld(b,'labourcost')-_mrFld(a,'labourcost');});
    _mrSetKpi('mr_top_net',byNet[0]?_mrLbl(byNet[0]):'-',byNet[0]?'Cost: '+_mrFmt(_mrFld(byNet[0],'nettotal')):'');
    _mrSetKpi('mr_top_lab',byLab[0]?_mrLbl(byLab[0]):'-',byLab[0]?'Labour: '+_mrFmt(_mrFld(byLab[0],'labourcost')):'');
    _mrSetKpi('mr_top_cnt',rows.length,'vehicles tracked');
    _mrSetKpi('mr_top_avg',_mrFmt(rows.length?Math.round(rows.reduce(function(s,r){return s+_mrFld(r,'nettotal');},0)/rows.length):0),'avg cost');

    var t15=byNet.slice(0,15);
    if(_mrc.tp1)_mrc.tp1.destroy();
    _mrc.tp1=new Chart(document.getElementById('mr_ch_top_net').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15.map(_mrLbl),datasets:[{data:t15.map(function(r){return _mrFld(r,'nettotal');}),backgroundColor:_MRC.C,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Total: '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}},y:{ticks:{font:{size:11}}}}}
    });
    var t15l=byLab.slice(0,15);
    if(_mrc.tp2)_mrc.tp2.destroy();
    _mrc.tp2=new Chart(document.getElementById('mr_ch_top_lab').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15l.map(_mrLbl),datasets:[{data:t15l.map(function(r){return _mrFld(r,'labourcost');}),backgroundColor:_MRC.B,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Labour: '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}},y:{ticks:{font:{size:11}}}}}
    });
}

function _mrRenderByGroup(rows){
    var grpMap={};
    rows.forEach(function(r){
        var g=r.gname||'Unknown';
        if(!grpMap[g]) grpMap[g]={lab:0,parts:0,net:0,cnt:0};
        grpMap[g].lab+=_mrFld(r,'labourcost'); grpMap[g].parts+=_mrFld(r,'partscost');
        grpMap[g].net+=_mrFld(r,'nettotal'); grpMap[g].cnt++;
    });
    var grps=Object.keys(grpMap).map(function(k){return {name:k,data:grpMap[k]};}).sort(function(a,b){return b.data.net-a.data.net;});
    var topGrp=grps[0];
    _mrSetKpi('mr_grp_count',grps.length,'groups');
    _mrSetKpi('mr_grp_top',topGrp?topGrp.name:'-',topGrp?'Cost: '+_mrFmt(topGrp.data.net):'');
    _mrSetKpi('mr_grp_veh',topGrp?topGrp.data.cnt:'-',topGrp?'vehicles in top group':'');
    _mrSetKpi('mr_grp_avg',topGrp&&topGrp.data.cnt?_mrFmt(Math.round(topGrp.data.net/topGrp.data.cnt)):'-','avg cost in top group');

    if(_mrc.gp1)_mrc.gp1.destroy();
    _mrc.gp1=new Chart(document.getElementById('mr_ch_grp_bar').getContext('2d'),{
        type:'bar',
        data:{labels:grps.map(function(g){return g.name;}),datasets:[
            {label:'Labour',data:grps.map(function(g){return g.data.lab;}),backgroundColor:_MRC.B,borderRadius:4},
            {label:'Parts', data:grps.map(function(g){return g.data.parts;}),backgroundColor:_MRC.A,borderRadius:4}
        ]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{font:{size:11}}},y:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}}}}
    });
    document.getElementById('mr_grp_table').innerHTML='<table><tr><th>Group</th><th>Vehicles</th><th>Labour Cost</th><th>Parts Cost</th><th>Total Cost</th><th>Avg / Vehicle</th></tr>'
        +grps.map(function(g){
            var avg=g.data.cnt?Math.round(g.data.net/g.data.cnt):0;
            return '<tr><td>'+g.name+'</td><td>'+g.data.cnt+'</td><td>'+_mrFmt(g.data.lab)+'</td><td>'+_mrFmt(g.data.parts)+'</td><td><span class="d-badge d-b-amber">'+_mrFmt(g.data.net)+'</span></td><td>'+_mrFmt(avg)+'</td></tr>';
        }).join('')+'</table>';
}

function _mrRenderByYom(rows){
    var yomMap={};
    rows.forEach(function(r){
        var y=r.yom||'Unknown';
        if(!yomMap[y]) yomMap[y]={lab:0,parts:0,net:0,cnt:0};
        yomMap[y].lab+=_mrFld(r,'labourcost'); yomMap[y].parts+=_mrFld(r,'partscost');
        yomMap[y].net+=_mrFld(r,'nettotal'); yomMap[y].cnt++;
    });
    var yoms=Object.keys(yomMap).map(function(k){return {name:k,data:yomMap[k]};}).sort(function(a,b){
        return (parseInt(a.name)||0)-(parseInt(b.name)||0);
    });
    var topYom=yoms.slice().sort(function(a,b){return b.data.net-a.data.net;})[0];
    _mrSetKpi('mr_yom_count',yoms.length,'YOM groups');
    _mrSetKpi('mr_yom_top',topYom?topYom.name:'-','highest cost YOM');
    _mrSetKpi('mr_yom_veh',topYom?topYom.data.cnt:'-',topYom?'vehicles':' ');
    _mrSetKpi('mr_yom_avg',topYom&&topYom.data.cnt?_mrFmt(Math.round(topYom.data.net/topYom.data.cnt)):'-','avg cost in top YOM');

    if(_mrc.ym1)_mrc.ym1.destroy();
    _mrc.ym1=new Chart(document.getElementById('mr_ch_yom_bar').getContext('2d'),{
        type:'bar',
        data:{labels:yoms.map(function(y){return y.name;}),datasets:[{
            data:yoms.map(function(y){return y.data.cnt?Math.round(y.data.net/y.data.cnt):0;}),
            backgroundColor:_MRC.P,borderRadius:4
        }]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Avg cost: '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{font:{size:11}}},y:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}}}}
    });
    document.getElementById('mr_yom_table').innerHTML='<table><tr><th>YOM</th><th>Vehicles</th><th>Labour Cost</th><th>Parts Cost</th><th>Total Cost</th><th>Avg / Vehicle</th></tr>'
        +yoms.map(function(y){
            var avg=y.data.cnt?Math.round(y.data.net/y.data.cnt):0;
            return '<tr><td>'+y.name+'</td><td>'+y.data.cnt+'</td><td>'+_mrFmt(y.data.lab)+'</td><td>'+_mrFmt(y.data.parts)+'</td><td>'+_mrFmt(y.data.net)+'</td><td><span class="d-badge d-b-blue">'+_mrFmt(avg)+'</span></td></tr>';
        }).join('')+'</table>';
}
// ===================== END ANALYTICS DASHBOARD =====================

</script>
</head>
<body onload="getBranch();">
<form id="frmMaintenanceReport" method="post">
<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">
<div class="master-container">

    <!-- SIDEBAR -->
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id="fromdate" name="fromdate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" name="todate"></div></td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <div style="display:flex;justify-content:center;gap:20px;padding:5px 0;">
                    <span>
                        <input type="radio" name="radioreporttype" id="rdosummary" onchange="setReportType();">
                        <label class="branch" for="rdosummary">Summary</label>
                    </span>
                    <span>
                        <input type="radio" name="radioreporttype" id="rdodetail" onchange="setReportType();">
                        <label class="branch" for="rdodetail">Detail</label>
                    </span>
                </div>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Vehicle</td>
                        <td>
                            <input type="text" id="txtvehicle" name="txtvehicle" readonly
                                placeholder="Press F3 to Search"
                                value='<s:property value="txtvehicle"/>'
                                ondblclick="vehicleSearchContent('vehicleDetailsGrid.jsp?id=1');"
                                onkeydown="getVehicle(event);"
                                style="font-size:12px;"/>
                            <input type="hidden" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <textarea id="vehinfo" name="vehinfo" rows="8"
                    style="width:100%;font-size:10px;font-family:Tahoma;resize:none;border:none;background:transparent;"
                    readonly><s:property value="vehinfo"/></textarea>
            </div>

            <div style="display:flex;flex-direction:column;gap:8px;padding:5px;">
                <button type="button" class="myButton" onclick="funMaintenancePrint();">Print</button>
                <button type="button" class="myButtons" onclick="funClearInfo();">Clear</button>
            </div>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content-wrapper">

        <!-- View Toggle Bar -->
        <div style="display:flex;align-items:center;gap:8px;padding:9px 14px;background:#fff;border-bottom:1px solid #e1e8ed;flex-wrap:wrap;">
            <button type="button" id="mrBtnGrid" onclick="showMrView('grid')" class="view-btn active">Grid View</button>
            <button type="button" id="mrBtnDash" onclick="showMrView('dash')" class="view-btn">Analytics Dashboard</button>
            <div style="margin-left:auto;display:flex;gap:8px;">
                <button type="button" onclick="funExportBtn()" class="view-btn" style="background:#059669;color:#fff;">Export Excel</button>
                <button type="button" onclick="funreload()" class="view-btn" style="background:#2563eb;color:#fff;">Load / Refresh</button>
            </div>
        </div>

        <div class="scrollable-grid-area">

            <div id="summarygriddiv"><jsp:include page="summaryGrid.jsp"></jsp:include></div>
            <div id="detailgriddiv" hidden="true"><jsp:include page="detailGrid.jsp"></jsp:include></div>

            <!-- Analytics Dashboard -->
            <div id="mrDashboard" style="display:none;height:calc(100vh - 95px);overflow-y:auto;background:#f4f7f9;padding:14px 16px;">

                <div id="mrDashNoData" style="display:none;text-align:center;padding:60px 20px;color:#9a9a9a;">
                    <div style="font-size:32px;margin-bottom:10px;">&#128202;</div>
                    <div style="font-size:15px;font-weight:500;">No Data Loaded</div>
                    <div style="font-size:12px;margin-top:6px;">Select filters, choose <strong>Summary</strong> type, and click <strong>Load / Refresh</strong>, then open Analytics Dashboard.</div>
                </div>

                <div id="mrDashContent">
                    <div class="d-tabs">
                        <div class="d-tab active" id="mrt_ov"   onclick="switchMrTab('ov')">Overview</div>
                        <div class="d-tab" id="mrt_cs"          onclick="switchMrTab('cs')">Cost Split</div>
                        <div class="d-tab" id="mrt_top"         onclick="switchMrTab('top')">Top Vehicles</div>
                        <div class="d-tab" id="mrt_grp"         onclick="switchMrTab('grp')">By Group</div>
                        <div class="d-tab" id="mrt_yom"         onclick="switchMrTab('yom')">By YOM</div>
                    </div>

                    <!-- OVERVIEW -->
                    <div id="mrp_ov" class="d-panel active">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="mr_ov_fleet"><div class="d-metric-label">Total Vehicles</div><div class="d-metric-val">-</div><div class="d-metric-sub">vehicles</div></div>
                            <div class="d-metric" id="mr_ov_lab"><div class="d-metric-label">Total Labour</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_ov_parts"><div class="d-metric-label">Total Parts</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_ov_net"><div class="d-metric-label">Total Cost</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_ov_avg"><div class="d-metric-label">Avg / Vehicle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_ov_top"><div class="d-metric-label">Highest Cost</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box">
                                <div class="d-chart-title">Labour vs Parts cost split</div>
                                <div class="d-legend">
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Labour</span>
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#EF9F27"></span>Parts</span>
                                </div>
                                <div style="position:relative;width:100%;height:220px"><canvas id="mr_ch_ov_donut"></canvas></div>
                            </div>
                            <div class="d-chart-box">
                                <div class="d-chart-title">Top 15 vehicles by maintenance cost</div>
                                <div style="position:relative;width:100%;height:220px"><canvas id="mr_ch_ov_top"></canvas></div>
                            </div>
                        </div>
                    </div>

                    <!-- COST SPLIT -->
                    <div id="mrp_cs" class="d-panel">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="mr_cs_labpct"><div class="d-metric-label">Labour %</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_cs_partspct"><div class="d-metric-label">Parts %</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_cs_highlab"><div class="d-metric-label">Highest Labour</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_cs_ratio"><div class="d-metric-label">Labour:Parts</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-box" style="margin-bottom:16px">
                            <div class="d-chart-title">Labour vs Parts — top 15 by total cost</div>
                            <div class="d-legend">
                                <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Labour</span>
                                <span class="d-leg-item"><span class="d-leg-sq" style="background:#EF9F27"></span>Parts</span>
                            </div>
                            <div style="position:relative;width:100%;height:300px"><canvas id="mr_ch_cs_stacked"></canvas></div>
                        </div>
                        <div class="d-chart-box" style="margin-bottom:16px">
                            <div class="d-chart-title">Cost distribution (10-bucket histogram)</div>
                            <div style="position:relative;width:100%;height:200px"><canvas id="mr_ch_cs_hist"></canvas></div>
                        </div>
                    </div>

                    <!-- TOP VEHICLES -->
                    <div id="mrp_top" class="d-panel">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="mr_top_net"><div class="d-metric-label">Highest Total Cost</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_top_lab"><div class="d-metric-label">Highest Labour</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_top_cnt"><div class="d-metric-label">Vehicles</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_top_avg"><div class="d-metric-label">Avg Cost</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box">
                                <div class="d-chart-title">Top 15 by total maintenance cost</div>
                                <div style="position:relative;width:100%;height:340px"><canvas id="mr_ch_top_net"></canvas></div>
                            </div>
                            <div class="d-chart-box">
                                <div class="d-chart-title">Top 15 by labour cost</div>
                                <div style="position:relative;width:100%;height:340px"><canvas id="mr_ch_top_lab"></canvas></div>
                            </div>
                        </div>
                    </div>

                    <!-- BY GROUP -->
                    <div id="mrp_grp" class="d-panel">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="mr_grp_count"><div class="d-metric-label">Groups</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_grp_top"><div class="d-metric-label">Highest Cost Group</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_grp_veh"><div class="d-metric-label">Vehicles</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_grp_avg"><div class="d-metric-label">Avg Cost</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-box" style="margin-bottom:16px">
                            <div class="d-chart-title">Labour vs Parts cost by group</div>
                            <div class="d-legend">
                                <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Labour</span>
                                <span class="d-leg-item"><span class="d-leg-sq" style="background:#EF9F27"></span>Parts</span>
                            </div>
                            <div style="position:relative;width:100%;height:280px"><canvas id="mr_ch_grp_bar"></canvas></div>
                        </div>
                        <div class="d-table-box">
                            <div class="d-chart-title" style="margin-bottom:10px">Group cost summary</div>
                            <div id="mr_grp_table"></div>
                        </div>
                    </div>

                    <!-- BY YOM -->
                    <div id="mrp_yom" class="d-panel">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="mr_yom_count"><div class="d-metric-label">YOM Groups</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_yom_top"><div class="d-metric-label">Highest Cost YOM</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_yom_veh"><div class="d-metric-label">Vehicles</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="mr_yom_avg"><div class="d-metric-label">Avg Cost</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-box" style="margin-bottom:16px">
                            <div class="d-chart-title">Average maintenance cost per vehicle by YOM</div>
                            <div style="position:relative;width:100%;height:280px"><canvas id="mr_ch_yom_bar"></canvas></div>
                        </div>
                        <div class="d-table-box">
                            <div class="d-chart-title" style="margin-bottom:10px">YOM cost summary</div>
                            <div id="mr_yom_table"></div>
                        </div>
                    </div>

                </div><!-- mrDashContent -->
            </div><!-- mrDashboard -->

            <input type="hidden" name="hidreporttype" id="hidreporttype">
            <input type="hidden" id="txtvehdocno" name="txtvehdocno" value='<s:property value="txtvehdocno"/>'/>

        </div><!-- scrollable-grid-area -->
    </div><!-- main-content-wrapper -->

</div><!-- master-container -->
</div>
</div>

<div id="vehicleDetailsWindow"><div></div><div></div></div>
<div id="inspectionWindow"><div></div></div>
</form>
</body>
</html>
