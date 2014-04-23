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
    <!-- customized css -->
    <jsp:include page="template_css.jsp"/>
    <style type="text/css">
        .wellfield {
            padding-top: 40px;
            text-align: center;
        }
    </style>

    <script src="js/jquery.js"></script>
    <script src="js/combjs.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // search field id
            $("h4[id]").click(function () {
                var para = "content=" + $(this).attr("id") + "&group=field";
                search_now = $(this).attr("id");
                search_type = "field";
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
                <jsp:param name="para" value="field"/>
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

                    <div>
                        <div id="sta" class="col-md-6"></div>
                        <div class="col-md-6">
                        </div>
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
                    String sql = "select field from paper.fieldcount";
                    ResultSet rs = stmt.executeQuery(sql);
                %>
                <div id="main_list" class="row">
                    <div class="col-md-12 wellfield">
                        <%
                            while (rs.next()) {
                                String name = rs.getString(1);
                                out.println("<h4 class='col-md-3' id='" + name + "'><a href='#'>" + name + "</a></h4>");
                            }
                        %>
                    </div>
                </div>
                <!-- main_list -->

                <!-- result list -->
                <div id="result_list" style="display:none" class="row">
                    <div class="col-md-12">
                        <table id='rstable' class='table listtable'>
                            <!--<tr><th>author</th><th>title</th><th>pub</th><th>year</th></tr>-->
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
<jsp:include page="template_bottom.jsp"/>

<script src="js/bootstrap3.js"></script>
</body>
</html>
