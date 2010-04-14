function scollLeft() {
    $("#article_scroll_content").scrollTo( "-=" + (numberArticlesPerPage * $($("#article_scroll_content td")[0]).outerWidth()), 800);
}

function scollRight() {
    $("#article_scroll_content").scrollTo( "+=" + (numberArticlesPerPage * $($("#article_scroll_content td")[0]).outerWidth()), 800);
}