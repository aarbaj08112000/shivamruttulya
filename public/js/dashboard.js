$(document).ready(function() {
    // 1. Collection Trend Chart (Bar/Line)
    const trendCtx = document.getElementById('collectionTrendChart');
    if (trendCtx) {
        new Chart(trendCtx, {
            type: 'line',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [
                    {
                        label: 'Cash Collection (₹)',
                        data: [15000, 12000, 18000, 16500, 21000, 25000, 28000],
                        borderColor: '#8B5E3C', // Tea Brown
                        backgroundColor: 'rgba(139, 94, 60, 0.1)',
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true
                    },
                    {
                        label: 'Online Collection (₹)',
                        data: [12000, 10000, 15000, 13000, 18000, 22000, 25000],
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
                labels: ['Chinchwad', 'Akurdi', 'Wakad'],
                datasets: [{
                    data: [45000, 32000, 28000],
                    backgroundColor: [
                        '#8B5E3C', // Primary
                        '#C49A6C', // Light
                        '#C77B30'  // Accent
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
