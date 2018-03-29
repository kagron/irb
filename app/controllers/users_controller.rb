class UsersController < ApplicationController
  def autocomplete
      render json: User.search(params[:query], {fields: ['first_name', 'last_name'], match: :word_start, limit: 10}).map{|x| x.first_name + " " + x.last_name}
  end
end
