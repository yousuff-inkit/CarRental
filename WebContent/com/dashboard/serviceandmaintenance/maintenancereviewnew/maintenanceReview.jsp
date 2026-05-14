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
    $("#branchlabel").hide();
    $("#branchdiv").hide();
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index:1;display:none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display:none;position:absolute;z-index:1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#fromdate").jqxDateTimeInput({ width:'125px', height:'15px', formatString:"dd.MM.yyyy" });
    $("#todate").jqxDateTimeInput({ width:'125px', height:'15px', formatString:"dd.MM.yyyy" });
    $('#vehicleDetailsWindow').jqxWindow({ width:'51%', height:'58%', maxHeight:'70%', maxWidth:'51%', title:'Vehicle Search', position:{x:300,y:87}, theme:'energyblue', showCloseButton:true, keyboardCloseKey:27 });
    $('#vehicleDetailsWindow').jqxWindow('close');
    $('#inspectionWindow').jqxWindow({ autoOpen:false, width:'78%', height:'85%', maxHeight:'85%', maxWidth:'78%', title:'Inspection Details', theme:'energyblue', position:{x:280,y:10}, keyboardCloseKey:27, showCloseButton:true, closeButtonAction:'hide' });
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthback=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthback);
    $('#txtvehicle').dblclick(function(){ vehicleSearchContent('vehicleDetailsGrid.jsp'); });
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
    if(event.keyCode==114) vehicleSearchContent('vehicleDetailsGrid.jsp');
}
function funSearchdblclick(){}

function funreload(){
    var branchval = 1;
    var type = $('#cmbtype').val();
    var fleetno = $('#txtfleetno').val();
    var fromdate = $('#fromdate').val();
    var todate = $('#todate').val();
    if(type==''){
        $.messager.alert('Message','Please Choose a Review Type.','warning');
        return;
    }
    _mrData = null;
    $("#overlay, #PleaseWait").show();
    if(type=='1'){
        $("#serviceHistoryDiv").prop("hidden", true);
        $("#accidentHistoryDiv").prop("hidden", false);
        $("#accidentHistoryDiv").load("accidentHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1', function(){
            if(document.getElementById('mrDashboard').style.display!=='none'){
                setTimeout(buildMrDashboard, 100);
            }
        });
    } else {
        $("#accidentHistoryDiv").prop("hidden", true);
        $("#serviceHistoryDiv").prop("hidden", false);
        $("#serviceHistoryDiv").load("serviceHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1', function(){
            if(document.getElementById('mrDashboard').style.display!=='none'){
                setTimeout(buildMrDashboard, 100);
            }
        });
    }
}

function funClearInfo(){
    $('#fromdate').val(new Date());
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthback=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthback);
    $('#todate').val(new Date());
    $("#cmbtype").val(''); $("#txtvehicle").val(''); $("#txtfleetno").val(''); $("#txtvehdocno").val('');
    try{ $("#accidentHistory").jqxGrid('clear'); }catch(e){}
    try{ $("#serviceHistory").jqxGrid('clear'); }catch(e){}
    if(document.getElementById('txtvehicle').value=='')
        $('#txtvehicle').attr('placeholder','Press F3 to Search');
    document.getElementById('vehinfo').value='';
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
    var win=window.open(reurl[0]+"printMaintenanceReviewNew?&fleetno="+fleetno+'&branch='+document.getElementById('cmbbranch').value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}

function funExportBtn(){
    var type=$('#cmbtype').val();
    if(parseInt(window.parent.chkexportdata.value)=="1"){
        if(type=='1') JSONToCSVCon(data2,'AccidentHistory',true);
        if(type=='2') JSONToCSVCon(data1,'ServiceHistory',true);
    } else {
        if(type=='1') $("#accidentHistory").jqxGrid('exportdata','xls','AccidentHistory');
        if(type=='2') $("#serviceHistory").jqxGrid('exportdata','xls','ServiceHistory');
    }
}

// ===================== VIEW TOGGLE =====================
function showMrView(view){
    var type=$('#cmbtype').val();
    var ad=document.getElementById('accidentHistoryDiv');
    var sd=document.getElementById('serviceHistoryDiv');
    var d =document.getElementById('mrDashboard');
    var bg=document.getElementById('mrBtnGrid');
    var bd=document.getElementById('mrBtnDash');
    if(view==='grid'){
        if(type=='1'){ad.hidden=false;sd.hidden=true;}
        else{sd.hidden=false;ad.hidden=true;}
        d.style.display='none';
        bg.classList.add('active'); bd.classList.remove('active');
    } else {
        if(type===''){
            $.messager.alert('Info','Please select a Review Type first, then load data.','info');
            return;
        }
        ad.hidden=true; sd.hidden=true;
        d.style.display='';
        bg.classList.remove('active'); bd.classList.add('active');
        setTimeout(buildMrDashboard, 60);
    }
}

function switchMrTab(tab){
    document.querySelectorAll('#mrDashServiceContent .d-tab').forEach(function(b){b.classList.remove('active');});
    document.querySelectorAll('#mrDashServiceContent .d-panel').forEach(function(p){p.classList.remove('active');});
    document.getElementById('mrt_'+tab).classList.add('active');
    document.getElementById('mrp_'+tab).classList.add('active');
}

function switchMrAccTab(tab){
    document.querySelectorAll('#mrDashAccidentContent .d-tab').forEach(function(b){b.classList.remove('active');});
    document.querySelectorAll('#mrDashAccidentContent .d-panel').forEach(function(p){p.classList.remove('active');});
    document.getElementById('mra_'+tab).classList.add('active');
    document.getElementById('mrap_'+tab).classList.add('active');
}

// ===================== ANALYTICS DASHBOARD =====================
var _mrc={}, _mrData=null;
var _MRC={T:'#1D9E75',B:'#185FA5',B2:'#378ADD',A:'#EF9F27',C:'#D85A30',R:'#E24B4A',G:'#888780',P:'#7F77DD'};
var _MGC='rgba(128,128,128,0.1)';

function _mrcD(){ Object.keys(_mrc).forEach(function(k){if(_mrc[k]){_mrc[k].destroy();delete _mrc[k];}}); }
function _mrFmt(v){ return v>=1e6?(v/1e6).toFixed(1)+'M':v>=1e3?Math.round(v/1e3)+'K':String(Math.round(v)); }
function _mrFld(r,f){ return parseFloat(r[f])||0; }
function _mrSetKpi(id,val,sub){
    var el=document.getElementById(id); if(!el)return;
    var ve=el.querySelector('.d-metric-val'), se=el.querySelector('.d-metric-sub');
    if(ve) ve.textContent=(val!=null)?val:'-';
    if(se) se.textContent=sub||'';
}

function buildMrDashboard(){
    var type=$('#cmbtype').val();
    var rows=[];
    var noEl=document.getElementById('mrDashNoData');
    var conEl=document.getElementById('mrDashContent');
    var svcDiv=document.getElementById('mrDashServiceContent');
    var accDiv=document.getElementById('mrDashAccidentContent');
    if(type=='1'){
        try{ var g=$('#accidentHistory').jqxGrid('getrows'); if(g&&g.length>0) rows=g; }catch(e){}
        if(!rows.length){ noEl.style.display=''; conEl.style.display='none'; return; }
        noEl.style.display='none'; conEl.style.display='';
        svcDiv.style.display='none'; accDiv.style.display='';
        _mrData=rows; _mrcD();
        _mrRenderAccOverview(rows);
        _mrRenderAccByVehicle(rows);
        _mrRenderAccByPlace(rows);
        _mrRenderAccClaims(rows);
    } else {
        try{ var g=$('#serviceHistory').jqxGrid('getrows'); if(g&&g.length>0) rows=g; }catch(e){}
        if(!rows.length){ noEl.style.display=''; conEl.style.display='none'; return; }
        noEl.style.display='none'; conEl.style.display='';
        svcDiv.style.display=''; accDiv.style.display='none';
        _mrData=rows; _mrcD();
        _mrRenderOverview(rows);
        _mrRenderByGarage(rows);
        _mrRenderByType(rows);
        _mrRenderByVehicle(rows);
    }
}

function _mrRenderOverview(rows){
    var totLab=0, totParts=0, totNet=0;
    rows.forEach(function(r){ totLab+=_mrFld(r,'lbrcost'); totParts+=_mrFld(r,'partscost'); totNet+=_mrFld(r,'total'); });
    var avgNet=rows.length?Math.round(totNet/rows.length):0;
    var garageMap={};
    rows.forEach(function(r){ var g=r.garage||'Unknown'; if(!garageMap[g])garageMap[g]=0; garageMap[g]+=_mrFld(r,'total'); });
    var topGarage=Object.keys(garageMap).sort(function(a,b){return garageMap[b]-garageMap[a];})[0];
    _mrSetKpi('mr_ov_records',rows.length,'service records');
    _mrSetKpi('mr_ov_lab',_mrFmt(totLab),'total labour cost');
    _mrSetKpi('mr_ov_parts',_mrFmt(totParts),'total parts cost');
    _mrSetKpi('mr_ov_net',_mrFmt(totNet),'total service cost');
    _mrSetKpi('mr_ov_avg',_mrFmt(avgNet),'avg cost / record');
    _mrSetKpi('mr_ov_garage',topGarage||'-',topGarage?'Cost: '+_mrFmt(garageMap[topGarage]):'top garage');

    if(_mrc.ov1)_mrc.ov1.destroy();
    _mrc.ov1=new Chart(document.getElementById('mr_ch_ov_donut').getContext('2d'),{
        type:'doughnut',
        data:{labels:['Labour','Parts'],datasets:[{data:[totLab,totParts],backgroundColor:[_MRC.B,_MRC.A],borderWidth:0,hoverOffset:4}]},
        options:{responsive:true,maintainAspectRatio:false,cutout:'58%',plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.label+': '+_mrFmt(b.raw);}}}}}
    });
    var top=rows.slice().sort(function(a,b){return _mrFld(b,'total')-_mrFld(a,'total');}).slice(0,15);
    if(_mrc.ov2)_mrc.ov2.destroy();
    _mrc.ov2=new Chart(document.getElementById('mr_ch_ov_top').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:top.map(function(r){return (r.reg_no||r.fleet_no||'')+'';}) ,datasets:[{data:top.map(function(r){return _mrFld(r,'total');}),backgroundColor:_MRC.B,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Cost: '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}},y:{ticks:{font:{size:11}}}}}
    });
}

function _mrRenderByGarage(rows){
    var gMap={};
    rows.forEach(function(r){
        var g=r.garage||'Unknown';
        if(!gMap[g]) gMap[g]={lab:0,parts:0,net:0,cnt:0};
        gMap[g].lab+=_mrFld(r,'lbrcost'); gMap[g].parts+=_mrFld(r,'partscost');
        gMap[g].net+=_mrFld(r,'total'); gMap[g].cnt++;
    });
    var garages=Object.keys(gMap).map(function(k){return {name:k,data:gMap[k]};}).sort(function(a,b){return b.data.net-a.data.net;});
    var top=garages[0];
    _mrSetKpi('mr_grg_count',garages.length,'garages');
    _mrSetKpi('mr_grg_top',top?top.name:'-',top?'Cost: '+_mrFmt(top.data.net):'');
    _mrSetKpi('mr_grg_visits',top?top.data.cnt:'-',top?'visits to top garage':'');
    _mrSetKpi('mr_grg_avg',top&&top.data.cnt?_mrFmt(Math.round(top.data.net/top.data.cnt)):'-','avg per visit');

    if(_mrc.gp1)_mrc.gp1.destroy();
    _mrc.gp1=new Chart(document.getElementById('mr_ch_grg_bar').getContext('2d'),{
        type:'bar',
        data:{labels:garages.map(function(g){return g.name;}),datasets:[
            {label:'Labour',data:garages.map(function(g){return g.data.lab;}),backgroundColor:_MRC.B,borderRadius:4},
            {label:'Parts', data:garages.map(function(g){return g.data.parts;}),backgroundColor:_MRC.A,borderRadius:4}
        ]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{font:{size:10},maxRotation:30,autoSkip:false}},y:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}}}}
    });
    document.getElementById('mr_grg_table').innerHTML='<table><tr><th>Garage</th><th>Visits</th><th>Labour</th><th>Parts</th><th>Total</th><th>Avg / Visit</th></tr>'
        +garages.map(function(g){
            return '<tr><td>'+g.name+'</td><td>'+g.data.cnt+'</td><td>'+_mrFmt(g.data.lab)+'</td><td>'+_mrFmt(g.data.parts)+'</td><td><span class="d-badge d-b-amber">'+_mrFmt(g.data.net)+'</span></td><td>'+_mrFmt(Math.round(g.data.net/g.data.cnt))+'</td></tr>';
        }).join('')+'</table>';
}

function _mrRenderByType(rows){
    var tMap={};
    rows.forEach(function(r){
        var t=r.mtype||r.type||'Unknown';
        if(!tMap[t]) tMap[t]={lab:0,parts:0,net:0,cnt:0};
        tMap[t].lab+=_mrFld(r,'lbrcost'); tMap[t].parts+=_mrFld(r,'partscost');
        tMap[t].net+=_mrFld(r,'total'); tMap[t].cnt++;
    });
    var types=Object.keys(tMap).map(function(k){return {name:k,data:tMap[k]};}).sort(function(a,b){return b.data.net-a.data.net;});
    var top=types[0];
    _mrSetKpi('mr_typ_count',types.length,'maintenance types');
    _mrSetKpi('mr_typ_top',top?top.name:'-',top?'Cost: '+_mrFmt(top.data.net):'');
    _mrSetKpi('mr_typ_records',top?top.data.cnt:'-',top?'records of top type':'');
    _mrSetKpi('mr_typ_avg',top&&top.data.cnt?_mrFmt(Math.round(top.data.net/top.data.cnt)):'-','avg cost');

    if(_mrc.tp1)_mrc.tp1.destroy();
    _mrc.tp1=new Chart(document.getElementById('mr_ch_typ_bar').getContext('2d'),{
        type:'bar',
        data:{labels:types.map(function(t){return t.name;}),datasets:[
            {label:'Labour',data:types.map(function(t){return t.data.lab;}),backgroundColor:_MRC.B,borderRadius:4},
            {label:'Parts', data:types.map(function(t){return t.data.parts;}),backgroundColor:_MRC.A,borderRadius:4}
        ]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{font:{size:11}}},y:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}}}}
    });
    if(_mrc.tp2)_mrc.tp2.destroy();
    _mrc.tp2=new Chart(document.getElementById('mr_ch_typ_donut').getContext('2d'),{
        type:'doughnut',
        data:{labels:types.map(function(t){return t.name+' ('+t.data.cnt+')';}),
              datasets:[{data:types.map(function(t){return t.data.net;}),
                backgroundColor:[_MRC.B,_MRC.A,_MRC.T,_MRC.C,_MRC.R,_MRC.G,_MRC.P],borderWidth:0,hoverOffset:4}]},
        options:{responsive:true,maintainAspectRatio:false,cutout:'55%',plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.label+': '+_mrFmt(b.raw);}}}}}
    });
}

function _mrRenderByVehicle(rows){
    var vMap={};
    rows.forEach(function(r){
        var k=(r.reg_no||r.fleet_no||'Unknown')+'';
        if(!vMap[k]) vMap[k]={lab:0,parts:0,net:0,cnt:0};
        vMap[k].lab+=_mrFld(r,'lbrcost'); vMap[k].parts+=_mrFld(r,'partscost');
        vMap[k].net+=_mrFld(r,'total'); vMap[k].cnt++;
    });
    var vehs=Object.keys(vMap).map(function(k){return {name:k,data:vMap[k]};}).sort(function(a,b){return b.data.net-a.data.net;});
    var top=vehs[0];
    _mrSetKpi('mr_veh_count',vehs.length,'vehicles');
    _mrSetKpi('mr_veh_top',top?top.name:'-',top?'Cost: '+_mrFmt(top.data.net):'');
    _mrSetKpi('mr_veh_visits',top?top.data.cnt:'-',top?'service visits':'');
    _mrSetKpi('mr_veh_avg',_mrFmt(vehs.length?Math.round(vehs.reduce(function(s,v){return s+v.data.net;},0)/vehs.length):0),'avg cost / vehicle');

    var t15=vehs.slice(0,15);
    if(_mrc.vh1)_mrc.vh1.destroy();
    _mrc.vh1=new Chart(document.getElementById('mr_ch_veh_bar').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15.map(function(v){return v.name;}),datasets:[
            {label:'Labour',data:t15.map(function(v){return v.data.lab;}),backgroundColor:_MRC.B,borderRadius:4},
            {label:'Parts', data:t15.map(function(v){return v.data.parts;}),backgroundColor:_MRC.A,borderRadius:4}
        ]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_mrFmt(b.raw);}}}},
            scales:{x:{stacked:false,ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}},y:{ticks:{font:{size:11}}}}}
    });
    document.getElementById('mr_veh_table').innerHTML='<table><tr><th>Vehicle</th><th>Visits</th><th>Labour</th><th>Parts</th><th>Total</th><th>Avg / Visit</th></tr>'
        +vehs.map(function(v){
            return '<tr><td>'+v.name+'</td><td>'+v.data.cnt+'</td><td>'+_mrFmt(v.data.lab)+'</td><td>'+_mrFmt(v.data.parts)+'</td><td><span class="d-badge d-b-blue">'+_mrFmt(v.data.net)+'</span></td><td>'+_mrFmt(Math.round(v.data.net/v.data.cnt))+'</td></tr>';
        }).join('')+'</table>';
}
// ===================== ACCIDENT DASHBOARD FUNCTIONS =====================
function _mrRenderAccOverview(rows){
    var totFine=0,ownCnt=0,tpCnt=0;
    var vMap={},pMap={};
    rows.forEach(function(r){
        totFine+=parseFloat(r.fine)||0;
        var cl=(r.claim||'').toLowerCase();
        if(cl.indexOf('own')>=0) ownCnt++; else tpCnt++;
        var v=(r.reg_no||r.fleet_no||'Unknown')+'';
        vMap[v]=(vMap[v]||0)+1;
        var p=r.place||'Unknown';
        pMap[p]=(pMap[p]||0)+1;
    });
    var topV=Object.keys(vMap).sort(function(a,b){return vMap[b]-vMap[a];})[0];
    var topP=Object.keys(pMap).sort(function(a,b){return pMap[b]-pMap[a];})[0];
    _mrSetKpi('mra_ov_records',rows.length,'total accidents');
    _mrSetKpi('mra_ov_fine',_mrFmt(totFine),'total fines');
    _mrSetKpi('mra_ov_own',ownCnt,'own claim accidents');
    _mrSetKpi('mra_ov_tp',tpCnt,'third party accidents');
    _mrSetKpi('mra_ov_veh',topV||'-',topV?vMap[topV]+' accidents':'most affected vehicle');
    _mrSetKpi('mra_ov_place',topP||'-',topP?pMap[topP]+' accidents':'most common place');
    if(_mrc.aov1)_mrc.aov1.destroy();
    _mrc.aov1=new Chart(document.getElementById('mra_ch_ov_donut').getContext('2d'),{
        type:'doughnut',
        data:{labels:['Own','Third Party'],datasets:[{data:[ownCnt,tpCnt],backgroundColor:[_MRC.B,_MRC.C],borderWidth:0,hoverOffset:4}]},
        options:{responsive:true,maintainAspectRatio:false,cutout:'58%',plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.label+': '+b.raw+' accidents';}}}}}
    });
    var vFines={};
    rows.forEach(function(r){var v=(r.reg_no||r.fleet_no||'Unknown')+''; vFines[v]=(vFines[v]||0)+(parseFloat(r.fine)||0);});
    var t15=Object.keys(vFines).map(function(k){return {name:k,fine:vFines[k]};}).sort(function(a,b){return b.fine-a.fine;}).slice(0,15);
    if(_mrc.aov2)_mrc.aov2.destroy();
    _mrc.aov2=new Chart(document.getElementById('mra_ch_ov_top').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15.map(function(v){return v.name;}),datasets:[{data:t15.map(function(v){return v.fine;}),backgroundColor:_MRC.C,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Fine: '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}},y:{ticks:{font:{size:11}}}}}
    });
}

function _mrRenderAccByVehicle(rows){
    var vMap={};
    rows.forEach(function(r){
        var k=(r.reg_no||r.fleet_no||'Unknown')+'';
        if(!vMap[k]) vMap[k]={cnt:0,fine:0};
        vMap[k].cnt++; vMap[k].fine+=parseFloat(r.fine)||0;
    });
    var vehs=Object.keys(vMap).map(function(k){return {name:k,data:vMap[k]};}).sort(function(a,b){return b.data.cnt-a.data.cnt;});
    var top=vehs[0];
    _mrSetKpi('mra_veh_count',vehs.length,'vehicles involved');
    _mrSetKpi('mra_veh_top',top?top.name:'-',top?top.data.cnt+' accidents':'');
    _mrSetKpi('mra_veh_fine',top?_mrFmt(top.data.fine):'-',top?'fines on top vehicle':'');
    _mrSetKpi('mra_veh_avg',_mrFmt(vehs.length?Math.round(vehs.reduce(function(s,v){return s+v.data.fine;},0)/vehs.length):0),'avg fine / vehicle');
    var t15c=vehs.slice(0,15);
    if(_mrc.avh1)_mrc.avh1.destroy();
    _mrc.avh1=new Chart(document.getElementById('mra_ch_veh_cnt').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15c.map(function(v){return v.name;}),datasets:[{data:t15c.map(function(v){return v.data.cnt;}),backgroundColor:_MRC.B,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Accidents: '+b.raw;}}}},
            scales:{x:{ticks:{stepSize:1},grid:{color:_MGC}},y:{ticks:{font:{size:11}}}}}
    });
    var t15f=vehs.slice().sort(function(a,b){return b.data.fine-a.data.fine;}).slice(0,15);
    if(_mrc.avh2)_mrc.avh2.destroy();
    _mrc.avh2=new Chart(document.getElementById('mra_ch_veh_fine').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15f.map(function(v){return v.name;}),datasets:[{data:t15f.map(function(v){return v.data.fine;}),backgroundColor:_MRC.C,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Fine: '+_mrFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}},y:{ticks:{font:{size:11}}}}}
    });
}

function _mrRenderAccByPlace(rows){
    var pMap={};
    rows.forEach(function(r){
        var p=r.place||'Unknown';
        if(!pMap[p]) pMap[p]={cnt:0,fine:0};
        pMap[p].cnt++; pMap[p].fine+=parseFloat(r.fine)||0;
    });
    var places=Object.keys(pMap).map(function(k){return {name:k,data:pMap[k]};}).sort(function(a,b){return b.data.cnt-a.data.cnt;});
    var top=places[0];
    _mrSetKpi('mra_plc_count',places.length,'locations');
    _mrSetKpi('mra_plc_top',top?top.name:'-',top?top.data.cnt+' accidents':'');
    if(_mrc.apl1)_mrc.apl1.destroy();
    _mrc.apl1=new Chart(document.getElementById('mra_ch_plc_bar').getContext('2d'),{
        type:'bar',
        data:{labels:places.map(function(p){return p.name;}),datasets:[{data:places.map(function(p){return p.data.cnt;}),backgroundColor:_MRC.P,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Accidents: '+b.raw;}}}},
            scales:{x:{ticks:{font:{size:10},maxRotation:30,autoSkip:false}},y:{ticks:{stepSize:1},grid:{color:_MGC}}}}
    });
    document.getElementById('mra_plc_table').innerHTML='<table><tr><th>Place</th><th>Accidents</th><th>Total Fine</th><th>Avg Fine</th></tr>'
        +places.map(function(p){return '<tr><td>'+p.name+'</td><td>'+p.data.cnt+'</td><td>'+_mrFmt(p.data.fine)+'</td><td>'+_mrFmt(p.data.cnt?Math.round(p.data.fine/p.data.cnt):0)+'</td></tr>';}).join('')+'</table>';
}

function _mrRenderAccClaims(rows){
    var ownCnt=0,tpCnt=0,ownFine=0,tpFine=0;
    rows.forEach(function(r){
        var cl=(r.claim||'').toLowerCase();
        var fine=parseFloat(r.fine)||0;
        if(cl.indexOf('own')>=0){ownCnt++;ownFine+=fine;}else{tpCnt++;tpFine+=fine;}
    });
    _mrSetKpi('mra_clm_own_cnt',ownCnt,'own claim accidents');
    _mrSetKpi('mra_clm_tp_cnt',tpCnt,'third party accidents');
    _mrSetKpi('mra_clm_own_fine',_mrFmt(ownFine),'own claim total fines');
    _mrSetKpi('mra_clm_tp_fine',_mrFmt(tpFine),'third party total fines');
    if(_mrc.acl1)_mrc.acl1.destroy();
    _mrc.acl1=new Chart(document.getElementById('mra_ch_clm_donut').getContext('2d'),{
        type:'doughnut',
        data:{labels:['Own ('+ownCnt+')','Third Party ('+tpCnt+')'],datasets:[{data:[ownCnt,tpCnt],backgroundColor:[_MRC.B,_MRC.C],borderWidth:0,hoverOffset:4}]},
        options:{responsive:true,maintainAspectRatio:false,cutout:'58%',plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.label+': '+b.raw+' cases';}}}}}
    });
    if(_mrc.acl2)_mrc.acl2.destroy();
    _mrc.acl2=new Chart(document.getElementById('mra_ch_clm_bar').getContext('2d'),{
        type:'bar',
        data:{labels:['Own','Third Party'],datasets:[{data:[ownFine,tpFine],backgroundColor:[_MRC.B,_MRC.C],borderRadius:6}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Fine: '+_mrFmt(b.raw);}}}},
            scales:{y:{ticks:{callback:function(v){return _mrFmt(v);}},grid:{color:_MGC}}}}
    });
}
// ===================== END ANALYTICS DASHBOARD =====================

</script>
</head>
<body onload="getBranch();">
<form id="frmMaintenanceReview" method="post">
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
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Review</td>
                        <td>
                            <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Accident History</option>
                                <option value="2">Service History</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Vehicle</td>
                        <td>
                            <input type="text" id="txtvehicle" name="txtvehicle" readonly
                                placeholder="Press F3 to Search"
                                value='<s:property value="txtvehicle"/>'
                                ondblclick="vehicleSearchContent('vehicleDetailsGrid.jsp');"
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

            <input type="hidden" id="hidbrhid" name="hidbrhid"/>
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

            <div id="accidentHistoryDiv"><jsp:include page="accidentHistoryGrid.jsp"></jsp:include></div>
            <div id="serviceHistoryDiv" hidden="true"><jsp:include page="serviceHistoryGrid.jsp"></jsp:include></div>

            <!-- Analytics Dashboard -->
            <div id="mrDashboard" style="display:none;height:calc(100vh - 95px);overflow-y:auto;background:#f4f7f9;padding:14px 16px;">

                <div id="mrDashNoData" style="display:none;text-align:center;padding:60px 20px;color:#9a9a9a;">
                    <div style="font-size:32px;margin-bottom:10px;">&#128202;</div>
                    <div style="font-size:15px;font-weight:500;">No Data Loaded</div>
                    <div style="font-size:12px;margin-top:6px;">Select a Review Type, apply filters and click <strong>Load / Refresh</strong>, then open Analytics Dashboard.</div>
                </div>

                <div id="mrDashContent">

                    <!-- ===== SERVICE HISTORY DASHBOARD ===== -->
                    <div id="mrDashServiceContent">
                        <div class="d-tabs">
                            <div class="d-tab active" id="mrt_ov"  onclick="switchMrTab('ov')">Overview</div>
                            <div class="d-tab" id="mrt_grg"        onclick="switchMrTab('grg')">By Garage</div>
                            <div class="d-tab" id="mrt_typ"        onclick="switchMrTab('typ')">By Type</div>
                            <div class="d-tab" id="mrt_veh"        onclick="switchMrTab('veh')">By Vehicle</div>
                        </div>

                        <!-- OVERVIEW -->
                        <div id="mrp_ov" class="d-panel active">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="mr_ov_records"><div class="d-metric-label">Service Records</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_ov_lab"><div class="d-metric-label">Total Labour</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_ov_parts"><div class="d-metric-label">Total Parts</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_ov_net"><div class="d-metric-label">Total Cost</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_ov_avg"><div class="d-metric-label">Avg / Record</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_ov_garage"><div class="d-metric-label">Top Garage</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
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
                                    <div class="d-chart-title">Top 15 service records by cost</div>
                                    <div style="position:relative;width:100%;height:220px"><canvas id="mr_ch_ov_top"></canvas></div>
                                </div>
                            </div>
                        </div>

                        <!-- BY GARAGE -->
                        <div id="mrp_grg" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="mr_grg_count"><div class="d-metric-label">Garages</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_grg_top"><div class="d-metric-label">Top Garage</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_grg_visits"><div class="d-metric-label">Visits</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_grg_avg"><div class="d-metric-label">Avg / Visit</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-box" style="margin-bottom:16px">
                                <div class="d-chart-title">Labour vs Parts cost by garage</div>
                                <div class="d-legend">
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Labour</span>
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#EF9F27"></span>Parts</span>
                                </div>
                                <div style="position:relative;width:100%;height:280px"><canvas id="mr_ch_grg_bar"></canvas></div>
                            </div>
                            <div class="d-table-box">
                                <div class="d-chart-title" style="margin-bottom:10px">Garage cost summary</div>
                                <div id="mr_grg_table"></div>
                            </div>
                        </div>

                        <!-- BY TYPE -->
                        <div id="mrp_typ" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="mr_typ_count"><div class="d-metric-label">Types</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_typ_top"><div class="d-metric-label">Highest Cost Type</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_typ_records"><div class="d-metric-label">Records</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_typ_avg"><div class="d-metric-label">Avg Cost</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-row">
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Cost by maintenance type</div>
                                    <div class="d-legend">
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Labour</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#EF9F27"></span>Parts</span>
                                    </div>
                                    <div style="position:relative;width:100%;height:280px"><canvas id="mr_ch_typ_bar"></canvas></div>
                                </div>
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Cost share by type</div>
                                    <div style="position:relative;width:100%;height:280px"><canvas id="mr_ch_typ_donut"></canvas></div>
                                </div>
                            </div>
                        </div>

                        <!-- BY VEHICLE -->
                        <div id="mrp_veh" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="mr_veh_count"><div class="d-metric-label">Vehicles</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_veh_top"><div class="d-metric-label">Highest Cost Vehicle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_veh_visits"><div class="d-metric-label">Service Visits</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mr_veh_avg"><div class="d-metric-label">Avg Cost / Vehicle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-box" style="margin-bottom:16px">
                                <div class="d-chart-title">Labour vs Parts — top 15 vehicles by service cost</div>
                                <div class="d-legend">
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Labour</span>
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#EF9F27"></span>Parts</span>
                                </div>
                                <div style="position:relative;width:100%;height:340px"><canvas id="mr_ch_veh_bar"></canvas></div>
                            </div>
                            <div class="d-table-box">
                                <div class="d-chart-title" style="margin-bottom:10px">All vehicles — service cost summary</div>
                                <div id="mr_veh_table"></div>
                            </div>
                        </div>
                    </div><!-- mrDashServiceContent -->

                    <!-- ===== ACCIDENT HISTORY DASHBOARD ===== -->
                    <div id="mrDashAccidentContent" style="display:none;">
                        <div class="d-tabs">
                            <div class="d-tab active" id="mra_ov"  onclick="switchMrAccTab('ov')">Overview</div>
                            <div class="d-tab" id="mra_veh"        onclick="switchMrAccTab('veh')">By Vehicle</div>
                            <div class="d-tab" id="mra_plc"        onclick="switchMrAccTab('plc')">By Place</div>
                            <div class="d-tab" id="mra_clm"        onclick="switchMrAccTab('clm')">Claims</div>
                        </div>

                        <!-- ACC OVERVIEW -->
                        <div id="mrap_ov" class="d-panel active">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="mra_ov_records"><div class="d-metric-label">Total Accidents</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_ov_fine"><div class="d-metric-label">Total Fines</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_ov_own"><div class="d-metric-label">Own Claims</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_ov_tp"><div class="d-metric-label">Third Party</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_ov_veh"><div class="d-metric-label">Most Affected Vehicle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_ov_place"><div class="d-metric-label">Most Common Place</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-row">
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Own vs Third Party claims</div>
                                    <div class="d-legend">
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Own</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#D85A30"></span>Third Party</span>
                                    </div>
                                    <div style="position:relative;width:100%;height:220px"><canvas id="mra_ch_ov_donut"></canvas></div>
                                </div>
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Top 15 vehicles by fine amount</div>
                                    <div style="position:relative;width:100%;height:220px"><canvas id="mra_ch_ov_top"></canvas></div>
                                </div>
                            </div>
                        </div>

                        <!-- ACC BY VEHICLE -->
                        <div id="mrap_veh" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="mra_veh_count"><div class="d-metric-label">Vehicles Involved</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_veh_top"><div class="d-metric-label">Most Accidents</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_veh_fine"><div class="d-metric-label">Top Fine</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_veh_avg"><div class="d-metric-label">Avg Fine / Vehicle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-row">
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Top 15 vehicles by accident count</div>
                                    <div style="position:relative;width:100%;height:300px"><canvas id="mra_ch_veh_cnt"></canvas></div>
                                </div>
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Top 15 vehicles by fine amount</div>
                                    <div style="position:relative;width:100%;height:300px"><canvas id="mra_ch_veh_fine"></canvas></div>
                                </div>
                            </div>
                        </div>

                        <!-- ACC BY PLACE -->
                        <div id="mrap_plc" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="mra_plc_count"><div class="d-metric-label">Locations</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_plc_top"><div class="d-metric-label">Most Accidents At</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-box" style="margin-bottom:16px">
                                <div class="d-chart-title">Accidents by place</div>
                                <div style="position:relative;width:100%;height:280px"><canvas id="mra_ch_plc_bar"></canvas></div>
                            </div>
                            <div class="d-table-box">
                                <div class="d-chart-title" style="margin-bottom:10px">Place summary</div>
                                <div id="mra_plc_table"></div>
                            </div>
                        </div>

                        <!-- ACC CLAIMS -->
                        <div id="mrap_clm" class="d-panel">
                            <div class="d-metric-grid">
                                <div class="d-metric" id="mra_clm_own_cnt"><div class="d-metric-label">Own Claim Accidents</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_clm_tp_cnt"><div class="d-metric-label">Third Party Accidents</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_clm_own_fine"><div class="d-metric-label">Own Claim Fines</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                                <div class="d-metric" id="mra_clm_tp_fine"><div class="d-metric-label">Third Party Fines</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            </div>
                            <div class="d-chart-row">
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Own vs Third Party — accident count</div>
                                    <div class="d-legend">
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Own</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#D85A30"></span>Third Party</span>
                                    </div>
                                    <div style="position:relative;width:100%;height:260px"><canvas id="mra_ch_clm_donut"></canvas></div>
                                </div>
                                <div class="d-chart-box">
                                    <div class="d-chart-title">Own vs Third Party — fine amount</div>
                                    <div class="d-legend">
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Own</span>
                                        <span class="d-leg-item"><span class="d-leg-sq" style="background:#D85A30"></span>Third Party</span>
                                    </div>
                                    <div style="position:relative;width:100%;height:260px"><canvas id="mra_ch_clm_bar"></canvas></div>
                                </div>
                            </div>
                        </div>
                    </div><!-- mrDashAccidentContent -->

                </div><!-- mrDashContent -->
            </div><!-- mrDashboard -->

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
