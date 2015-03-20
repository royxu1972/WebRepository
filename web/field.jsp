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
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/repository.css">


    <script src="./js/jquery.min.js"></script>
    <script src="./js/comb.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // search field id
            $("h3[id]").click(function () {
                var para = "content=" + $(this).attr("id") + "&group=field";
                search_now = $(this).attr("id");
                search_type = "field";
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

                <!-- waiting -->
                <div id="wait" style="display:none" class="row">
                    <div class="col-md-12 text-center">
                        <h1><i class="fa fa-spinner fa-pulse fa-lg"></i></h1><br>
                        <h4><h4>keep calm and data is loading ...</h4></h4>
                    </div>
                </div>

                <div id="main_list" class="row">
                    <div class="col-md-12 well_field">

                        <h3 id="model"><a href='#' class="none_dec"><i class="fa fa-pencil-square-o fa-fw"></i> model</a></h3>
                        <p> Modeling focuses on identifying parameters, values, and interactions and relations
                            of software under test. It is the fundamental activity of combinatorial testing.</p>
                        <br>

                        <h3 id="generation"><a href='#' class="none_dec"><i class="fa fa-cogs fa-fw"></i> generation</a></h3>
                        <p> Generation is the most popular research field in combinatorial testing.
                            As the minimum size of a covering array is unknown,
                            so proposed methods all focused on finding a covering array that
                            have as few test cases as possible.
                            Mathematical and computational methods are both used.
                            The former one can yield the best possible covering arrays in certain cases,
                            but its application is restrict to sets of factors.
                            Hence, computational methods, which primarily use greedy strategies or
                            search techniques to generate any types of covering array, have dominated the literates.</p>
                        <br>

                        <h3 id="constraint"><a href='#' class="none_dec"><i class="fa fa-puzzle-piece fa-fw"></i> constraint</a></h3>
                        <p> Constraint depicts the dependencies among parameters.
                            As invalid combinations will prevent the execution of certain test cases,
                            the constraint must be addressed to maintain the effectiveness
                            of combinatorial testing.</p>
                        <br>

                        <h3 id="prioritization"><a href='#' class="none_dec"><i class="fa fa-sort fa-fw"></i> prioritization</a></h3>
                        <p> Test suite prioritization can help reorder the test
                            sequence to meet predefined metrics. By assigning different
                            weights to different combinations, we can ensure that important test cases
                            are tested before the testing is terminated after running a subset of the
                            test suite.</p>
                        <br>

                        <h3 id="diagnosis"><a href='#' class="none_dec"><i class="fa fa-bug fa-fw"></i> fault diagnosis</a></h3>
                        <p> Applying combinatorial testing can guarantee all failures
                            that are caused by a fixed number of parameters to be detected,
                            but it cannot identify the concrete failure causing combinations.
                            When a fault is exposed, the diagnosis process is desired
                            to locate and remove the fault.</p>
                        <br>

                        <h3 id="evaluation"><a href='#' class="none_dec"><i class="fa fa-area-chart fa-fw"></i> evaluation</a></h3>
                        <p> Evaluation and metric studies on measuring the combination coverage of CT and the
                            effectiveness of fault detection, and the degree to which CT contributes
                            to the improvement of software quality. </p>
                        <br>

                        <h3 id="application"><a href='#' class="none_dec"><i class="fa fa-wrench fa-fw"></i> application</a></h3>
                        <p> Application contains practical testing procedures on different types of software systems.
                            The quantity and variety of applications are good indicators to reflect the popularity
                            of different testing methods. In combinatorial testing, the application is the second most
                            popular research eld
                        </p>
                        <br>

                        <h3 id="survey"><a href='#' class="none_dec"><i class="fa fa-bookmark fa-fw"></i> survey</a></h3>
                        <p>The survey of combinatorial testing, or some sub fields.</p>
                        <br>
                        <br><br>
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

<script src="./js/bootstrap.min.js"></script>
</body>
</html>
