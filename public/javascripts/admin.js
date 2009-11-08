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

function mettreAJourPrix() {
    var prix = 0;
    $(".article").each(function(){
        var numero = $(this);
        var id = numero.attr("id");
        var prixNumero = parseFloat($("#prix_" + id).val());
        var nombreExemplaires = parseInt(numero.val());
        prix += prixNumero * nombreExemplaires;
    });
    $("#prixAffiche").html(prix);
}
