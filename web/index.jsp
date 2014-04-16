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
$(document).ready(function() {	
	// andvanced option show 
	$("#advop").click(function() { 
		$("#advanced").toggle("slow");
	});
	
	// search click 
	$("#sbtn").click(function(){
		str = $("#search_content").val().trim();
		if( str == "" ) {
			$('#myModal').modal('show') ;	
			return ;
		}

		var para = "content=" + str + 
		"&ad_author=" + $("#ad_author").val() +
		"&ad_year=" + $("#ad_year").val() +
		"&ad_order=" + $("#ad_order").val() ;
		//alert(para);
		$.ajax({  
			// 请求的url 
			url : "searchAction.action",  
			// 发送方式  
			type : "post",
			// 接受数据格式  
			dataType : "json",
			// 参数 
			data: para ,
			// 回传函数  
			success : showsearh_index
			}); 
	});	
});

function showsearh_index(data) {
	json = eval( "("+data+")" );
	json_data = data ;

	// nothing 
	if( json == "" ) {
		$("#sh1").hide();
		$("#sh2").hide();
		$("#search_none").show("slow");		
	}
	// results 
	else {
		page = parseInt(( json.length + pagesize - 1 ) / pagesize) ;
		current = 1 ;		
		$("#sh1").hide();
		$("#sh2").hide();
		showpage(json, current);
		
		if( page > 1 ) {
			$("#search_page_pre").addClass("disabled");
			$("#search_page_pre").after("<li id='1' class='active pagecadd'><a href='#'>1 <span class='sr-only'>(current)</span></a></li>");
			for( var i=2 ; i<=page && i<=count ; i++ ) {
				$("#search_page_nxt").before("<li id='"+i+"' class='pagecadd'><a href='#'>"+i+"</a></li>");
			}
			if( page > count ) {
				$("#search_page_nxt").before("<li id='"+page+"' class='pagecadd'><a href='#'>Last</a></li>");
			}
			$("#search_page").show("slow");	
		}
	}
}

function showpage(json, num) {
	$(".added").empty();
	var start = ( num - 1 ) *  pagesize ;
	for(var i = start ; i < start + pagesize && i < json.length ; i++ )    
		$("#stable").append("<tr class='added'><td>" + json[i].author + "</td><td>" +
				json[i].title + "</td><td>" + json[i].publication + "</td><td>" + json[i].year + "</td><td>" ) ;
	$("#sta").html("<p><span class='label label-success'>" + json.length + "</span> papers included</p>");
	$("#shs").show("slow");
	$("#search_list").show("slow");	
}
</script>

<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<%
// search table paper
Class.forName("com.mysql.jdbc.Driver").newInstance();  
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper","root","123456");  
Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);  
String sql = "select * from paper.list";
ResultSet rs = stmt.executeQuery(sql); 
//获取记录总数   
rs.last();  
int RowCount = rs.getRow();  
//记算总页数  
%>

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
        <jsp:param name="para" value="index"/>
        </jsp:include>
        
        <!-- data part -->
        <div class="col-md-10">
        
            <!-- search 1 -->
            <div id="sh1" class="row well-search1">
            <div class="col-md-12">
                <h3>All <span class="label label-success mainlabel"><%=RowCount%></span> relevant publications are included</h3>
            </div>
            <div class="col-md-12">
                <small class="pull-right" style="color:#666666">Last updated on the November 2013</small>
            </div>
            </div>
                  
            <!-- search 2 -->
            <div id="sh2" class="row well-search2">
                    <div class="col-md-10">
                        <form role="form">
                        <div class="form-group">
                            <input class="form-control" id="search_content" size="16" placeholder="author, title, publication, field..." type="text">
                            <input type="hidden" id="ad_order" value="year">
                        </div>
                        </form>
                   </div>
                   <div class="col-md-2">
                       <button id="sbtn" type="button" class="btn btn-primary searchbtn">Search</button>
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
            
        <!-- all included -->
        <div id="shs" class="row" style="display:none">
            <div id="sta" class="col-md-6"></div>
            <div class="col-md-6">
                <button id="downbtn" class="btn btn-xs btn-info pull-right">Cite Export</button>
            </div>
        </div>
            
        <!-- table -->
        <div id="search_list" style="display:none" class="row">
        <div class="col-md-12">
            <table id='stable' class='table listtable'>
                <tr><th>author</th><th>title</th><th>publication</th><th>year</th>
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

        <!-- none -->
        <div id="search_none" style="display:none;padding-left:60px" class="row">
            <div class="alert alert-warning">
            <h4 class="alert-heading">No relevant papers are found in our database</h4>
            please change your key word or see the "All" in paper list</div>
        </div>
        
        </div>  <!-- span10 -->
    </div>

    <hr>
    <div class="footer">
      <p>&copy; Company 2012</p>
    </div>
</div> <!-- /container -->

<!-- modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="myModal">
<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"><h3>Attention</h3></div>
      <div class="modal-body"><p>The input text of search form cannot be empty</p></div>
      <div class="modal-footer"><a href="#" class="btn btn btn-danger" data-dismiss="modal">OK</a></div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div>  

<script src="js/bootstrap3.js"></script>
</body>
</html>