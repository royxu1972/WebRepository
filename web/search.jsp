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

    <title>Repository Search</title>
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap3.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/repository.css">

    <script src="js/jquery.js"></script>
    <script src="js/combjs.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // press enter button
            $("#search_content").keypress(function (ee) {
                if(ee.which == 13) {
                    $("#sbtn").click();
                    return false ;
                }
            });
            // search click
            $("#sbtn").click(function () {
                str = $("#search_content").val().trim();
                if (str == "") {
                    $('#myModal').modal('show');
                    return;
                }
                var para = "content=" + str;
                search_now = str;
                search_type = "index";
                //alert(para);
                $.ajax({
                    // 请求的url
                    url: "searchAction.action",
                    // 发送方式
                    type: "post",
                    // 接受数据格式
                    dataType: "json",
                    // 参数
                    data: para,
                    // 回传函数
                    success: showsearh
                });
            });
        });
    </script>

    <%@ page import="java.util.*" %>
    <%@ page import="java.sql.*" %>
    <%
        // search table paper
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper", "root", "123456");
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String sql = "select * from paper.list";
        ResultSet rs = stmt.executeQuery(sql);
        //获取记录总数
        rs.last();
        int RowCount = rs.getRow();
    %>
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
                <jsp:param name="para" value="index"/>
            </jsp:include>

            <!-- data part -->
            <div class="col-md-10">

                <!-- search 1 -->
                <div id="sh1" class="row well_search1">
                    <div class="col-md-12">
                        <h3>All <span class="label label-success main_label">
                        <%=RowCount%></span> relevant publications are included</h3>
                    </div>
                </div>

                <!-- search 2 -->
                <div id="sh2" class="row well_search2">
                    <div class="col-md-10">
                        <form role="form">
                            <div class="form-group">
                                <input class="form-control" id="search_content" size="16"
                                       placeholder="author, title, publication, ..." type="text">
                                <input type="hidden" id="ad_order" value="year">
                            </div>
                        </form>
                    </div>
                    <div class="col-md-2">
                        <button id="sbtn" type="button" class="btn btn-primary search_btn">Search</button>
                    </div>
                </div>

                <!-- advanced option
                <div class="row well-search2">
                     <div class="col-md-12">
                         <p id="advop"><a href="#">advanced options</a></p>
                         <div id="advanced" style="display:none">
                            <div class="input-group">
                            <span class="add-on">Author</span><input id="ad_author" size="16" type="text">
                            </div>
                            <div class="input-prepend">
                            <span class="add-on">Year</span><input id="ad_year" size="16" type="text">
                            </div>
                         </div>
                     </div>
                </div>-->

                <!-- bread crumb -->
                <!-- only display sta -->
                <div id="pa" style="display:none" class="row-fluid">
                    <div id="sta" class="col-md-6"></div>
                </div>

                <!-- table -->
                <div id="result_list" style="display:none" class="row">
                    <div class="col-md-12">
                        <table id='rstable' class='table listtable'></table>
                    </div>
                </div>

                <!-- pagination -->
                <div id="search_page" style="display:none;text-align:center">
                    <ul class="pagination">
                        <li id="search_page_pre" class="disabled"><a href="#">&laquo;</a></li>
                        <li id="search_page_nxt"><a href="#">&raquo;</a></li>
                    </ul>
                </div>

                <!-- none -->
                <div id="search_none" style="display:none;padding-left:60px" class="row">
                    <div class="alert alert-warning">
                        <h4 class="alert-heading">No relevant papers are found in our database</h4>
                        please change your key word or see the "All" in paper list
                    </div>
                </div>

            </div>
            <!-- span10 -->
        </div>
    </div>
    <!-- /container -->

</div>
<!-- /wrap -->

<!-- footer -->
<jsp:include page="template_bottom.jsp"/>

<!-- modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Attention</h4>
            </div>
            <div class="modal-body">
                <p>The input text of search form cannot be empty</p>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn btn-danger" data-dismiss="modal">OK</a>
            </div>
        </div>
    </div>
</div>

<script src="js/bootstrap3.js"></script>
</body>
</html>