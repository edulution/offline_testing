angular.module('helpApp', ['ngSanitize']) // Include ngSanitize module
    .controller('HelpController', function($scope) {
        // FAQ data 
        $scope.faqs = [
            // Common Commands
            { category: 'common_commands', question: "How do I restart Kolibri?", answer: "In order to restart Kolibri, open up the terminal on the session laptop, then input the <b>'restartko'</b> command. The <b>'restartko'</b> command restarts Kolibri, ensuring it runs smoothly. Kolibri should be operational again within 2 minutes." },
            { category: 'common_commands', question: "How do I submit month end reports?", answer: "In order to submit month end reports, open up the terminal on the session laptop then input the command <b>‘monthend’</b> followed by the month and the year. For example, if you input the command <b>‘monthend 02-24’</b>; where, in this instance, <i>'02'</i> represents the month (February) and <i>‘24’</i> is the year (2024). The month end process occurs on the last working day every month." },
            { category: 'common_commands', question: "How do I submit mid-month reports?", answer: "In order to submit month end reports, open up the terminal on the session laptop then input the command <b>‘monthend’</b> followed by the month and the year. For example, if you input the command <b>‘monthend 02-24’</b>; where, in this instance, <i>'02'</i> represents the month (February) and <i>‘24’</i> is the year (2024). The mid-month process occurs on the 15th day of every month." },
            { category: 'common_commands', question: "Hoe do I generate quizzes for my learners on Kolibri?", answer: "In order to generate quizzes for learners on Kolibri, open up the terminal on the session laptop and input the <b>‘make_quiz’</b> command. This will generate quizzes for each topic on Kolibri. Note that when you use the <b>‘make_quiz’</b> command, it will refresh previously created quizzes and delete any quizzes that were manually created." },
            { category: 'common_commands', question: "Hoe do I assign learners to their correct groups on Kolibri?", answer: "In order to assign learners to their correct groups on Kolibri, open up the terminal on the session laptop and input the <b>'assign_learners'</b> command. This will enrol the learners into groups on Kolibbri based on their current level. If learners are not in the correct grade on Kolibri, submit a ticket to the technical support team for further assistance." },
            { category: 'common_commands', question: "How do I shut dowen the session laptop?", answer: "In order to shut down the session laptop, open up the terminal and input the <b>'shutdown'</b> command. The <b>'shutdown'</b> command safely powers down the session laptop, ensuring that a backup of all of your learners' data is made before the laptop shuts off." },

            // Kolibri
            { category: 'kolibri', question: "How can i fix the issue of learners not appearing in on Kolibri dashboard?", answer: "If learners are not showing on the Kolibri dashboard, ensure that learners are still logged in from the tablet and refresh the page. If the issue persists, check for possible network issues or try restarting Kolibri using the <b>'restartko'</b> command." },
            { category: 'kolibri', question: "How do I create a backup of my learners' data?", answer: "On the session laptop, initiate the backup process by accessing the terminal and executing the command <b>'backup'</b>. This action generates a backup contain all of your learners' activity data and asessment results inclusive of data up to the current day. The backup file generated can be found in the backups folder in the home directory of the session laptop" },
            { category: 'kolibri', question: "How do I upload a backup to Telegram?", answer: "After completing a backup, transfer it to the Coach tablet, and upload the backup to the Edulution Telegram Channel for secure data storage. This is done <i>twice a month</i> (mid-month and month-end)." },
            { category: 'kolibri', question: "How do learners log in to Kolibri?", answer: "Learners log in to Kolibri by opening Edulution Portal application on the tablets, then selecting the Kolibri icon on the portal home page, entering their username, and tapping <b>'Sign in'</b>." },
            { category: 'kolibri', question: "How do I view learner details?", answer: "On the seession laptop, open up the browser and go to the Coach Dashboard and click on the <b>'Learners'</b> tab in order to view a detailed overview of each learner's details. This includes <b>Username</b>, <b>Class</b>, and <b>Group</b>." },

            // Reports
            { category: 'reports', question: "How do I analyze test results?", answer: "On the seession laptop, open up the browser and go to the <b>Coach Dashboard</b>. Click on the <b>'Test Results'</b> tab. This will give you a summary of the test results for all of your learners. In order to view a detailed breakdown of the test results, click on the <b>Coach Dashboard</b> tab on the <b>Coach Dashboard</b>. This will give you a detailed breakdown of the learner’s performance on each test, which can help you identify areas where they may need additional support." },
            { category: 'reports', question: "How do I view learner attendance on Kolibri?", answer: "Sign in as a Coach using the centre code, go to <b>'Classes'</b>, and then tap into <b>'Live attendance'</b> to see the list of live learners in the session." },
            { category: 'reports', question: "How can I access reports on Qlik?", answer: "Access the Qlik dashboard using your Edulution email credentials. Navigate through the dashboard and apply filters as needed to generate customized reports on learner progress and other key metrics." },

            // Hardware
            { category: 'hardware', question: "How can i fix a malfunctioning tablet?", answer: "Try restarting the tablet. If the issue persists, perform a factory reset by navigating to the <b>'Backup and Reset'</b> option under <b>'Settings'</b> and selecting <b>'Factory Data Reset'</b>. If the issue persists, create a ticket on Freshdesk." },
            { category: 'hardware', question: "How do I set up the hardware for a session?", answer: "Switch on the session laptop, connect it to the router using an ethernet cable, and ensure that the Wi-Fi access point is connected properly." },
            { category: 'hardware', question: "How can i fix the issue of a tablet losing WiFi connection during a session?", answer: "Check if the Wi-Fi connection is active. If necessary, restart the tablet or refresh the Wi-Fi connection. You may also need to restart Kolibri using the <b>'restartko'</b> command." },
            { category: 'hardware', question: "How do I manage solar equipment?", answer: "Keep the solar panels clean by using a sponge cleaner twice a week. Log the solar battery levels daily, and ensure that the solar equipment is functioning correctly to support off-grid sessions." },
            { category: 'hardware', question: "How can i fix a router that is not working?", answer: "Ensure the router is properly connected to the power source and the session laptop. If it's still not working, restart the router and check the cables. If the issue persists, create a ticket on Freshdesk." },

            // Software
            { category: 'software', question: "How do I access Google Drive?", answer: "Go to drive.google.com, log in with your Edulution credentials, and navigate to the relevant folders. You can upload and organize files, or access shared documents such as reports and personal files like payslips." },
            { category: 'software', question: "How can i fix a slow Kolibri performance issue?", answer: "If Kolibri is slow, you can try restarting the laptop or tablet. If the issue persists, use the <b>'restartko'</b> command to reset Kolibri and restore its performance. If the issue persists, create a ticket on Freshdesk." },
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