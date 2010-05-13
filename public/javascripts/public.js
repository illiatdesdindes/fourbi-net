$(function() {
    centerImages();
    $("#ac_image").load(function() {
        centerImages()
    });
    if ($('.ac_scroll_content').size() != 0) {
        $(".ac_scroll_content").scrollTo($("#ad_scroll_content .current"));
        updateScrollArticles();
    }
});

function centerImages() {
    if ($("#ac_image").width() > $("#ac_predelle").width()) {
        $("#ac_predelle").css("padding-left", "" + (($("#article_image").width() - $("#ac_predelle").width()) / 2) + "px");
    }
}

function articleScrollLeft() {
    $(".ac_scroll_content").scrollTo("-=" + (numberArticlesPerPage * $($(".ac_scroll_content td")[0]).outerWidth()), 800, {onAfter: function() {
        updateScrollArticles()
    }});
}

function articleScrollRight() {
    $(".ac_scroll_content").scrollTo("+=" + (numberArticlesPerPage * $($(".ac_scroll_content td")[0]).outerWidth()), 800, {onAfter: function() {
        updateScrollArticles()
    }});
}

function updateScrollArticles() {
    var scrollPosition = $(".ac_scroll_content").scrollLeft();
    $("#ac_scroll_droite").fadeTo(200, (scrollPosition == $.scrollTo.max($(".ac_scroll_content")[0], "x")) ? 0.5 : 1);
    $("#ac_scroll_gauche").fadeTo(200, (scrollPosition == 0) ? 0.5 : 1);
}

function serieScrollLeft() {
    $(".sc_bloc_centre").scrollTo("-=" + ($($(".sc_bloc_images")[0]).outerWidth()), 2000);
}
function serieScrollRight() {
    $(".sc_bloc_centre").scrollTo("+=" + ($($(".sc_bloc_images")[0]).outerWidth()), 2000);
}
