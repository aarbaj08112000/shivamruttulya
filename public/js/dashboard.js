$(document).ready(function() {
    var trendChart = null;

    // Helper to get label format based on range
    function getLabelFormat(range) {
        return function(dateStr) {
            var d = new Date(dateStr);
            if (range === 'daily') {
                return d.toLocaleDateString('en-US', {day: 'numeric', month: 'short'});
            } else if (range === 'monthly') {
                return d.toLocaleDateString('en-US', {day: 'numeric', month: 'short'});
            } else {
                // weekly
                return d.toLocaleDateString('en-US', {weekday: 'short'});
            }
        };
    }

    // Build / Rebuild the trend chart
    function buildTrendChart(data, range) {
        var trendCtx = document.getElementById('collectionTrendChart');
        if (!trendCtx) return;

        // Destroy existing chart if any
        if (trendChart) {
            trendChart.destroy();
            trendChart = null;
        }

        var formatLabel = getLabelFormat(range);

        trendChart = new Chart(trendCtx, {
            type: 'line',
            data: {
                labels: data.map(function(item) { return formatLabel(item.collection_date); }),
                datasets: [
                    {
                        label: 'Cash Collection (₹)',
                        data: data.map(function(item) { return parseFloat(item.cash); }),
                        borderColor: '#8B5E3C',
                        backgroundColor: 'rgba(139, 94, 60, 0.1)',
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true
                    },
                    {
                        label: 'Online Collection (₹)',
                        data: data.map(function(item) { return parseFloat(item.online); }),
                        borderColor: '#C77B30',
                        backgroundColor: 'rgba(199, 123, 48, 0.1)',
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    // 1. Initialize Collection Trend Chart with default data
    buildTrendChart(trendData, 'weekly');

    // 2. Handle dropdown change - fetch new trend data via AJAX
    $('#trendRangeSelector').on('change', function() {
        var selectedRange = $(this).val();
        
        $.ajax({
            url: base_url + 'user/login/get_trend_data',
            type: 'POST',
            data: { range: selectedRange },
            dataType: 'json',
            success: function(response) {
                if (response.success == 1) {
                    buildTrendChart(response.data, selectedRange);
                }
            },
            error: function() {
                console.error('Failed to fetch trend data');
            }
        });
    });

    // 3. Shop Wise Comparison Chart (Doughnut)
    var shopWiseCtx = document.getElementById('shopWiseChart');
    if (shopWiseCtx) {
        new Chart(shopWiseCtx, {
            type: 'doughnut',
            data: {
                labels: shopWiseData.map(function(item) { return item.shop_name; }),
                datasets: [{
                    data: shopWiseData.map(function(item) { return parseFloat(item.total); }),
                    backgroundColor: [
                        '#8B5E3C',
                        '#C49A6C',
                        '#C77B30',
                        '#E6B17A',
                        '#F5C293',
                        '#9E6B47',
                        '#75482A',
                        '#D38B42'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    }
});
