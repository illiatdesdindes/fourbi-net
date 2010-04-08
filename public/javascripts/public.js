$(function() {
    for (var i = 0; i < 3; i++) {
        resize_to_fit($("#sommaire_image_desordre_" + i + "> img"), $("#sommaire_image_desordre_" + i));
    }
    for (var j = 0; j < 4; j++) {
        resize_to_fit($("#sommaire_image_terrier_" + j + "> img"), $("#sommaire_image_terrier_" + j));
    }
});

function resize_to_fit(image, target_frame) {

    var delta;
    if ((target_frame.height() / image.height() * image.width()) >= target_frame.width()) {
        delta = (target_frame.height() - (target_frame.width() / image.width() * image.height() )) / 2;
        image.css({'width': target_frame.width(), 'position': 'absolute', 'top': delta });
    } else {
        delta = (target_frame.width() - (target_frame.height() / image.height() * image.width() )) / 2;
        image.css({'height': target_frame.height(), 'position': 'absolute', 'left': delta });
    }

}