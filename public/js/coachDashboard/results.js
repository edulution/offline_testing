angular.module('coachDashBoard', ['ngAnimate', 'ngSanitize', 'ui.bootstrap', 'smart-table', 'angular.filter'])
    .controller('MainCtrl', function($scope, $log, $document, $http) {
        var $ctrl = this;

        $scope.init = function() {

            $http.get("/get_users").then(function(response) {
                $scope.users = response.data;
                /*console.log($scope.users);*/
            });

            $http.get("/get_test_marks").then(function(response) {
                $scope.tests_marks = response.data;
                /*console.log($scope.tests_marks);*/

                /*Get raw test responses*/
                /*run inside the get test marks call because test marks must always be fetched before responses*/
                $http.get("/get_responses").then(function(response) {
                    /*Do some operations on the responses*/
                    for (var i = response.data.length - 1; i >= 0; i--) {
                        /*Convert test dates to javascript dates to enable search by alphanumeric characters*/
                        response.data[i]["test_date"] = new Date(response.data[i]["test_date"])

                        /*Generate blocks of fifths for each response*/
                        generate_blocks($scope.tests_marks, response.data[i])

                        /*Get test name*/
                        get_test_name($scope.tests_marks, response.data[i])

                        /*Calculate the percent score*/
                        calculate_score($scope.tests_marks, response.data[i])
                    };

                    /*store the processed file as a scope variable*/
                    $scope.results = response.data;

                    /*console.log($scope.results)*/

                });
            });

            /*Get the tests count by month*/
            $http.get("/get_test_count").then(function(response) {
                $scope.tests_count = response.data;
            });

            $scope.selUser = '';

            /*placeholder value used in smart-table because users are loaded asynchorously*/
            $scope.users_placeholder = [];

            $scope.selresults = []

            $scope.selresults_placeholder = [];            

            /*placeholder value used in smart-table because results are loaded asynchorously*/
            $scope.results_placeholder = [];

            /*pagination - items to display on each page*/
            $scope.itemsByPage = 15;

            /*empty object to initalize tests_marks*/
            $scope.tests_marks = {};

            /*enable angular animations*/
            $ctrl.animationsEnabled = true;

        }

        $scope.get_results = function(){
            $scope.selresults = $scope.results.filter(function (resp){
                return resp.username == $scope.selUser;
            });
        }

        /*Calculate the score percent for a test*/
        var calculate_score = function(testMarks, testResponse) {
            /*get the maxscore from config*/
            var maxScore = get_test_max_score(testMarks, testResponse)

            /*get object values for all qs in the response*/
            var all_qvals = Object.values(get_all_qs(testResponse))

            /*get only the slice of the qvals for the test e.g get only the first 25 vals if the test is out of 25*/
            var qvals_for_test = all_qvals.slice(0, maxScore)

            /*get the sum of the values and calculate the percent score based on maxscore*/
            testResponse.score_pct = get_sum_of_array(qvals_for_test) / maxScore

        }


        /*Test Results into blocks of fifths*/
        /*Split an array into chunks of specific length*/
        var chunkArrayInGroups = function(arr, chunk_length) {
            return arr.reduce(function(r, v, i) {
                if (i % chunk_length == 0) r.push(arr.slice(i, i + chunk_length));
                return r;
            }, []);
        }


        /*helper function to get sum of array*/
        const reducer = (accumulator, currentValue) => accumulator + Number(currentValue);
        /*get sum of members of array*/
        /*total of members of dataArray*/
        var get_sum_of_array = function(dataArray) {
            /*if the input is a dataArray(an object), then get the total of its memebers*/
            if (typeof(dataArray) == "object") {
                total = dataArray.reduce(reducer, 0)
                return total
            }
            /*if not an object, return null*/
            else {
                return null
            }
        }


        /*Get the max score of a test by finding it in the testMarks config array based on test,course, and module*/
        var get_test_max_score = function(testMarks, testResponse) {
            var testDetails = testMarks.find(testMark => { return testMark.test_id == testResponse.test && testMark.course == testResponse.course && testMark.module == testResponse.module })
            /*if the testDetails are found get the maxscore*/
            if (testDetails) {
                /*return the testmaxscore property of the testDetails object*/
                return testDetails.testmaxscore
            }
            /*if the testDetails are not found, return null*/
            else {
                return null
            }
        }

        /*Get the test name of a user's test from config*/
        var get_test_name = function(testMarks, testResponse) {
            var testDetails = testMarks.find(testMark => { return testMark.test_id == testResponse.test && testMark.course == testResponse.course && testMark.module == testResponse.module })
            /*if the testDetails are found get the maxscore*/
            if (testDetails) {
                /*return the testmaxscore property of the testDetails object*/
                testResponse.test_name = testDetails.test_name
            }
            /*if the testDetails are not found, return null*/
            else {
                return null
            }
        }


        /*Get all answers for each question i.e q1 to q... as key,value pairs*/
        var get_all_qs = function(testResponse) {
            var all_qs = Object.keys(testResponse).filter(function(k) {
                /*get index of all object properties that begin with 'q'*/
                return k.indexOf('q') == 0;
            }).reduce(function(newObj, k) {
                newObj[k] = testResponse[k];
                /*place all these properites and their values into a new object*/
                return newObj;
            }, {});

            /*return an object with q1 to q.. as key,value pairs*/
            return all_qs;
        }


        /*Create obeject properties for fifths of each response*/
        var get_block_values = function(testResponse, testMaxScore, chunksArray) {
            var one_fifth = testMaxScore / 5
            /*assumptions*/
            /*each question has a maxscore of 1*/
            /*the number of questions in a tests = maxscore*/
            /*the maxscore is always divisible by 5 with no remainder*/

            /*create blocks of fifths based on the number of questions in a test*/
            /*the names of the blocks may vary depending on the total number of questions in a test*/
            var block_1_name = 'Q1 to ' + 'Q' + one_fifth
            var block_2_name = 'Q' + (one_fifth + 1) + ' to Q' + (one_fifth * 2)
            var block_3_name = 'Q' + (one_fifth * 2 + 1) + ' to Q' + (one_fifth * 3)
            var block_4_name = 'Q' + (one_fifth * 3 + 1) + ' to Q' + (one_fifth * 4)
            var block_5_name = 'Q' + (one_fifth * 4 + 1) + ' to Q' + (one_fifth * 5)

            /*assign the result property on each block to true or false based on whether the value is equal to the value of one fifth*/
            /*This will modify the object passed in and returns nothing*/
            testResponse.block_1 = { name: block_1_name, result: chunksArray[0] / one_fifth }
            testResponse.block_2 = { name: block_2_name, result: chunksArray[1] / one_fifth }
            testResponse.block_3 = { name: block_3_name, result: chunksArray[2] / one_fifth }
            testResponse.block_4 = { name: block_4_name, result: chunksArray[3] / one_fifth }
            testResponse.block_5 = { name: block_5_name, result: chunksArray[4] / one_fifth }

            /*console.log(testResponse)*/

        }


        /*Main function which puts everything together*/
        /*Modifies testresponse object and adds properties block_1 to block_5*/
        var generate_blocks = function(testMarks, testResponse) {
          /*Get the cutoff point to be used when slicing the q values i.e the number of answers expected for a test*/
            var cuttoffPoint = get_test_max_score(testMarks, testResponse)

          /*Get one fifth of the cut off point. Will be used as the length of the chunks when the sections are created*/
            var one_fifth = cuttoffPoint / 5

            /*Get the object values for q1 to q..*/
            var all_qvals = Object.values(get_all_qs(testResponse))

            /*Slice only the values for the particular test*/
            var qvals_for_test = all_qvals.slice(0, cuttoffPoint)

            /*Divide the values array evenly into chunks. Each chunk is one fifth of the total length*/
            var qvals_chunks = chunkArrayInGroups(qvals_for_test, one_fifth)

            /*Empty array to store the sum of each chunk*/
            var qvals_chunk_totals = []

            /*Loop through the chunks arrays and get the sum*/
            /*Push the sum to the empty array declared above*/
            for (var i = 0; i < qvals_chunks.length; i++) {
                qvals_chunk_totals.push(get_sum_of_array(qvals_chunks[i]))
            }

            /*finally create the values and results for each chunk of questions*/
            /*based on the maxscore for the test and totals for each chunk*/ 
            /*This will modify the object passed in and returns nothing*/
            get_block_values(testResponse, cuttoffPoint, qvals_chunk_totals)

        }


    })
    /*element directive for navigation bar*/
    .directive('navigation', function() {
        return {
            restrict: 'E',
            templateUrl: 'navigation.html',
            controller: function($window) {
                this.tab = 1; /* initially set tab to 1*/
                this.selectTab = function(setTab) { /* Set tab to whatever tab user clicks*/
                    this.tab = setTab;
                    console.log(this.tab);
                };
                this.isSelected = function(checkTab) { /* Check which tab is selected to trigger show of selected tab */
                    return this.tab === checkTab;

                };

                /*function to refresh page when button clicked*/
                this.refresh = function() {
                    $window.location.reload();
                }
            },
            controllerAs: 'menu'
        };
    })
    /*element directive for responses tab*/
    .directive('getresults', function() {
        return {
            restrict: 'E',
            templateUrl: 'get_results.html',
            link: function(scope, element, attributes) {
                /*class for all elements in directive. used for scoped styling*/
                element.addClass('results');
            }
        };
    });