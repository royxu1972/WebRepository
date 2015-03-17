<!-- list part -->
<!-- para = index | statistic | rank | all | author | field | publication -->
<%
String par = request.getParameter("para");
%>
<!-- list part -->
<div class="col-md-2">
<ul class="nav nav-pills nav-stacked">
    <%if( par.equals("index") ){%>
    <li class="active"><a href="./search.jsp"><i class="fa fa-search"></i>&nbsp;&nbsp;Search</a></li>
    <%}else{%>
    <li><a href="./search.jsp"><i class="fa fa-search"></i>&nbsp;&nbsp;Search</a></li>
    <%}%>
    
    <%if( par.equals("statistic") ){%>
    <li class="active"><a href="./statistic.jsp"><i class="fa fa-bars"></i>&nbsp;&nbsp;Statistic</a></li>
    <%}else{%>
    <li><a href="./statistic.jsp"><i class="fa fa-bars"></i>&nbsp;&nbsp;Statistic</a></li>
    <%}%>

    <%if( par.equals("rank") ){%>
    <li class="active"><a href="#"><i class="fa fa-star"></i>&nbsp;&nbsp;Rank (beta)</a></li>
    <%}else{%>
    <li><a href="./rank.jsp"><i class="fa fa-star"></i>&nbsp;&nbsp;Rank (beta)</a></li>
    <%}%>  
</ul>
<br>

<div class="panel panel-success">
    <div class="panel-heading"><h4>paper list</h4></div>
    <div class="list-group">
        <%if( par.equals("all") ){%>
        <a href="./all.jsp" class="list-group-item active">All</a>
        <%}else{%>
        <a href="./all.jsp" class="list-group-item">All</a>
        <%}%>
        
        <%if( par.equals("author") ){%>
        <a id="left_back" href="#" class="list-group-item active">Author</a>
        <%}else{%>
        <a href="./author.jsp" class="list-group-item">Author</a>
        <%}%>
        
        <%if( par.equals("field") ){%>
        <a id="left_back" href="#" class="list-group-item active">Field</a>
        <%}else{%>
        <a href="./field.jsp" class="list-group-item">Field</a>
        <%}%>
        
        <%if( par.equals("publication") ){%>
        <a id="left_back" href="#" class="list-group-item active">Publication</a>
        <%}else{%>
        <a href="./pub.jsp" class="list-group-item">Publication</a>
        <%}%>
    </div>
</div>
</div>

