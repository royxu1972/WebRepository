<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>  
<!DOCTYPE html>
<html>
<head> 
<!-- Publication main -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="wayne">
    
<title>Publication</title>
<!-- customized css -->
<jsp:include page="template_css.jsp"/>

<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<%
// search year count
Class.forName("com.mysql.jdbc.Driver").newInstance();  
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper","root","123456");  
Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);  
String sql1 = "select * from paper.cumulative";
ResultSet rs1 = stmt.executeQuery(sql1);
// rs1 result
String firstyear = "", lastyear = "" ;
String yearindex = "";
String annual = "";
String cumulative = "";
rs1.next();
firstyear = lastyear = rs1.getString(1);
yearindex = "'" + rs1.getString(1) + "'," ;
annual = rs1.getString(2) + "," ;
cumulative = rs1.getString(3) + "," ;
while(rs1.next()) {
	yearindex = yearindex + "'" + rs1.getString(1) + "'," ;
	annual = annual + rs1.getString(2) + "," ;
	cumulative = cumulative + rs1.getString(3) + "," ;
	lastyear = rs1.getString(1) ;
}
yearindex = yearindex.substring(0, yearindex.length()-1);
annual = annual.substring(0, annual.length()-1);
cumulative = cumulative.substring(0, cumulative.length()-1);
rs1.close();

// search fielf count
String sql2 = "select * from paper.fieldcount";
ResultSet rs2 = stmt.executeQuery(sql2);
String[] field = new String[8] ;
rs2.absolute(5); field[0] = rs2.getString(2);  // generation
rs2.absolute(1); field[1] = rs2.getString(2);  // application
rs2.absolute(4); field[2] = rs2.getString(2);  // fault
rs2.absolute(3); field[3] = rs2.getString(2);  // evaluation
rs2.absolute(2); field[4] = rs2.getString(2);  // constraint
rs2.absolute(9); field[5] = rs2.getString(2);  // prioritization
rs2.absolute(6); field[6] = rs2.getString(2);  // model
int sum = 0 ; // others
rs2.absolute(7); sum += Integer.parseInt(rs2.getString(2));
rs2.absolute(8); sum += Integer.parseInt(rs2.getString(2));
rs2.absolute(10); sum += Integer.parseInt(rs2.getString(2));
field[7] = Integer.toString( sum );
rs2.close();

// search top 3 count
String gen = "" ;
String app = "" ;
String loc = "" ;
String sql3 = "select * from paper.topthree";
ResultSet rs3 = stmt.executeQuery(sql3);
while( rs3.next() ) {
	if( rs3.getString(2) == null )
		gen = gen + "0," ;
	else
		gen = gen + rs3.getString(2) + "," ;
	
	if( rs3.getString(3) == null )
		app = app + "0," ;
	else
		app = app + rs3.getString(3) + "," ;
	
	if( rs3.getString(4) == null )
		loc = loc + "0," ;
	else
		loc = loc + rs3.getString(4) + "," ;
}
gen = gen.substring(0, gen.length()-1);
app = app.substring(0, app.length()-1);
loc = loc.substring(0, loc.length()-1);
rs3.close();
stmt.close();
%>


<script src="js/jquery.js"></script>
<script type="text/javascript">
$(function () {
    var chart1 ;
    var chart2 ;
    var chart3 ;
    
    $("#show_c1").click(function() {  
    	$("#btngroup").hide();
    	$("#back_home").html("<a href='/statistic.jsp'>statistic</a>");
    	$("#current").html("<span class='divider'>/</span>number of publication");
    	$("#pbread").show();
    	$("#container-chart").show();
    	
    	chart1 = new Highcharts.Chart({
            chart: {
                renderTo: 'container-chart',
                type: 'line',
            },
            title: {
                text: 'The Number of Publications in the Year from <%=firstyear%> to <%=lastyear%>',
                x: -20 //center 
            },
            subtitle: {
                text: null
            },
            xAxis: {
                categories: [<%=yearindex%>]
            },
            yAxis: {
                title: {
                    text: null 
                },
                allowDecimals: false,
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +' num: '+ this.y ;
                }
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: false
                    },
                    enableMouseTracking: true
                }
            },
            series: [{
                name: 'Annual',
                data: [<%=annual%>]
            }, {
                name: 'Cumulative',
                data: [<%=cumulative%>]
            }]
        });
    }); // end $(#show_c1) 
    

    $("#show_c2").click(function () {
    	
    	$("#btngroup").hide();
    	$("#back_home").html("<a href='/statistic.jsp'>statistic</a>");
    	$("#current").html("<span class='divider'>/</span>ratio of field");
    	$("#pbread").show();
    	$("#container-chart").show();
    	
    	chart3 = new Highcharts.Chart({
        	chart: {
                renderTo: 'container-chart',
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: 'The Ratio of CT Research Fields'
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage}%</b>',
            	percentageDecimals: 1
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            },
            series: [{
                type: 'pie',
                name: 'ratio' ,
                data: [ 
                    ['Generation', <%=field[0]%>],   
                    {
                    	name: 'Application',
                    	y: <%=field[1]%>,
                        sliced: true,
                        selected: true
                    },
                    ['Fault', <%=field[2]%>],
                    ['Evaluation', <%=field[3]%>],   
                    ['Constraint', <%=field[4]%>],
                    ['Prioritization', <%=field[5]%>],
                    ['Model', <%=field[6]%>],
                    ['Others', <%=field[7]%>]  
                ]
            }]
        });
    });// end $(#show_c2) 
    
    
    $("#show_c3").click(function () {
    	
    	$("#btngroup").hide();
    	$("#back_home").html("<a href='/statistic.jsp'>statistic</a>");
    	$("#current").html("<span class='divider'>/</span>number of field");
    	$("#pbread").show();
    	$("#container-chart").show();
   	
    	chart3 = new Highcharts.Chart({
    		chart: {
                renderTo: 'container-chart',
                type: 'column'
            },
            title: {
                text: 'The Annual Number of CT Top Three Research Fields'
            },
            xAxis: {
                categories: [<%=yearindex%>]                   
            },
            yAxis: {
                title: {
                    text: null 
                }
            },
            tooltip: {
                formatter: function() {
                    return ''+
                        this.series.name +': '+ this.y +'';
                }
            },
            credits: {
                enabled: false
            },
            series: [{
                name: 'Generation',
                data:  [<%=gen%>]
            }, {
                name: 'Application',
                data: [<%=app%>]
            }, {
                name: 'Fault',
                data: [<%=loc%>]
            }]
        });
    });

});

</script>
</head>

<body>
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
            
            <div id="btngroup" style="text-align:center" class="row">
                <div class="col-md-1"></div>
                
                <div class="col-md-3">
                <div id="show_c1"><a href="#" class="thumbnail"><img src="image/chart_area.png"/></a></div>
                <h4>Number of Publication</h4>
                <p>The Number of Publications in the Year from <%=firstyear%> to <%=lastyear%></p>
                </div>
                
                <div class="col-md-1"></div>

                <div class="col-md-3">
                <div id="show_c2"><a href="#" class="thumbnail"><img src="image/chart_pie.png"/></a></div>
                <h4>Ratio of Field</h4>
                <p>The Ratio of CT Research Fields</p>
                </div>
                
                <div class="col-md-1"></div>
                
                <div class="col-md-3">
                <div id="show_c3"><a href="#" class="thumbnail"><img src="image/chart_bar.png"/></a></div>
                <h4>Number of Field</h4>
                <p>The Ratio of CT Research Fields Annual</p>
                </div>
            </div>

            <div class="row">
            <div class="col-md-12" id="container-chart" style="display:none; min-width: 400px; height: 400px; margin: 0 auto"></div>
            </div>

        </div>   <!-- span10 -->       
    </div>

    <hr>
    <div class="footer">
      <p>&copy; Company 2012</p>
    </div>
    
</div> <!-- /container -->

<script src="js/bootstrap3.js"></script>
<script src="js/highcharts.js"></script>
</body>
</html>