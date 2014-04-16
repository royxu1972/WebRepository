/*
 * 控制分页
 * 用于search, author, field , pub
 *
 * #top_main : 头部导航返回
 * #left_back : 左侧导航返回
 * #pa : 头部导航条
 * 
 * .added : 表格加入项
 * .pagecadd : 分页数加入项
 * 
 * #main_list : 主要显示列表
 * #result_list : 结果列表
 * #rstable : 显示结果的表格
 * 
 * #search_page : 分页列表
 * #search_page_pre, #search_page_net : 上一页，下一页
 */
var json ;
var json_data ;
var pagesize = 15 ;  // 单页条目数 
var page ;           // 页数 
var count = 5 ;      // 页码范围 
var current ;        // 当前页面 

$(document).ready(function() {
	/*
	 * clear result table for author, field and publication
	 */
	$("#pa_main").click(function() { 
		$("#pa").hide("slow");
		$(".added").empty();
		$(".pagecadd").empty();
		$("#result_list").hide("slow");
		$("#search_page").hide();
		$("#main_list").show("slow");
	});
	
	$("#left_back").click(function() {
		$("#pa").hide("slow");
		$(".added").empty();
		$(".pagecadd").empty();
		$("#result_list").hide("slow");
		$("#search_page").hide();
		$("#main_list").show("slow");
	});
	
	/*
	 * previous and next page
	 */
	$("#search_page_pre").click(function() {
		if( $(this).hasClass("disabled") ) {
			event.preventDefault();
		}
		else {
			current = parseInt(current) - 1 ;
			showpagecount();
		}
	});
	
	$("#search_page_nxt").click(function() {
		if( $(this).hasClass("disabled") ) {
			event.preventDefault();
		}
		else {
			current = parseInt(current) + 1 ;
			showpagecount();
		}
	});
	
	/*
	 * page click
	 */
	$(document).on("click", ".pagecadd", function() {
		//alert(current);
		if( parseInt($(this).attr("id")) == current ) {
			//alert('User clicked on "foo ' + $(this).attr("id") );
			event.preventDefault();
		}
		else {
			current = $(this).attr("id") ;
			showpagecount();
		}
	});
	
	/*
	 * Cite Download
	 */
	$("#downbtn").click(function() { 
		//alert(json_data);
		json_data = json_data.replace(/\&/g,"%26"); 
		$.ajax({
			// 请求的url 
			url : "citeAction.action",  
			// 发送方式  
			type : "post",
			// 参数 
			data: "jsda=" + json_data ,
			// 回传函数  
			success : function() {
				//location.href = "CiteList.txt";
				location.href = "downAction.action" ; 
			},
		}); 	
	});
});

/*
 * current - 当前页码
 * count - 最大显示页码数
 * pagecadd - 分页显示Class属性
 * search_page_pre ， search_page_nxt - 上一页，下一页
 */
function showpagecount() {
	if( parseInt(current) < count-1 || page <= count - 1 ) {
		$(".pagecadd").empty();
		if( parseInt(current) == 1 ) {
			$("#search_page_pre").after("<li id='1' class='active pagecadd'><a href='#'>1 <span class='sr-only'>(current)</span></a></li>");
			$("#search_page_pre").addClass("disabled");
		}
		else {
			$("#search_page_pre").after("<li id='1' class='pagecadd'><a href='#'>1</a></li>");
			$("#search_page_pre").removeClass("disabled");
		}	
		for( var i=2 ; i<=page && i<=count ; i++ ) {
			if( i == parseInt(current) ) 
				$("#search_page_nxt").before("<li id='"+i+"' class='active pagecadd'><a href='#'>"+i+" <span class='sr-only'>(current)</span></a></li>");
			else
				$("#search_page_nxt").before("<li id='"+i+"' class='pagecadd'><a href='#'>"+i+"</a></li>");
		}
		if( page > count ) {
			$("#search_page_nxt").before("<li id='"+page+"' class='pagecadd'><a href='#'>Last</a></li>");
		}
		if( current == page )
			$("#search_page_nxt").addClass("disabled");
		else
			$("#search_page_nxt").removeClass("disabled");
		showpage(json,current);
	}
	else if( parseInt(current) >= count-1 && parseInt(current) <= page-parseInt(count/2)-1 ){		
		$(".pagecadd").empty();
		$("#search_page_pre").after("<li id='1' class='pagecadd'><a href='#'>First</a></li>");
		for( var i=parseInt(current)-parseInt(count/2) ; i<=parseInt(current)+parseInt(count/2) ; i++ ) {
			if( i == parseInt(current) ) 
				$("#search_page_nxt").before("<li id='"+i+"' class='active pagecadd'><a href='#'>"+i+" <span class='sr-only'>(current)</span></a></li>");
			else	
			    $("#search_page_nxt").before("<li id='"+i+"' class='pagecadd'><a href='#'>"+i+"</a></li>");
		}
		$("#search_page_nxt").before("<li id='"+page+"' class='pagecadd'><a href='#'>Last</a></li>");
		$("#search_page_nxt").removeClass("disabled");
		showpage(json,current);
	}
	else {
		$(".pagecadd").empty();
		$("#search_page_pre").after("<li id='1' class='pagecadd'><a href='#'>First</a></li>");
		for( var i=parseInt(page-count)+1 ; i<=parseInt(page) ; i++ ) {
			if( i == parseInt(current) ) 
				$("#search_page_nxt").before("<li id='"+i+"' class='active pagecadd'><a href='#'>"+i+" <span class='sr-only'>(current)</span></a></li>");
			else	
			    $("#search_page_nxt").before("<li id='"+i+"' class='pagecadd'><a href='#'>"+i+"</a></li>");
		}
		if( current == page )
			$("#search_page_nxt").addClass("disabled");
		else
			$("#search_page_nxt").removeClass("disabled");
		showpage(json,current);
	}
}

/*
 * 显示结果
 * 用于author, field, publication
 */
var search_now = "" ;   // name
var search_type = "" ;  // author or field

function showsearh(data) {
	json = eval( "("+data+")" ); 
	json_data = data ;
	
	page = parseInt(( json.length + pagesize - 1 ) / pagesize) ;
	current = 1 ;
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

function showpage(json, num) {
	$(".added").empty();
	var start = ( num - 1 ) *  pagesize ;
	for(var i = start ; i < start + pagesize && i < json.length ; i++ )    
		$("#rstable").append("<tr class='added'><td>" + json[i].author + "</td><td>" +
				json[i].title + "</td><td>" +
				json[i].publication + "</td><td>" +
				json[i].year + "</td><td>" ) ;
	// show result 
	if( search_now != "wholepaper" ) {
		$("#pa_main").html("<a href='#'>" + search_type + "</a>");
		$("#pa_name").html(search_now);
		$("#main_list").hide();
	}
	
	$("#pa").show();
	$("#sta").html("<p><span class='label label-success'>" + json.length + "</span> papers included</p>");
	$("#result_list").show("slow");
}


