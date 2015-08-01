(function() {
  "use strict";
 
  angular.module("app").controller("childrenCtrl", function($scope, $http) {
    $scope.total_investments = 0;
    $scope.setup = function(user_id) {
      $scope.current_user = user_id;
      $http.get("/api/v1/children.json").then(function(response) {
        setChildren(response);
      });
    };

    var setChildren = function (response){
      $scope.children = response.data;
        for (var i = 0; i < $scope.children.length; i++) {
          if ($scope.children[i].id === $scope.current_user) {
            $scope.current_child = $scope.children[i];
            $scope.first_name = $scope.current_child.first_name;
            $scope.incomplete_tasks = $scope.current_child.incomplete_tasks;
            $scope.total_balance = $scope.current_child.total_balance;
            $scope.current_investments = $scope.current_child.current_investments;
            $scope.interest_rate = $scope.current_child.interest_rate;
          for (var j = 0; j < $scope.current_child.current_investments.length; j++) {
            $scope.total_investments += parseFloat($scope.current_child.current_investments[j].investment_balance_to_date);
            }
            $scope.total_investments = $scope.total_investments.toFixed(2);
            $scope.investments_and_balance = (parseFloat($scope.total_investments) + parseFloat($scope.total_balance)).toFixed(2);
          }
        }
    };

    $scope.toggleOrder = function(attribute) {
      $scope.orderAttribute = attribute;
      $scope.descending = !$scope.descending;
    };

    $scope.updateTaskStatus=function(task_id){
      $http.patch('api/v1/children/update_task/' + task_id + '.json', {
        status: "pending",
        child_id: $scope.current_user
      }).success(function(response){
        for(var i = 0; i < $scope.incomplete_tasks.length; i++){
          if(task_id === $scope.incomplete_tasks[i].id){
            $scope.incomplete_tasks.splice(i,1);
          }
        }
      });
    };


    $scope.payOutInvestment=function(investment_id){
      $http.patch('api/v1/children/' + investment_id + '.json', {
        withdrawl_status: "paid"
      }).success(function(response){
        self.location.reload($scope.current_investments);
      });
    };

    $scope.addNewInvestment=function(money_invested, duration){
      var investmentAmt = {
        money_invested: money_invested,
        duration: duration,
        child_id: $scope.current_user
      };
      $http.post('api/v1/children.json', investmentAmt).then(function(response){
        $scope.total_investments = 0;
        $scope.investments_and_balance = 0;
        setChildren(response);
      });
      $scope.money_invested = null;
      $scope.duration = null;
    };

    window.scope = $scope;
  });
 
}());