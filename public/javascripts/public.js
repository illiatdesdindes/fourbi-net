$(function() {
   if($("#article_desordre_image").width() > $("#article_desordre_predelle").width()) {
        $("#article_desordre_predelle").css("padding-left", "" + (($("#article_desordre_image").width() - $("#article_desordre_predelle").width()) / 2) + "px" );
   }
});


function scollLeft() {
    $("#article_scroll_content").scrollTo( "-=" + (numberArticlesPerPage * $($("#article_scroll_content td")[0]).outerWidth()), 800);
}

function scollRight() {
    $("#article_scroll_content").scrollTo( "+=" + (numberArticlesPerPage * $($("#article_scroll_content td")[0]).outerWidth()), 800);
}