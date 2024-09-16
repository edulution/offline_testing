angular.module('helpApp', [])
.controller('HelpController', function($scope) {
    // FAQ data 
    $scope.faqs = [
        { category: 'kolibri', question: "What does 'monthend 02-24' do?", answer: "Input the command ‘monthend 02-24’; where, in this instance, '02' represents the month (February) and ‘24’ is the year (2024). The month-end process occurs on the 15th and the last day of every month. If the 15th falls on a Saturday, submission should be conducted on the preceding Friday, adhering to the same protocol for the month-end date" },
        { category: 'kolibri', question: "What does 'make_quiz' do?", answer: "When you use the ‘make_quiz’ command it will refresh previously created quizzes." },
        { category: 'kolibri', question: "How do can i make a backup?", answer: "On the session laptop, initiate the backup process by accessing the terminal and executing the command “backup”. This action generates a backup inclusive of data up to the current day"},
        { category: 'kolibri', question: "How can i upload a backup to telegram?", answer: "Upon completion of taking backup, duplicate the backup and transfer it to the Coach tablet. Upload the backup to the Edulution Telegram Channel for secure data storage twice a month (mid-month and month-end data)"},
        { category: 'kolibri', question: "What does 'assign_learners' do?", answer: "This command assigns learners to their correct groups"},
        { category: 'linux', question: "What does 'shutdown' do?", answer: "This command shuts down the session laptop, by first making a backup, then after that, the computer shuts down." },
        { category: 'kolibri', question: "What does 'restartko' do?", answer: "This command restarts Kolibri. It takes less than 2 minutes for Kolibri to start running again once this command is run." },
        { category: 'monthend', question: "When do we submit 'monthend' ?", answer: "The month-end process occurs on the 15th and the last day of every month. If the 15th falls on a Saturday, submission should be conducted on the preceding Friday, adhering to the same protocol for the month-end date." },
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