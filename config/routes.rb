Rails.application.routes.draw do
  get 'applications/approved', :to => 'documents#approved'
  get 'applications/assignments', :to => 'documents#assignments'
  get 'applications/needs_revisions', :to => 'documents#needs_revisions'
  get 'applications/archived', :to => 'documents#archived'
  get 'applications/new_apps', :to => 'documents#new_apps'

  resources :applications, as: 'documents', controller: 'documents'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins

  post 'applications/:id', :to => 'comments#create'
  get 'irb/ArchivedApps'
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'irb#home'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
