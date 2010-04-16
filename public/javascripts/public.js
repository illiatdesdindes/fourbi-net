$(function() {
    centerImages();
    $("#article_image").load(function() {
        centerImages()
    });
});

function centerImages() {
    if ($("#article_image").width() > $("#article_predelle").width()) {
        $("#article_predelle").css("padding-left", "" + (($("#article_image").width() - $("#article_predelle").width()) / 2) + "px");
    }
}

function scrollLeft(id) {
    $("#" + id).scrollTo("-=" + (numberArticlesPerPage * $($("#" + id + " td")[0]).outerWidth()), 800);
}

function scrollRight(id) {
    $("#" + id).scrollTo("+=" + (numberArticlesPerPage * $($("#" + id +" td")[0]).outerWidth()), 800);
}