<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard Tiles</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { background:#f5f6fa; font-family: "Helvetica Neue", Arial, sans-serif; padding:20px; }
        .tiles-row { margin-bottom:20px; }
        .tile {
            background:#fff;
            border-radius:6px;
            box-shadow:0 1px 3px rgba(0,0,0,0.08);
            padding:18px;
            text-align:left;
            min-height:110px;
            display:flex;
            align-items:center;
        }
        .tile .icon {
            width:64px;
            height:64px;
            border-radius:8px;
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:24px;
            margin-right:16px;
            color:#fff;
        }
        .tile .content { flex:1; }
        .tile .label { font-size:13px; color:#888; }
        .tile .value { font-size:26px; font-weight:600; margin-top:4px; }
        .tile .meta { font-size:12px; color:#999; margin-top:6px; }
        .bg-blue { background:#3b82f6; }
        .bg-green { background:#10b981; }
        .bg-orange { background:#f59e0b; }
        .bg-red { background:#ef4444; }
        .bg-purple { background:#7c3aed; }
        .tile a.details { color:#666; font-size:12px; text-decoration:none; }
        @media (max-width:767px){
            .tile { padding:12px; }
            .tile .icon { width:52px; height:52px; font-size:20px; margin-right:12px; }
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <h3 class="m-b-15">Dashboard — Tiles</h3>

    <div class="row tiles-row">
        <div class="col-xs-12 col-sm-6 col-md-3">
            <div class="tile">
                <div class="icon bg-blue"><i class="fas fa-car"></i></div>
                <div class="content">
                    <div class="label">Live Fleets</div>
                    <div class="value">120</div>
                    <div class="meta">Updated: 29-08-2019 14:03</div>
                </div>
            </div>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-3">
            <div class="tile">
                <div class="icon bg-green"><i class="fas fa-chart-line"></i></div>
                <div class="content">
                    <div class="label">Monthly Additions</div>
                    <div class="value">35</div>
                    <div class="meta">This month</div>
                </div>
            </div>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-3">
            <div class="tile">
                <div class="icon bg-orange"><i class="fas fa-shopping-cart"></i></div>
                <div class="content">
                    <div class="label">Sales</div>
                    <div class="value">50</div>
                    <div class="meta">This month</div>
                </div>
            </div>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-3">
            <div class="tile">
                <div class="icon bg-red"><i class="fas fa-exclamation-triangle"></i></div>
                <div class="content">
                    <div class="label">Alerts</div>
                    <div class="value">3</div>
                    <div class="meta">High priority</div>
                </div>
            </div>
        </div>
    </div>

    <div class="row tiles-row">
        <div class="col-xs-12 col-sm-6 col-md-3">
            <div class="tile">
                <div class="icon bg-purple"><i class="fas fa-users"></i></div>
                <div class="content">
                    <div class="label">Active Users</div>
                    <div class="value">24</div>
                    <div class="meta">Last 24 hrs</div>
                </div>
            </div>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-3">
            <div class="tile">
                <div class="icon bg-blue"><i class="fas fa-tachometer-alt"></i></div>
                <div class="content">
                    <div class="label">System Load</div>
                    <div class="value">68%</div>
                    <div class="meta">Average</div>
                </div>
            </div>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-3">
            <div class="tile">
                <div class="icon bg-green"><i class="fas fa-map-marked-alt"></i></div>
                <div class="content">
                    <div class="label">Regions Active</div>
                    <div class="value">8</div>
                    <div class="meta">Global</div>
                </div>
            </div>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-3">
            <div class="tile">
                <div class="icon bg-orange"><i class="fas fa-layer-group"></i></div>
                <div class="content">
                    <div class="label">Models Tracked</div>
                    <div class="value">42</div>
                    <div class="meta">Catalog</div>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>