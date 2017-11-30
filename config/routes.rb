Rails.application.routes.draw do

  resources  :users,    only: %i(create new)
  resources  :sessions, only: %i(create new destroy)

  root 'pictures#index'

  resources  :pictures
end
