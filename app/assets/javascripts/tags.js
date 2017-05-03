var ready = function() {
    if (window.location.pathname == "/polls/new") {
        var taglist = []
        $(".tag").off("click");
        $(".tag").on("click", function() {
            var tagname = $(this).html()
            if ( taglist.find(function(tag){ return tag === tagname}) ){
                var itr = taglist.indexOf(tagname);
                if (itr > -1) {
                    taglist.splice(itr, 1);
                }
                $(this).removeClass("added_tag");
            } else {
                taglist.push(tagname);
                $(this).addClass("added_tag");
                $("#tags-field").val(taglist.toString());
            }
        });
    }
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
