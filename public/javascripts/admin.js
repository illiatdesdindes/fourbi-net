$(function() {
    $("table.alternated tr:even").addClass("even");
    $("table.sortable").tablesorter();
    if ($('.draggable').size() != 0) {
        $(".draggable").dragsort();
    }
});


function calculateOrder() {
    var order = "";
    $(".draggable li").each(function(i, elm) {
        order += (i > 0 ? "|" : "") + $(elm).attr("id");
    });
    $("[name=order]").val(order);
}