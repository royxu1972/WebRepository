<!-- list part -->
<!-- para = index | statistic | rank | all | author | field | publication -->
<%
String par = request.getParameter("para");
%>
<!-- list part -->
<div class="col-md-2">
<ul class="nav nav-pills nav-stacked">
    <%if( par.equals("index") ){%>
    <li class="active"><a href="/"><span class="glyphicon glyphicon-search"> Search</span></a></li>
    <%}else{%>
    <li><a href="/"><span class="glyphicon glyphicon-search"> Search</span></a></li>
    <%}%>
    
    <%if( par.equals("statistic") ){%>
    <li class="active"><a href="/statistic.jsp"><span class="glyphicon glyphicon-th"> Statistic</span></a></li>
    <%}else{%>
    <li><a href="/statistic.jsp"><span class="glyphicon glyphicon-th"> Statistic</span></a></li>
    <%}%>
    
    <%if( par.equals("rank") ){%>
    <li class="active"><a href="#"><span class="glyphicon glyphicon-leaf"> Rank</span></a></li>
    <%}else{%>
    <li><a href="/rank.jsp"><span class="glyphicon glyphicon-leaf"> Rank</span></a></li>
    <%}%>  
</ul>
<br>

<div class="panel panel-success">
    <div class="panel-heading"><h4>paper list</h4></div>
    <div class="list-group">
        <%if( par.equals("all") ){%>
        <a href="/all.jsp" class="list-group-item active">All</a>
        <%}else{%>
        <a href="/all.jsp" class="list-group-item">All</a>
        <%}%>
        
        <%if( par.equals("author") ){%>
        <a id="left_back" href="#" class="list-group-item active">Author</a>
        <%}else{%>
        <a href="/author.jsp" class="list-group-item">Author</a>
        <%}%>
        
        <%if( par.equals("field") ){%>
        <a id="left_back" href="#" class="list-group-item active">Field</a>
        <%}else{%>
        <a href="/field.jsp" class="list-group-item">Field</a>
        <%}%>
        
        <%if( par.equals("publication") ){%>
        <a id="left_back" href="#" class="list-group-item active">Publication</a>
        <%}else{%>
        <a href="/pub.jsp" class="list-group-item">Publication</a>
        <%}%>
    </div>
</div>
</div>

