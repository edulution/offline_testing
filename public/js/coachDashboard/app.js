angular.module('coachDashBoard', ['ngAnimate', 'ngSanitize', 'ui.bootstrap', 'smart-table', 'angular.filter'])
    .controller('MainCtrl', function($scope, $uibModal, $log, $document, $http) {
        var $ctrl = this;
        /*enable angular animations*/
        $ctrl.animationsEnabled = true;
        $scope.init = function() {
            /*placeholder value used in smart-table because results_breakdown are loaded asynchorously*/
            $scope.results_breakdown_placeholder = []

            /*placeholder value used in smart-table because results_breakdown are loaded asynchorously*/
            $scope.results_breakdown_placeholder = []

            /*pagination - items to display on each page*/
            $scope.itemsByPage = 15;

            /*empty object to initalize tests_marks*/
            $scope.tests_marks = {};

            $http.get("/api/get_users").then(function(response) {
                $scope.users = response.data;
                /*console.log($scope.users);*/

                $scope.totalLearners = $scope.users.length
            });

            $http.get("/api/get_test_marks").then(function(response) {
                $scope.tests_marks = response.data;
                /*console.log($scope.tests_marks);*/

                /*Get raw test responses*/
                /*run inside the get test marks call because test marks must always be fetched before responses*/
                $http.get("/api/get_responses").then(function(response) {
                    /*Do some operations on the responses*/
                    for (var i = response.data.length - 1; i >= 0; i--) {
                        /*Convert test dates to javascript dates to enable search by alphanumeric characters*/
                        response.data[i]["test_date"] = new Date(response.data[i]["test_date"])

                        /*Get test name*/
                        get_test_name($scope.tests_marks, response.data[i])

                        /*Calculate the percent score*/
                        calculate_score($scope.tests_marks, response.data[i])
                    };

                    /*store the processed file as a scope variable*/
                    $scope.results = response.data;

                });
            });


            /*Get the tests count by month*/
            $http.get("/api/get_test_count").then(function(response) {
                $scope.tests_count = response.data;
            });

            /*get learners count by class*/
            $http.get("/api/get_learners_count").then(function(response) {
                $scope.learners_count = response.data;
            });

            $http.get("/api/results_breakdown").then(function(response) {
                $scope.results_breakdown = response.data;
            });



        }

        /*Function to open a password modal*/
        $ctrl.openModal = function(parentSelector) {
            var parentElem = parentSelector ?
                angular.element($document[0].querySelector('body' + parentSelector)) : undefined;
            var modalInstance = $uibModal.open({
                animation: $ctrl.animationsEnabled,
                ariaLabelledBy: 'modal-title',
                ariaDescribedBy: 'modal-body',
                templateUrl: 'passwordModalContent.html',
                controller: 'ModalInstanceCtrl',
                controllerAs: '$ctrl',
                backdrop: 'static',
                keyboard: false,
                appendTo: parentElem
            });

            /*console.log("modal loaded");*/
        };

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

        /**function to find score */
        $scope.percentage_score = function(arr) {
            var total = 0;

            /*how many avgs */
            var count = 0;
            for (var i = 0; i < arr.length; i++) {
                total += parseFloat(arr[i].answer)
                count++;
            }
            var percerntage = total / count * 100;
            return percerntage.toFixed(1);
        }


        /**function to display scores in each topic */
        $scope.calc_section_pct = function(num) {
            var section_pct = parseFloat(num);
            return section_pct.toFixed(1);
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
            let testDetails = testMarks.find(testMark => { return testMark.test_id == testResponse.test && testMark.course == testResponse.course && testMark.module == testResponse.module })
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
            let testDetails = testMarks.find(testMark => { return testMark.test_id == testResponse.test && testMark.course == testResponse.course && testMark.module == testResponse.module })
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
            let all_qs = Object.keys(testResponse).filter(function(k) {
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

        const weightedMean = function(arrValues, arrWeights) {
            const result = arrValues
                .map((value, i) => {
                    const weight = arrWeights[i]
                    const sum = value * weight
                    return [sum, weight]
                })
                .reduce((p, c) => [p[0] + c[0], p[1] + c[1]], [0, 0])

            return result[0] / result[1]
        }


        $scope.topic_score_weighted_mean = function(topic_details_arr) {
            var topic_scores = topic_details_arr.map((obj) => obj.topic_score).map(Number)
            var topic_weights = topic_details_arr.map((obj) => obj.total_wt).map(Number)


            return weightedMean(topic_scores, topic_weights)

        }






    })
    /*Controller for a modalinstance that was opened by the $ctrl.openModal function*/
    .controller('ModalInstanceCtrl', function($scope, $uibModalInstance) {
        /*The password a coach is expected to enter*/
        $scope.coachPassword = "Ctrib3";

        /*Variable which changes depending on whether the password submitted is correct or not*/
        /*Used to either trigger displaying of errors on the html template or dismiss the modal*/
        $scope.wrongPassword = false;

        /*Alias for the controller*/
        let $ctrl = this;

        /*Function to dismiss the modal. Only invoked when the coach enters the correct password*/
        $ctrl.cancel = function() {
            $uibModalInstance.dismiss();
        };

        /*Check if the password entered is equal to the password expected from the coach*/
        $ctrl.checkPassword = function(password) {
            /*If the password is correct*/
            if (password == $scope.coachPassword) {
                /*The wrongPassword variable remains false*/
                /*The modal is dismissed*/
                $scope.wrongPassword = false;
                $uibModalInstance.dismiss();
            }
            /*If the password is wrong*/
            else {
                /*he wrongPassword variable is set to true*/
                /*Errors are show on the html template based on this value*/
                $scope.wrongPassword = true;
            }
        };
    })
    /*element directive for navigation bar*/
    .directive('navigation', function() {
        return {
            restrict: 'E',
            templateUrl: '/js/coachDashboard/templates/navigation.html',
            controller: function($window) {
                this.tab = 0; 
                this.selectTab = function(setTab) {
                    this.tab = setTab;
                    /*console.log(this.tab);*/
                };
                this.isSelected = function(checkTab) {
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

    /*element directive for learners tab*/
    .directive('learners', function() {
        return {
            restrict: 'E',
            templateUrl: "/js/coachDashboard/templates/learners.html",
            link: function(scope, element, attributes) {
                /*class for all elements in directive. used for scoped styling*/
                element.addClass('learners');
            }
        };
    })
    /*element directive for responses tab*/
    .directive('responses', function() {
        return {
            restrict: 'E',
            templateUrl: '/js/coachDashboard/templates/responses.html',
            link: function(scope, element, attributes) {
                /*class for all elements in directive. used for scoped styling*/
                element.addClass('responses');
            }
        };
    })
    /*element directive for responses by question tab(development only)*/
    .directive('questresponses', function() {
        return {
            restrict: 'E',
            templateUrl: '/js/coachDashboard/templates/responses_q.html',
            link: function(scope, element, attributes) {
                /*class for all elements in directive. used for scoped styling*/
                element.addClass('questresponses');
            }
        };
    })
    /*element directive for tests count tab*/
    .directive('testscount', function() {
        return {
            restrict: 'E',
            templateUrl: '/js/coachDashboard/templates/testcount.html',
            link: function(scope, element, attributes) {
                /*class for all elements in directive. used for scoped styling*/
                element.addClass('testscount');
            }
        };
    })
    /*element directive for results by section tab*/
    .directive('responsesections', function() {
        return {
            restrict: 'E',
            templateUrl: '/js/coachDashboard/templates/responses_sections.html',
            link: function(scope, element, attributes) {
                /*class for all elements in directive. used for scoped styling*/
                element.addClass('responsesections');
            }
        };
    })

    /*element directive for learners count by class tab*/
    .directive('learnerscount', function() {
        return {
            restrict: 'E',
            templateUrl: '/js/coachDashboard/templates/learner_count.html',
            link: function(scope, element, attributes) {
                /*class for all elements in directive. used for scoped styling*/
                element.addClass('learnerscount');
            }
        };
    });
