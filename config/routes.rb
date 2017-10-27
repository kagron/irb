Rails.application.routes.draw do
  root 'irb#home'

  get 'about', to: 'irb#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
