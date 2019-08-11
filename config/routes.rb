Rails.application.routes.draw do
  root to: "courses#index"
  resources :courses, :only => [:index, :show] do
    resources :questions, :only => [:index, :new, :create, :destroy] do
      resources :polls, :only => [:index, :show, :create, :update, :destroy] do
        resources :poll_responses, :only => [:create]
      end
    end
  end
  get '/courses/:course_id/questions/:question_id/polls/:id/status', :to => 'polls#status', :as => :poll_status, :action => 'status', :controller => 'polls'
  get '/courses/:id/status', :to => 'courses#status', :as => :course_status, :action => 'status', :controller => 'courses'

  get '/x', :to => 'courses#create_and_activate'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
