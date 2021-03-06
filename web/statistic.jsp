<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Publication main -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="combinatorial testing repository">
    <meta name="keywords" content="repository, combinatorial testing, software testing, publication, research, paper">
    <meta name="author" content="huayao">

    <title>Statistic</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/font-awesome.min.css">
    <link rel="stylesheet" href="./css/repository.css">



<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
    // search year count
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper", "wayne", "123456");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    String sql1 = "select * from paper.cumulative";
    ResultSet rs1 = stmt.executeQuery(sql1);
    // rs1 result
    String firstyear = "";
    String lastyear = "";
    String yearindex = "";
    String annual = "";
    String cumulative = "";
    rs1.next();
    firstyear = lastyear = rs1.getString(1);
    yearindex = "'" + rs1.getString(1) + "',";
    annual = rs1.getString(2) + ",";
    cumulative = rs1.getString(3) + ",";
    while (rs1.next()) {
        yearindex = yearindex + "'" + rs1.getString(1) + "',";
        annual = annual + rs1.getString(2) + ",";
        cumulative = cumulative + rs1.getString(3) + ",";
        lastyear = rs1.getString(1);
    }
    yearindex = yearindex.substring(0, yearindex.length() - 1);
    annual = annual.substring(0, annual.length() - 1);
    cumulative = cumulative.substring(0, cumulative.length() - 1);
    rs1.close();

    // search field count
    String sql2 = "select * from paper.fieldcount order by count DESC";
    ResultSet rs2 = stmt.executeQuery(sql2);
    rs2.last();
    int row_num = rs2.getRow();
    String[] field_name = new String[row_num];
    String[] field = new String[row_num];
    for (int i = 0; i < row_num; i++) {
        rs2.absolute(i + 1);
        field_name[i] = rs2.getString(1);
        field[i] = rs2.getString(2);
    }
    rs2.close();

    // search top 3 count
    String gen = "";
    String app = "";
    String loc = "";
    String sql3 = "select * from paper.topthree";
    ResultSet rs3 = stmt.executeQuery(sql3);
    while (rs3.next()) {
        if (rs3.getString(2) == null)
            gen = gen + "0,";
        else
            gen = gen + rs3.getString(2) + ",";

        if (rs3.getString(3) == null)
            app = app + "0,";
        else
            app = app + rs3.getString(3) + ",";

        if (rs3.getString(4) == null)
            loc = loc + "0,";
        else
            loc = loc + rs3.getString(4) + ",";
    }
    gen = gen.substring(0, gen.length() - 1);
    app = app.substring(0, app.length() - 1);
    loc = loc.substring(0, loc.length() - 1);
    rs3.close();
    stmt.close();
%>

<script src="./js/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(function () {
        var chart1;
        var chart2;
        var chart3;

        $("#show_c1").click(function () {
            $("#btn_group").hide();
            $("#back_home").html("<a href='./statistic.jsp'>statistic</a>");
            $("#current").html("<span class='divider'></span>number of publication");
            $("#pbread").fadeIn("slow");
            $("#container-chart").fadeIn("slow");

            $('#container-chart').highcharts({
                title: {
                    text: 'The Number of Publications from <%=firstyear%> to <%=lastyear%>',
                    x: -20 //center
                },
                xAxis: {
                    title: {
                        text: 'year'
                    },
                    categories: [<%=yearindex%>]
                },
                yAxis: {
                    title: {
                        text: '# of publications'
                    },
                    plotLines: [
                        {
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }
                    ],
                    min: 0
                },
                tooltip: {
                    formatter: function () {
                        return '<b>' + this.series.name + '</b><br/>' +
                                this.x + ' num: ' + this.y;
                    }
                },
                series: [
                    {
                        name: 'Annual',
                        data: [<%=annual%>]
                    },
                    {
                        name: 'Cumulative',
                        data: [<%=cumulative%>]
                    }
                ]
            });
        }); // end $(#show_c1)


        $("#show_c2").click(function () {
            $("#btn_group").hide();
            $("#back_home").html("<a href='./statistic.jsp'>statistic</a>");
            $("#current").html("<span class='divider'></span>distribution of field");
            $("#pbread").fadeIn("slow");
            $("#container-chart").fadeIn("slow");

            // Make monochrome colors and set them as default for all pies
            Highcharts.getOptions().plotOptions.pie.colors = (function () {
                var colors = [],
                        base = Highcharts.getOptions().colors[0],
                        i

                for (i = 0; i < 8; i++) {
                    // Start out with a darkened base color (negative brighten), and end
                    // up with a much brighter color
                    colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
                }
                return colors;
            }());

            // Build the chart
            $('#container-chart').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false
                },
                title: {
                    text: 'The Distribution of CT Research Fields'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            style: {
                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                            }
                        }
                    }
                },
                series: [
                    {
                        type: 'pie',
                        name: 'Field ratio',
                        data: [
                            {
                                name: '<%=field_name[0]%>',
                                y: <%=field[0]%>,
                                sliced: true,
                                selected: true
                            },
                            <%
                            for( int k=1; k<row_num-1; k++ ) {
                                out.println("['" + field_name[k] + "', " + field[k] + "]," );
                            }
                            %>
                            ['<%=field_name[row_num-1]%>', <%=field[row_num-1]%>]
                        ]
                    }
                ]
            });
        });// end $(#show_c2)


        $("#show_c3").click(function () {
            $("#btn_group").hide();
            $("#back_home").html("<a href='./statistic.jsp'>statistic</a>");
            $("#current").html("<span class='divider'></span>annual publication");
            $("#pbread").fadeIn("slow");
            $("#container-chart").fadeIn("slow");

            $('#container-chart').highcharts({
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'The Annual Publication Number of the Top Three Research Fields'
                },
                xAxis: {
                    categories: [<%=yearindex%>],
                    title: {
                        text: 'year'
                    },
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: '# of publications'
                    },
                    stackLabels: {
                        enabled: false
                    }
                },
                tooltip: {
                    formatter: function () {
                        return '<b>' + this.x + '</b><br/>' +
                                this.series.name + ': ' + this.y;
                    }
                },
                plotOptions: {
                    column: {
                        stacking: 'normal',
                        dataLabels: {
                            enabled: false
                        }
                    }
                },
                series: [
                    {
                        name: 'Generation',
                        data: [<%=gen%>]
                    },
                    {
                        name: 'Application',
                        data: [<%=app%>]
                    },
                    {
                        name: 'Fault Diagnosis',
                        data: [<%=loc%>]
                    }
                ]
            });
        }); // end $(#show_c3)


        $("#show_c4").click(function () {
            var data = [
                {"code": "AU", "value": 2, "name": "Australia"},
                {"code": "AT", "value": 1, "name": "Austria"},
                {"code": "BR", "value": 1, "name": "Brazil"},
                {"code": "CA", "value": 9, "name": "Canada"},
                {"code": "CN", "value": 31, "name": "China"},
                {"code": "HR", "value": 1, "name": "Croatia"},
                {"code": "DK", "value": 2, "name": "Denmark"},
                {"code": "FI", "value": 2, "name": "Finland"},
                {"code": "DE", "value": 3, "name": "Germany"},
                {"code": "IN", "value": 5, "name": "India"},
                {"code": "IE", "value": 1, "name": "Ireland"},
                {"code": "IL", "value": 4, "name": "Israel"},
                {"code": "IT", "value": 4, "name": "Italy"},
                {"code": "JP", "value": 6, "name": "Japan"},
                {"code": "JO", "value": 1, "name": "Jordan"},
                {"code": "LU", "value": 2, "name": "Luxembourg"},
                {"code": "MY", "value": 8, "name": "Malaysia"},
                {"code": "MX", "value": 7, "name": "Mexico"},
                {"code": "NO", "value": 2, "name": "Norway"},
                {"code": "RO", "value": 1, "name": "Romania"},
                {"code": "SA", "value": 1, "name": "Saudi Arabia"},
                {"code": "RS", "value": 1, "name": "Serbia"},
                {"code": "ES", "value": 3, "name": "Spain"},
                {"code": "SE", "value": 2, "name": "Sweden"},
                {"code": "TR", "value": 3, "name": "Turkey"},
                {"code": "GB", "value": 2, "name": "United Kingdom"},
                {"code": "US", "value": 65, "name": "United States of America"},
                {"code": "VN", "value": 1, "name": "Vietnam"}
            ]

            $("#btn_group").hide();
            $("#back_home").html("<a href='./statistic.jsp'>statistic</a>");
            $("#current").html("<span class='divider'></span>researchers in the world");
            $("#pbread").fadeIn("slow");
            $("#container-chart").fadeIn("slow");
            $('#container-chart').highcharts('Map', {
                title : {
                    text : 'The Distribution of Researchers across the World'
                },
                mapNavigation: {
                    enabled: true,
                    enableDoubleClickZoomTo: true
                },
                colorAxis: {
                    min: 0,
                    max: 75,
                    type: 'linear'
                },
                series : [{
                    data : data,
                    mapData: Highcharts.maps['custom/world'],
                    joinBy: ['iso-a2', 'code'],
                    name: 'The number of authors',
                    states: {
                        hover: {
                            color: '#BADA55'
                        }
                    },
                    tooltip: {
                        valueSuffix: ''
                    }
                }]
            });
        });

    });

</script>
</head>

<body>
<!-- Wrap all page content here -->
<div id="wrap">

    <!-- top navigation -->
    <jsp:include page="template_top.jsp"/>

    <div class="container">
        <br/><br/>
        <br/><br/>

        <div class="row">
            <!-- list part -->
            <jsp:include page="template_navlist.jsp">
                <jsp:param name="para" value="statistic"/>
            </jsp:include>

            <!-- show -->
            <div class="col-md-10">

                <div class="row">
                    <div id="pbread" style="display:none" class="col-md-12">
                        <ul class="breadcrumb">
                            <li id="back_home">statistic</li>
                            <li id="current"></li>
                        </ul>
                    </div>
                </div>

                <div id="btn_group" style="text-align:center">
                    <div class = "row">
                        <div class="col-md-3 col-md-offset-1">
                            <div id="show_c1"><a href="#" class="img-thumbnail"><img src="image/chart1.ico"/></a></div>
                            <h4>Number of Publication</h4>
                            <p>The number of publications from <%=firstyear%> to <%=lastyear%></p>
                        </div>

                        <div class="col-md-3 col-md-offset-1">
                            <div id="show_c2"><a href="#" class="img-thumbnail"><img src="image/chart2.ico"/></a></div>
                            <h4>Distribution of Field</h4>
                            <p>The distribution of CT research fields</p>
                        </div>

                        <div class="col-md-3 col-md-offset-1">
                            <div id="show_c3"><a href="#" class="img-thumbnail"><img src="image/chart3.ico"/></a></div>
                            <h4>Annual Publication</h4>
                            <p>The annual publication number of the top three research fields</p>
                        </div>
                    </div>
                    <br>

                    <div class="row">
                        <div class="col-md-3 col-md-offset-1">
                            <div id="show_c4"><a href="#" class="img-thumbnail"><img src="image/chart4.ico"/></a></div>
                            <h4>Researchers in the World (beta version)</h4>
                            <p>The distribution of researchers across the world</p>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12" id="container-chart"
                         style="display:none; min-width: 400px; height: 400px; margin: 0 auto"></div>
                </div>

                <div id="container2"></div>

            </div>
            <!-- span10 -->
        </div>
    </div>
    <!-- /container -->

    <div id="push"></div>
</div>
<!-- /wrap -->

<!-- footer -->
<jsp:include page="template_bottom.jsp"/>

<script src="./js/highcharts.js"></script>
<script src="./js/modules/map.js"></script>
<script src="./js/modules/data.js"></script>
<script src="./js/modules/exporting.js"></script>
<script src="./js/modules/world.js"></script>
</body>
</html>