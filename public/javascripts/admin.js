$(function() {
    $("table.alternated tr:even").addClass("even");
    $("table.sortable").tablesorter();
    $(".draggable").dragsort();
});
