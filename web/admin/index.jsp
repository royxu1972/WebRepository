<!-- database management -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="wayne">

    <title>Management</title>
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="/css/bootstrap3.css">
    <link rel="stylesheet" type="text/css" href="/css/repository.css">

    <script src="/js/jquery.js"></script>
    <script src="admin.js"></script>
    <script type="text/javascript">
        // search all content for management
        $(document).ready(function () {
            var para = "content=all&group=all";
            search_now = "all";
            search_type = "all";
            $.ajax({
                url: "contentAction.action",
                type: "post",
                dataType: "json",
                data: para,
                success: showsearh_manage
            });
        });
    </script>
</head>

<body>
<div>
<br/><br/><br/><br/>

    <div class="col-md-12">
        <div id="result_list" style="display:none" class="row">
            <table id='rstable' class='table table-bordered table-responsive'>
                <!-- id, bib, type, year, author, title, publication, [abbr], [vol], [no], [pages], field, [doi], [abstract] -->
                <tr><th>#</th><th>bib</th><th>type</th><th>year</th><th>author</th>
                <th>title</th><th>publication</th><th>abbr</th><th>vol</th><th>no</th><th>page</th><th>field</th>
                <th>doi</th><th>abstract</th></tr>
            </table>
        </div>
    </div>

</div>
<!-- /container -->



<script src="/js/bootstrap3.js"></script>
</body>
</html>
