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

    <title>Repository Search</title>
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
            // press enter button
            $("#search_content").keypress(function (ee) {
                if(ee.which == 13) {
                    $("#sbtn").click();
                    return false ;
                }
            });
            // search click
            $("#sbtn").click(function () {
                var str = $("#search_content").val().trim();
                if (str == "") {
                    $('#myModal').modal('show');
                    return;
                }
                var para = "content=" + str;
                search_now = str;
                search_type = "index";
                $("#wait").show();
                $("#sh1").hide();
                $("#sh2").hide();
                $.ajax({
                    url: "searchAction.action",
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
                <jsp:param name="para" value="index"/>
            </jsp:include>

            <!-- -->
            <div class="col-md-9 col-md-offset-1">
                <!-- search 1 -->
                <div id="sh1" class="well_search1">
                    <h3>All <span class="label label-success main_label">
                        319</span> relevant publications are included</h3>
                </div>

                <!-- search 2 -->
                <div id="sh2" class="well_search2">
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
            </div>

            <!-- data part -->
            <div class="col-md-10">
                <!-- bread crumb -->
                <!-- only display sta -->
                <div id="pa" style="display:none" class="row-fluid">
                    <div id="sta" class="col-md-12"></div>
                </div>

                <!-- waiting -->
                <div id="wait" style="display:none" class="row">
                    <div class="col-md-12 text-center">
                        <h1><i class="fa fa-spinner fa-pulse fa-lg"></i></h1><br>
                        <h4><h4>keep calm and data is loading ...</h4></h4>
                    </div>
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
                        <p>please change your key words, or click <em>All</em> for the whole paper list<p>
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

<script src="./js/bootstrap.min.js"></script>
</body>
</html>