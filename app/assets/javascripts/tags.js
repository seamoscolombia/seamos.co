$( document ).ready(function(){
    var pathn = window.location.pathname
    if (pathn.split("/").find(function(controller) {
            return controller === "polls"
        })) {
         if ($("#tags-field").val() == null){
           var taglist = []
         } else {
           var taglist = $("#tags-field").val().split(',')
         }
        $(".tag").each(function() {
            var existingTag = $(this).html();
            if (taglist.find(function(tag) {
                    return tag === existingTag
                })) {
                $(this).addClass("added_tag");
            }
        });
        $(".tag").off("click");
        $(".tag").on("click", function() {
            var tagname = $(this).html()
            if (taglist.find(function(tag) {
                    return tag === tagname
                })) {
                var itr = taglist.indexOf(tagname);
                if (itr > -1) {
                    taglist.splice(itr, 1);
                }
                $(this).removeClass("added_tag");
                $("#tags-field").val(taglist.toString());
            } else {
                taglist.push(tagname);
                $(this).addClass("added_tag");
                $("#tags-field").val(taglist.toString());
            }
        });
    }
};
