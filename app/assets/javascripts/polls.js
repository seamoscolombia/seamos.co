$(document).on('turbolinks:load', function() {
    if (window.location.pathname === "/polls/new") {
        function charLeft() {
            counterLabel.text(3000 - (this.value.length));
        }
        var textArea = $('#poll-description');
        var counterLabel = $('#counter-label');
        textArea.on('keydown', charLeft);
        counterLabel.text(3000 - (textArea.val().length));
    }
});
