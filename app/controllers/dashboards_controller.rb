class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_parent!, :except => [:child_dashboard]
  
  def child_dashboard

  end

  def parent_dashboard
  end
end
