(function ($) {
    // VERTICALLY ALIGN FUNCTION
    $.fn.vAlign = function() {
        return this.each(function(i) {
            var ah = $(this).height();

            // safari
            if (ah != 0) {
                var ph = $(this).parent().parent().height();
                var mh = (ph - ah) / 2;
                $(this).parent().css('margin-top', mh);
            }
        });
    };
})(jQuery);

$(function() {
    $(".s_image_terrier img, .s_image_desordre img").vAlign();
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
