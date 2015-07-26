class Api::V1::ParentsController < ApplicationController
  def index
    @parents = User.where(role_id: 1)
  end
end
