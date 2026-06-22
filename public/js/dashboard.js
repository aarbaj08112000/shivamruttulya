$(document).ready(function() {
    // 1. Collection Trend Chart (Bar/Line)
    const trendCtx = document.getElementById('collectionTrendChart');
    if (trendCtx) {
        new Chart(trendCtx, {
            type: 'line',
            data: {
                labels: trendData.map(item => new Date(item.collection_date).toLocaleDateString('en-US', {weekday: 'short'})),
                datasets: [
                    {
                        label: 'Cash Collection (₹)',
                        data: trendData.map(item => parseFloat(item.cash)),
                        borderColor: '#8B5E3C', // Tea Brown
                        backgroundColor: 'rgba(139, 94, 60, 0.1)',
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true
                    },
                    {
                        label: 'Online Collection (₹)',
                        data: trendData.map(item => parseFloat(item.online)),
                        borderColor: '#C77B30', // Chai Orange
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

    // 2. Shop Wise Comparison Chart (Doughnut)
    const shopWiseCtx = document.getElementById('shopWiseChart');
    if (shopWiseCtx) {
        new Chart(shopWiseCtx, {
            type: 'doughnut',
            data: {
                labels: shopWiseData.map(item => item.shop_name),
                datasets: [{
                    data: shopWiseData.map(item => parseFloat(item.total)),
                    backgroundColor: [
                        '#8B5E3C', // Primary
                        '#C49A6C', // Light
                        '#C77B30', // Accent
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
