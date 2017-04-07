var ready = function() {
    if (window.location.pathname == "/polls/new") {
        var taglist = []
        $(".tag").click(function() {
            var tagname = $(this).html()
            if (jQuery.inArray(tagname, taglist) !== -1) {
                var itr = taglist.indexOf(tagname);
                if (itr > -1) {
                    taglist.splice(itr, 1);
                }
                $(this).removeClass("added_tag");
                console.log(taglist);
            } else {
                taglist.push(tagname);
                $(this).addClass("added_tag");
                $("#tags-field").val(taglist.toString());
                console.log(taglist);
            }
        });
    }
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
