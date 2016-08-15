
$(function() {
    
    $("h1")
        .wrapInner("<span>")

    $("h1 br")
        .before("<span class='spacer'>")
        .after("<span class='spacer'>");

});