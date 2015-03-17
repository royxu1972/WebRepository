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

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="./js/jquery.min.js"></script>
    <script src="./js/comb.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // search field id
            $("p[id]").click(function () {
                var para = "content=" + $(this).attr("id") + "&group=pub";
                search_now = $(this).text();
                search_type = "publication";
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

                    <div>
                        <div id="sta" class="col-md-6"></div>
                        <div class="col-md-6">
                        </div>
                    </div>
                </div>

                <!-- waiting -->
                <div id="wait" style="display:none" class="row">
                    <div class="col-md-12 text-center">
                        <h1><i class="fa fa-spinner fa-pulse fa-lg"></i></h1><br>
                        <h4>keep calm and data is loading ...</h4>
                    </div>
                </div>

                <!-- main list -->
                <%@ page import="java.sql.*" %>
                <%
                    // search table paper.Author
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper", "wayne", "123456");
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

<script src="./js/bootstrap.min.js"></script>
</body>
</html>
