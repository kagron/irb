Rails.application.routes.draw do
  get 'applications/approved', :to => 'documents#approved'
  get 'applications/assignments', :to => 'documents#assignments'
  get 'applications/needs_revisions', :to => 'documents#needs_revisions'
  get 'applications/archived', :to => 'documents#archived'
  get 'applications/new_apps', :to => 'documents#new_apps'
  get 'applications/:id/approve-vote', :to => 'votes#approve_vote', as: 'approve_vote_app'
  get 'applications/:id/revise-vote', :to => 'votes#revise_vote', as: 'revise_vote_app'
  get 'applications/:id/reject-vote', :to => 'votes#reject_vote', as: 'reject_vote_app'
  get 'applications/:id/approve', :to => 'votes#approve', as: 'approve_app'
  get 'applications/:id/revise', :to => 'votes#revise', as: 'revise_app'
  get 'applications/:id/reject', :to => 'votes#reject', as: 'reject_app'
  post 'applications/:id/comments/:comment_id', :to => 'comments#destroy', as: 'delete_comment'

  # Chair Comment routes, we only need create, update, and destroy
  post 'chair_comments', :to => 'chair_comments#create', as: 'create_chair_comment'
  patch "/", :to => "chair_comments#update", as: 'edit_chair_comment'
  put "/", :to => "chair_comments#update"

  post 'users/:id/removeboard', :to => 'irb#removeBoard', as: 'remove_board'
  post 'users/:id/removechair', :to => 'irb#removeChair', as: 'remove_chair'
  post 'users/:id/addboard', :to => 'irb#addBoard', as: 'add_board'
  post 'users/:id/addchair', :to => 'irb#addChair', as: 'add_chair'
  post 'users/:id/addreadonly', :to => 'irb#addReadOnly', as: 'add_read_only'
  resources :applications, as: 'documents', controller: 'documents'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins

  # resources :assignments, only: [:create, :destroy], :collection =>  {:destroy => :delete }
  delete 'applications/new_apps', :to => 'assignments#destroy', as: 'delete_assign'
  post 'applications/assignments', :to => 'assignments#create'
  post 'applications/:id', :to => 'comments#create'
  get 'board', :to => 'irb#board'
  get 'search', :to => 'irb#search'
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'users/autocomplete', :to => 'users#autocomplete'
  root 'irb#home'
  get 'edit', to: 'irb#edit'
  # Update index
  patch "/", :to => "irb#update"
  put "/", :to => "irb#update"
  post "/", :to => "irb#create"




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
