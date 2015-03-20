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

    <title>Publication</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/font-awesome.min.css">
    <link rel="stylesheet" href="./css/repository.css">
    

    <script src="./js/jquery.min.js"></script>
    <script src="./js/comb.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("dd[id]").click(function () {
                var para = "content=" + $(this).attr("id") + "&group=author";
                search_now = $(this).attr("id");
                search_type = "author";
                $("#wait").show();
                $("#main_list").hide();
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
                <jsp:param name="para" value="author"/>
            </jsp:include>


            <!-- show -->
            <div class="col-md-10 list_col">
                <!-- bread crumb -->
                <div id="pa" style="display:none" class="row">
                    <div class="col-md-12">
                        <ul class="breadcrumb">
                            <li id="pa_main">author</li>
                            <li id="pa_name"></li>
                        </ul>
                    </div>

                    <!--div class="col-md-12">
                        <p>-- University, -- Country</p>
                        <p><a href="#">(and a link to google author or personal home page)</a></p>
                        <br>
                    </div-->

                    <div class="col-md-12">
                        <div id="sta"></div>
                    </div>
                </div>

                <!-- waiting -->
                <div id="wait" style="display:none" class="row">
                    <div class="col-md-12 text-center">
                        <h1><i class="fa fa-spinner fa-pulse fa-lg"></i></h1><br>
                        <h4><h4>keep calm and data is loading ...</h4></h4>
                    </div>
                </div>

                <!-- main list -->
                <%@ page import="java.util.*" %>
                <%@ page import="java.sql.*" %>
                <%
                    // search table paper.Author
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper", "wayne", "123456");
                    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    String sql = "select author from paper.listauthor order by author ";
                    ResultSet rs = stmt.executeQuery(sql);
                    String index = "A";
                    boolean first = false;
                %>
                <div id="main_list" class="row">
                    <%
                        out.println("<div class='col-md-4'><h2><span class='label label-success indexlabel'>A</span></h2>");
                        while (rs.next()) {
                            String name = rs.getString(1);

                            while (!name.substring(0, 1).equals(index)) {
                                index = name.substring(0, 1);
                                if (first)
                                    out.println("</div>");
                                out.println("<div class='col-md-4'><h2><span class='label label-success indexlabel'>" + index + "</span></h2>");
                            }
                            out.println("<dd id='" + name + "'><a href='#'>" + name + "</a></dd>");
                            first = true;
                        }
                        out.println("</div>");
                    %>
                </div>

                <!-- paper list -->
                <div id="result_list" style="display:none" class="row">
                    <div class="col-md-12">
                        <table id='rstable' class='table listtable'>
                            <!--<tr><th>author</th><th>title</th><th>pub</th><th>year</th></tr> -->
                        </table>
                    </div>
                </div>

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

<script src="./js/bootstrap.min.js"></script>
</body>
</html>
