# frozen_string_literal: true

Rails.application.routes.draw do

  resources :productos
  resources :paginas do
    collection do
      get 'grid'
    end
  end
  resources :formularios do
    resources :formulariosobservaciones
    resources :formulariosobsusers
    collection do
      get 'pagina'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'paginas#index'
end
