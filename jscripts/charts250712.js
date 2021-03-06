/* Игорь Ряховский 25.07.2012
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
AmCharts.shortMonthNames="Янв Фев Мар Апр Май Июн Июл Авг Сен Окт Ноя Дек".split(" ");

var Chart_pie = {
    chart: null,
    div: '',
    loaded: false,
    // TODO: нужно сделать в виде array чтобы удалять элементы после... 
    hist: {},
    create: function (div) {
        if (!document.getElementById(div)) {
            return false;
        }
        this.loaded=false;
        this.div = div;
        var th = this;

        this.chart = new AmCharts.AmPieChart();
        th.hist[''] = 'Начало';
        this.chart.addListener('clickSlice', function (item) {
            th.hist[item.dataItem.dataContext['cat_id']] = item.dataItem.dataContext['category'];
            th.get_pie_data(item.dataItem.dataContext['cat_id']);
        });


        this.get_pie_data();


        $("#chart_history").on('click', 'li', function () {
            var cat = $(this).attr('data-cat-id');
            th.get_pie_data(cat);
            delete th.hist[cat];
        });

        return true;
    },
    get_pie_data: function (cat_id) {
        var cat = '';
        if (cat_id) {
            cat = '&parent_category_id=' + cat_id;
        }

        var th = this;

        $.ajax({
            type: "POST",
            url: "out_table.php",
            data: "class_name=InOutCats&request_mode=out_report_mode&entity_suffix=_account&report_name=outcome_categories_diagramm&result_type=json" + cat,
            dataType: "json",
            success: function (data) {
                th.set_chart_proretry(data);
                th.update_history();
            }
        });
    },
    set_chart_proretry: function (data) {
        for (key in data) {
            this.chart[key] = data[key];
        }

        if (!this.loaded) {
            this.loaded = true;
            this.chart.write(this.div);
        } else {
            this.chart.validateData();
            this.chart.animateAgain();
        }


    },

    update_history: function () {
        var h = $("#chart_history");
        $("#chart_history > li").remove();
        for (cat_id in this.hist) {
            $(h).append('<li data-cat-id="' + cat_id + '">' + this.hist[cat_id] + '</li>');
        }
    }

};

var Chart_line = {
    div: '',
    loaded: false,
    chart: null,
    create: function (div) {
        if (!document.getElementById(div)) {
            return false;
        }
        this.div = div;
        this.get_line_data();
    },
    get_line_data: function () {
        var th = this;
        $.ajax({
            type: "POST",
            url: "out_table.php",
            data: "class_name=FinanceActData&request_mode=out_report_mode&entity_suffix=_account&report_name=balance_chart&result_type=json",
            dataType: "json",
            success: function (data) {

                for (var i = 0; i < data.dataProvider.length; i++) {
                    var arr = data.dataProvider[i].month_date_point.split('.');
                    data.dataProvider[i].month_date_point = new Date(arr[1], arr[0], 1);
                }

                th.chart = new AmCharts.AmSerialChart();
                th.chart.categoryField = "month_date_point";
                th.chart.dataProvider = data.dataProvider;

                th.chart.pathToImages = "/jscripts/images/";
                th.chart.startDuration = 0.5;
                th.chart.zoomOutButton = {
                    backgroundColor: '#000000',
                    backgroundAlpha: 0.15
                };
                th.chart.balloon.bulletSize = 5;

                
                th.chart.addListener("dataUpdated", function () {
                    th.chart.zoomToIndexes(th.chart.dataProvider.length - 40, th.chart.dataProvider.length - 1);
                });

                // AXES
                // category
                var categoryAxis = th.chart.categoryAxis;
                categoryAxis.parseDates = true; // as our data is date-based, we set parseDates to true
                categoryAxis.minPeriod = "MM"; // our data is daily, so we set minPeriod to DD
                categoryAxis.dashLength = 1;
                categoryAxis.gridAlpha = 0.15;
                categoryAxis.position = "top";
                categoryAxis.axisColor = "#DADADA";

                // value                
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.axisAlpha = 0;
                valueAxis.dashLength = 1;
                th.chart.addValueAxis(valueAxis);




                // GRAPH
                var graph = new AmCharts.AmGraph();
                graph.title = "Расходы";
                graph.valueField = "month_outcome";
                graph.bullet = "round";
                graph.bulletBorderColor = "#FFFFFF";
                graph.bulletBorderThickness = 2;
                graph.lineThickness = 2;
                graph.lineColor = "#FF0F00";
                graph.negativeLineColor = "#FF0F00";
                graph.hideBulletsCount = 50; // th makes the chart to hide bullets when there are more than 50 series in selection
                th.chart.addGraph(graph);

                // GRAPH
                var graph = new AmCharts.AmGraph();
                graph.title = "Доходы";
                graph.valueField = "month_income";
                graph.bullet = "round";
                graph.bulletBorderColor = "#FFFFFF";
                graph.bulletBorderThickness = 2;
                graph.lineThickness = 2;
                graph.lineColor = "green";
                graph.negativeLineColor = "green";
                graph.hideBulletsCount = 50; // th makes the chart to hide bullets when there are more than 50 series in selection
                th.chart.addGraph(graph);

                var graph = new AmCharts.AmGraph();
                graph.title = "Сумма";
                graph.valueField = "month_summ";
                graph.bullet = "round";
                graph.bulletBorderColor = "#FFFFFF";
                graph.bulletBorderThickness = 2;
                graph.lineThickness = 2;
                graph.lineColor = "blue";
                graph.negativeLineColor = "blue";
                graph.hideBulletsCount = 50; // th makes the chart to hide bullets when there are more than 50 series in selection
                th.chart.addGraph(graph);

                // CURSOR
                chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorPosition = "mouse";
                chartCursor.pan = true; // set it to fals if you want the cursor to work in "select" mode
                th.chart.addChartCursor(chartCursor);

                // SCROLLBAR
                var chartScrollbar = new AmCharts.ChartScrollbar();
                th.chart.addChartScrollbar(chartScrollbar);

                // LEGEND
                var legend = new AmCharts.AmLegend();
                legend.bulletType = "round";
                legend.equalWidths = false;
                legend.valueWidth = 120;
                legend.color = "#000000";
                th.chart.addLegend(legend);

                th.chart.write(th.div);
            }
        });
    }

}