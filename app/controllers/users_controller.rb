class UsersController < ApplicationController
  def autocomplete
      # render json: ["test"]
      render json: User.search(params[:term], {fields: ['first_name', 'last_name'], match: :text_start, limit: 10}).map{|x| x.first_name + " " + x.last_name}
  end
end
