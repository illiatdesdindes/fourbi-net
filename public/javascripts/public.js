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
    if (($('.ac_scroll_content').size() != 0) && ($("#ad_scroll_content .current").size() != 0)) {
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

/**
 * Adapted from
 * JavaScript: The Definitive Guide, 4th Edition
 * By David Flanagan
 * Edited by O'Reilly
 * ISBN: 0-596-00048-0
 * http://www.oreilly.com/catalog/jscript4/index.html
 *
 * Drag.js:
 * This function is designed to be called from a mousedown event handler.
 * It registers temporary capturing event handlers for the mousemove and
 * mouseup events that will follow and uses these handlers to "drag" the
 * specified document element. The first argument must be an absolutely
 * positioned document element. It may be the element that received the
 * mousedown event or it may be some containing element. The second
 * argument must be the event object for the mousedown event.
 **/
function beginDrag(elementToDrag, event) {
	try {
		// Figure out where the element currently is
		// The element must have left and top CSS properties in a style attribute
		// Also, we assume they are set using pixel units
		var x = parseInt($(elementToDrag).offset().left);
		var y = parseInt($(elementToDrag).offset().top);

		// Compute the distance between that point and the mouse-click
		// The nested moveHandler function below needs these values
		var deltaX = event.clientX - x;
		var deltaY = event.clientY - y;

		// Register the event handlers that will respond to the mousemove
		// and mouseup events that follow this mousedown event. Note that
		// these are registered as capturing event handlers on the document.
		// These event handlers remain active while the mouse button remains
		// pressed and are removed when the button is released.
		document.addEventListener("mousemove", moveHandler, true);
		document.addEventListener("mouseup", upHandler, true);
		document.addEventListener("mouseout", upHandler, true);

		// We've handled this event. Don't let anybody else see it.
		event.stopPropagation( );
		event.preventDefault( );
	} catch(e) {

	}

    /**
     * This is the handler that captures mousemove events when an element
     * is being dragged. It is responsible for moving the element.
     **/
    function moveHandler(event) {
        // Move the element to the current mouse position, adjusted as
        // necessary by the offset of the initial mouse-click
        $(elementToDrag).offset({ top: (event.clientY - deltaY), left: (event.clientX - deltaX)});
        // And don't let anyone else see this event
        event.stopPropagation( );
    }

    /**
     * This is the handler that captures the final mouseup event that
     * occurs at the end of a drag
     **/
    function upHandler(event) {
        // Unregister the capturing event handlers
        document.removeEventListener("mouseup", upHandler, true);
        document.removeEventListener("mousemove", moveHandler, true);
        // And don't let the event propagate any further
        event.stopPropagation( );
    }
}

var cursorPositionX = -1;
var cursorPositionY = -1;

function clicked(e) {
    cursorPositionX = e.screenX;
    cursorPositionY = e.screenY;
}

function dragged(e) {
    var deltaX = cursorPositionX - e.screenX;
    var deltaY = cursorPositionY - e.screenY;
    cursorPositionX = e.screenX;
    cursorPositionY = e.screenY;
    window.scrollBy(deltaX, deltaY);
}

function closeSession() {
    $.get("/vider_session", function() {
        window.location("/");
    })
}