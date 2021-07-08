/*Show confirm message if a user clicks the back button or tries to refresh the page*/
$(window).on('beforeunload', function() {
    /*Custom message on dialog not supported in newer browsers but left there just in case*/
    var c = confirm("Are you sure you want to leave this page? Your answers will not be saved");
    if (c) {
        return true;
    } else
        return false;
});