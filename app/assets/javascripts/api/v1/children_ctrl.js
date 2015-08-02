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
            $scope.unbought_rewards = $scope.current_child.rewards_not_bought;
            $scope.total_balance = $scope.current_child.total_balance;
            $scope.current_investments = $scope.current_child.current_investments;
            $scope.paid_interests = $scope.current_child.paid_interests;
            $scope.paid_interest_final = $scope.current_child.paid_interests.final_balance;
            $scope.interest_rate = $scope.current_child.interest_rate;
          $scope.total_investments = 0;
          for (var j = 0; j < $scope.current_child.current_investments.length; j++) {
            $scope.total_investments += parseFloat($scope.current_child.current_investments[j].investment_balance_to_date);
            }
            $scope.total_investments = $scope.total_investments
              .toFixed(2);
            $scope.investments_and_balance = (parseFloat($scope.total_investments) + parseFloat($scope.total_balance))
              .toFixed(2);
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
        $http.get("/api/v1/children.json").then(function(response2) {
          setChildren(response2);
        });
      });
    };

    $scope.buyReward=function(reward_id){
      $http.patch('api/v1/children/update_reward/' + reward_id + '.json', {
        status: "pending",
        child_id: $scope.current_user
      }).success(function(response){
        for(var i=0; i < $scope.unbought_rewards.length; i++){
          if(reward_id === $scope.unbought_rewards[i].id){
            $scope.unbought_rewards.splice(i,1);
          }
        }
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