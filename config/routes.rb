Rails.application.routes.draw do
  resources :documents
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins
  get 'irb/FormApps'

  get 'irb/ArchivedApps'

  get 'irb/InProgressApps'

  get 'irb/StateApps'

  get 'form_apps/ArchivedApps'

  get 'form_apps/InProgressApps'

  get 'form_apps/StateApps'

  get 'irb/NewApplication'

  get 'irb/BoardView'

  devise_for :users
  root 'irb#home'

  get 'about', to: 'irb#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
