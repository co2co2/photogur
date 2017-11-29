Rails.application.routes.draw do

  resources  :users,    only: %i(create new)
  resources  :sessions, only: %i(create new destroy)

  root 'pictures#index'

  get 'pictures'=>'pictures#index'

  post 'pictures' => 'pictures#create'
  get 'pictures/new'=> 'pictures#new'

  get 'pictures/:id/edit' => "pictures#edit"
  patch 'pictures/:id' => "pictures#update"

  delete 'pictures/:id' => 'pictures#destroy'

  get 'pictures/:id'=>'pictures#show'# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
