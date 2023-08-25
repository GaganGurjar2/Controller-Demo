Rails.application.routes.draw do

resources :users, except: [:new, :edit] do
  collection do
    get 'students', to: 'users#students'
   get 'teachers', to: 'users#teachers'
 end 
end 
resources :courses, only: [:index,:create, :show, :update, :destroy] do
resources :chapters, only: [:index,:create, :show, :update, :destroy] 
resources :practice_questions, only: [:index,:create, :show, :update, :destroy]
end  

resources :subscriptions, only: [:create]


end
 