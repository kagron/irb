class UsersController < ApplicationController
  def autocomplete
      render json: User.search(params[:query], {fields: ['first_name', 'last_name'], match: :word_start, limit: 10})
  end
end
