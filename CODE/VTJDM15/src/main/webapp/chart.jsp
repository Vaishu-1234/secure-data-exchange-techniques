<%@page import="java.util.Map"%>
<%@page import="com.dao.DBUtil"%>
<%@page import="java.util.LinkedHashMap"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Data Value Chart</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Style -->
    <style>
        body {
            background: #f8f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .chart-container {
            max-width: 1000px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        }
        .chart-title {
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .btn-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .btn-toggle {
            background: #0d6efd;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 500;
            transition: background 0.3s;
        }
        .btn-toggle:hover {
            background: #0a58ca;
        }
        canvas {
            max-height: 500px;
        }
    </style>
</head>
<body>


<div class="sidebar">
  <h2>Client Panel</h2>
  <a href="index.jsp">📂 Upload</a>
  <a href="plc.jsp">📊 PLC</a>
   <a href="chart.jsp">Analytics</a>
  <a href="client.jsp">🚪 Logout</a>
</div>
<%
    // Step 1: Connect to DB and prepare data
    LinkedHashMap<String, Integer> valueCounts = new LinkedHashMap<String, Integer>();
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DBUtil.getConnection();
        String query = "SELECT data_value, COUNT(*) as count FROM file_tokens WHERE data_value IS NOT NULL GROUP BY data_value ORDER BY count DESC LIMIT 10";
        ps = conn.prepareStatement(query);
        rs = ps.executeQuery();

        while (rs.next()) {
            valueCounts.put(rs.getString("data_value"), rs.getInt("count"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }

    // Convert to JS arrays
    StringBuilder labels = new StringBuilder();
    StringBuilder data = new StringBuilder();

    for (Map.Entry<String, Integer> entry : valueCounts.entrySet()) {
        labels.append("'").append(entry.getKey()).append("',");
        data.append(entry.getValue()).append(",");
    }

    String labelsString = labels.length() > 0 ? labels.substring(0, labels.length() - 1) : "";
    String dataString = data.length() > 0 ? data.substring(0, data.length() - 1) : "";
%>

<div class="chart-container">
    <div class="chart-title">Data Value Visualization</div>

    <div class="btn-group">
        <button class="btn-toggle" onclick="renderChart('bar')">Bar</button>
        <button class="btn-toggle" onclick="renderChart('line')">Line</button>
        <button class="btn-toggle" onclick="renderChart('pie')">Pie</button>
    </div>

    <canvas id="dataChart"></canvas>
</div>

<script>
    let chart;
    const ctx = document.getElementById('dataChart').getContext('2d');

    const chartData = {
        labels: [<%= labelsString %>],
        datasets: [{
            label: 'Data Value Count',
            data: [<%= dataString %>],
            backgroundColor: [
                '#0d6efd', '#6610f2', '#6f42c1', '#d63384',
                '#dc3545', '#fd7e14', '#ffc107', '#198754',
                '#20c997', '#0dcaf0'
            ],
            borderColor: '#0d6efd',
            borderWidth: 2,
            tension: 0.4,
            fill: true,
        }]
    };

    const options = {
        responsive: true,
        plugins: {
            legend: {
                display: true
            },
            tooltip: {
                callbacks: {
                    label: function (context) {
                        return 'Count: ' + context.parsed.y;
                    }
                }
            }
        },
        scales: {
            x: {
                ticks: {
                    autoSkip: false,
                    maxRotation: 45,
                    minRotation: 0
                },
                title: {
                    display: true,
                    text: 'Data Value'
                }
            },
            y: {
                beginAtZero: true,
                title: {
                    display: true,
                    text: 'Count'
                }
            }
        }
    };

    function renderChart(type) {
        if (chart) chart.destroy();

        let config = {
            type: type,
            data: chartData,
            options: { ...options }
        };

        // Adjust options for pie chart (no axes)
        if (type === 'pie') {
            delete config.options.scales;
            config.options.plugins.tooltip.callbacks.label = function (context) {
                return context.label + ': ' + context.parsed + ' entries';
            };
        }

        chart = new Chart(ctx, config);
    }

    // Initial chart
    renderChart('bar');
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
