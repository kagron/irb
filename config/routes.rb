Rails.application.routes.draw do
  get 'applications/approved', :to => 'documents#approved'
  get 'applications/assignments', :to => 'documents#assignments'
  get 'applications/needs_revisions', :to => 'documents#needs_revisions'
  get 'applications/archived', :to => 'documents#archived'
  get 'applications/new_apps', :to => 'documents#new_apps'
  post 'applications/:id/approve-vote', :to => 'votes#approve_vote', as: 'approve_vote_app'
  post 'applications/:id/revise-vote', :to => 'votes#revise_vote', as: 'revise_vote_app'
  post 'applications/:id/reject-vote', :to => 'votes#reject_vote', as: 'reject_vote_app'
  post 'applications/:id/approve', :to => 'votes#approve', as: 'approve_app'
  post 'applications/:id/revise', :to => 'votes#revise', as: 'revise_app'
  post 'applications/:id/reject', :to => 'votes#reject', as: 'reject_app'
  post 'applications/:id/comments/:comment_id', :to => 'comments#destroy', as: 'delete_comment'

  # Chair Comment routes, we only need create, update, and destroy
  post 'chair_comments', :to => 'chair_comments#create', as: 'create_chair_comment'
  

  resources :applications, as: 'documents', controller: 'documents'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins

  # resources :assignments, only: [:create, :destroy], :collection =>  {:destroy => :delete }
  delete 'applications/new_apps', :to => 'assignments#destroy', as: 'delete_assign'
  post 'applications/assignments', :to => 'assignments#create'
  post 'applications/:id', :to => 'comments#create'
  get 'irb/ArchivedApps'
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'irb#home'
  get 'edit', to: 'irb#edit'
  # Update index
  patch "/", :to => "irb#update"
  put "/", :to => "irb#update"
  post "/", :to => "irb#create"




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
