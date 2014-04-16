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
	// search field id 
	$("p[id]").click(function() { 
		var para = "content=" + $(this).attr("id") + "&type=pub" ;
		search_now = $(this).text() ;
		search_type = "publication" ;
		$.ajax({
			url : "contentAction.action",  
			type : "post",
			dataType : "json",
			data: para , 
			success : showsearh
		});
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
             <button id="downbtn" class="btn btn-xs btn-info pull-right">Cite Export</button>
             </div>
             </div>
            </div>
 
             <!-- main list -->
             <%@ page import="java.util.*"%> 
             <%@ page import="java.sql.*"%> 
             <%
             // search table paper.Author
             Class.forName("com.mysql.jdbc.Driver").newInstance();  
             Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper","root","123456");  
             Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);  
             String sql1 = "select * from paper.listpub where type = 'journal'";  
             ResultSet rs1 = stmt.executeQuery(sql1); 
             %>  
             <div id="main_list" class="row">
             <div class="col-md-12">
             <h4>Main Journal</h4>
             <hr>
                 <%
                 while(rs1.next()){
                     String name = rs1.getString(2) ;
                     String pb = rs1.getString(3) ;
                     out.println("<p id='"+pb+"'><a href='#'>"+name+"</a></p>");
                 }
                 %>
             <br/><br/>              
             
                
             <h4>Main Conference</h4>
             <hr>
                 <%
                 String sql2 = "select * from paper.listpub where type = 'conference'";  
                 ResultSet rs2 = stmt.executeQuery(sql2); 
                 while(rs2.next()){
                     String name = rs2.getString(2) ;
                     String pb = rs2.getString(3) ;
                     out.println("<p id='"+pb+"'><a href='#'>"+name+"</a></p>");
                 }
                 %> 
             <br/><br/>
             
             <h4>Phd Thesis</h4>
             <hr>
             <p id="Phd"><a href="#">Phd thesis</a></p>    
             <br/><br/>
              
             <h4>Book Chapter</h4>
             <hr>
             <p id="book"><a href="#">Book Chapter</a></p>
             
             </div>                    
             </div> <!-- main_list -->
             
             
             
             <!-- result list -->
             <div id="result_list" style="display:none" class="row">
             <div class="col-md-12">
             <table id='rstable' class='table listtable'>
                 <tr><th>author</th><th>title</th><th>pub</th><th>year</th>
                 <!--  <th>type</th><th>area</th> -->
                 </tr>
             </table>
             </div>
             </div>  <!-- result -->
             
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

<script src="js/bootstrap.js"></script>
</body>
</html>
