class UsersController < ApplicationController
  # This method is called when you're in /board and searching for users to add to the board
  # it will render the users in a JSON format that we grab in /board
  # This uses elastic search's engine
  # One thing I would like to improve on: is allow someone to type in the whole name
  # when searching.  Currently it searches first name and last name separately, so you cannot type
  # in someone's full name
  def autocomplete
      # render json: ["test"]
      render json: User.search(params[:term], {fields: ['first_name', 'last_name'], match: :text_start, limit: 10}).map{|x| x.first_name + " " + x.last_name}
  end
end
