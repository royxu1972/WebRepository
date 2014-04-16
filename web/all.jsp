<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>  
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

<script src="js/jquery.js"></script>
<script src="js/combjs.js"></script>
<script type="text/javascript">
// search all content 
$(document).ready(function() {
	var para = "content=wholepaper&type=all" ;
	search_now = "wholepaper" ;
	search_type = "all" ;
	$.ajax({  
		// 请求的url 
		url : "contentAction.action",  
		// 发送方式  
		type : "post",
		// 接受数据格式  
		dataType : "json",
		// 参数 
		data: para ,
		// 回传函数  
		success : showsearh
	}); 	
});
</script>
</head>

<body>
<!-- top navigation -->
<jsp:include page="template_top.jsp"/>

<div class="container">
    <br/><br/>
    <br/><br/>

    <div class="row">
        <!-- list part -->
        <jsp:include page="template_navlist.jsp">
        <jsp:param name="para" value="all"/>
        </jsp:include>
        
        <!-- show -->
        <div class="col-md-10">
            <!-- bread crumb -->
            <!-- only display sta -->
            <div id="pa" style="display:none" class="row-fluid">
            <div class="row">
                 <div id="sta" class="col-md-6"></div>
                 <div class="col-md-6">
                 <button id="downbtn" class="btn btn-xs btn-info pull-right">Cite Export</button>
                 </div>
                 </div>
            </div>
             
            <!-- all list -->
            <div id="result_list" style="display:none" class="row">
            <div class="col-md-12">
                <table id='rstable' class='table listtable'>
                <tr><th>author</th><th>title</th><th>pub</th><th>year</th>
                <!--  <th>type</th><th>area</th> -->
                </tr>
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
         
        </div> <!-- span10 -->    
    </div>

    <hr>
    <div class="footer">
      <p>&copy; Company 2012</p>
    </div>
</div> <!-- /container -->

<script src="js/bootstrap3.js"></script>
</body>
</html>
