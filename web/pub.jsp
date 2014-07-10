<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>

<html>
<head>
    <!-- Publication main -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="wayne">

    <title>Publication</title>
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap3.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/repository.css">

    <script src="js/jquery.js"></script>
    <script src="js/combjs.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // search field id
            $("p[id]").click(function () {
                var para = "content=" + $(this).attr("id") + "&group=pub";
                search_now = $(this).text();
                search_type = "publication";
                $.ajax({
                    url: "contentAction.action",
                    type: "post",
                    dataType: "json",
                    data: para,
                    success: showsearh
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
                <jsp:param name="para" value="publication"/>
            </jsp:include>

            <!-- show -->
            <div class="col-md-10 list_col">
                <!-- bread crumb -->
                <div id="pa" style="display:none" class="row">
                    <div class="col-md-12">
                        <ul class="breadcrumb">
                            <li id="pa_main">field</li>
                            <li id="pa_name"></li>
                        </ul>
                    </div>
                </div>

                <!-- main list -->
                <%@ page import="java.util.*" %>
                <%@ page import="java.sql.*" %>
                <%
                    // search table paper.Author
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper", "root", "123456");
                    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    String sql1 = "select * from paper.listpub where type = 'article'";
                    ResultSet rs1 = stmt.executeQuery(sql1);
                %>
                <div id="main_list" class="row">
                    <div class="col-md-12">
                        <h4>Main Journal</h4>
                        <hr>
                        <%
                            while (rs1.next()) {
                                String name = rs1.getString(2);
                                String abbr = rs1.getString(3);
                                out.println("<p id='" + abbr + "'><a href='#'>" + name + " (" + abbr + ")</a></p>");
                            }
                        %>
                        <br/><br/>


                        <h4>Main Conference</h4>
                        <hr>
                        <%
                            String sql2 = "select * from paper.listpub where type = 'inproceedings'";
                            ResultSet rs2 = stmt.executeQuery(sql2);
                            while (rs2.next()) {
                                String name = rs2.getString(2);
                                String abbr = rs2.getString(3);
                                out.println("<p id='" + abbr + "'><a href='#'>" + name + " (" + abbr + ")</a></p>");
                            }
                        %>
                        <br/><br/>

                        <h4>Others</h4>
                        <hr>
                        <p id="phd"><a href="#">Phd thesis</a></p>
                        <p id="book"><a href="#">Book Chapter</a></p>
                        <p id="tech"><a href="#">Technique Report</a></p>
                        <br/><br/>

                    </div>
                </div>
                <!-- main_list -->


                <!-- result list -->
                <div id="result_list" style="display:none" class="row">
                    <div class="col-md-12">
                        <table id='rstable' class='table listtable'>
                        </table>
                    </div>
                </div>
                <!-- result -->

                <!-- pagination -->
                <div id="search_page" style="display:none;text-align:center">
                    <ul class="pagination">
                        <li id="search_page_pre" class="disabled"><a href="#">&laquo;</a></li>
                        <li id="search_page_nxt"><a href="#">&raquo;</a></li>
                    </ul>
                </div>

            </div>
            <!-- span10 -->
        </div>
    </div>
    <!-- /container -->

    <div id="push"></div>
</div>
<!-- /wrap -->

<!-- footer -->
<br/><br/>
<jsp:include page="template_bottom.jsp"/>

<script src="js/bootstrap3.js"></script>
</body>
</html>
