/**
 * Created by Huayao on 2014/9/18.
 */

function showsearh_manage(data) {
    json = eval( "("+data+")" );
    json_data = data ;

    // id, bib, type, year, author, title, publication, [abbr], [vol], [no], [pages], field, [doi], [abstract]
    for(var i = 0 ; i < json.length ; i++ ) {
        $("#rstable").append("<tr class='added'><td>" + (i+1) + "</td>" +
            "<td>" + json[i].bib + "</td>" +
            "<td>" + json[i].type + "</td>" +
            "<td>" + json[i].year + "</td>" +
            "<td>" + json[i].author + "</td>" +
            "<td>" + json[i].title + "</td>" +
            "<td>" + json[i].publication + "</td>" +
            "<td>" + json[i].abbr + "</td>" +
            "<td>" + json[i].vol + "</td>" +
            "<td>" + json[i].no + "</td>" +
            "<td>" + json[i].pages + "</td>" +
            "<td>" + json[i].field + "</td>" +
            "<td width='5'>" + json[i].doi + "</td>" +
            "<td>" + json[i].abstra + "</td>" +
            "</tr>");
    }
    $("#result_list").show() ;
}