Rails.application.routes.draw do
  get 'applications/approved', :to => 'documents#approved'
  get 'applications/rejected', :to => 'documents#rejected'
  get 'applications/needs_revisions', :to => 'documents#needs_revisions'
  get 'applications/archived', :to => 'documents#archived'

  resources :applications, as: 'documents', controller: 'documents'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins

  get 'irb/ArchivedApps'
  devise_for :users
  root 'irb#home'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
