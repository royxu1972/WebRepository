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
            $("h3[id]").click(function () {
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

                <div id="main_list" class="row">
                    <div class="col-md-12 well_field">

                        <h3 id="model"><a href='#' class="none_dec"><i class="icon-chevron-right"></i> model</a></h3>
                        <p> Model Studies on identifying the parameters, values, and the interrelations
                            of parameters of SUT. </p>
                        <p><a href="#" class="none_dec"><span class="label label-danger">learn more...</span></a></p>
                        <br/>

                        <h3 id="generation"><a href='#' class="none_dec"><i class="icon-chevron-right"></i> geneartion</a></h3>
                        <p> Generation studies on generating a small test suite effectively.
                            As the minimum size is unknown, so methods have focused on fnding CAs that
                            have as few test cases as possible. Mathematical and computational methods are both used.
                            The former one can yield the best possible CAs in certain cases,
                            but its application is restrict to sets of factors.
                            Hence, computational methods, which primarily use greedy strategies or
                            search techniques to generate any types of CA, have dominated the literates.</p>
                        <p><a href="#" class="none_dec"><span class="label label-danger">learn more...</span></a></p>
                        <br/>

                        <h3 id="constraint"><a href='#' class="none_dec"><i class="icon-chevron-right"></i> constraint</a></h3>
                        <p> Constraints studies on avoiding invalid test cases in the test suite generation. </p>
                        <p><a href="#" class="none_dec"><span class="label label-danger">learn more...</span></a></p>
                        <br/>

                        <h3 id="prioritization"><a href='#' class="none_dec"><i class="icon-chevron-right"></i> prioritization</a></h3>
                        <p> the prioritization of the test suite.</p>
                        <p><a href="#" class="none_dec"><span class="label label-danger">learn more...</span></a></p>
                        <br/>

                        <h3 id="diagnosis"><a href='#' class="none_dec"><i class="icon-chevron-right"></i> fault diagnosis</a></h3>
                        <p> Failure characterization and diagnosis studies on fixing the detected faults.</p>
                        <p><a href="#" class="none_dec"><span class="label label-danger">learn more...</span></a></p>
                        <br/>

                        <h3 id="evaluation"><a href='#' class="none_dec"><i class="icon-chevron-right"></i> evaluation</a></h3>
                        <p> Evaluation and metric studies on measuring the combination coverage of CT and the
                            effectiveness of fault detection, and the degree to which CT contributes
                            to the improvement of software quality. </p>
                        <p><a href="#" class="none_dec"><span class="label label-danger">learn more...</span></a></p>
                        <br/>

                        <h3 id="application"><a href='#' class="none_dec"><i class="icon-chevron-right"></i> application</a></h3>
                        <p> Application studies on practical testing procedure for CT and reporting
                            the results of the CT application. </p>
                        <p><a href="#" class="none_dec"><span class="label label-danger">learn more...</span></a></p>
                        <br/>

                        <h3 id="survey"><a href='#' class="none_dec"><i class="icon-chevron-right"></i> survey</a></h3>
                        <p> Survey summarizes the current researches in CT.</p>
                        <p><a href="#" class="none_dec"><span class="label label-danger">learn more...</span></a></p>
                        <br/>

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
