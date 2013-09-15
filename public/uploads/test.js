var getUserActivityChartConfig = function(renderId, title, cats, data) {
    var config = {};
    config.chart = {
        renderTo: renderId,
        type: 'areaspline'
    };
    config.title = title;
    config.legend = {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 150,
        y: 100,
        floating: true,
        borderWidth: 1,
        backgroundColor: '#FFFFFF'
    };
    config.xAxis = {
        categories: weeks,
        plotBands: [{ // visualize the weekend
            from: 4.5,
            to: 6.5,
            color: 'rgba(68, 170, 213, .2)'
        }]
    };
    config.yAxis = {
        title: {
            text: 'Active Users'
        }
    };

    config.tooltip = {
        shared: true,
        valueSuffix: ' users'
    };

    config.series = [{
        name: 'Users',
        data: data
    }];

    return config;
};

$(function () {
    var thechart = new Highcharts.Chart(
        getChartConfig('#useractivity', "User Activity Weekly", weeks, users))

});
