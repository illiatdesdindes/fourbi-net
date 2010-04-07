$(function() {
    for (var i = 1; i <= 3; i++) {
        resize_to_fit($("#sommaire_image_desordre_" + i + "> img"), $("#sommaire_image_desordre_" + i));
    }
    for (var j = 1; j <= 4; j++) {
        resize_to_fit($("#sommaire_image_terrier_" + j + "> img"), $("#sommaire_image_terrier_" + i));
    }
});

function resize_to_fit(source, target) {
    var source_h = source.height();
    var source_w = source.width();

    var parent_h = target.height();
    var parent_w = target.width();

    var ratio_source = source_h / source_w;
    var ratio_target = parent_h / parent_w;

    var delta;
    if (ratio_source < ratio_target) {
        delta = parent_h - (source_h * ( parent_w / source_w));
        source.css({'width': parent_w, 'position': 'absolute', 'top': (delta / 2)});
    } else {
        delta = parent_w - (source_w * ( parent_h / source_h));
        source.css({'height': parent_h, 'position': 'absolute', 'left': (delta / 2)});
    }

}