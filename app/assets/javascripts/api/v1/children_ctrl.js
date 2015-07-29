(function() {
  "use strict";
 
  angular.module("app").controller("childrenCtrl", function($scope, $http) {
    $scope.total_investments = 0;
    $scope.setup = function(user_id) {
      $http.get("/api/v1/children.json").then(function(response) {
        $scope.children = response.data;
        for (var i = 0; i < $scope.children.length; i++) {
          if ($scope.children[i].id === user_id) {
            $scope.current_child = $scope.children[i];
            $scope.incomplete_tasks = $scope.current_child.incomplete_tasks;
            $scope.total_balance = $scope.current_child.total_balance;
            $scope.current_investments = $scope.current_child.current_investments;
            $scope.interest_rate = $scope.current_child.interest_rate;
          for (var j = 0; j < $scope.current_child.current_investments.length; j++) {
            $scope.total_investments += parseFloat($scope.current_child.current_investments[j].investment_balance_to_date);
            }
            $scope.investments_and_balance = $scope.total_investments + $scope.total_balance;
          }
        }
      });
    };

    window.scope = $scope;
  });
 
}());