<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style type="text/css">
.master-container{display:flex;width:100%;height:100%;font-family:'Segoe UI',Tahoma,sans-serif;background-color:#f4f7f9}
.sidebar-filters{width:300px;flex:0 0 300px;background:#fff;border-right:1px solid #e1e8ed;display:flex;flex-direction:column;height:100vh;box-shadow:2px 0 8px rgba(0,0,0,.05)}
.sidebar-fixed-top{padding:15px 20px;border-bottom:1px solid #f0f4f8}
.sidebar-scroll-content{flex:1;overflow-y:auto;padding:15px 20px 25px}
.filter-card{background:#f8fafc;border:1px solid #e3e8ee;border-radius:12px;padding:15px;margin-bottom:12px}
.filter-table{width:100%;border-spacing:0 10px}
.label-cell{text-align:right;padding-right:10px;font-size:13px;font-weight:600;color:#4e5e71;width:80px}
input[type="text"],select{width:100%;padding:7px 10px;border:1px solid #ccd6e0;border-radius:6px;font-size:13px}
.btn-submit{width:100%;padding:11px;margin-top:10px;background:#2563eb;color:#fff;border:none;border-radius:6px;font-size:14px;font-weight:600;cursor:pointer}
.btn-submit:hover{background:#1d4ed8}
html,body,#mainBG,.hidden-scrollbar{height:100%;margin:0;overflow:hidden}
.myButtons,.myButton{background-color:#2563eb!important;color:#fff!important;border:none!important;border-radius:6px;padding:10px 15px;width:100%;font-weight:600;cursor:pointer}
.myButtons:hover,.myButton:hover{background-color:#1d4ed8!important}
.main-content-wrapper{flex:1;width:100%;display:flex;flex-direction:column}
.scrollable-grid-area{width:100%}
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
.d-loading{text-align:center;padding:50px 20px;color:#9a9a9a;font-size:13px}
@media(max-width:520px){.d-chart-row{grid-template-columns:1fr}}
</style>

<script type="text/javascript">

$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index:1;display:none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display:none;position:absolute;z-index:1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    $('#vehdetaildiv').hide();
    $("#fromdate").jqxDateTimeInput({ width:'125px', height:'15px', formatString:"dd.MM.yyyy" });
    $("#todate").jqxDateTimeInput({ width:'125px', height:'15px', formatString:"dd.MM.yyyy" });
    $('#brandwindow').jqxWindow({ width:'50%', height:'60%', maxHeight:'80%', maxWidth:'50%', title:'Brand Search', position:{x:250,y:60}, keyboardCloseKey:27 });
    $('#brandwindow').jqxWindow('close');
    $('#modelwindow').jqxWindow({ width:'50%', height:'60%', maxHeight:'80%', maxWidth:'50%', title:'Model Search', position:{x:250,y:60}, keyboardCloseKey:27 });
    $('#modelwindow').jqxWindow('close');
    $('#groupwindow').jqxWindow({ width:'50%', height:'60%', maxHeight:'80%', maxWidth:'50%', title:'Group Search', position:{x:250,y:60}, keyboardCloseKey:27 });
    $('#groupwindow').jqxWindow('close');
    $('#yomwindow').jqxWindow({ width:'50%', height:'60%', maxHeight:'80%', maxWidth:'50%', title:'YOM Search', position:{x:250,y:60}, keyboardCloseKey:27 });
    $('#yomwindow').jqxWindow('close');
    $('#fleetwindow').jqxWindow({ width:'50%', height:'60%', maxHeight:'80%', maxWidth:'50%', title:'Fleet Search', position:{x:250,y:60}, keyboardCloseKey:27 });
    $('#fleetwindow').jqxWindow('close');
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
});

function getBrand(){
    $('#brandwindow').jqxWindow('open');
    $('#brandwindow').jqxWindow('focus');
    brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));
}
function getModel(){
    $('#modelwindow').jqxWindow('open');
    $('#modelwindow').jqxWindow('focus');
    modelSearchContent('modelSearch.jsp?id=1', $('#brandwindow'));
}
function getGroup(event){
    $('#groupwindow').jqxWindow('open');
    $('#groupwindow').jqxWindow('focus');
    groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));
}
function getYom(event){
    $('#yomwindow').jqxWindow('open');
    $('#yomwindow').jqxWindow('focus');
    yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
}
function getFleet(event){
    $('#fleetwindow').jqxWindow('open');
    $('#fleetwindow').jqxWindow('focus');
    fleetSearchContent('fleetSearch.jsp?id=1', $('#fleetwindow'));
}
function brandSearchContent(url){ $.get(url).done(function(data){ $('#brandwindow').jqxWindow('setContent',data); }); }
function modelSearchContent(url){ $.get(url).done(function(data){ $('#modelwindow').jqxWindow('setContent',data); }); }
function groupSearchContent(url){ $.get(url).done(function(data){ $('#groupwindow').jqxWindow('setContent',data); }); }
function yomSearchContent(url)  { $.get(url).done(function(data){ $('#yomwindow').jqxWindow('setContent',data); }); }
function fleetSearchContent(url){ $.get(url).done(function(data){ $('#fleetwindow').jqxWindow('setContent',data); }); }

function setSearch(){
    var v=$('#searchby').val().trim();
    if(v==='brand')getBrand();
    else if(v==='model')getModel();
    else if(v==='group')getGroup();
    else if(v==='yom')getYom();
    else if(v==='fleet')getFleet();
}

function setRemove(){
    var v=$('#searchby').val().trim();
    var rebuild=function(){
        var s='';
        if(document.getElementById('brand').value)s+=document.getElementById('brand').value;
        if(document.getElementById('model').value)s+=(s?'\n':'')+document.getElementById('model').value;
        if(document.getElementById('group').value)s+=(s?'\n':'')+document.getElementById('group').value;
        if(document.getElementById('yom').value)  s+=(s?'\n':'')+document.getElementById('yom').value;
        if(document.getElementById('fleet').value) s+=(s?'\n':'')+document.getElementById('fleet').value;
        document.getElementById('searchdetails').value=s;
    };
    if(v==='brand'){document.getElementById('brand').value='';document.getElementById('hidbrand').value='';}
    else if(v==='model'){document.getElementById('model').value='';document.getElementById('hidmodel').value='';}
    else if(v==='group'){document.getElementById('group').value='';document.getElementById('hidgroup').value='';}
    else if(v==='yom'){document.getElementById('yom').value='';document.getElementById('hidyom').value='';}
    else if(v==='fleet'){document.getElementById('fleet').value='';document.getElementById('hidfleet').value='';}
    rebuild();
}

function funreload(event){
    if(document.getElementById('cmbbranch').value==''){
        $.messager.alert('Warning','Please Select Branch');
        return false;
    }
    var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
    if(dateval==1){
        var branch   = document.getElementById('cmbbranch').value;
        var fromdate = $('#fromdate').jqxDateTimeInput('val');
        var todate   = $('#todate').jqxDateTimeInput('val');
        var grpby1   = document.getElementById('grpby1').value;
        var hidbrand = document.getElementById('hidbrand').value;
        var hidmodel = document.getElementById('hidmodel').value;
        var hidgroup = document.getElementById('hidgroup').value;
        var hidyom   = document.getElementById('hidyom').value;
        var gridtype = document.getElementById('gridtype').value;
        var hidfleet = document.getElementById('hidfleet').value;
        _vpData = null;
        $("#overlay, #PleaseWait").show();
        if(gridtype=='detail'){
            $("#vehdetaildiv").load("vehDetailGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&id=1&gridtype="+gridtype+"&hidfleet="+hidfleet);
        } else {
            $("#vehprofitdiv").load("vehProfitGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&id=1&gridtype="+gridtype+"&hidfleet="+hidfleet, function(){
                if(document.getElementById('vpDashboard').style.display!=='none'){
                    setTimeout(buildVpDashboard,100);
                }
            });
        }
    }
}

function setValues(){
    if($('#msg').val()!=''){
        $.messager.alert('Message',$('#msg').val());
    }
    if(document.getElementById('gridtype').value==''){
        document.getElementById('rdosummary').checked=true;
        setGrid('summary');
    }
}

function funExportBtn(){
    if(document.getElementById('gridtype').value=='detail'){
        $("#vehdetaildiv").excelexportjs({ containerid:"vehdetaildiv", datatype:'json', dataset:null, gridId:"vehDetailGrid", columns:getColumns("vehDetailGrid"), worksheetName:"Vehicle Profitability Detail" });
    } else {
        $("#vehprofitdiv").excelexportjs({ containerid:"vehprofitdiv", datatype:'json', dataset:null, gridId:"vehProfitGrid", columns:getColumns("vehProfitGrid"), worksheetName:"Vehicle Profitability Summary" });
    }
}

function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('textarea').val('');
    $('#grpby1').val('');
    $('#searchby').val('');
}

function setGrid(value){
    if(value=='detail'){
        $('#vehprofitdiv').hide();
        $('#vehdetaildiv').show();
        document.getElementById('gridtype').value='detail';
    } else {
        $('#vehprofitdiv').show();
        $('#vehdetaildiv').hide();
        document.getElementById('gridtype').value='summary';
    }
}

// ===================== VIEW TOGGLE =====================
function showVpView(view){
    var g1=document.getElementById('vehprofitdiv');
    var g2=document.getElementById('vehdetaildiv');
    var d =document.getElementById('vpDashboard');
    var bg=document.getElementById('vpBtnGrid');
    var bd=document.getElementById('vpBtnDash');
    if(view==='grid'){
        var gt=document.getElementById('gridtype').value;
        if(gt==='detail'){g2.style.display='';g1.style.display='none';}
        else{g1.style.display='';g2.style.display='none';}
        d.style.display='none';
        bg.classList.add('active'); bd.classList.remove('active');
    } else {
        g1.style.display='none'; g2.style.display='none';
        d.style.display='';
        bg.classList.remove('active'); bd.classList.add('active');
        setTimeout(buildVpDashboard,60);
    }
}

function switchVpTab(tab){
    document.querySelectorAll('#vpDashboard .d-tab').forEach(function(b){b.classList.remove('active');});
    document.querySelectorAll('#vpDashboard .d-panel').forEach(function(p){p.classList.remove('active');});
    document.getElementById('vpt_'+tab).classList.add('active');
    document.getElementById('vpp_'+tab).classList.add('active');
}

// ===================== ANALYTICS DASHBOARD =====================
var _vpc={}, _vpData=null;
var _VPC={T:'#1D9E75',B:'#185FA5',B2:'#378ADD',A:'#EF9F27',C:'#D85A30',R:'#E24B4A',G:'#888780',P:'#7F77DD'};
var _VGC='rgba(128,128,128,0.1)';

function _vpcD(){ Object.keys(_vpc).forEach(function(k){if(_vpc[k]){_vpc[k].destroy();delete _vpc[k];}}); }
function _vpFmt(v){ return v>=1e6?(v/1e6).toFixed(1)+'M':v>=1e3?Math.round(v/1e3)+'K':String(Math.round(v)); }
function _vpFld(r,f){ return parseFloat(r[f])||0; }
function _vpLbl(r){ return (((r.description||r.reg_no||r.refno||'')+'').trim())||'-'; }
function _vpSetKpi(id,val,sub){
    var el=document.getElementById(id); if(!el)return;
    var ve=el.querySelector('.d-metric-val'), se=el.querySelector('.d-metric-sub');
    if(ve) ve.textContent=(val!=null)?val:'-';
    if(se) se.textContent=sub||'';
}

function buildVpDashboard(){
    var rows=[];
    try{ var g=$('#vehProfitGrid').jqxGrid('getrows'); if(g&&g.length>0) rows=g; }catch(e){}
    var noEl=document.getElementById('vpDashNoData');
    var conEl=document.getElementById('vpDashContent');
    if(!rows.length){ noEl.style.display=''; conEl.style.display='none'; return; }
    noEl.style.display='none'; conEl.style.display='';
    _vpData=rows;
    _vpcD();
    _vpRenderOverview(rows);
    _vpRenderProfitability(rows);
    _vpRenderTopPerformers(rows);
    _vpRenderLossMakers(rows);
    _vpRenderAgeAnalysis(rows);
    _vpRenderROI(rows);
}

function _vpRenderOverview(rows){
    var totInc=0,totExp=0,totNet=0,profitable=0,loss=0;
    rows.forEach(function(r){
        totInc+=_vpFld(r,'income'); totExp+=_vpFld(r,'expenses'); totNet+=_vpFld(r,'netamount');
        if(_vpFld(r,'netamount')>0)profitable++; else if(_vpFld(r,'netamount')<0)loss++;
    });
    var avgNet=rows.length?Math.round(totNet/rows.length):0;
    _vpSetKpi('vp_ov_fleet',rows.length,'vehicles tracked');
    _vpSetKpi('vp_ov_income',_vpFmt(totInc),'total revenue');
    _vpSetKpi('vp_ov_expense',_vpFmt(totExp),'total expenses');
    _vpSetKpi('vp_ov_net',_vpFmt(totNet),'net contribution');
    _vpSetKpi('vp_ov_profitable',profitable,'profitable vehicles');
    _vpSetKpi('vp_ov_avg',_vpFmt(avgNet),'avg net / vehicle');

    if(_vpc.ov1)_vpc.ov1.destroy();
    _vpc.ov1=new Chart(document.getElementById('vp_ch_ov_donut').getContext('2d'),{
        type:'doughnut',
        data:{labels:['Income','Expenses'],datasets:[{data:[totInc,totExp],backgroundColor:[_VPC.T,_VPC.R],borderWidth:0,hoverOffset:4}]},
        options:{responsive:true,maintainAspectRatio:false,cutout:'58%',plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.label+': '+_vpFmt(b.raw);}}}}}
    });

    var top=rows.slice().sort(function(a,b){return _vpFld(b,'netamount')-_vpFld(a,'netamount');}).slice(0,15);
    if(_vpc.ov2)_vpc.ov2.destroy();
    _vpc.ov2=new Chart(document.getElementById('vp_ch_ov_top').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:top.map(_vpLbl),datasets:[{data:top.map(function(r){return _vpFld(r,'netamount');}),
            backgroundColor:top.map(function(r){return _vpFld(r,'netamount')>=0?_VPC.T:_VPC.R;}),borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Net: '+_vpFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _vpFmt(v);}},grid:{color:_VGC}},y:{ticks:{font:{size:11}}}}}
    });
}

function _vpRenderProfitability(rows){
    var profitable=[],loss=[],even=[];
    rows.forEach(function(r){
        var n=_vpFld(r,'netamount');
        if(n>0)profitable.push(r); else if(n<0)loss.push(r); else even.push(r);
    });
    var byMargin=rows.slice().sort(function(a,b){
        var ma=_vpFld(a,'income')>0?_vpFld(a,'netamount')/_vpFld(a,'income')*100:-999;
        var mb=_vpFld(b,'income')>0?_vpFld(b,'netamount')/_vpFld(b,'income')*100:-999;
        return mb-ma;
    });
    var best=byMargin[0];
    _vpSetKpi('vp_prof_profit',profitable.length,'profitable');
    _vpSetKpi('vp_prof_loss',loss.length,'loss making');
    _vpSetKpi('vp_prof_even',even.length,'break-even');
    _vpSetKpi('vp_prof_best',best?_vpLbl(best):'-',best&&_vpFld(best,'income')>0?Math.round(_vpFld(best,'netamount')/_vpFld(best,'income')*100)+'% margin':'');

    var top=rows.slice().sort(function(a,b){return _vpFld(b,'income')-_vpFld(a,'income');}).slice(0,15);
    if(_vpc.pf1)_vpc.pf1.destroy();
    _vpc.pf1=new Chart(document.getElementById('vp_ch_prof_bar').getContext('2d'),{
        type:'bar',
        data:{labels:top.map(_vpLbl),datasets:[
            {label:'Income',data:top.map(function(r){return _vpFld(r,'income');}),backgroundColor:_VPC.T,borderRadius:4},
            {label:'Expenses',data:top.map(function(r){return _vpFld(r,'expenses');}),backgroundColor:_VPC.R,borderRadius:4}
        ]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_vpFmt(b.raw);}}}},
            scales:{y:{ticks:{callback:function(v){return _vpFmt(v);}},grid:{color:_VGC}},x:{ticks:{font:{size:10},maxRotation:30,autoSkip:false}}}}
    });

    var nets=rows.map(function(r){return _vpFld(r,'netamount');});
    var minN=Math.min.apply(null,nets), maxN=Math.max.apply(null,nets);
    var range=maxN-minN, bktSz=range>0?range/10:1;
    var bkts=[];
    for(var i=0;i<10;i++) bkts.push({mn:minN+i*bktSz,mx:minN+(i+1)*bktSz,cnt:0});
    nets.forEach(function(n){
        var idx=Math.min(Math.floor((n-minN)/bktSz),9);
        if(idx>=0&&idx<10)bkts[idx].cnt++;
    });
    if(_vpc.pf2)_vpc.pf2.destroy();
    _vpc.pf2=new Chart(document.getElementById('vp_ch_prof_hist').getContext('2d'),{
        type:'bar',
        data:{labels:bkts.map(function(b){return _vpFmt(b.mn)+'~'+_vpFmt(b.mx);}),
              datasets:[{data:bkts.map(function(b){return b.cnt;}),
                backgroundColor:bkts.map(function(b){return b.mn>=0?_VPC.T:_VPC.R;}),borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.raw+' vehicles';}}}},
            scales:{y:{grid:{color:_VGC}},x:{ticks:{font:{size:10},maxRotation:35}}}}
    });
}

function _vpRenderTopPerformers(rows){
    var byNet=rows.slice().sort(function(a,b){return _vpFld(b,'netamount')-_vpFld(a,'netamount');});
    var byInc=rows.slice().sort(function(a,b){return _vpFld(b,'income')-_vpFld(a,'income');});
    _vpSetKpi('vp_top_net',byNet[0]?_vpLbl(byNet[0]):'-',byNet[0]?'Net: '+_vpFmt(_vpFld(byNet[0],'netamount')):'');
    _vpSetKpi('vp_top_inc',byInc[0]?_vpLbl(byInc[0]):'-',byInc[0]?'Income: '+_vpFmt(_vpFld(byInc[0],'income')):'');
    _vpSetKpi('vp_top_cnt',byNet.filter(function(r){return _vpFld(r,'netamount')>0;}).length,'profitable');
    _vpSetKpi('vp_top_avg',_vpFmt(byNet.length?Math.round(byNet.reduce(function(s,r){return s+_vpFld(r,'netamount');},0)/byNet.length):0),'avg net');

    var t15n=byNet.slice(0,15);
    if(_vpc.tp1)_vpc.tp1.destroy();
    _vpc.tp1=new Chart(document.getElementById('vp_ch_top_net').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15n.map(_vpLbl),datasets:[{data:t15n.map(function(r){return _vpFld(r,'netamount');}),backgroundColor:_VPC.T,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Net: '+_vpFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _vpFmt(v);}},grid:{color:_VGC}},y:{ticks:{font:{size:11}}}}}
    });

    var t15i=byInc.slice(0,15);
    if(_vpc.tp2)_vpc.tp2.destroy();
    _vpc.tp2=new Chart(document.getElementById('vp_ch_top_inc').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15i.map(_vpLbl),datasets:[{data:t15i.map(function(r){return _vpFld(r,'income');}),backgroundColor:_VPC.B2,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Income: '+_vpFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _vpFmt(v);}},grid:{color:_VGC}},y:{ticks:{font:{size:11}}}}}
    });
}

function _vpRenderLossMakers(rows){
    var lossList=rows.filter(function(r){return _vpFld(r,'netamount')<0;})
        .sort(function(a,b){return _vpFld(a,'netamount')-_vpFld(b,'netamount');});
    var totLoss=lossList.reduce(function(s,r){return s+_vpFld(r,'netamount');},0);
    var avgLoss=lossList.length?Math.round(totLoss/lossList.length):0;
    _vpSetKpi('vp_loss_count',lossList.length,'loss-making vehicles');
    _vpSetKpi('vp_loss_total',_vpFmt(Math.abs(totLoss)),'total loss amount');
    _vpSetKpi('vp_loss_worst',lossList[0]?_vpLbl(lossList[0]):'-',lossList[0]?'Loss: '+_vpFmt(Math.abs(_vpFld(lossList[0],'netamount'))):'');
    _vpSetKpi('vp_loss_avg',_vpFmt(Math.abs(avgLoss)),'avg loss / vehicle');

    var wrap=document.getElementById('vp_loss_chart_wrap');
    var tbl=document.getElementById('vp_loss_table');
    if(!lossList.length){
        wrap.innerHTML='<div class="d-loading">&#10003; No loss-making vehicles — great performance!</div>';
        tbl.innerHTML='<div class="d-loading">All vehicles are profitable.</div>';
        return;
    }
    wrap.innerHTML='<div style="position:relative;width:100%;height:'+Math.max(200,lossList.slice(0,20).length*22)+'px"><canvas id="vp_ch_loss_bar"></canvas></div>';
    if(_vpc.ls1)_vpc.ls1.destroy();
    _vpc.ls1=new Chart(document.getElementById('vp_ch_loss_bar').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:lossList.slice(0,20).map(_vpLbl),datasets:[{data:lossList.slice(0,20).map(function(r){return Math.abs(_vpFld(r,'netamount'));}),backgroundColor:_VPC.R,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Loss: '+_vpFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _vpFmt(v);}},grid:{color:_VGC}},y:{ticks:{font:{size:11}}}}}
    });
    tbl.innerHTML='<table><tr><th>Vehicle</th><th>Reg No</th><th>Income</th><th>Expenses</th><th>Net Loss</th></tr>'
        +lossList.map(function(r){return '<tr><td>'+_vpLbl(r)+'</td><td>'+(r.reg_no||'-')+'</td><td>'+_vpFmt(_vpFld(r,'income'))+'</td><td>'+_vpFmt(_vpFld(r,'expenses'))+'</td><td><span class="d-badge d-b-red">'+_vpFmt(Math.abs(_vpFld(r,'netamount')))+'</span></td></tr>';}).join('')+'</table>';
}

function _vpRenderAgeAnalysis(rows){
    var bkts=[
        {lbl:'0-2 yrs',min:0,max:2,rows:[]},
        {lbl:'2-4 yrs',min:2,max:4,rows:[]},
        {lbl:'4-6 yrs',min:4,max:6,rows:[]},
        {lbl:'6-8 yrs',min:6,max:8,rows:[]},
        {lbl:'8-10 yrs',min:8,max:10,rows:[]},
        {lbl:'10+ yrs',min:10,max:999,rows:[]}
    ];
    rows.forEach(function(r){
        var a=_vpFld(r,'age');
        for(var i=0;i<bkts.length;i++){ if(a>=bkts[i].min&&a<bkts[i].max){bkts[i].rows.push(r);break;} }
    });
    var ages=rows.map(function(r){return _vpFld(r,'age');}).filter(function(a){return a>0;});
    var avgAge=ages.length?(Math.round(ages.reduce(function(s,a){return s+a;},0)/ages.length*10)/10):0;
    var bestBkt=bkts.slice().filter(function(b){return b.rows.length>0;}).sort(function(a,b){
        var an=a.rows.reduce(function(s,r){return s+_vpFld(r,'netamount');},0)/a.rows.length;
        var bn=b.rows.reduce(function(s,r){return s+_vpFld(r,'netamount');},0)/b.rows.length;
        return bn-an;
    })[0];
    _vpSetKpi('vp_age_count',rows.length,'total vehicles');
    _vpSetKpi('vp_age_avg',avgAge,'avg age (years)');
    _vpSetKpi('vp_age_best',bestBkt?bestBkt.lbl:'-','best avg net');
    _vpSetKpi('vp_age_young',bkts[0].rows.length,'vehicles 0-2 yrs');

    if(_vpc.ag1)_vpc.ag1.destroy();
    _vpc.ag1=new Chart(document.getElementById('vp_ch_age_donut').getContext('2d'),{
        type:'doughnut',
        data:{labels:bkts.map(function(b){return b.lbl+' ('+b.rows.length+')';}),
              datasets:[{data:bkts.map(function(b){return b.rows.length;}),
                backgroundColor:[_VPC.T,_VPC.B2,_VPC.A,_VPC.C,_VPC.R,_VPC.G],borderWidth:0,hoverOffset:4}]},
        options:{responsive:true,maintainAspectRatio:false,cutout:'55%',plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.label+': '+b.raw+' vehicles';}}}}}
    });

    if(_vpc.ag2)_vpc.ag2.destroy();
    _vpc.ag2=new Chart(document.getElementById('vp_ch_age_net').getContext('2d'),{
        type:'bar',
        data:{labels:bkts.map(function(b){return b.lbl;}),datasets:[{
            data:bkts.map(function(b){
                if(!b.rows.length)return 0;
                return Math.round(b.rows.reduce(function(s,r){return s+_vpFld(r,'netamount');},0)/b.rows.length);
            }),
            backgroundColor:bkts.map(function(b){
                if(!b.rows.length)return _VPC.G;
                return (b.rows.reduce(function(s,r){return s+_vpFld(r,'netamount');},0)/b.rows.length)>=0?_VPC.T:_VPC.R;
            }),
            borderRadius:4
        }]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return 'Avg net: '+_vpFmt(b.raw);}}}},
            scales:{y:{ticks:{callback:function(v){return _vpFmt(v);}},grid:{color:_VGC}},x:{grid:{display:false}}}}
    });

    document.getElementById('vp_age_table').innerHTML='<table><tr><th>Age Bucket</th><th>Vehicles</th><th>Avg Income</th><th>Avg Expenses</th><th>Avg Net</th><th>Total Net</th></tr>'
        +bkts.map(function(b){
            if(!b.rows.length)return '';
            var n=b.rows.length;
            var tI=b.rows.reduce(function(s,r){return s+_vpFld(r,'income');},0);
            var tE=b.rows.reduce(function(s,r){return s+_vpFld(r,'expenses');},0);
            var tN=b.rows.reduce(function(s,r){return s+_vpFld(r,'netamount');},0);
            var cls=tN>=0?'d-b-green':'d-b-red';
            return '<tr><td>'+b.lbl+'</td><td>'+n+'</td><td>'+_vpFmt(Math.round(tI/n))+'</td><td>'+_vpFmt(Math.round(tE/n))+'</td><td><span class="d-badge '+cls+'">'+_vpFmt(Math.round(tN/n))+'</span></td><td>'+_vpFmt(tN)+'</td></tr>';
        }).join('')+'</table>';
}

function _vpRenderROI(rows){
    var withCost=rows.filter(function(r){return _vpFld(r,'purcost')>0;});
    var rois=withCost.map(function(r){return {r:r,roi:Math.round(_vpFld(r,'netamount')/_vpFld(r,'purcost')*1000)/10};});
    rois.sort(function(a,b){return b.roi-a.roi;});
    var totPur=rows.reduce(function(s,r){return s+_vpFld(r,'purcost');},0);
    var totRet=rows.reduce(function(s,r){return s+_vpFld(r,'returnprice');},0);
    var totNet=rows.reduce(function(s,r){return s+_vpFld(r,'netamount');},0);
    var avgROI=totPur>0?Math.round(totNet/totPur*1000)/10:0;
    _vpSetKpi('vp_roi_pur',_vpFmt(totPur),'total purchase cost');
    _vpSetKpi('vp_roi_ret',_vpFmt(totRet),'total return value');
    _vpSetKpi('vp_roi_avg',avgROI+'%','avg portfolio ROI');
    _vpSetKpi('vp_roi_best',rois[0]?_vpLbl(rois[0].r):'-',rois[0]?rois[0].roi+'% ROI':'');

    var t15r=rows.slice().sort(function(a,b){return _vpFld(b,'returnprice')-_vpFld(a,'returnprice');}).slice(0,15);
    if(_vpc.ro1)_vpc.ro1.destroy();
    _vpc.ro1=new Chart(document.getElementById('vp_ch_roi_ret').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15r.map(_vpLbl),datasets:[
            {label:'Return Price',data:t15r.map(function(r){return _vpFld(r,'returnprice');}),backgroundColor:_VPC.T,borderRadius:4},
            {label:'Purchase Cost',data:t15r.map(function(r){return _vpFld(r,'purcost');}),backgroundColor:_VPC.B,borderRadius:4}
        ]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.dataset.label+': '+_vpFmt(b.raw);}}}},
            scales:{x:{ticks:{callback:function(v){return _vpFmt(v);}},grid:{color:_VGC}},y:{ticks:{font:{size:11}}}}}
    });

    var t15roi=rois.slice(0,15);
    if(_vpc.ro2)_vpc.ro2.destroy();
    _vpc.ro2=new Chart(document.getElementById('vp_ch_roi_bar').getContext('2d'),{
        type:'bar',indexAxis:'y',
        data:{labels:t15roi.map(function(x){return _vpLbl(x.r);}),datasets:[{
            data:t15roi.map(function(x){return x.roi;}),
            backgroundColor:t15roi.map(function(x){return x.roi>=0?_VPC.T:_VPC.R;}),
            borderRadius:4
        }]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(b){return b.raw+'% ROI';}}}},
            scales:{x:{ticks:{callback:function(v){return v+'%';}},grid:{color:_VGC}},y:{ticks:{font:{size:11}}}}}
    });
}
// ===================== END ANALYTICS DASHBOARD =====================

</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmSalesInvoiceList" method="post">
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>
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
                <div style="display:flex;justify-content:center;gap:20px;padding:5px 0;">
                    <span>
                        <input type="radio" name="rdosummary" id="rdosummary" value="summary" onchange="setGrid(this.value);">
                        <label class="branch" for="rdosummary">Summary</label>
                    </span>
                    <span>
                        <input type="radio" name="rdosummary" id="rdodetail" value="detail" onchange="setGrid(this.value);">
                        <label class="branch" for="rdodetail">Detail</label>
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
                            <div style="display:flex;justify-content:center;gap:6px;">
                                <button type="button" id="additem" class="myButton" onclick="setSearch();" style="width:40px;height:28px;">+</button>
                                <button type="button" id="btnremoveitem" class="myButton" onclick="setRemove();" style="width:40px;height:28px;">-</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-top:10px;">
                            <textarea id="searchdetails" name="searchdetails" rows="10" readonly style="resize:none;font-size:11px;"></textarea>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding:5px;">
                <input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
            </div>

        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content-wrapper">

        <!-- View Toggle Bar -->
        <div style="display:flex;align-items:center;gap:8px;padding:9px 14px;background:#fff;border-bottom:1px solid #e1e8ed;flex-wrap:wrap;">
            <button type="button" id="vpBtnGrid" onclick="showVpView('grid')" class="view-btn active">Grid View</button>
            <button type="button" id="vpBtnDash" onclick="showVpView('dash')" class="view-btn">Analytics Dashboard</button>
            <div style="margin-left:auto;display:flex;gap:8px;">
                <button type="button" onclick="funExportBtn()" class="view-btn" style="background:#059669;color:#fff;">Export Excel</button>
                <button type="button" onclick="funreload()" class="view-btn" style="background:#2563eb;color:#fff;">Load / Refresh</button>
            </div>
        </div>

        <div class="scrollable-grid-area">

            <div id="vehprofitdiv"><jsp:include page="vehProfitGrid.jsp"></jsp:include></div>
            <div id="vehdetaildiv"><jsp:include page="vehDetailGrid.jsp"></jsp:include></div>

            <!-- Analytics Dashboard -->
            <div id="vpDashboard" style="display:none;height:calc(100vh - 95px);overflow-y:auto;background:#f4f7f9;padding:14px 16px;">

                <div id="vpDashNoData" style="display:none;text-align:center;padding:60px 20px;color:#9a9a9a;">
                    <div style="font-size:32px;margin-bottom:10px;">&#128202;</div>
                    <div style="font-size:15px;font-weight:500;">No Data Loaded</div>
                    <div style="font-size:12px;margin-top:6px;">Select filters and click <strong>Load / Refresh</strong>, then open Analytics Dashboard.</div>
                </div>

                <div id="vpDashContent">
                    <div class="d-tabs">
                        <div class="d-tab active" id="vpt_ov"   onclick="switchVpTab('ov')">Overview</div>
                        <div class="d-tab" id="vpt_prof"        onclick="switchVpTab('prof')">Profitability</div>
                        <div class="d-tab" id="vpt_top"         onclick="switchVpTab('top')">Top Performers</div>
                        <div class="d-tab" id="vpt_loss"        onclick="switchVpTab('loss')">Loss Makers</div>
                        <div class="d-tab" id="vpt_age"         onclick="switchVpTab('age')">Age Analysis</div>
                        <div class="d-tab" id="vpt_roi"         onclick="switchVpTab('roi')">ROI Analysis</div>
                    </div>

                    <!-- OVERVIEW -->
                    <div id="vpp_ov" class="d-panel active">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="vp_ov_fleet"><div class="d-metric-label">Total Fleet</div><div class="d-metric-val">-</div><div class="d-metric-sub">vehicles tracked</div></div>
                            <div class="d-metric" id="vp_ov_income"><div class="d-metric-label">Total Revenue</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_ov_expense"><div class="d-metric-label">Total Expenses</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_ov_net"><div class="d-metric-label">Net Contribution</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_ov_profitable"><div class="d-metric-label">Profitable</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_ov_avg"><div class="d-metric-label">Avg Net / Vehicle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box">
                                <div class="d-chart-title">Revenue vs Expenses (total)</div>
                                <div class="d-legend">
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#1D9E75"></span>Income</span>
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#E24B4A"></span>Expenses</span>
                                </div>
                                <div style="position:relative;width:100%;height:220px"><canvas id="vp_ch_ov_donut"></canvas></div>
                            </div>
                            <div class="d-chart-box">
                                <div class="d-chart-title">Top 15 vehicles by net amount</div>
                                <div style="position:relative;width:100%;height:220px"><canvas id="vp_ch_ov_top"></canvas></div>
                            </div>
                        </div>
                    </div>

                    <!-- PROFITABILITY -->
                    <div id="vpp_prof" class="d-panel">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="vp_prof_profit"><div class="d-metric-label">Profitable</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_prof_loss"><div class="d-metric-label">Loss Making</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_prof_even"><div class="d-metric-label">Break-even</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_prof_best"><div class="d-metric-label">Best Margin</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-box" style="margin-bottom:16px">
                            <div class="d-chart-title">Income vs Expenses — top 15 by revenue</div>
                            <div class="d-legend">
                                <span class="d-leg-item"><span class="d-leg-sq" style="background:#1D9E75"></span>Income</span>
                                <span class="d-leg-item"><span class="d-leg-sq" style="background:#E24B4A"></span>Expenses</span>
                            </div>
                            <div style="position:relative;width:100%;height:300px"><canvas id="vp_ch_prof_bar"></canvas></div>
                        </div>
                        <div class="d-chart-box" style="margin-bottom:16px">
                            <div class="d-chart-title">Net amount distribution (10-bucket histogram)</div>
                            <div style="position:relative;width:100%;height:200px"><canvas id="vp_ch_prof_hist"></canvas></div>
                        </div>
                    </div>

                    <!-- TOP PERFORMERS -->
                    <div id="vpp_top" class="d-panel">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="vp_top_net"><div class="d-metric-label">Top by Net</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_top_inc"><div class="d-metric-label">Top by Income</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_top_cnt"><div class="d-metric-label">Profitable</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_top_avg"><div class="d-metric-label">Avg Net</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box">
                                <div class="d-chart-title">Top 15 by net amount</div>
                                <div style="position:relative;width:100%;height:340px"><canvas id="vp_ch_top_net"></canvas></div>
                            </div>
                            <div class="d-chart-box">
                                <div class="d-chart-title">Top 15 by revenue (income)</div>
                                <div style="position:relative;width:100%;height:340px"><canvas id="vp_ch_top_inc"></canvas></div>
                            </div>
                        </div>
                    </div>

                    <!-- LOSS MAKERS -->
                    <div id="vpp_loss" class="d-panel">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="vp_loss_count"><div class="d-metric-label">Loss Vehicles</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_loss_total"><div class="d-metric-label">Total Loss</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_loss_worst"><div class="d-metric-label">Worst Vehicle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_loss_avg"><div class="d-metric-label">Avg Loss</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-box" style="margin-bottom:16px">
                            <div class="d-chart-title">Top 20 loss-making vehicles (worst first)</div>
                            <div id="vp_loss_chart_wrap"></div>
                        </div>
                        <div class="d-table-box">
                            <div class="d-chart-title" style="margin-bottom:10px">All loss-making vehicles</div>
                            <div id="vp_loss_table"></div>
                        </div>
                    </div>

                    <!-- AGE ANALYSIS -->
                    <div id="vpp_age" class="d-panel">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="vp_age_count"><div class="d-metric-label">Total Vehicles</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_age_avg"><div class="d-metric-label">Avg Age</div><div class="d-metric-val">-</div><div class="d-metric-sub">years</div></div>
                            <div class="d-metric" id="vp_age_best"><div class="d-metric-label">Best Age Bucket</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_age_young"><div class="d-metric-label">Newest (0-2 yrs)</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box">
                                <div class="d-chart-title">Fleet distribution by age</div>
                                <div style="position:relative;width:100%;height:240px"><canvas id="vp_ch_age_donut"></canvas></div>
                            </div>
                            <div class="d-chart-box">
                                <div class="d-chart-title">Avg net contribution by age bucket</div>
                                <div style="position:relative;width:100%;height:240px"><canvas id="vp_ch_age_net"></canvas></div>
                            </div>
                        </div>
                        <div class="d-table-box">
                            <div class="d-chart-title" style="margin-bottom:10px">Age bucket summary</div>
                            <div id="vp_age_table"></div>
                        </div>
                    </div>

                    <!-- ROI ANALYSIS -->
                    <div id="vpp_roi" class="d-panel">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="vp_roi_pur"><div class="d-metric-label">Total Purchase Cost</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_roi_ret"><div class="d-metric-label">Total Return Value</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_roi_avg"><div class="d-metric-label">Avg Portfolio ROI</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                            <div class="d-metric" id="vp_roi_best"><div class="d-metric-label">Best ROI Vehicle</div><div class="d-metric-val">-</div><div class="d-metric-sub">-</div></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box">
                                <div class="d-chart-title">Return price vs purchase cost — top 15</div>
                                <div class="d-legend">
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#1D9E75"></span>Return Price</span>
                                    <span class="d-leg-item"><span class="d-leg-sq" style="background:#185FA5"></span>Purchase Cost</span>
                                </div>
                                <div style="position:relative;width:100%;height:340px"><canvas id="vp_ch_roi_ret"></canvas></div>
                            </div>
                            <div class="d-chart-box">
                                <div class="d-chart-title">Top 15 vehicles by ROI %</div>
                                <div style="position:relative;width:100%;height:340px"><canvas id="vp_ch_roi_bar"></canvas></div>
                            </div>
                        </div>
                    </div>

                </div><!-- vpDashContent -->
            </div><!-- vpDashboard -->

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
            <input type="hidden" name="gridtype" id="gridtype">
            <input type="hidden" name="fleet" id="fleet">
            <input type="hidden" name="hidfleet" id="hidfleet">

        </div><!-- scrollable-grid-area -->
    </div><!-- main-content-wrapper -->

</div><!-- master-container -->
</div>
</div>

<div id="brandwindow"><div><img src="../../../../icons/31load.gif" style="position:absolute;top:50%;left:50%;"/></div></div>
<div id="modelwindow"><div><img src="../../../../icons/31load.gif" style="position:absolute;top:50%;left:50%;"/></div></div>
<div id="groupwindow"><div><img src="../../../../icons/31load.gif" style="position:absolute;top:50%;left:50%;"/></div></div>
<div id="yomwindow"><div><img src="../../../../icons/31load.gif" style="position:absolute;top:50%;left:50%;"/></div></div>
<div id="fleetwindow"><div><img src="../../../../icons/31load.gif" style="position:absolute;top:50%;left:50%;"/></div></div>
</form>
</body>
</html>
