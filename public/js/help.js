angular.module('helpApp', [])
.controller('HelpController', function($scope) {
    // FAQ data 
    $scope.faqs = [
        { category: 'kolibri', question: "What does 'monthend 09-24' do?", answer: "This submits monthend report for your centre. This command is used for both mid-month and monthend, where (09) is the month and (24) is the year. Substitute the month and the year with the right dates." },
        { category: 'kolibri', question: "What does 'make_quiz' do?", answer: "This command recreates quiz in Kolibri. Every time this runs, quizzes are regenerated." },
        { category: 'kolibri', question: "How do can i make a backup?", answer: "You make a backup of your data by opening the terminal and entering the command 'backup', this process does not require any internet connection"},
        { category: 'kolibri', question: "How can i upload a backup to telegram?", answer: "Copy the backup you want to upload from the centre laptop on to your mobile device, and then open the Edulution Telegram channel and upload the backup there, this requires internet connection. The anmount of data usage during the upload process will depend on the size of the backup you are uploading"},
        { category: 'kolibri', question: "What does 'assign_learners' do?", answer: "This command assigns learners to their correct groups"},
        { category: 'linux', question: "What does 'shutdown' do?", answer: "This command shuts down the session laptop, by first making a backup, then after that, the computer shuts down." },
        { category: 'kolibri', question: "What does 'restartko' do?", answer: "This command restarts Kolibri. It takes less than 3 minutes for Kolibri to start running again once this command is run." },
        { category: 'monthend', question: "When do we submit 'monthend' ?", answer: "We submit monthend on the last day of the month, and on the 15th of every month"}
    ];

    $scope.searchText = '';
    $scope.selectedCategory = '';
    $scope.filteredFaqs = $scope.faqs;

    // Filter FAQs based on search input and category
    $scope.filterCommands = function() {
        var filter = $scope.searchText.toUpperCase();
        var category = $scope.selectedCategory;

        $scope.filteredFaqs = $scope.faqs.filter(function(faq) {
            var matchesCategory = category === '' || faq.category === category;
            var matchesSearch = faq.question.toUpperCase().indexOf(filter) > -1;
            return matchesCategory && matchesSearch;
        });
    };

    // Check if a FAQ matches the current filters
    $scope.faqMatches = function(faq) {
        var matchesCategory = $scope.selectedCategory === '' || faq.category === $scope.selectedCategory;
        var matchesSearch = faq.question.toUpperCase().indexOf($scope.searchText.toUpperCase()) > -1;
        return matchesCategory && matchesSearch;
    };
});