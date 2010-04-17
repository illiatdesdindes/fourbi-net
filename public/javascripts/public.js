$(function() {
    centerImages();
    $("#ac_image").load(function() {
        centerImages()
    });
});

function centerImages() {
    if ($("#ac_image").width() > $("#ac_predelle").width()) {
        $("#ac_predelle").css("padding-left", "" + (($("#article_image").width() - $("#ac_predelle").width()) / 2) + "px");
    }
}

function articleScrollLeft() {
    $(".ac_scroll_content").scrollTo("-=" + (numberArticlesPerPage * $($(".ac_scroll_content td")[0]).outerWidth()), 800);
}

function articleScrollRight(id) {
    $(".ac_scroll_content").scrollTo("+=" + (numberArticlesPerPage * $($(".ac_scroll_content td")[0]).outerWidth()), 800);
}