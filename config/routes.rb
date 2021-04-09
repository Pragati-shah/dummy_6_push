Rails.application.routes.draw do
  
  get 'employee/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #root to: 'welcome#index'
  get '/welcome/index'
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  post '/employee/attendance', "employee#attendance"
  post '/employee/temperature', "employee#temperature"
  get '/users/sign_in'
end
