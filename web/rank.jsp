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

    <title>Rank</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/font-awesome.min.css">
    <link rel="stylesheet" href="./css/repository.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <%@ page import="java.sql.*" %>
    <%
        // search table paper
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper", "wayne", "123456");
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String sql = "select *, TSE*5 + TOSEM*5 + ESE*3 + IST*3 + JSS*3 + STVR*3 + FSE*5 + ICSE*5 + ASE*5 + ISSRE*3 + ISSTA*3 + ICSM*3 + Other as score from paper.rank order by score desc limit 50";
        ResultSet rs = stmt.executeQuery(sql);
    %>

    <script src="./js/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // template
            $("#nav_content").html("Publication");
            $("#nav_publication").addClass("active");
            $("#c_rank").addClass("active");
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
                <jsp:param name="para" value="rank"/>
            </jsp:include>

            <!-- data part -->
            <div class="col-md-10">
                <h4>Top 50 Scholars</h4>
                <table id='atable' class='table listtable table-hover'>
                    <tr>
                        <th>Rank</th>
                        <th>Author</th>
                        <th>TSE</th>
                        <th>TOSEM</th>
                        <th>ESE</th>
                        <th>IST</th>
                        <th>JSS</th>
                        <th>STVR</th>
                        <th>FSE</th>
                        <th>ICSE</th>
                        <th>ASE</th>
                        <th>ISSRE</th>
                        <th>ISSTA</th>
                        <th>ICSM</th>
                        <th>Other</th>
                        <th>Sum</th>
                        <th>Score</th>
                    </tr>
                    <% int i = 1;
                        while (rs.next()) {
                            out.println("<tr><td>" + i + "</td>" +
                                    "<td>" + rs.getString(1) + "</td>" +
                                    "<td>" + rs.getString(2) + "</td>" +
                                    "<td>" + rs.getString(3) + "</td>" +
                                    "<td>" + rs.getString(4) + "</td>" +
                                    "<td>" + rs.getString(5) + "</td>" +
                                    "<td>" + rs.getString(6) + "</td>" +
                                    "<td>" + rs.getString(7) + "</td>" +
                                    "<td>" + rs.getString(8) + "</td>" +
                                    "<td>" + rs.getString(9) + "</td>" +
                                    "<td>" + rs.getString(10) + "</td>" +
                                    "<td>" + rs.getString(11) + "</td>" +
                                    "<td>" + rs.getString(12) + "</td>" +
                                    "<td>" + rs.getString(13) + "</td>" +
                                    "<td>" + rs.getString(14) + "</td>" +
                                    "<td>" + rs.getString(15) + "</td>" +
                                    "<td>" + rs.getString(16) + "</td></tr>");
                            i++;
                        }%>
                </table>
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

<script src="./js/bootstrap.min.js"></script>
</body>
</html>