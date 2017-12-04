Rails.application.routes.draw do
  resources :applications, as: 'documents', controller: 'documents'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins
  get 'irb/FormApps'

  get 'irb/ArchivedApps'

  get 'irb/InProgressApps'

  get 'irb/StateApps'

  get 'form_apps/ArchivedApps'

  get 'form_apps/InProgressApps'

  get 'form_apps/StateApps'

  get 'irb/BoardView'

  devise_for :users
  root 'irb#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
