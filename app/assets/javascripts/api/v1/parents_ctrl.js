(function() {
  "use strict";
  
  angular.module("app").controller("parentsCtrl", function($scope, $http) {
    $scope.total_investments = 0;
    $scope.setup = function(user_id) {
      $scope.current_user = user_id;
      $http.get("/api/v1/parents.json").then(function(response) {
        setParents(response);
      });
    };

    var setParents = function(response){
      $scope.parents = response.data;
        for (var i = 0; i < $scope.parents.length; i++) {
          if ($scope.parents[i].id === $scope.current_user) {
            $scope.current_parent = $scope.parents[i];
            $scope.childrens_incomplete_tasks = $scope.current_parent.all_childrens_incomplete_tasks;
            $scope.tasks_needing_approval = $scope.current_parent.all_childrens_tasks_needing_approval;
            $scope.rewards_needing_approval = $scope.current_parent.all_rewards_needing_approval;
            $scope.children = $scope.current_parent.children;
          }
        }
      };

    $scope.addInterestRate=function(interestRate, child){
      $http.patch('api/v1/interest_rate.json', {child_id: child.id, interest_rate: interestRate});
      $scope.interest_rate = null;
    };

    window.scope = $scope;
  });
 
}());