<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
    String contextPath = request.getContextPath();
    String atype = request.getParameter("atype");
    if (atype == null) {
        atype = "0";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Vehicles Search & Select Vehicle</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --primary-teal: #3ba294;
        --danger-red: #ea5b60;
        --btn-blue: #348fe2;
        --text-color: #666;
        --border-color: #e2e2e2;
        --bg-light: #f5f6f8;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f0f0;
        margin: 0;
        padding: 20px;
        color: var(--text-color);
    }

    .modal-container {
        background: #fff;
        border-radius: 4px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        max-width: 1200px;
        margin: auto;
        display: flex;
        flex-direction: column;
    }

    /* Header Styling */
    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 20px;
        border-bottom: 1px solid var(--border-color);
    }
    .modal-header h2 {
        margin: 0;
        font-size: 18px;
        color: #444;
        font-weight: normal;
    }
    .modal-header h2 span {
        color: #888;
        font-size: 14px;
        margin-left: 5px;
    }
    .close-btn {
        color: #bbb;
        font-size: 20px;
        cursor: pointer;
    }

    /* Search Form Layout */
    .search-section {
        padding: 20px;
    }
    .form-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px 30px;
        margin-bottom: 20px;
    }
    
    /* Input Styling */
    .input-group {
        display: flex;
        flex-direction: column;
    }
    .input-group label {
        font-size: 13px;
        color: #999;
        margin-bottom: 5px;
    }
    .input-group input, 
    .input-group select {
        border: none;
        border-bottom: 1px solid var(--border-color);
        padding: 5px 0;
        font-size: 14px;
        color: #333;
        outline: none;
        background: transparent;
    }
    .input-group input:focus, 
    .input-group select:focus {
        border-bottom: 2px solid var(--primary-teal);
    }
    .input-group.active-field input {
        border-bottom: 2px solid var(--primary-teal);
    }
    
    /* Custom Select Arrow */
    select {
        appearance: none;
        background-image: url('data:image/svg+xml;utf8,<svg fill="%23999" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
        background-repeat: no-repeat;
        background-position-x: 100%;
        background-position-y: center;
    }

    /* Action Buttons */
    .action-buttons {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: -10px; /* Aligns with the last grid row */
    }
    .btn {
        border: none;
        border-radius: 3px;
        padding: 8px 15px;
        color: #fff;
        cursor: pointer;
        font-size: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .btn-search {
        background-color: var(--primary-teal);
    }
    .btn-clear {
        background-color: var(--danger-red);
    }

    /* Data Table Styling */
    .table-container {
        overflow-x: auto;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13px;
        white-space: nowrap;
    }
    th {
        background-color: #f9f9f9;
        color: #555;
        font-weight: 600;
        text-align: left;
        padding: 10px;
        border-top: 1px solid var(--border-color);
        border-bottom: 2px solid var(--border-color);
    }
    td {
        padding: 8px 10px;
        border-bottom: 1px solid var(--border-color);
        color: #444;
        vertical-align: middle;
    }
    tr:nth-child(even) td {
        background-color: #fafafa;
    }
    
    /* Select Button in Table */
    .btn-select {
        background-color: var(--btn-blue);
        color: #fff;
        border: none;
        border-radius: 3px;
        padding: 4px 12px;
        font-size: 11px;
        font-weight: bold;
        cursor: pointer;
    }
    .btn-select i {
        margin-right: 4px;
    }

    /* Pagination Bar */
    .pagination-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 15px;
        background-color: #fff;
        border-top: 1px solid var(--border-color);
        font-size: 13px;
        color: #666;
    }
    .page-controls {
        display: flex;
        align-items: center;
        gap: 5px;
    }
    .page-btn {
        background: #fff;
        border: 1px solid #ccc;
        border-radius: 3px;
        padding: 3px 8px;
        cursor: pointer;
        color: #666;
    }
    .page-input {
        width: 40px;
        border: 1px solid #ccc;
        border-radius: 3px;
        padding: 3px 5px;
        text-align: center;
    }
    .items-per-page {
        border: 1px solid #ccc;
        border-radius: 3px;
        padding: 3px 5px;
    }
</style>

<script src="<%=contextPath%>/js/jquery.min.js"></script>
<script>
    function performSearch() {
        // Your logic to reload the grid goes here
        // e.g., fetching data via AJAX and populating the table body
        console.log("Searching...");
    }
</script>
</head>
<body>

<div class="modal-container">
    <div class="modal-header">
        <h2>Vehicles <span>Search & Select Vehicle</span></h2>
        <i class="fas fa-times close-btn"></i>
    </div>

    <div class="search-section">
        <div class="form-grid">
            <div class="input-group active-field">
                <label>From</label>
                <input type="text" value="2023-08-16 15:06" id="fromDate">
            </div>
            <div class="input-group active-field">
                <label>To</label>
                <input type="text" value="2023-08-18 15:06" id="toDate">
            </div>
            <div class="input-group">
                <label>Plate No</label>
                <input type="text" id="plateNo">
            </div>

            <div class="input-group">
                <label>Chassis No</label>
                <input type="text" id="chassisNo">
            </div>
            <div class="input-group">
                <label>Fleet No</label>
                <input type="text" id="fleetNo">
            </div>
            <div class="input-group">
                <label>Branch</label>
                <select id="branch"></select>
            </div>

            <div class="input-group">
                <label>Vehicle Group</label>
                <select id="vehicleGroup"></select>
            </div>
            <div class="input-group">
                <label>Make and Model</label>
                <select id="makeAndModel"></select>
            </div>
            
            <div class="action-buttons">
                <button class="btn btn-search" onclick="performSearch()"><i class="fas fa-search"></i></button>
                <button class="btn btn-clear"><i class="fas fa-trash-alt"></i></button>
            </div>
        </div>
    </div>

    <div class="table-container" id="refreshSearchDetailsDiv">
        <table>
            <thead>
                <tr>
                    <th>Select <i class="fas fa-chevron-down" style="font-size:10px; margin-left:3px;"></i></th>
                    <th>Vehicle No <i class="fas fa-chevron-down" style="font-size:10px; margin-left:3px;"></i></th>
                    <th>Make And Model <i class="fas fa-chevron-down" style="font-size:10px; margin-left:3px;"></i></th>
                    <th>Fleet No <i class="fas fa-chevron-down" style="font-size:10px; margin-left:3px;"></i></th>
                    <th>Vehicle Type <i class="fas fa-chevron-down" style="font-size:10px; margin-left:3px;"></i></th>
                    <th>Colour <i class="fas fa-chevron-down" style="font-size:10px; margin-left:3px;"></i></th>
                    <th>Branch</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><button class="btn-select"><i class="fas fa-check"></i> SELECT</button></td>
                    <td>أ م و 6666</td>
                    <td>KIA Sportage</td>
                    <td>6472</td>
                    <td>2023, KIA Sportage ...</td>
                    <td>White</td>
                    <td>[ ... ]</td>
                </tr>
                <tr>
                    <td><button class="btn-select"><i class="fas fa-check"></i> SELECT</button></td>
                    <td>ر ر ب 9776</td>
                    <td>Ashok Leyland</td>
                    <td>3915</td>
                    <td>2020, Ashok Leylan...</td>
                    <td></td>
                    <td>[ ... ]</td>
                </tr>
                <tr>
                    <td><button class="btn-select"><i class="fas fa-check"></i> SELECT</button></td>
                    <td>ر ر ب 9774</td>
                    <td>Ashok Leyland</td>
                    <td>3913</td>
                    <td>2020, Ashok Leylan...</td>
                    <td></td>
                    <td>[ ... ]</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="pagination-bar">
        <div class="page-controls">
            <button class="page-btn"><i class="fas fa-step-backward" style="font-size:10px;"></i></button>
            <button class="page-btn"><i class="fas fa-caret-left"></i></button>
            <input type="text" class="page-input" value="1">
            <span>/ 15</span>
            <button class="page-btn"><i class="fas fa-caret-right"></i></button>
            <button class="page-btn"><i class="fas fa-step-forward" style="font-size:10px;"></i></button>
            
            <select class="items-per-page" style="margin-left: 10px;">
                <option>100</option>
            </select>
            <span style="margin-left:5px;">items per page</span>
        </div>
        <div>
            1 - 100 of 1444 items
        </div>
    </div>

</div>

</body>
</html>