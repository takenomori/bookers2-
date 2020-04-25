# frozen_string_literal: true

Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  root 'homes#index'

  resources :books, only: %i[update new index create index show destroy edit] do
    resource :book_comments, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
  end

  resources :users, only: %i[new index show edit update]
  resources :homes, only: [:index]
  get 'home/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
